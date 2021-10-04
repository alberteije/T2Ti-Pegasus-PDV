<?php
/*******************************************************************************
Title: T2Ti ERP 3.0
Description: Service relacionado à tabela [NFE_CONFIGURACAO] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (alberteije@gmail.com)                    
@version 1.0.0
*******************************************************************************/

class NfeConfiguracaoService extends ServiceBase
{
  public static function consultarLista()
  {
    return NfeConfiguracao::select()->limit(QUANTIDADE_POR_PAGINA)->get();
  }

  public static function consultarListaFiltroValor($filtro)
  {
    return NfeConfiguracao::whereRaw($filtro->where)->get();
  }

  public static function consultarObjeto(int $id)
  {
    return NfeConfiguracao::find($id);
  }
  
  public static function atualizar($nfeConfiguracao, $cnpj, $decimaisQuantidade, $decimaisValor)
  {
    $filtro = 'CNPJ = "' . $cnpj . '"';
    $empresaRetorno = Empresa::whereRaw($filtro)->get();
    if ($empresaRetorno->count() > 0) {
			// salva o objeto de configuração no banco de dados
      $empresa = $empresaRetorno[0];
      $nfeConfiguracao->empresa = $empresa;
      $nfeConfiguracao->caminhoSalvarXml->replace("\\", "\\\\");
      $nfeConfiguracao->caminhoSalvarPdf->replace("\\", "\\\\");
      $nfeConfiguracao->save();			

      // verificar se já existe uma porta definida para o monitor da empresa
      // ALTER TABLE acbr_monitor_porta AUTO_INCREMENT=3435; - executa um comando no banco de dados para definir a porta inicial para o ID
      $filtro = "ID_EMPRESA = " . $empresa->id->ToString();
      $portaMonitorRetorno = AcbrMonitorPorta::whereRaw($filtro)->get();
      if ($portaMonitorRetorno->count() == 0)
      {
        $portaMonitor = new AcbrMonitorPorta();
        $portaMonitor->empresa = $empresa;
        $portaMonitor->save();
      } else {
        $portaMonitor = $portaMonitorRetorno[0];
      }

      // criar a pasta do monitor para a empresa
      NfeConfiguracaoService::criarPastaAcbrMonitor($cnpj);

      // configurar o arquivo INI
      NfeConfiguracaoService::configurarArquivoIniMonitor($nfeConfiguracao, $empresa, $decimaisQuantidade, $decimaisValor, $portaMonitor);

      return $portaMonitor;
    }
  }

  public static function criarPastaAcbrMonitor($cnpj)
  {
    $caminho = 'c:\\ACBrMonitor\\CopiarBase.bat ' . $cnpj;
    system('cmd /c ' . $caminho);
  }

