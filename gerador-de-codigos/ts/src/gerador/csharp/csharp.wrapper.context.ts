import * as lodash from "lodash";

/// classe base que ajuda a gerar o controller do CSharp usando o mustache
export class CSharpWrapperContext {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    objetoPrincipal: string; //armazena o nome do objeto principal, que costuma ser o nome da classe com a primeira letra em minúsculo

    constructor(tabela: string) {
        // nome da classe
        this.class = lodash.camelCase(tabela);
        this.objetoPrincipal = this.class;
        this.class = lodash.upperFirst(this.class);
    }

}