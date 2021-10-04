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

export class Biblioteca {

    constructor() { }

    /**
      * Salva o arquivo no disco
      */
    static async gravarArquivo(caminho: string, conteudo: any) {
        fs.writeFileSync(caminho, conteudo);
    }

    /**
      * Salva o log num arquivo no disco
      */
    static async gravarLog(arquivo: string, mensagem: any) {
        fs.appendFileSync(arquivo, mensagem);
    }

    /**
      * Verifica se o JSON é válido
      */
    static isJsonString(tabela: string, stringJson: string) {
        try {
            JSON.parse(stringJson);
        } catch (e) {
            this.gravarLog("c:\\t2ti\\log\\gerador.txt", "TABELA: " + tabela + " | stringJson: " + stringJson + " | Erro: " + e.message + "\n");
            return false;
        }
        return true;
    }

}