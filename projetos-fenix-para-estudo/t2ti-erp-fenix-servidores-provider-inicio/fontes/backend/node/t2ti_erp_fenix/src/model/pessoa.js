const conexao = require('../config/db_config.js');

const Pessoa = function (pessoa) {
    this.nome = pessoa.nome;
    this.tipo = pessoa.tipo;
    this.site = pessoa.site;
    this.email = pessoa.email;
    this.cliente = pessoa.cliente;
    this.fornecedor = pessoa.fornecedor;
    this.transportadora = pessoa.transportadora;
    this.colaborador = pessoa.colaborador;
    this.contador = pessoa.contador;
};

Pessoa.ConsultarLista = result => {
    conexao.query('SELECT * FROM pessoa', (erro, res) => {
        if (erro) {
            console.log('erro:', erro);
            result(null, erro);
            return;
        }

        console.log('Lista de objetos', res);
        result(null, res);
    });
};

Pessoa.ConsultarObjeto = (Id, result) => {
    conexao.query('SELECT * FROM pessoa where id = ' + Id, (erro, res) => {
        if (erro) {
            console.log('erro:', erro);
            result(null, erro);
            return;
        }

        if (res.length) {
            console.log('Objeto localizado', res[0]);
            result(null, res[0]);
            return;
        }

        // objeto não localizado
        result(null, {kind: "not_found"});
    });
};

Pessoa.Inserir = (pessoa, result) => {
    conexao.query('INSERT INTO pessoa SET ?', pessoa, (erro, res) => {
        if (erro) {
            console.log('erro:', erro);
            result(null, erro);
            return;
        }

        console.log('Objeto inserido', {id: res.insertId, ...pessoa });
        result(null, {id: res.insertId, ...pessoa });
    });
};

Pessoa.Alterar = (Id, pessoa, result) => {
    conexao.query(
        'UPDATE pessoa SET nome = ?, tipo = ?, site = ?, email = ?, cliente = ?, fornecedor = ?, '+
        'transportadora = ?, colaborador = ?, contador = ? where id = ?', 
        [pessoa.nome, pessoa.tipo, pessoa.site, pessoa.email, pessoa.cliente, pessoa.fornecedor,
            pessoa.transportadora, pessoa.colaborador, pessoa.contador, Id], 
        (erro, res) => {
        if (erro) {
            console.log('erro:', erro);
            result(null, erro);
            return;
        }

        if (res.affectedRows == 0) {
            // objeto não localizado
            result(null, {kind: "not_found"});
            return;
        }

        console.log('Objeto alterado', {id: Id, ...pessoa });
        result(null, {id: Id, ...pessoa });
    });
};

Pessoa.Excluir = (Id, result) => {
    conexao.query('DELETE FROM pessoa where id = ' + Id, (erro, res) => {
        if (erro) {
            console.log('erro:', erro);
            result(null, erro);
            return;
        }

        if (res.affectedRows == 0) {
            // objeto não localizado
            result(null, {kind: "not_found"});
            return;
        }

        console.log('Objeto excluído com o id = ', Id);
        result(null, res);
    });
};

// Pessoa Jurídica
Pessoa.InserirPessoaJuridica = (pessoaJuridica, result) => {
    conexao.query('INSERT INTO pessoa_juridica SET ?', pessoaJuridica, (erro, res) => {
        if (erro) {
            console.log('erro:', erro);
            result(null, erro);
            return;
        }

        console.log('Objeto inserido', {id: res.insertId, ...pessoaJuridica });
    });
};


// Contatos
Pessoa.InserirContato = (contato, result) => {
    conexao.query('INSERT INTO pessoa_contato SET ?', contato, (erro, res) => {
        if (erro) {
            console.log('erro:', erro);
            result(null, erro);
            return;
        }

        console.log('Objeto inserido', {id: res.insertId, ...contato });
    });
};

module.exports = Pessoa;