  public static function configurarArquivoIniMonitor($nfeConfiguracao, $empresa, $decimaisQuantidade, $decimaisValor, $portaMonitor)
  {
    $caminhoComCnpj = 'C:\\ACBrMonitor\\' . $empresa->cnpj . '\\';
    $nfeConfiguracao->caminhoSalvarPdf = $caminhoComCnpj . 'PDF';
    $nfeConfiguracao->caminhoSalvarXml = $caminhoComCnpj . 'DFes';

    // carrega o arquivo ini num array
    $nomeArquivoIni = $caminhoComCnpj . 'ACBrMonitor.ini';
		$acbrMonitorIni = parse_ini_file($nomeArquivoIni, true);

    //*******************************************************************************************
    //  [ACBrMonitor]
    //*******************************************************************************************
    Biblioteca::iniWriteString('ACBrMonitor', 'TCP_Porta', $portaMonitor->id->toString(), $acbrMonitorIni);

    //*******************************************************************************************
    //  [ACBrNFeMonitor]
    //*******************************************************************************************
    Biblioteca::iniWriteString('ACBrNFeMonitor', 'Arquivo_Log_Comp', $caminhoComCnpj . 'LOG_DFe.TXT', $acbrMonitorIni);
    Biblioteca::iniWriteString('ACBrNFeMonitor', 'ArquivoWebServices', $caminhoComCnpj . 'ACBrNFeServicos.ini', $acbrMonitorIni);
    Biblioteca::iniWriteString('ACBrNFeMonitor', 'ArquivoWebServicesCTe', $caminhoComCnpj . 'ACBrCTeServicos.ini', $acbrMonitorIni);
    Biblioteca::iniWriteString('ACBrNFeMonitor', 'ArquivoWebServicesMDFe', $caminhoComCnpj . 'ACBrMDFeServicos.ini', $acbrMonitorIni);
    Biblioteca::iniWriteString('ACBrNFeMonitor', 'ArquivoWebServicesGNRe', $caminhoComCnpj . 'ACBrGNREServicos.ini', $acbrMonitorIni);
    Biblioteca::iniWriteString('ACBrNFeMonitor', 'ArquivoWebServiceseSocial', $caminhoComCnpj . 'ACBreSocialServicos.ini', $acbrMonitorIni);
    Biblioteca::iniWriteString('ACBrNFeMonitor', 'ArquivoWebServicesReinf', $caminhoComCnpj . 'ACBrReinfServicos.ini', $acbrMonitorIni);
    Biblioteca::iniWriteString('ACBrNFeMonitor', 'ArquivoWebServicesBPe', $caminhoComCnpj . 'ACBrBPeServicos.ini', $acbrMonitorIni);

    //*******************************************************************************************
    //  [WebService]
    //*******************************************************************************************
    // tpAmb - 1-Produção/ 2-Homologação
    // OBS: o monitor leva em conta o índice do Radiogroup, ou seja, será 0 para produção e 1 para homologação
    $ambiente = $nfeConfiguracao->webserviceAmbiente - 1;
    Biblioteca::iniWriteString('WebService', 'Ambiente', $ambiente, $acbrMonitorIni);
    Biblioteca::iniWriteString('WebService', 'UF', $empresa->uf, $acbrMonitorIni);

    //*******************************************************************************************
    //  [RespTecnico]
    //*******************************************************************************************
    if ($nfeConfiguracao->respTecHashCsrt != '0')
        Biblioteca::iniWriteString('RespTecnico', 'CSRT', $nfeConfiguracao->respTecHashCsrt, $acbrMonitorIni);
    if ($nfeConfiguracao->respTecIdCsrt != '0')
        Biblioteca::iniWriteString('RespTecnico', 'idCSRT', $nfeConfiguracao->respTecIdCsrt, $acbrMonitorIni);

    //*******************************************************************************************
    //  [NFCe]
    //*******************************************************************************************
    Biblioteca::iniWriteString('NFCe', 'IdToken', $nfeConfiguracao->nfceIdCsc, $acbrMonitorIni);
    Biblioteca::iniWriteString('NFCe', 'Token', $nfeConfiguracao->nfceCsc, $acbrMonitorIni);
    if ($nfeConfiguracao->nfceModeloImpressao == 'A4')
        Biblioteca::iniWriteString('NFCe', 'ModoImpressaoEvento', '0', $acbrMonitorIni);
    else
        Biblioteca::iniWriteString('NFCe', 'ModoImpressaoEvento', '1', $acbrMonitorIni);
    if ($nfeConfiguracao->nfceImprimirItensUmaLinha == 'S')
        Biblioteca::iniWriteString('NFCe', 'ImprimirItem1Linha', '1', $acbrMonitorIni);
    else
        Biblioteca::iniWriteString('NFCe', 'ImprimirItem1Linha', '0', $acbrMonitorIni);
    if ($nfeConfiguracao->nfceImprimirDescontoPorItem == 'S')
        Biblioteca::iniWriteString('NFCe', 'ImprimirDescAcresItem', '1', $acbrMonitorIni);
    else
        Biblioteca::iniWriteString('NFCe', 'ImprimirDescAcresItem', '0', $acbrMonitorIni);
    if ($nfeConfiguracao->nfceImprimirQrcodeLateral == 'S')
        Biblioteca::iniWriteString('NFCe', 'QRCodeLateral', '1', $acbrMonitorIni);
    else
        Biblioteca::iniWriteString('NFCe', 'QRCodeLateral', '0', $acbrMonitorIni);
    if ($nfeConfiguracao->nfceImprimirGtin == 'S')
        Biblioteca::iniWriteString('NFCe', 'UsaCodigoEanImpressao', '1', $acbrMonitorIni);
    else
        Biblioteca::iniWriteString('NFCe', 'UsaCodigoEanImpressao', '0', $acbrMonitorIni);
    if ($nfeConfiguracao->nfceImprimirNomeFantasia == 'S')
        Biblioteca::iniWriteString('NFCe', 'ImprimeNomeFantasia', '1', $acbrMonitorIni);
    else
        Biblioteca::iniWriteString('NFCe', 'ImprimeNomeFantasia', '0', $acbrMonitorIni);
    if ($nfeConfiguracao->nfceImpressaoTributos == 'S')
        Biblioteca::iniWriteString('NFCe', 'ExibeTotalTributosItem', '1', $acbrMonitorIni);
    else
        Biblioteca::iniWriteString('NFCe', 'ExibeTotalTributosItem', '0', $acbrMonitorIni);

    //*******************************************************************************************
    //  [DANFCe]
    //*******************************************************************************************
    Biblioteca::iniWriteString('DANFCe', 'MargemInf', $nfeConfiguracao->nfceMargemInferior->toString()->replace('.', ','), $acbrMonitorIni);
    Biblioteca::iniWriteString('DANFCe', 'MargemSup', $nfeConfiguracao->nfceMargemSuperior->toString()->replace('.', ','), $acbrMonitorIni);
    Biblioteca::iniWriteString('DANFCe', 'MargemDir', $nfeConfiguracao->nfceMargemDireita->toString()->replace('.', ','), $acbrMonitorIni);
    Biblioteca::iniWriteString('DANFCe', 'MargemEsq', $nfeConfiguracao->nfceMargemEsquerda->toString()->replace('.', ','), $acbrMonitorIni);
    Biblioteca::iniWriteString('DANFCe', 'LarguraBobina', $nfeConfiguracao->nfceResolucaoImpressao->toString(), $acbrMonitorIni);

    //*******************************************************************************************
    //  [FonteLinhaItem]
    //*******************************************************************************************
    Biblioteca::iniWriteString('FonteLinhaItem', 'Size', $nfeConfiguracao->nfceTamanhoFonteItem->toString(), $acbrMonitorIni);

    //*******************************************************************************************
    //  [DANFE]
    //*******************************************************************************************
    Biblioteca::iniWriteString('DANFE', 'PathPDF', $nfeConfiguracao->caminhoSalvarPdf, $acbrMonitorIni);
    Biblioteca::iniWriteString('DANFE', 'DecimaisQTD', $decimaisQuantidade, $acbrMonitorIni);
    Biblioteca::iniWriteString('DANFE', 'DecimaisValor', $decimaisValor, $acbrMonitorIni);

    //*******************************************************************************************
    //  [Arquivos]
    //*******************************************************************************************
    Biblioteca::iniWriteString('Arquivos', 'PathNFe', $nfeConfiguracao->caminhoSalvarXml, $acbrMonitorIni);
    Biblioteca::iniWriteString('Arquivos', 'PathInu', $caminhoComCnpj . 'Inutilizacao', $acbrMonitorIni);
    Biblioteca::iniWriteString('Arquivos', 'PathDPEC', $caminhoComCnpj . 'EPEC', $acbrMonitorIni);
    Biblioteca::iniWriteString('Arquivos', 'PathEvento', $caminhoComCnpj . 'Evento', $acbrMonitorIni);
    Biblioteca::iniWriteString('Arquivos', 'PathArqTXT', $caminhoComCnpj . 'TXT', $acbrMonitorIni);
    Biblioteca::iniWriteString('Arquivos', 'PathDonwload', $caminhoComCnpj . 'DistribuicaoDFe', $acbrMonitorIni);
    
		// grava arquivo INI
		Biblioteca::writeIniFile($nomeArquivoIni, $acbrMonitorIni);
    
    // encerra e executa o monitor novamente
    Biblioteca::killTask('ACBrMonitor_' . $empresa->cnpj . '.exe');
    $caminhoExecutavel = $caminhoComCnpj . 'ACBrMonitor_' . $empresa->cnpj . '.exe';
    shell_exec($caminhoExecutavel);
  }	
		
