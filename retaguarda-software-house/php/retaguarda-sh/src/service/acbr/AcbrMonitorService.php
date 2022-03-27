<?php

/*******************************************************************************
Title: T2Ti ERP 3.0
Description: Service relacionado ao ACBrMonitor
                                                                                
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

class AcbrMonitorService extends ServiceBase
{

  private static $caminhoComCnpj = '';

  public static function emitirNfce($numero, $cnpj, $nfceIni)
  {
		// configurações
		self::$caminhoComCnpj = "C:\\ACBrMonitor\\" . $cnpj . "\\";
		// salva o arquivo INI em disco
		$caminhoArquivoIniNfce = self::$caminhoComCnpj . "ini\\nfce\\" . $numero . ".ini";
    $ifp = fopen($caminhoArquivoIniNfce, 'wb');
    fwrite($ifp, base64_decode($nfceIni));
    fclose($ifp);

		// chama o método para criar a nota
		self::criarNFe($caminhoArquivoIniNfce);
		// pega o caminho do XML criado
		$caminhoArquivoXml = self::pegarRetornoSaida("ARQUIVO-XML");
		// chama o método para criar e enviar a nota
		self::enviarNFe($caminhoArquivoXml);
		$retorno = self::pegarRetornoSaida("Envio");
		if (!str_contains($retorno, "ERRO")) {
			  // chama o método para gerar o PDF
        self::imprimirDanfe($caminhoArquivoXml);
		    // captura o retorno do arquivo SAI
		    $retorno = self::pegarRetornoSaida("ARQUIVO-PDF");
		}		
		return $retorno;
  }

  public static function emitirNfceContingencia($numero, $cnpj, $nfceIni)
  {
		// configurações
		self::$caminhoComCnpj = "C:\\ACBrMonitor\\" . $cnpj . "\\";
		// salva o arquivo INI em disco
		$caminhoArquivoIniNfce = self::$caminhoComCnpj . "ini\\nfce\\" . $numero . ".ini";
    $ifp = fopen($caminhoArquivoIniNfce, 'wb');
    fwrite($ifp, base64_decode($nfceIni));
    fclose($ifp);

		// passa para o modo de emissão off-line
		self::passarParaModoOffLine();
		// chama o método para criar a nota
		self::criarNFe($caminhoArquivoIniNfce);
		// pega o caminho do XML criado
		$caminhoArquivoXml = self::pegarRetornoSaida("ARQUIVO-XML");
		// chama o método para gerar o PDF
		self::imprimirDanfe($caminhoArquivoXml);
		// captura o retorno do arquivo SAI
		$retorno = self::pegarRetornoSaida("ARQUIVO-PDF");
		// passa para o modo de emissão on-line
		self::passarParaModoOnLine();
	  
		return $retorno;
  }

  public static function transmitirNfceContingenciada($chave, $cnpj)
  {
		// configurações
		self::$caminhoComCnpj = "C:\\ACBrMonitor\\" . $cnpj . "\\";
		$caminhoArquivoXml = self::$caminhoComCnpj . "LOG_NFe\\" . $chave . "-nfe.xml";

		// chama o método para criar e enviar a nota
		self::enviarNFe($caminhoArquivoXml);		

		$retorno = self::pegarRetornoSaida("Envio");
		if (!str_contains($retorno, "ERRO")) {
			// chama o método para gerar o PDF
      self::imprimirDanfe($caminhoArquivoXml);
      // captura o retorno do arquivo SAI
      $retorno = self::pegarRetornoSaida("ARQUIVO-PDF");
  }
		
		return $retorno;
  }

  public static function tratarNotaAnteriorContingencia($objetoNfe)
  {
		// configurações
		self::$caminhoComCnpj = "C:\\ACBrMonitor\\" . $objetoNfe->cnpj . "\\";
		$caminhoArquivoXml = self::$caminhoComCnpj . "LOG_NFe\\" . $objetoNfe->chave . "-nfe.xml";

    self::apagarArquivoSaida();
    self::gerarArquivoEntrada("NFE.ConsultarNFe(" . $caminhoArquivoXml . ")");
    self::aguardarArquivoSaida();    

		$retorno = self::pegarRetornoSaida("Consulta");
		if (!str_contains($retorno, "ERRO")) {
			// se a nota anterior foi emitida = cancela. senão = inutiliza.
			if (str_contains($retorno, "Autorizado")) {
				$retorno = self::cancelarNfce($objetoNfe);
			} else {
				$retorno = self::inutilizarNumero($objetoNfe);
			}
		}
		
		return $retorno;
  }

  public static function inutilizarNumero($objetoNfe)
  {
		// configurações
		self::$caminhoComCnpj = "C:\\ACBrMonitor\\" . $objetoNfe->cnpj . "\\";
    self::apagarArquivoSaida();
    
    self::gerarArquivoEntrada("NFE.InutilizarNFe("
    .$objetoNfe->cnpj . ", "
    .$objetoNfe->justificativa . ", "
    .$objetoNfe->ano . ", "
    .$objetoNfe->modelo . ", "
    .$objetoNfe->serie . ", "
    .$objetoNfe->numeroInicial . ", "
    .$objetoNfe->numeroFinal . ")");

    self::aguardarArquivoSaida();    
		return self::pegarRetornoSaida("Inutilizacao");	
  }

  public static function cancelarNfce($objetoNfe)
  {
		// configurações
		self::$caminhoComCnpj = "C:\\ACBrMonitor\\" . $objetoNfe->cnpj . "\\";
    self::apagarArquivoSaida();
    self::gerarArquivoEntrada("NFe.CANCELARNFE(" . $objetoNfe->chaveAcesso . ", " . $objetoNfe->justificativa . ", " . $objetoNfe->cnpj . ")");

    self::aguardarArquivoSaida();    
		return self::pegarRetornoSaida("Cancelamento");	
  }

  public static function gerarPdfDanfeNfce($chave, $cnpj)
  {
		// configurações
		self::$caminhoComCnpj = "C:\\ACBrMonitor\\" . $cnpj . "\\";
		// pega o caminho do arquivo XML da nota em contingência
		$caminhoArquivoXml = self::$caminhoComCnpj . "LOG_NFe\\" . $chave . "-nfe.xml";
		// chama o método para gerar o PDF
		self::imprimirDanfe($caminhoArquivoXml);
		// captura o retorno do arquivo SAI
		return self::pegarRetornoSaida("ARQUIVO-PDF");	
  }

  public static function criarNFe($caminhoArquivoIniNfce)
  {
    self::apagarArquivoSaida();
    self::gerarArquivoEntrada("NFE.CriarNFe(" . $caminhoArquivoIniNfce . ")");
    self::aguardarArquivoSaida();    
  }

  public static function enviarNFe($caminhoArquivoXml)
  {
    self::apagarArquivoSaida();
    self::gerarArquivoEntrada("NFE.EnviarNFe(" . $caminhoArquivoXml . ", 001, , , , 1, , )");
    self::aguardarArquivoSaida();    
  }

  public static function imprimirDanfe($caminhoArquivoXml)
  {
    self::apagarArquivoSaida();
    self::gerarArquivoEntrada("NFE.ImprimirDANFEPDF(" . $caminhoArquivoXml . ", , , 1,)");
    self::aguardarArquivoSaida();    
  }

  public static function passarParaModoOffLine()
  {
    self::apagarArquivoSaida();
    self::gerarArquivoEntrada("NFE.SetFormaEmissao(9)"); // 1=normal
    self::aguardarArquivoSaida();    
  }

  public static function passarParaModoOnLine()
  {
    self::apagarArquivoSaida();
    self::gerarArquivoEntrada("NFE.SetFormaEmissao(1)"); // 1=normal
    self::aguardarArquivoSaida();    
  }

  public static function gerarZipArquivosXml($periodo, $cnpj)
  {
    $filtro = 'CNPJ = "' . $cnpj . '"';
    $empresa = Empresa::whereRaw($filtro)->get();
    if ($empresa->count() > 0) {
      $pasta = 'C:\\ACBrMonitor\\' . $cnpj . '\\DFes\\' . $periodo;
      $arquivoZip = 'C:\\ACBrMonitor\\' . $cnpj . '\\NotasFiscaisNFCe_' . $periodo . '.zip';
      Biblioteca::compactarPasta($pasta, $arquivoZip);
      return true;
    } else {
      return false;
    }
  }

  public static function atualizarCertificado($certificadoBase64, $senha, $cnpj)
  {
    $filtro = 'CNPJ = "' . $cnpj . '"';
    $empresaRetorno = Empresa::whereRaw($filtro)->get();
    if ($empresaRetorno->count() > 0) {
      $empresa = $empresaRetorno[0];

      // configura os caminhos
      self::$caminhoComCnpj = 'C:\\ACBrMonitor\\' . $empresa->cnpj . '\\';
      $caminhoArquivoCertificado = self::$caminhoComCnpj . $empresa->cnpj . '.pfx';

      // converte e salva o arquivo do certificado em disco
      $ifp = fopen($caminhoArquivoCertificado, 'wb');
      fwrite($ifp, base64_decode($certificadoBase64));
      fclose($ifp);

      self::apagarArquivoSaida();
      self::gerarArquivoEntrada("NFE.SetCertificado(" . $caminhoArquivoCertificado . "," . $senha . ")");
      self::aguardarArquivoSaida();

      Biblioteca::killTask('ACBrMonitor_' . $empresa->cnpj . '.exe');
      $caminhoExecutavel = self::$caminhoComCnpj . 'ACBrMonitor_' . $empresa->cnpj . '.exe';
      pclose(popen("start " . $caminhoExecutavel, "r"));
    }
  }

  public static function gerarArquivoEntrada($comando)
  {
    $nomeArquivoEntrada = self::$caminhoComCnpj . "\\ent.txt";
    $arquivoEntrada = fopen($nomeArquivoEntrada, "w");
    fwrite($arquivoEntrada, $comando);
    fclose($arquivoEntrada);
  }

  public static function pegarRetornoSaida($operacao)
  {
    $retorno = '';

    $nomeArquivoIni = self::$caminhoComCnpj . 'sai.txt';
    $arquivoCompleto = file_get_contents($nomeArquivoIni);

    $codigoStatus = Biblioteca::IniReadString($operacao, "CStat", $nomeArquivoIni);
    $motivo = Biblioteca::IniReadString($operacao, "XMotivo", $nomeArquivoIni);

    $caminhoArquivoXml = '';

    if ($operacao === 'ARQUIVO-XML') {
      $caminhoArquivoXml = $arquivoCompleto;
      $caminhoArquivoXml = trim(str_replace('OK: ', '', $caminhoArquivoXml));
      return $caminhoArquivoXml;
    }
    if ($operacao === 'ARQUIVO-PDF') {
      $retorno = $arquivoCompleto;
      $retorno = trim(str_replace('OK: Arquivo criado em: ', '', $arquivoCompleto));
      return $retorno;
    }
    if ($operacao === 'Envio') {
      $retorno = $motivo;
    }
    if ($operacao === 'Cancelamento') {
      $retorno = $motivo;
    }
    if ($operacao === 'Consulta') {
      $retorno = $motivo;
    }
    if ($operacao === 'Inutilizacao') {
      return $arquivoCompleto;
    }

    $listaStatus = array("", "100", "102", "135"); // se o status não for um dos que estiverem nessa lista, vamos retornar um erro.
    if (!in_array($codigoStatus, $listaStatus)) {
      return "[ERRO] - [" . $codigoStatus . "] " . $motivo;
    }

    return $retorno;
  }

  public static function apagarArquivoSaida()
  {
    unlink(self::$caminhoComCnpj . "\\sai.txt");
  }

  public static function aguardarArquivoSaida()
  {
    sleep(1);
    $tempoEspera = 0;
    while (!file_exists(self::$caminhoComCnpj . "\\sai.txt")) {
      sleep(1);
      $tempoEspera = $tempoEspera + 1;

      if ($tempoEspera > 30) {
        return false;
      }
    }
    return true;
  }
}
