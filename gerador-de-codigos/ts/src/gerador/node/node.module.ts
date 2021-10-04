import * as lodash from "lodash";

/// classe base que ajuda a gerar o module do Node usando o mustache
export class NodeModule {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    classFile: string; // armazena o nome do arquivo da classe
    path: string; // armazena o caminho para a API REST

    constructor(tabela: string) {
        // nome da classe
        this.classFile = lodash.camelCase(tabela);
        this.class = lodash.upperFirst(this.classFile);

        // nome da tabela
        this.table = tabela.toUpperCase();

        // path
        this.path = lodash.replace(tabela.toLowerCase(), new RegExp("_", "g"), "-");
    }

}