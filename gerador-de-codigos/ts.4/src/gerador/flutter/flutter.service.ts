import * as lodash from "lodash";

/// classe base que ajuda a gerar o service do Flutter usando o mustache
export class FlutterService {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    objetoPrincipal: string; // armazena o nome da clase com a primeira letra em caixa baixa
    path: string; // armazena o caminho para a API REST
    nomeArquivo: string; // armazena o nome do aruqivo que aparece no import
    tituloRelatorio: string; // armazena o título do relatório


    constructor(tabela: string) {
        // nome da classe e objeto principal
        this.class = lodash.camelCase(tabela);
        this.objetoPrincipal = this.class;
        this.class = lodash.upperFirst(this.class);

        // título do relatório
        this.tituloRelatorio = lodash.startCase(this.class);

        // nome da tabela
        this.table = tabela.toUpperCase();

        // path
        this.path = lodash.replace(tabela.toLowerCase(), new RegExp("_", "g"), "-");

        // nomeArquivo
        this.nomeArquivo = tabela.toLowerCase();
    }

}