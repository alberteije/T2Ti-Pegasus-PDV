import * as lodash from "lodash";

/// classe base que ajuda a gerar o arquivo com as exportações das entities
export class NodeEntitiesExport {

    imports = []; // armazena os imports para a classe

    constructor(modulo: string, listaTabelas: string[]) {
        let nomeTabela = "";
        let nomeClasse = "";
        let nomeArquivo = "";

        for (let i = 0; i < listaTabelas.length; i++) {
            nomeTabela = listaTabelas[i];
            nomeClasse = lodash.camelCase(nomeTabela);
            nomeClasse = lodash.upperFirst(nomeClasse);
            nomeArquivo = lodash.replace(nomeTabela.toLowerCase(), new RegExp("_", "g"), "-");

            // monta o export
            this.imports.push("export { " + nomeClasse + " } from './" + modulo + "/" + nomeArquivo + "/" + nomeArquivo + ".entity';");
        }


    }

}