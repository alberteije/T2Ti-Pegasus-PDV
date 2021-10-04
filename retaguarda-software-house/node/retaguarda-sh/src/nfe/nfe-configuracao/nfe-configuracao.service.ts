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
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { getConnection, QueryRunner } from 'typeorm';
import { Empresa, AcbrMonitorPorta, NfeConfiguracao } from '../../entities-export';
import { Biblioteca } from '../../util/biblioteca';
import * as fs from "fs";
import * as INI from "easy-ini";

@Injectable()
export class NfeConfiguracaoService extends TypeOrmCrudService<NfeConfiguracao> {

  constructor(
    @InjectRepository(NfeConfiguracao) repository) { super(repository); }

    async atualizar(nfeConfiguracao: NfeConfiguracao, cnpj: string, decimaisQuantidade: number, decimaisValor: number): Promise<AcbrMonitorPorta> {
      const connection = getConnection();
      const queryRunner = connection.createQueryRunner();  
      await queryRunner.connect();
      await queryRunner.startTransaction();
            
      // salva o objeto de configuração no banco de dados
      let empresa = await connection.manager.findOne(Empresa, { where: { cnpj: cnpj }} );
      if (empresa != null) {
        nfeConfiguracao.empresa = empresa;
        nfeConfiguracao.caminhoSalvarXml.replace("\\", "\\\\");
        nfeConfiguracao.caminhoSalvarPdf.replace("\\", "\\\\");
        await queryRunner.manager.save(nfeConfiguracao);

        // verificar se já existe uma porta definida para o monitor da empresa
        // ALTER TABLE acbr_monitor_porta AUTO_INCREMENT=3435; - executa um comando no banco de dados para definir a porta inicial para o ID
        let portaMonitor = await connection.manager.findOne(AcbrMonitorPorta, { where: { empresa: empresa }} );
        if (portaMonitor == null) {
          let portaMonitor = new AcbrMonitorPorta({});
          portaMonitor.empresa = empresa;
          await queryRunner.manager.save(portaMonitor);
        }

        // criar a pasta do monitor para a empresa
        const exec = require('child_process').execSync;
        var result = exec('cmd /c c:\\ACBrMonitor\\CopiarBase.bat ' + cnpj);        

        // let caminhoComCnpj = 'C:\\ACBrMonitor\\' + empresa.cnpj + '\\';
        // let caminhoExecutavel = caminhoComCnpj + 'ACBrMonitor_' + empresa.cnpj + '.exe';
        // require('child_process').exec(caminhoExecutavel);

        // configurar o arquivo INI
        await this.configurarArquivoIniMonitor(nfeConfiguracao, empresa, decimaisQuantidade, decimaisValor, portaMonitor.id);

        await queryRunner.commitTransaction();

        return portaMonitor;        
      } else {
        return null;
      }

    }  

