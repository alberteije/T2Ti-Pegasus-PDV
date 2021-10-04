conexao = require('../config/db_config.js');

class TabelaService {

    static ConsultarLista(result) {

        var sql = "SELECT table_name AS nome " +
            "FROM " +
            "information_schema.tables " +
            "WHERE  " +
            "table_schema = DATABASE()";

        conexao.query(sql, (erro, res) => {
            if (null, erro) {
                result(null, erro);
                return;
            }
            result(res, null);
        });
    }

    static ConsultarListaCampos(tabela, result) {
        conexao.query('SHOW COLUMNS FROM ' + tabela, (erro, res) => {
            if (null, erro) {
                result(null, erro);
                return;
            }
            result(res, null);
        });
    }

}

module.exports = TabelaService;