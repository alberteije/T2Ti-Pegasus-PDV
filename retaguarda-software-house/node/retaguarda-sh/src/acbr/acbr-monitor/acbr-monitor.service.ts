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
import { Injectable } from '@nestjs/common';
import { getConnection } from 'typeorm';
import { Empresa } from '../../entities-export';
import { Biblioteca } from '../../util/biblioteca';
import { ObjetoNfe } from '../../util/objeto.nfe';
import { Ini } from '../../util/ini';
import * as fs from "fs";

@Injectable()
export class AcbrMonitorService {

    caminhoComCnpj: string = "";	

	async emitirNfce(numero: string, cnpj: string, nfceIni: string): Promise<string> {
		// configurações
		this.caminhoComCnpj = "C:\\ACBrMonitor\\" + cnpj + "\\";
		
		// salva o arquivo INI em disco
		const caminhoArquivoIniNfce = this.caminhoComCnpj + "ini\\nfce\\" + numero + ".ini";
        let buff = Buffer.from(nfceIni, 'base64');
        fs.writeFileSync(caminhoArquivoIniNfce, buff);

		// chama o método para criar a nota
		await this.criarNFe(caminhoArquivoIniNfce);
		// pega o caminho do XML criado
		let caminhoArquivoXml = await this.pegarRetornoSaida("ARQUIVO-XML");
		// chama o método para criar e enviar a nota
		await this.enviarNFe(caminhoArquivoXml);
		let retorno = await this.pegarRetornoSaida("Envio");
		if (!retorno.includes("ERRO")) {
			// chama o método para gerar o PDF
		    await this.imprimirDanfe(caminhoArquivoXml);
		    // captura o retorno do arquivo SAI
		    retorno = await this.pegarRetornoSaida("ARQUIVO-PDF");
		}		
		return retorno;
    }

	async emitirNfceContingencia(numero: string, cnpj: string, nfceIni: string): Promise<string> {
		// configurações
		this.caminhoComCnpj = "C:\\ACBrMonitor\\" + cnpj + "\\";

		// salva o arquivo INI em disco
		const caminhoArquivoIniNfce = this.caminhoComCnpj + "ini\\nfce\\" + numero + ".ini";
        let buff = Buffer.from(nfceIni, 'base64');
        fs.writeFileSync(caminhoArquivoIniNfce, buff);
		
		// passa para o modo de emissão off-line
		await this.passarParaModoOffLine();
		// chama o método para criar a nota
		await this.criarNFe(caminhoArquivoIniNfce);
		// pega o caminho do XML criado
		const caminhoArquivoXml = await this.pegarRetornoSaida("ARQUIVO-XML");
		// chama o método para gerar o PDF
		await this.imprimirDanfe(caminhoArquivoXml);
		// captura o retorno do arquivo SAI
		let retorno = await this.pegarRetornoSaida("ARQUIVO-PDF");
		// passa para o modo de emissão on-line
		await this.passarParaModoOnLine();
	  
		return retorno;    
    }

	async transmitirNfceContingenciada(chave: string, cnpj: string): Promise<string> {
		// configurações
		this.caminhoComCnpj = "C:\\ACBrMonitor\\" + cnpj + "\\";
		const caminhoArquivoXml = this.caminhoComCnpj + "LOG_NFe\\" + chave + "-nfe.xml";
		// chama o método para criar e enviar a nota
		await this.enviarNFe(caminhoArquivoXml);		
		let retorno = await this.pegarRetornoSaida("Envio");
		if (!retorno.includes("ERRO")) {
			// chama o método para gerar o PDF
		    await this.imprimirDanfe(caminhoArquivoXml);
		    // captura o retorno do arquivo SAI
		    retorno = await this.pegarRetornoSaida("ARQUIVO-PDF");
		}		
		return retorno;
    }

	async tratarNotaAnteriorContingencia(objetoNfe: ObjetoNfe): Promise<string> {
		// configurações
		this.caminhoComCnpj = "C:\\ACBrMonitor\\" + objetoNfe.cnpj + "\\";
		const caminhoArquivoXml = this.caminhoComCnpj + "LOG_NFe\\" + objetoNfe.chaveAcesso + "-nfe.xml";

		// vamos verificar o status da nota
		await this.apagarArquivoSaida();
		await this.gerarArquivoEntrada("NFE.ConsultarNFe(" + caminhoArquivoXml + ")");
		await this.aguardarArquivoSaida();
		
		let retorno = await this.pegarRetornoSaida("Consulta");
		if (!retorno.includes("ERRO")) {
			// se a nota anterior foi emitida = cancela. senão = inutiliza.
			if (retorno.includes("Autorizado")) {
				retorno = await this.cancelarNfce(objetoNfe);
			} else {
				retorno = await this.inutilizarNumero(objetoNfe);
			}
		}
		
		return retorno;
    }

