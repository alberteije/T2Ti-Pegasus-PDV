<?php

// conecta com o MySQL usando PDO

class BancoDeDados {

    private $dbHost = 'localhost';
    private $dbUser = 'root';
    private $dbPass = 'root';
    private $dbName = 'fenix';

    public function conectar() {

        // https://www.php.net/manual/en/pdo.connections.php
        $stringConexao = "mysql:host=$this->dbHost;dbname=$this->dbName";
        $conexao = new PDO($stringConexao, $this->dbUser, $this->dbPass);

        // https://www.php.net/manual/en/pdo.setattribute.php
        $conexao->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        return $conexao;
    }
}