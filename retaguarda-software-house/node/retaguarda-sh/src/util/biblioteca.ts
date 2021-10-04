/********************************************************************************
Title: T2Ti ERP Fenix
Description: Biblioteca de funções.

The MIT License

Copyright: Copyright (C) 2020 T2Ti.COM

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

@author T2Ti.COM
@version 1.0
********************************************************************************/
import * as fs from "fs";
const {exec} = require('child_process');
import * as INI from "easy-ini";

export class Biblioteca {

    constructor() { }

    /**
      * Salva o arquivo no disco
      */
     static async gravarArquivo(caminho: string, conteudo: any) {
        fs.writeFile(caminho, conteudo, function (erro: any) {
            if (erro) {
                return erro;
            } else {
                return true;
            }
        });
    }

    /**
     * recebe a seção, chave e valor de forma separada e devolve de acordo com o esperado
     * pela lib Easy-INI no método putStringInSection
     * 
     * @param secao - seção desejada do INI
     * @param chave - chave desejada para a seção
     * @param valor - valor desejado para a chave
     */
    static iniWriteString(secao: string, chave:string, valor:string, arquivoIni: any) {
        arquivoIni.putStringInSection(chave + '=' + valor, '[' + secao + ']');
    }

    static arredondaTruncaValor(pOperacao: string, pValor: number, pCasas: number)
    {
        return pValor;
        // TODO: implementar arredondamento e truncamento
    }

    static uFToInt(pUF: string)
    {
        if (pUF == "RO")
        {
            return 11;
        }
        else if (pUF == "AC")
        {
            return 12;
        }
        else if (pUF == "AM")
        {
            return 13;
        }
        else if (pUF == "RR")
        {
            return 14;
        }
        else if (pUF == "PA")
        {
            return 15;
        }
        else if (pUF == "AP")
        {
            return 16;
        }
        else if (pUF == "TO")
        {
            return 17;
        }
        else if (pUF == "MA")
        {
            return 21;
        }
        else if (pUF == "PI")
        {
            return 22;
        }
        else if (pUF == "CE")
        {
            return 23;
        }
        else if (pUF == "RN")
        {
            return 24;
        }
        else if (pUF == "PB")
        {
            return 25;
        }
        else if (pUF == "PE")
        {
            return 26;
        }
        else if (pUF == "AL")
        {
            return 27;
        }
        else if (pUF == "SE")
        {
            return 28;
        }
        else if (pUF == "BA")
        {
            return 29;
        }
        else if (pUF == "MG")
        {
            return 31;
        }
        else if (pUF == "ES")
        {
            return 32;
        }
        else if (pUF == "RJ")
        {
            return 33;
        }
        else if (pUF == "SP")
        {
            return 35;
        }
        else if (pUF == "PR")
        {
            return 41;
        }
        else if (pUF == "SC")
        {
            return 42;
        }
        else if (pUF == "RS")
        {
            return 43;
        }
        else if (pUF == "MS")
        {
            return 50;
        }
        else if (pUF == "MT")
        {
            return 51;
        }
        else if (pUF == "GO")
        {
            return 52;
        }
        else if (pUF == "DF")
        {
            return 53;
        }
        else
        {
            return 0;
        }
    }

    static intToUF(pUF: number)
    {
        if (pUF == 11)
        {
            return "RO";
        }
        else if (pUF == 12)
        {
            return "AC";
        }
        else if (pUF == 13)
        {
            return "AM";
        }
        else if (pUF == 14)
        {
            return "RR";
        }
        else if (pUF == 15)
        {
            return "PA";
        }
        else if (pUF == 16)
        {
            return "AP";
        }
        else if (pUF == 17)
        {
            return "TO";
        }
        else if (pUF == 21)
        {
            return "MA";
        }
        else if (pUF == 22)
        {
            return "PI";
        }
        else if (pUF == 23)
        {
            return "CE";
        }
        else if (pUF == 24)
        {
            return "RN";
        }
        else if (pUF == 25)
        {
            return "PB";
        }
        else if (pUF == 26)
        {
            return "PE";
        }
        else if (pUF == 27)
        {
            return "AL";
        }
        else if (pUF == 28)
        {
            return "SE";
        }
        else if (pUF == 29)
        {
            return "BA";
        }
        else if (pUF == 31)
        {
            return "MG";
        }
        else if (pUF == 32)
        {
            return "ES";
        }
        else if (pUF == 33)
        {
            return "RJ";
        }
        else if (pUF == 35)
        {
            return "SP";
        }
        else if (pUF == 41)
        {
            return "PR";
        }
        else if (pUF == 42)
        {
            return "SC";
        }
        else if (pUF == 43)
        {
            return "RS";
        }
        else if (pUF == 50)
        {
            return "MS";
        }
        else if (pUF == 51)
        {
            return "MT";
        }
        else if (pUF == 52)
        {
            return "GO";
        }
        else if (pUF == 53)
        {
            return "DF";
        }
        else
        {
            return "";
        }
    }

	static pegarPlanoPdv(descricaoProduto: string): string {
	  if (descricaoProduto.includes("Mensal")) {
		  return "M";
	  } else if (descricaoProduto.includes("Semestral")) {
		  return "S";
	  } else if (descricaoProduto.includes("Anual")) {
		  return "A";
	  } else {
		  return "";		  
	  }
	}

	static pegarModuloFiscalPdv(descricaoProduto: string): string {
	  if (descricaoProduto.includes("NFC")) {
		  return "NFC";
	  } else if (descricaoProduto.includes("SAT")) {
		  return "SAT";
	  } else if (descricaoProduto.includes("MFE")) {
		  return "MFE";
	  } else {
		  return "";		  
	  }
	}

    static killTask(appName: string) {
        exec('taskkill /im ${appName} /t', (err, stdout, stderr) => {
            if (err) {
              throw err
            }        
            // console.log('stdout', stdout)
            // console.log('stderr', err)
          })                
    }
	
    static md5String(texto: string): string {
        var crypto = require('crypto');
        return crypto.createHash('md5').update(texto).digest("hex");    
    }

	// fonte: https://morioh.com/p/ca75996654d1
    static enviarEmail(assunto: string, destino: string, corpo: string): boolean {
        let nomeArquivoIni = "c:\\t2ti\\config-email.ini";
        const iniFile = new INI(fs.readFileSync(nomeArquivoIni, {encoding: 'utf8'}));
        
		let host = iniFile.getKeyIfExists('Host').val;
		let port = iniFile.getKeyIfExists('Port').val;
		let from = iniFile.getKeyIfExists('From').val;
		//let bccList = iniFile.getKeyIfExists('BccList').val;
		let userName = iniFile.getKeyIfExists('Username').val;
		let password = iniFile.getKeyIfExists('Password').val;

        var nodemailer = require('nodemailer');
        var mail = nodemailer.createTransport({
            service: 'gmail',
            auth: {
              user: userName,
              pass: password
            }
          }
        );        

        var mailOptions = {
            from: from,
            to: destino,
            subject: assunto,
            text: corpo
        };

        mail.sendMail(mailOptions, function(error, info){
            if (error) {
              console.log(error);
            } else {
              console.log('Email sent: ' + info.response);
            }
          }
        );

        return true
    }
    
}