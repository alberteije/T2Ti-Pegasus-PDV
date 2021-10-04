import { connection } from "../config/db.config";

export class TabelaService {

    constructor() { }

    static async consultarLista(result: (lista: any, erro: any) => void) {
        try {
            let sql = "SELECT table_name AS nome " +
                "FROM " +
                "information_schema.tables " +
                "WHERE  " +
                "table_schema = DATABASE()";
            let dados = await (await connection).manager.query(sql);
            return result(dados, null);
        } catch (erro) {
            return result(null, erro);
        }
    }

    static async consultarListaCampos(tabela: string, result: (lista: any, erro: any) => void) {
        try {
            let sql = "SHOW FULL COLUMNS FROM " + tabela;
            let dados = await (await connection).manager.query(sql);
            return result(dados, null);
        } catch (erro) {
            return result(null, erro);
        }
    }

    static async consultarAgregados(tabela: string) {
        try {
            let sql = "SELECT TABLE_NAME, COLUMN_NAME " +
                "FROM information_schema.columns " +
                "WHERE table_schema='pegasus_pdv' and COLUMN_NAME = 'ID_" + tabela + "'";
            let dados = await (await connection).manager.query(sql);
            return dados;
        } catch (erro) {
            return erro;
        }
    }

    static async pegarCampos(tabela: string) {
        try {
            let sql = "SHOW FULL COLUMNS FROM " + tabela;
            let dados = await (await connection).manager.query(sql);
            return dados;
        } catch (erro) {
            return erro;
        }
    }

    /// esse método faz a mesma coisa do método consultarLista, 
    /// mas é implementado de uma maneira diferente para mostrar ao aluno as duas formas de fazer
    static async pegarTabelas() {
        try {
            let sql = "SELECT table_name AS nome " +
                "FROM " +
                "information_schema.tables " +
                "WHERE  " +
                "table_schema = DATABASE()";
            let dados = await (await connection).manager.query(sql);
            return dados;
        } catch (erro) {
            return erro;
        }
    }

    static async pegarDefinicao(tabela: string) {
        try {
            let sql = "show create table " + tabela;
            let dados = await (await connection).manager.query(sql);
            return dados;
        } catch (erro) {
            return erro;
        }
    }

    static async gerarComentariosJSON(sql: string) {
        try {
            let retorno = await (await connection).manager.query(sql);
            return retorno;
        } catch (erro) {
            return erro;
        }
    }

}