  public static function atualizarCertificado($certificadoBase64, $senha, $cnpj)
  {
    $filtro = 'CNPJ = "' . $cnpj . '"';
    $empresaRetorno = Empresa::whereRaw($filtro)->get();
    if ($empresaRetorno->count() > 0) {
      $empresa = $empresaRetorno[0];

      // encerra o Monitor
      Biblioteca::killTask('ACBrMonitor_' . $empresa->cnpj . '.exe');

      // configura os caminhos
      $caminhoComCnpj = 'C:\\ACBrMonitor\\' . $empresa->cnpj . '\\';
      $caminhoArquivoCertificado = $caminhoComCnpj . $empresa->cnpj . '.pfx';

      // converte e salva o arquivo do certificado em disco
      $ifp = fopen( $caminhoArquivoCertificado, 'wb' ); 
      fwrite( $ifp, base64_decode( $certificadoBase64[ 1 ] ) );
      fclose( $ifp );

      // vamos alterar o monitor para receber dados em arquivo TXT para armazenar os dados do certificado
      // faremos dessa maneira porque o monitor criptografa a senha
      $nomeArquivoIni = $caminhoComCnpj . 'ACBrMonitor.ini';
      $acbrMonitorIni = parse_ini_file($nomeArquivoIni, true);
      
      try {
        //*******************************************************************************************
        //  [ACBrMonitor]
        //*******************************************************************************************
        Biblioteca::iniWriteString('Arquivos', 'Modo_TCP', '0', $acbrMonitorIni);
        Biblioteca::iniWriteString('Arquivos', 'Modo_TXT', '1', $acbrMonitorIni);
        Biblioteca::writeIniFile($nomeArquivoIni, $acbrMonitorIni);
      } finally {
        $caminhoExecutavel = $caminhoComCnpj . 'ACBrMonitor_' . $empresa->cnpj . '.exe';
        shell_exec($caminhoExecutavel);
      }

			NfeConfiguracaoService::gerarArquivoEntradaMonitor($caminhoArquivoCertificado, $senha, $cnpj);
      
      while (!file_exists("c:\\ACBrMonitor\\" . $cnpj . "\\sai.txt")) { }

      // altera novamente o monitor para o modo TCP
      try {
        //*******************************************************************************************
        //  [ACBrMonitor]
        //*******************************************************************************************
        Biblioteca::iniWriteString('Arquivos', 'Modo_TCP', '1', $acbrMonitorIni);
        Biblioteca::iniWriteString('Arquivos', 'Modo_TXT', '0', $acbrMonitorIni);
        Biblioteca::writeIniFile($nomeArquivoIni, $acbrMonitorIni);
      } finally {
        Biblioteca::killTask('ACBrMonitor_' . $empresa->cnpj . '.exe');
        $caminhoExecutavel = $caminhoComCnpj . 'ACBrMonitor_' . $empresa->cnpj . '.exe';
        shell_exec($caminhoExecutavel);
      }
  
    }   
  }