    async configurarArquivoIniMonitor(nfeConfiguracao: NfeConfiguracao, empresa: Empresa, decimaisQuantidade: number, decimaisValor: number, portaMonitor: number) {
      let caminhoComCnpj = 'C:\\ACBrMonitor\\' + empresa.cnpj + '\\';
      nfeConfiguracao.caminhoSalvarPdf = caminhoComCnpj + 'PDF';
      nfeConfiguracao.caminhoSalvarXml = caminhoComCnpj + 'DFes';

      let nomeArquivoIni = caminhoComCnpj + 'ACBrMonitor.ini';
      fs.writeFileSync(nomeArquivoIni, '');
      const acbrMonitorIni = new INI(fs.readFileSync(nomeArquivoIni, {encoding: 'utf8'}));

      try {
        //*******************************************************************************************
        //  [ACBrMonitor]
        //*******************************************************************************************
        Biblioteca.iniWriteString('ACBrMonitor', 'TCP_Porta', portaMonitor.toString(), acbrMonitorIni);

        //*******************************************************************************************
        //  [ACBrNFeMonitor]
        //*******************************************************************************************
        Biblioteca.iniWriteString('ACBrNFeMonitor', 'Arquivo_Log_Comp', caminhoComCnpj + 'LOG_DFe.TXT', acbrMonitorIni);
        Biblioteca.iniWriteString('ACBrNFeMonitor', 'ArquivoWebServices', caminhoComCnpj + 'ACBrNFeServicos.ini', acbrMonitorIni);
        Biblioteca.iniWriteString('ACBrNFeMonitor', 'ArquivoWebServicesCTe', caminhoComCnpj + 'ACBrCTeServicos.ini', acbrMonitorIni);
        Biblioteca.iniWriteString('ACBrNFeMonitor', 'ArquivoWebServicesMDFe', caminhoComCnpj + 'ACBrMDFeServicos.ini', acbrMonitorIni);
        Biblioteca.iniWriteString('ACBrNFeMonitor', 'ArquivoWebServicesGNRe', caminhoComCnpj + 'ACBrGNREServicos.ini', acbrMonitorIni);
        Biblioteca.iniWriteString('ACBrNFeMonitor', 'ArquivoWebServiceseSocial', caminhoComCnpj + 'ACBreSocialServicos.ini', acbrMonitorIni);
        Biblioteca.iniWriteString('ACBrNFeMonitor', 'ArquivoWebServicesReinf', caminhoComCnpj + 'ACBrReinfServicos.ini', acbrMonitorIni);
        Biblioteca.iniWriteString('ACBrNFeMonitor', 'ArquivoWebServicesBPe', caminhoComCnpj + 'ACBrBPeServicos.ini', acbrMonitorIni);

        //*******************************************************************************************
        //  [WebService]
        //*******************************************************************************************
        // tpAmb - 1-Produção/ 2-Homologação
        // OBS: o monitor leva em conta o índice do Radiogroup, ou seja, será 0 para produção e 1 para homologação
        let ambiente = nfeConfiguracao.webserviceAmbiente - 1;
        Biblioteca.iniWriteString('WebService', 'Ambiente', ambiente.toString(), acbrMonitorIni);
        Biblioteca.iniWriteString('WebService', 'UF', empresa.uf, acbrMonitorIni);

        //*******************************************************************************************
        //  [RespTecnico]
        //*******************************************************************************************
        if (nfeConfiguracao.respTecHashCsrt != '0')
            Biblioteca.iniWriteString('RespTecnico', 'CSRT', nfeConfiguracao.respTecHashCsrt, acbrMonitorIni);
        if (nfeConfiguracao.respTecIdCsrt != '0')
            Biblioteca.iniWriteString('RespTecnico', 'idCSRT', nfeConfiguracao.respTecIdCsrt, acbrMonitorIni);

        //*******************************************************************************************
        //  [NFCe]
        //*******************************************************************************************
        Biblioteca.iniWriteString('NFCe', 'IdToken', nfeConfiguracao.nfceIdCsc, acbrMonitorIni);
        Biblioteca.iniWriteString('NFCe', 'Token', nfeConfiguracao.nfceCsc, acbrMonitorIni);
        if (nfeConfiguracao.nfceModeloImpressao == 'A4')
            Biblioteca.iniWriteString('NFCe', 'ModoImpressaoEvento', '0', acbrMonitorIni);
        else
            Biblioteca.iniWriteString('NFCe', 'ModoImpressaoEvento', '1', acbrMonitorIni);
        if (nfeConfiguracao.nfceImprimirItensUmaLinha == 'S')
            Biblioteca.iniWriteString('NFCe', 'ImprimirItem1Linha', '1', acbrMonitorIni);
        else
            Biblioteca.iniWriteString('NFCe', 'ImprimirItem1Linha', '0', acbrMonitorIni);
        if (nfeConfiguracao.nfceImprimirDescontoPorItem == 'S')
            Biblioteca.iniWriteString('NFCe', 'ImprimirDescAcresItem', '1', acbrMonitorIni);
        else
            Biblioteca.iniWriteString('NFCe', 'ImprimirDescAcresItem', '0', acbrMonitorIni);
        if (nfeConfiguracao.nfceImprimirQrcodeLateral == 'S')
            Biblioteca.iniWriteString('NFCe', 'QRCodeLateral', '1', acbrMonitorIni);
        else
            Biblioteca.iniWriteString('NFCe', 'QRCodeLateral', '0', acbrMonitorIni);
        if (nfeConfiguracao.nfceImprimirGtin == 'S')
            Biblioteca.iniWriteString('NFCe', 'UsaCodigoEanImpressao', '1', acbrMonitorIni);
        else
            Biblioteca.iniWriteString('NFCe', 'UsaCodigoEanImpressao', '0', acbrMonitorIni);
        if (nfeConfiguracao.nfceImprimirNomeFantasia == 'S')
            Biblioteca.iniWriteString('NFCe', 'ImprimeNomeFantasia', '1', acbrMonitorIni);
        else
            Biblioteca.iniWriteString('NFCe', 'ImprimeNomeFantasia', '0', acbrMonitorIni);
        if (nfeConfiguracao.nfceImpressaoTributos == 'S')
            Biblioteca.iniWriteString('NFCe', 'ExibeTotalTributosItem', '1', acbrMonitorIni);
        else
            Biblioteca.iniWriteString('NFCe', 'ExibeTotalTributosItem', '0', acbrMonitorIni);

        //*******************************************************************************************
        //  [DANFCe]
        //*******************************************************************************************
        Biblioteca.iniWriteString('DANFCe', 'MargemInf', nfeConfiguracao.nfceMargemInferior.toString().replace('.', ','), acbrMonitorIni);
        Biblioteca.iniWriteString('DANFCe', 'MargemSup', nfeConfiguracao.nfceMargemSuperior.toString().replace('.', ','), acbrMonitorIni);
        Biblioteca.iniWriteString('DANFCe', 'MargemDir', nfeConfiguracao.nfceMargemDireita.toString().replace('.', ','), acbrMonitorIni);
        Biblioteca.iniWriteString('DANFCe', 'MargemEsq', nfeConfiguracao.nfceMargemEsquerda.toString().replace('.', ','), acbrMonitorIni);
        Biblioteca.iniWriteString('DANFCe', 'LarguraBobina', nfeConfiguracao.nfceResolucaoImpressao.toString(), acbrMonitorIni);

        //*******************************************************************************************
        //  [FonteLinhaItem]
        //*******************************************************************************************
        Biblioteca.iniWriteString('FonteLinhaItem', 'Size', nfeConfiguracao.nfceTamanhoFonteItem.toString(), acbrMonitorIni);

        //*******************************************************************************************
        //  [DANFE]
        //*******************************************************************************************
        Biblioteca.iniWriteString('DANFE', 'PathPDF', nfeConfiguracao.caminhoSalvarPdf, acbrMonitorIni);
        Biblioteca.iniWriteString('DANFE', 'DecimaisQTD', decimaisQuantidade.toString(), acbrMonitorIni);
        Biblioteca.iniWriteString('DANFE', 'DecimaisValor', decimaisValor.toString(), acbrMonitorIni);

        //*******************************************************************************************
        //  [Arquivos]
        //*******************************************************************************************
        Biblioteca.iniWriteString('Arquivos', 'PathNFe', nfeConfiguracao.caminhoSalvarXml, acbrMonitorIni);
        Biblioteca.iniWriteString('Arquivos', 'PathInu', caminhoComCnpj + 'Inutilizacao', acbrMonitorIni);
        Biblioteca.iniWriteString('Arquivos', 'PathDPEC', caminhoComCnpj + 'EPEC', acbrMonitorIni);
        Biblioteca.iniWriteString('Arquivos', 'PathEvento', caminhoComCnpj + 'Evento', acbrMonitorIni);
        Biblioteca.iniWriteString('Arquivos', 'PathArqTXT', caminhoComCnpj + 'TXT', acbrMonitorIni);
        Biblioteca.iniWriteString('Arquivos', 'PathDonwload', caminhoComCnpj + 'DistribuicaoDFe', acbrMonitorIni);

        const arquivoFinalizado = acbrMonitorIni.createINIString();
        fs.writeFileSync(nomeArquivoIni, arquivoFinalizado);
      } finally {
        Biblioteca.killTask('ACBrMonitor_' + empresa.cnpj + '.exe');
        let caminhoExecutavel = caminhoComCnpj + 'ACBrMonitor_' + empresa.cnpj + '.exe';
        require('child_process').exec(caminhoExecutavel);
      }
    }
 
