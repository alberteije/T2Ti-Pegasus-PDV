import * as lodash from "lodash";

/// classe base que ajuda a gerar o Viewmodel do Flutter usando o mustache
export class FlutterViewModel {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    objetoPrincipal: string; // armazena o nome da clase com a primeira letra em caixa baixa
    nomeArquivo: string; // armazena o nome do aruqivo que aparece no import

    constructor(tabela: string) {
        // nome da classe e objeto principal
        this.class = lodash.camelCase(tabela);
        this.objetoPrincipal = this.class;
        this.class = lodash.upperFirst(this.class);

        // nome da tabela
        this.table = tabela.toUpperCase();

        // nomeArquivo
        this.nomeArquivo = tabela.toLowerCase();
    }

}