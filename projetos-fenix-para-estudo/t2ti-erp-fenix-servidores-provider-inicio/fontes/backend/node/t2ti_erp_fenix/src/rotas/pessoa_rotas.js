module.exports = app => {

    const pessoaController = require('../controller/pessoa_controller.js');

    // consultar a lista de objetos
    app.get('/pessoa', pessoaController.ConsultarLista);

    // consultar um objeto
    app.get('/pessoa/:Id', pessoaController.ConsultarObjeto);

    // inserir um objeto
    app.post('/pessoa', pessoaController.Inserir);

    // alterar um objeto
    app.put('/pessoa/:Id', pessoaController.Alterar);

    // excluir um objeto
    app.delete('/pessoa/:Id', pessoaController.Excluir);
};