conexao = require('../config/db_config.js');
const Banco = require('../model/banco.js');

class BancoService {

    static ConsultarLista(result) {
        Banco.findAll().then(listaBanco => {
            result(listaBanco, null);
        }).catch(function (erro) {
            result(null, erro);
        });
    }

    static ConsultarListaFiltroValor(filtro, result) {
        var sql = "select * from banco where " + filtro.where;
        Banco.sequelize
            .query(sql, {
                model: Banco,
                mapToModel: true // para verificar os campos mapeados
            })
            .then(listaBanco => {
                result(listaBanco, null);
            })
            .catch(function (erro) {
                result(null, erro);
            });
    }

    static ConsultarObjeto(Id, result) {
        Banco.findByPk(Id).then(banco => {
            result(banco, null);
        }).catch(function (erro) {
            result(null, erro);
        });
    }

    static Inserir(bancoJson, result) {
        Banco.create(bancoJson).then(banco => {
            result(banco, null);
        }).catch(function (erro) {
            result(null, erro);
        });
    }

    static Alterar(bancoJson, result) {
        Banco.update(bancoJson, {
            where: {
                id: bancoJson.id
            }
        }).then(registrosAtualizados => {
            result(registrosAtualizados[0], null);
        }).catch(function (erro) {
            result(null, erro);
        });
    }

    static Excluir(Id, result) {
        Banco.destroy({
            where: {
                id: Id
            }
        }).then(registrosAtualizados => {
            result(registrosAtualizados[0], null);
        }).catch(function (erro) {
            result(null, erro);
        });
    }

}

module.exports = BancoService;