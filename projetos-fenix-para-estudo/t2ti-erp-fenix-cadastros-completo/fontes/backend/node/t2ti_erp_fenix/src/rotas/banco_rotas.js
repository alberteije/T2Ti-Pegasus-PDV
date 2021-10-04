module.exports = app => {

    const bancoController = require('../controller/banco_controller.js');

    // consultar a lista de objetos
    app.get('/banco', bancoController.ConsultarLista);

    // consultar a lista de objetos com filtro
    app.get('/banco/:campo/:valor', bancoController.ConsultarListaFiltroValor);

    // consultar um objeto
    app.get('/banco/:Id', bancoController.ConsultarObjeto);

    // inserir um objeto
    app.post('/banco', bancoController.Inserir);

    // alterar um objeto
    app.put('/banco', bancoController.Alterar);

    // excluir um objeto
    app.delete('/banco/:Id', bancoController.Excluir);

};