	async inutilizarNumero(objetoNfe: ObjetoNfe): Promise<string> {
		// configurações
		this.caminhoComCnpj = "C:\\ACBrMonitor\\" + objetoNfe.cnpj + "\\";
		await this.apagarArquivoSaida();
		
		await this.gerarArquivoEntrada("NFE.InutilizarNFe("
            +objetoNfe.cnpj +", "
            +objetoNfe.justificativa +", "
            +objetoNfe.ano +", "
            +objetoNfe.modelo +", "
            +objetoNfe.serie +", "
            +objetoNfe.numeroInicial +", "
            +objetoNfe.numeroFinal +")");

		await this.aguardarArquivoSaida();		
		const retorno = await this.pegarRetornoSaida("Inutilizacao");
		return retorno;
    }

	async cancelarNfce(objetoNfe: ObjetoNfe): Promise<string> {
		this.caminhoComCnpj = "C:\\ACBrMonitor\\" + objetoNfe.cnpj + "\\";
		await this.apagarArquivoSaida();
		await this.gerarArquivoEntrada("NFe.CANCELARNFE(" + objetoNfe.chaveAcesso + ", " + objetoNfe.justificativa + ", " + objetoNfe.cnpj + ")");
		await this.aguardarArquivoSaida();		
		const retorno = await this.pegarRetornoSaida("Cancelamento");
		return retorno;
    }

	async gerarPdfDanfeNfce(chave: string, cnpj: string): Promise<string> {
		// configurações
		this.caminhoComCnpj = "C:\\ACBrMonitor\\" + cnpj + "\\";		
		// pega o caminho do arquivo XML da nota em contingência
		const caminhoArquivoXml = this.caminhoComCnpj + "LOG_NFe\\" + chave + "-nfe.xml";
		// chama o método para gerar o PDF
		await this.imprimirDanfe(caminhoArquivoXml);
		// captura o retorno do arquivo SAI
		return this.pegarRetornoSaida("ARQUIVO-PDF");	
    }

    async criarNFe(caminhoArquivoIniNfce: string) {
		await this.apagarArquivoSaida();
		await this.gerarArquivoEntrada("NFE.CriarNFe(" + caminhoArquivoIniNfce + ")"); 
		await this.aguardarArquivoSaida();
    }

    async enviarNFe(caminhoArquivoXml: string) {
		await this.apagarArquivoSaida();
		await this.gerarArquivoEntrada("NFE.EnviarNFe(" + caminhoArquivoXml + ", 001, , , , 1, , )"); 
		await this.aguardarArquivoSaida();
    }

	async imprimirDanfe(caminhoArquivoXml: string) {
		await this.apagarArquivoSaida();
		await this.gerarArquivoEntrada("NFE.ImprimirDANFEPDF(" + caminhoArquivoXml + ", , , 1,)"); 
		await this.aguardarArquivoSaida();
	}

	async passarParaModoOffLine(): Promise<boolean> {
		await this.apagarArquivoSaida();
		await this.gerarArquivoEntrada("NFE.SetFormaEmissao(9)"); // 9=offline
		return this.aguardarArquivoSaida();
	}

	async passarParaModoOnLine(): Promise<boolean> {
		await this.apagarArquivoSaida();
		await this.gerarArquivoEntrada("NFE.SetFormaEmissao(1)"); // 1=normal
		return this.aguardarArquivoSaida();
	}

    async gerarZipArquivosXml(periodo: string, cnpj: string): Promise<boolean> {
        const connection = getConnection();
        const queryRunner = connection.createQueryRunner();  
        await queryRunner.connect();
        await queryRunner.startTransaction();

        let empresa = await connection.manager.findOne(Empresa, { where: { cnpj: cnpj }} );
        if (empresa != null) {
            const pasta = 'C:\\ACBrMonitor\\' + cnpj + '\\DFes\\' + periodo;
            const arquivoZip = 'C:\\ACBrMonitor\\' + cnpj + '\\NotasFiscaisNFCe_' + periodo + '.zip';
            var zipper = require('zip-local');
            zipper.sync.zip(pasta).compress().save(arquivoZip);
            return true;
        } else {
            return false;
        }
    }

