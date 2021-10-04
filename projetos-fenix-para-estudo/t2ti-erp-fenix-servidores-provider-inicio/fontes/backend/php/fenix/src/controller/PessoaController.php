<?php

class PessoaController
{

    public function consultarLista($request, $response, $args)
    {

        $sql = 'SELECT * FROM pessoa';

        try {
            $db = new BancoDeDados();
            $db = $db->conectar();
            $stmt = $db->query($sql);
            $listaConsulta = $stmt->fetchAll(PDO::FETCH_OBJ);
            $db = null;
            $retorno = json_encode($listaConsulta);
            $response->getBody()->write($retorno);
            return $response->withHeader('Content-Type', 'application/json');
        } catch (PDOException $e) {
            echo '{"erro": {"mensagem": ' . $e->getMessage() . '}';
        }
    }

    public function consultarObjeto($request, $response, $args)
    {

        $sql = 'SELECT * FROM pessoa WHERE id = ' . $args['id'];

        try {
            $db = new BancoDeDados();
            $db = $db->conectar();
            $stmt = $db->query($sql);
            $objeto = $stmt->fetchAll(PDO::FETCH_OBJ);
            $db = null;
            $retorno = json_encode($objeto);
            $response->getBody()->write($retorno);
            return $response->withHeader('Content-Type', 'application/json');
        } catch (PDOException $e) {
            echo '{"erro": {"mensagem": ' . $e->getMessage() . '}';
        }
    }

    public function inserir($request, $response, $args)
    {
        // pegar o objeto da requisição
        $pessoa = json_decode($request->getBody());

        // pegar a pessoa jurídica do JSON
        $pessoaJuridica = $pessoa->PessoaJuridica;

        // pegar a lista de contatos
        $contatos = $pessoa->ListaContatos;

        $sql = 'INSERT INTO pessoa (nome, tipo, site, email, cliente, fornecedor, transportadora, colaborador, contador)
         VALUES (:nome, :tipo, :site, :email, :cliente, :fornecedor, :transportadora, :colaborador, :contador)';

        try {
            $db = new BancoDeDados();
            $db = $db->conectar();

            // https://www.php.net/manual/en/pdo.prepare.php
            $stmt = $db->prepare($sql);

            // vincular os parâmetros
            // https://www.php.net/manual/en/pdostatement.bindparam.php
            $stmt->bindParam(':nome', $pessoa->nome);
            $stmt->bindParam(':tipo', $pessoa->tipo);
            $stmt->bindParam(':site', $pessoa->site);
            $stmt->bindParam(':email', $pessoa->email);
            $stmt->bindParam(':cliente', $pessoa->cliente);
            $stmt->bindParam(':fornecedor', $pessoa->fornecedor);
            $stmt->bindParam(':transportadora', $pessoa->transportadora);
            $stmt->bindParam(':colaborador', $pessoa->colaborador);
            $stmt->bindParam(':contador', $pessoa->contador);

            $stmt->execute();
            $pessoa->id = $db->lastInsertId();

            // inserir a pessoa jurídica
            $pessoaJuridica->id_pessoa = $pessoa->id;
            $this->inserirPessoaJuridica($db, $pessoaJuridica);

            // inserir os contatos
            for ($i=0; $i < count($contatos); $i++) { 
                $contato = $contatos[$i];
                $contato->id_pessoa = $pessoa->id;
                $this->inserirContato($db, $contato);
            }

            $db = null;

            $retorno = json_encode($pessoa);
            $response->getBody()->write($retorno);
            return $response->withHeader('Content-Type', 'application/json');
        } catch (PDOException $e) {
            echo '{"erro": {"mensagem": ' . $e->getMessage() . '}';
        }
    }

