import * as lodash from "lodash";

/// classe base que ajuda a gerar o arquivo com as exportações das entities
export class NodeModulesExport {

    imports = []; // armazena os imports para a classe
    modules = []; // armazena os nomes das classes que ficam dentro do array "imports" do Nest 

    constructor(modulo: string, listaTabelas: string[]) {
        let nomeTabela = "";
        let nomeClasse = "";
        let nomeArquivo = "";

        for (let i = 0; i < listaTabelas.length; i++) {
            nomeTabela = listaTabelas[i];
            nomeClasse = lodash.camelCase(nomeTabela);
            nomeClasse = lodash.upperFirst(nomeClasse);
            nomeArquivo = lodash.replace(nomeTabela.toLowerCase(), new RegExp("_", "g"), "-");

            // monta o import
            this.imports.push("import { " + nomeClasse + "Module } from '../" + modulo + "/" + nomeArquivo + "/" + nomeArquivo + ".module';");

            // monta o nome da classe do array "imports" do Nest
            this.modules.push(nomeClasse + "Module,");
        }


    }

}