    async atualizarCertificado(certificadoBase64: string, senha: string, cnpj: string) {
        const connection = getConnection();
        const queryRunner = connection.createQueryRunner();  
        await queryRunner.connect();
        await queryRunner.startTransaction();

        const empresa = await connection.manager.findOne(Empresa, { where: { cnpj: cnpj }} );
        if (empresa != null) {
		    // configura os caminhos
            this.caminhoComCnpj = 'C:\\ACBrMonitor\\' + empresa.cnpj + '\\';
		    const caminhoArquivoCertificado = this.caminhoComCnpj + empresa.cnpj + ".pfx";
		    
		    // converte e salva o arquivo do certificado em disco
            let buff = Buffer.from(certificadoBase64, 'base64');
            fs.writeFileSync(caminhoArquivoCertificado, buff);

		    await this.apagarArquivoSaida();
		    await this.gerarArquivoEntrada("NFE.SetCertificado(" + caminhoArquivoCertificado + "," + senha + ")");
		    await this.aguardarArquivoSaida();
						
            Biblioteca.killTask('ACBrMonitor_' + empresa.cnpj + '.exe');
            let caminhoExecutavel = this.caminhoComCnpj + 'ACBrMonitor_' + empresa.cnpj + '.exe';
            require('child_process').exec(caminhoExecutavel);        
        }
    }    

	async gerarArquivoEntrada(comando: string) {
		const nomeArquivo = this.caminhoComCnpj + "ent.txt";
		fs.writeFileSync(nomeArquivo, comando);
	}

	async pegarRetornoSaida(operacao: string): Promise<string> {
		let retorno: string = "";

		const nomeArquivo = this.caminhoComCnpj + "sai.txt";
        const arquivoSaida = new Ini(fs.readFileSync(nomeArquivo, {encoding: 'utf8'}));

        const arquivoCompleto = fs.readFileSync(this.caminhoComCnpj + "sai.txt", {encoding: 'utf8'}).toString();

        let codigoStatus: string = arquivoSaida.getKeyIfExists('CStat') == null ? '' : arquivoSaida.getKeyIfExists('CStat').val;
        let motivo: string = arquivoSaida.getKeyIfExists('XMotivo') == null ? '' : arquivoSaida.getKeyIfExists('XMotivo').val;

		let caminhoArquivoXml = "";

        if (operacao == "ARQUIVO-XML") {
            caminhoArquivoXml = arquivoCompleto.replace("OK: ", "");
            return caminhoArquivoXml.trim();
        } else if (operacao == "ARQUIVO-PDF") {
            let retorno = arquivoCompleto.replace("OK: Arquivo criado em: ", "");
            return retorno.trim();
        } else if (operacao == "Envio") {
            retorno = motivo;
        } else if (operacao == "Cancelamento") {
            retorno = motivo;
        } else if (operacao == "Consulta") {
            retorno = motivo;
        } else if (operacao == "Inutilizacao") {
            return arquivoCompleto;
        }
        
        const listaStatus = ["", "100" , "102", "135"]; // se o status não for um dos que estiverem nessa lista, vamos retornar um erro.
        
        if (listaStatus.filter(function (str) { return str.includes(codigoStatus); }).length == 0) {
            return "[ERRO] - [" + codigoStatus + "] " + motivo;
        }

		return retorno;
	}

	async apagarArquivoSaida() {
		const nomeArquivo = this.caminhoComCnpj + "sai.txt";
        if (fs.existsSync(nomeArquivo)) {
            fs.unlinkSync(nomeArquivo);
        }
	}

	async aguardarArquivoSaida(): Promise<boolean> {
		const nomeArquivo = this.caminhoComCnpj + "sai.txt";
        let tempoEspera = 0;
        while (!fs.existsSync(nomeArquivo)) { 
            await new Promise(resolve => setTimeout(resolve, 1000));
			tempoEspera++;
			
			if (tempoEspera > 30) {
				return false;
			}
        }
        return true;
	}


}