    public function alterar($request, $response, $args)
    {
        // pegar o objeto da requisição
        $pessoa = json_decode($request->getBody());

        $sql = 'UPDATE pessoa SET nome=:nome, tipo=:tipo, site=:site, email=:email, cliente=:cliente,
        fornecedor=:fornecedor, transportadora=:transportadora, colaborador=:colaborador, contador=:contador
        WHERE id = ' . $pessoa->id;

        try {
            $db = new BancoDeDados();
            $db = $db->conectar();
            $stmt = $db->prepare($sql);

            // vincular os parâmetros
            $stmt->bindParam(':nome', $pessoa->nome);
            $stmt->bindParam(':tipo', $pessoa->tipo);
            $stmt->bindParam(':site', $pessoa->site);
            $stmt->bindParam(':email', $pessoa->email);
            $stmt->bindParam(':cliente', $pessoa->cliente);
            $stmt->bindParam(':fornecedor', $pessoa->fornecedor);
            $stmt->bindParam(':transportadora', $pessoa->transportadora);
            $stmt->bindParam(':colaborador', $pessoa->colaborador);
            $stmt->bindParam(':contador', $pessoa->contador);

            $stmt->execute();
            $db = null;

            $retorno = json_encode($pessoa);
            $response->getBody()->write($retorno);
            return $response->withHeader('Content-Type', 'application/json');
        } catch (PDOException $e) {
            echo '{"erro": {"mensagem": ' . $e->getMessage() . '}';
        }
    }

    public function excluir($request, $response, $args)
    {
        $sql = 'DELETE FROM pessoa WHERE id = ' . $args['id'];

        try {
            $db = new BancoDeDados();
            $db = $db->conectar();
            $stmt = $db->prepare($sql);

            $stmt->execute();
            $db = null;

            $retorno = '{"mensagem": "Registro excluído com sucesso!"}';
            $response->getBody()->write($retorno);
            return $response->withHeader('Content-Type', 'application/json');
        } catch (PDOException $e) {
            echo '{"erro": {"mensagem": ' . $e->getMessage() . '}';
        }
    }


    // pessoa jurídica
    function inserirPessoaJuridica($db, $pessoaJuridica)
    {
        $sql = 'INSERT INTO pessoa_juridica (id_pessoa, cnpj, nome_fantasia, inscricao_estadual, inscricao_municipal, data_constituicao, tipo_regime, crt)
         VALUES (:id_pessoa, :cnpj, :nome_fantasia, :inscricao_estadual, :inscricao_municipal, :data_constituicao, :tipo_regime, :crt)';

        try {
            $stmt = $db->prepare($sql);

            // vincular os parâmetros
            $stmt->bindParam(':id_pessoa', $pessoaJuridica->id_pessoa);
            $stmt->bindParam(':cnpj', $pessoaJuridica->cnpj);
            $stmt->bindParam(':nome_fantasia', $pessoaJuridica->nome_fantasia);
            $stmt->bindParam(':inscricao_estadual', $pessoaJuridica->inscricao_estadual);
            $stmt->bindParam(':inscricao_municipal', $pessoaJuridica->inscricao_municipal);
            $stmt->bindParam(':data_constituicao', $pessoaJuridica->data_constituicao);
            $stmt->bindParam(':tipo_regime', $pessoaJuridica->tipo_regime);
            $stmt->bindParam(':crt', $pessoaJuridica->crt);

            $stmt->execute();

            return true;
        } catch (PDOException $e) {
            echo '{"erro": {"mensagem": ' . $e->getMessage() . '}';
        }
    }

    // contatos
    function inserirContato($db, $contato)
    {
        $sql = 'INSERT INTO pessoa_contato (id_pessoa, nome, email, observacao)
         VALUES (:id_pessoa, :nome, :email, :observacao)';

        try {
            $stmt = $db->prepare($sql);

            // vincular os parâmetros
            $stmt->bindParam(':id_pessoa', $contato->id_pessoa);
            $stmt->bindParam(':nome', $contato->nome);
            $stmt->bindParam(':email', $contato->email);
            $stmt->bindParam(':observacao', $contato->observacao);

            $stmt->execute();

            return true;
        } catch (PDOException $e) {
            echo '{"erro": {"mensagem": ' . $e->getMessage() . '}';
        }
    }

}
