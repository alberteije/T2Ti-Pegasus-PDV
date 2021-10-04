import * as fs from "fs";

export class GeradorBase {

    constructor() { }

    /**
      * Cria o diretório que armazenará os arquivos (código fonte gerado) da tabela selecionada
      */
    async criarDiretorio(caminho: string) {
        try {
            if (!fs.existsSync(caminho)) {
                fs.mkdirSync(caminho);
            }
            return true;
        } catch (erro) {
            return erro;
        }
    }

    /**
      * Salva o arquivo no disco
      */
    async gravarArquivo(caminho: string, conteudo: any) {
        fs.writeFile(caminho, conteudo, function (erro: any) {
            if (erro) {
                return erro;
            } else {
                return true;
            }
        });
    }


}
