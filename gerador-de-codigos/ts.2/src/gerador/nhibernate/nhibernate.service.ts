import * as lodash from "lodash";

/// classe base que ajuda a gerar o service do NHibernate usando o mustache
export class NHibernateService {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe

    constructor(tabela: string) {
        // nome da classe
        this.class = lodash.camelCase(tabela);
        this.class = lodash.upperFirst(this.class);

        // nome da tabela
        this.table = tabela.toUpperCase();
    }

}