    async atualizarCertificado(certificadoBase64: string, senha: string, cnpj: string) {
        const connection = getConnection();
        const queryRunner = connection.createQueryRunner();  
        await queryRunner.connect();
        await queryRunner.startTransaction();

        let empresa = await connection.manager.findOne(Empresa, { where: { cnpj: cnpj }} );
        if (empresa != null) {
		    // encerra o Monitor
            Biblioteca.killTask('ACBrMonitor_' + empresa.cnpj + '.exe');

		    // configura os caminhos
            let caminhoComCnpj = 'C:\\ACBrMonitor\\' + empresa.cnpj + '\\';
		    let caminhoArquivoCertificado = caminhoComCnpj + empresa.cnpj + ".pfx";
		    
		    // converte e salva o arquivo do certificado em disco
            let buff = new Buffer(certificadoBase64, 'base64');
            fs.writeFileSync(caminhoArquivoCertificado, buff);

		    // vamos alterar o monitor para receber dados em arquivo TXT para armazenar os dados do certificado
		    // faremos dessa maneira porque o monitor criptografa a senha
            let nomeArquivoIni = caminhoComCnpj + 'ACBrMonitor.ini';
            fs.writeFileSync(nomeArquivoIni, '');
            const acbrMonitorIni = new INI(fs.readFileSync(nomeArquivoIni, {encoding: 'utf8'}));
			
			try {
                //*******************************************************************************************
                //  [ACBrMonitor]
                //*******************************************************************************************
                Biblioteca.iniWriteString('Arquivos', 'Modo_TCP', '0', acbrMonitorIni);
                Biblioteca.iniWriteString('Arquivos', 'Modo_TXT', '1', acbrMonitorIni);
                
                const arquivoFinalizado = acbrMonitorIni.createINIString();
                fs.writeFileSync(nomeArquivoIni, arquivoFinalizado);
            } finally {
                let caminhoExecutavel = caminhoComCnpj + 'ACBrMonitor_' + empresa.cnpj + '.exe';
                require('child_process').exec(caminhoExecutavel);
            }
			
			await this.gerarArquivoEntradaMonitor(caminhoArquivoCertificado, senha, cnpj);
			
            while (!fs.existsSync("c:\\ACBrMonitor\\" + cnpj + "\\sai.txt")) { }
			
		    // altera novamente o monitor para o modo TCP
			try {
                //*******************************************************************************************
                //  [ACBrMonitor]
                //*******************************************************************************************
                Biblioteca.iniWriteString('Arquivos', 'Modo_TCP', '1', acbrMonitorIni);
                Biblioteca.iniWriteString('Arquivos', 'Modo_TXT', '0', acbrMonitorIni);
                
                const arquivoFinalizado = acbrMonitorIni.createINIString();
                fs.writeFileSync(nomeArquivoIni, arquivoFinalizado);
			} finally {
                Biblioteca.killTask('ACBrMonitor_' + empresa.cnpj + '.exe');
                let caminhoExecutavel = caminhoComCnpj + 'ACBrMonitor_' + empresa.cnpj + '.exe';
                require('child_process').exec(caminhoExecutavel);
            }			
        }

    }    

