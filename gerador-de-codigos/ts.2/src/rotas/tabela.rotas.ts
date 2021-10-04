import { TabelaController } from "../controller/tabela.controller";

export class TabelaRotas {

    private controller: TabelaController;

    constructor() {
        this.controller = new TabelaController();
    }

    public routes(app: any): void {
        app.route('/tabela')
            .get(this.controller.consultarLista);

        app.route('/tabela/:nomeTabela')
            .get(this.controller.consultarListaCampos);

        app.route('/:linguagem/:nomeTabela/:modulo?')
            .get(this.controller.gerarFontes);

        app.route('/gerar/todos/arquivos/:linguagem/:modulo?')
            .get(this.controller.gerarTudo);

        app.route('/laco/tabela/node/:modulo')
            .get(this.controller.gerarArquivosLacoTabelaNode);

        app.route('/laco/tabela/php/:modulo')
            .get(this.controller.gerarArquivosLacoTabelaPHP);

        app.route('/laco/tabela/delphi/:modulo')
            .get(this.controller.gerarArquivosLacoTabelaDelphi);

        app.route('/laco/tabela/flutter/:modulo')
            .get(this.controller.gerarArquivosLacoTabelaFlutter);
    }
}