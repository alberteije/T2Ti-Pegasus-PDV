const Pessoa = require('../model/pessoa.js');

// consultar a lista
exports.ConsultarLista = (req, res) => {
    Pessoa.ConsultarLista((erro, dados) => {
        if (erro) {
            res.status(500).send({
                mensagem: "Ocorreu um erro na consulta (Pessoa) - " + erro.message
            });
        }
        else res.send(dados);
    });
};

// consultar um objeto
exports.ConsultarObjeto = (req, res) => {
    Pessoa.ConsultarObjeto(req.params.Id, (erro, dados) => {
        if (erro) {
            if (erro.kind === 'not_found') {
                res.status(404).send({
                    mensagem: "Pessoa não localizado para o id: " + req.params.Id
                });    
            } else {
                res.status(500).send({
                    mensagem: "Erro ao consultar Pessoa com o id: " + req.params.Id
                });
            }
        }
        else res.send(dados);
    });
};

// inserir um objeto
exports.Inserir = (req, res) => {
    //valida o conteúdo da requisição
    if (!req.body){
        res.status(400).send({
            mensagem: "Conteúdo não pode ser vazio."
        });    
    }

    // instanciar objeto a partir do JSON vindo na requisição
    var pessoa = new Pessoa(req.body);

    // pegar a pessoa jurídica do JSON
    var pessoaJuridica = req.body.PessoaJuridica

    // pegar a lista de contatos
    var listaContatos = req.body.ListaContatos;

    // salvar objeto no pessoa de dados
    Pessoa.Inserir(pessoa, (erro, dados) => {
        if (erro) {
            res.status(500).send({
                mensagem: "Erro ao inserir Pessoa - " + erro.message
            });
        }
        else {
          // inserir a pessoa jurídica
          pessoaJuridica.id_pessoa = dados.id;
          Pessoa.InserirPessoaJuridica(pessoaJuridica);  

          //inserir contatos
          var i;
          for (i = 0; i < listaContatos.length; i++) {
            var contato = listaContatos[i];
            contato.id_pessoa = dados.id;
            Pessoa.InserirContato(contato);  
          }

          res.send(dados);
        }
    });
};

// alterar um objeto
exports.Alterar = (req, res) => {
    //valida o conteúdo da requisição
    if (!req.body){
        res.status(400).send({
            mensagem: "Conteúdo não pode ser vazio."
        });    
    }

    // instanciar objeto a partir do JSON vindo na requisição
    var pessoa = new Pessoa(req.body);

    // salvar objeto no pessoa de dados
    Pessoa.Alterar(req.params.Id, pessoa, (erro, dados) => {
        if (erro) {
            if (erro.kind === 'not_found') {
                res.status(404).send({
                    mensagem: "Pessoa não localizado para o id: " + req.params.Id
                });    
            } else {
                res.status(500).send({
                    mensagem: "Erro ao alterar Pessoa com o id: " + req.params.Id
                });
            }
        }
        else res.send(dados);
    });
};

// excluir um objeto
exports.Excluir = (req, res) => {
    Pessoa.Excluir(req.params.Id, (erro, dados) => {
        if (erro) {
            if (erro.kind === 'not_found') {
                res.status(404).send({
                    mensagem: "Pessoa não localizado para o id: " + req.params.Id
                });    
            } else {
                res.status(500).send({
                    mensagem: "Erro ao excluir Pessoa com o id: " + req.params.Id
                });
            }
        }
        else res.send({mensagem: "Registro excluído com sucesso!"});
    });
};