    async gerarArquivoEntradaMonitor(caminhoArquivoCertificado: string, senha: string, cnpj: string) {
        //  apaga o arquivo 'SAI.TXT'
        let nomeArquivoApagar = "c:\\ACBrMonitor\\" + cnpj + "\\sai.txt";
        try {
            fs.unlinkSync(nomeArquivoApagar);
            //file removed
        } catch(err) {
            console.error(err);
        }		
          
        //  cria o arquivo 'ENT.TXT'
        let nomeArquivo = "c:\\ACBrMonitor\\" + cnpj + "\\ENT.TXT";
        let conteudoArquivo = "NFE.SetCertificado(" + caminhoArquivoCertificado + "," + senha + ")";
        fs.writeFileSync(nomeArquivo, conteudoArquivo);
    }        

    async gerarZipArquivosXml(periodo: string, cnpj: string): Promise<boolean> {
        const connection = getConnection();
        const queryRunner = connection.createQueryRunner();  
        await queryRunner.connect();
        await queryRunner.startTransaction();

        let empresa = await connection.manager.findOne(Empresa, { where: { cnpj: cnpj }} );
        if (empresa != null) {
            const pasta = 'C:\\ACBrMonitor\\' + cnpj + '\\DFes\\NFCe\\' + periodo;
            const arquivoZip = 'C:\\ACBrMonitor\\' + cnpj + '\\NotasFiscaisNFCe_' + periodo + '.zip';
            var zipper = require('zip-local');
            zipper.sync.zip(pasta).compress().save(arquivoZip);
            return true;
        } else {
            return false;
        }
    }
}