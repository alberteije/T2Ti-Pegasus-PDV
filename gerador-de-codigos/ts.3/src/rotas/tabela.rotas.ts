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

        app.route('/laco/tabela/moor/:modulo')
            .get(this.controller.gerarArquivosLacoTabelaMoor);

        // comentários json na tabela
        app.route('/json/gerar/comentario/:nomeTabela')
            .get(this.controller.gerarComentariosTabela);

        app.route('/json/comentario/gerar/todos')
            .get(this.controller.gerarComentariosTodasTabelas);

    }
}