  public static function gerarArquivoEntradaMonitor($caminhoArquivoCertificado, $senha, $cnpj)
  {
    //  apaga o arquivo 'SAI.TXT'
    unlink("c:\\ACBrMonitor\\" . $cnpj . "\\sai.txt");

    //  cria o arquivo 'ENT.TXT'
    $nomeArquivoEntrada = "c:\\ACBrMonitor\\" . $cnpj . "\\ENT.TXT";
    $arquivoEntrada = fopen($nomeArquivoEntrada, "w");
    fwrite($arquivoEntrada, "NFE.SetCertificado(" . $caminhoArquivoCertificado . "," . $senha . ")");
    fclose($arquivoEntrada);
  }  

  public static function gerarZipArquivosXml($periodo, $cnpj)
  {
    $filtro = 'CNPJ = "' . $cnpj . '"';
    $empresa = Empresa::whereRaw($filtro)->get();
    if ($empresa->count() > 0) {
      $pasta = 'C:\\ACBrMonitor\\' . $cnpj . '\\DFes\\NFCe\\' . $periodo;
      $arquivoZip = 'C:\\ACBrMonitor\\' . $cnpj . '\\NotasFiscaisNFCe_' . $periodo . '.zip';
      Biblioteca::compactarPasta($pasta, $arquivoZip);
      return true;
    } else {
      return false;
    }    
  }
}