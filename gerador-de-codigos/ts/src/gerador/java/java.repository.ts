import * as lodash from "lodash";

/// classe base que ajuda a gerar o repository do Java usando o mustache
export class JavaRepository {

    table: string; // armazena o nome da tabela
    modulo: string; // armazena o nome do package
    class: string; // armazena o nome da classe

    constructor(tabela: string, modulo: string) {
        // nome da classe
        this.class = lodash.camelCase(tabela);
        this.class = lodash.upperFirst(this.class);

        // nome da tabela
        this.table = tabela.toUpperCase();

        // package
        this.modulo = modulo;
    }

}