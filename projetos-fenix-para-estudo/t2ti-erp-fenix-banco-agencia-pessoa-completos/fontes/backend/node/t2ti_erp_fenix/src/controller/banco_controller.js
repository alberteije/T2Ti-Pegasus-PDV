const BancoService = require('../service/banco_service.js');
const RetornoJsonErro = require('../model/transiente/retorno_json_erro.js');
const Filtro = require('../model/transiente/filtro.js');

// consultar a lista
exports.ConsultarLista = (req, res) => {
    BancoService.ConsultarLista((listaBanco, erro) => {
        if (erro != null) {
            var jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Consultar Lista Banco]", erro: erro });
            res.status(500).send(jsonErro);
        } else {
            res.send(listaBanco);
        }
    });
};

// consultar a lista com filtro
exports.ConsultarListaFiltroValor = (req, res) => {
    var filtro = new Filtro({campo: req.params.campo, valor: req.params.valor})
    BancoService.ConsultarListaFiltroValor(filtro, (listaBanco, erro) => {
        if (erro != null) {
            var jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Consultar Lista Banco]", erro: erro });
            res.status(500).send(jsonErro);
        } else {
            res.send(listaBanco);
        }
    });
};

// consultar um objeto
exports.ConsultarObjeto = (req, res) => {
    BancoService.ConsultarObjeto(req.params.Id, (banco, erro) => {
        if (erro != null) {
            var jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Consultar Objeto Banco]", erro: erro });
            res.status(500).send(jsonErro);
        } else {
            if (banco == null) {
                var jsonErro = new RetornoJsonErro({ codigo: 400, mensagem: "Registro não localizado [Consultar Objeto Banco]", erro: erro });
                res.status(400).send(jsonErro);
            } else {
                res.send(banco);
            }
        }
    });
};

// inserir um objeto
exports.Inserir = (req, res) => {
    var bancoJson = req.body;

    //valida o conteúdo da requisição
    if (bancoJson.constructor === Object && Object.keys(bancoJson).length === 0) {
        var jsonErro = new RetornoJsonErro({ codigo: 400, mensagem: "Objeto inválido [Inserir Banco]", erro: erro });
        res.status(400).send(jsonErro);
    }

    BancoService.Inserir(bancoJson, (banco, erro) => {
        if (erro != null) {
            var jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Inserir Banco]", erro: erro });
            res.status(500).send(jsonErro);
        } else {
            res.send(banco);
        }
    });
};

// alterar um objeto
exports.Alterar = (req, res) => {
    var bancoJson = req.body;

    //valida o conteúdo da requisição
    if (bancoJson.constructor === Object && Object.keys(bancoJson).length === 0) {
        var jsonErro = new RetornoJsonErro({ codigo: 400, mensagem: "Objeto inválido [Alterar Banco]", erro: erro });
        res.status(400).send(jsonErro);
    }

    // valida o id do objeto
    if (bancoJson.id == null) {
        var jsonErro = new RetornoJsonErro({ codigo: 400, mensagem: "Objeto inválido [Alterar Banco]", erro: erro });
        res.status(400).send(jsonErro);
    }

    BancoService.ConsultarObjeto(bancoJson.id, (banco, erro) => {
        if (erro != null) {
            var jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Alterar Banco - Consulta]", erro: erro });
            res.status(500).send(jsonErro);
        } else {
            if (banco == null) {
                var jsonErro = new RetornoJsonErro({ codigo: 400, mensagem: "Objeto com ID inválido [Alterar Banco]", erro: erro });
                res.status(400).send(jsonErro);
            } else {
                BancoService.Alterar(bancoJson, (registrosAtualizados, erro) => {
                    if (erro != null) {
                        var jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Alterar Banco - Update]", erro: erro });
                        res.status(500).send(jsonErro);
                    } else {
                        res.send(bancoJson);
                    }
                });
            }
        }
    });
};

// excluir um objeto
exports.Excluir = (req, res) => {
    BancoService.Excluir(req.params.Id, (registrosAtualizados, erro) => {
        if (erro != null) {
            var jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Excluir Banco]", erro: erro });
            res.status(500).send(jsonErro);
        } else {
            res.status(200).send();
        }
    });
};