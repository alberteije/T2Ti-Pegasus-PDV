import * as express from 'express';
import { TabelaRotas } from "./rotas/tabela.rotas";
import bodyParser = require("body-parser");

class App {
    public app: express.Application;
    public tabelaRotas: TabelaRotas;

    constructor() {
        // iniciando o express
        this.app = express();

        // faz o parse do content-type do request - tipo: application/json
        this.app.use(bodyParser.json());

        // faz o parse do content-type do request - tipo: application/x-www-form-urlencoded
        this.app.use(bodyParser.urlencoded({ extended: true })); //extended: true - pode enviar objetos aninhados

        // adicionar uma rota simples padrão
        this.app.get('/', (req, res) => {
            res.json({ mensagem: "Olá, você está no Gerador de Código do T2Ti ERP Fenix!" });
        });

        // rotas
        this.tabelaRotas = new TabelaRotas();
        this.tabelaRotas.routes(this.app);
    }
}

export default new App().app;