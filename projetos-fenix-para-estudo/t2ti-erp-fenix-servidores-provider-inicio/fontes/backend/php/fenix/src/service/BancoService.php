<?php

require './src/config/doctrine.php';
require './src/model/Banco.php';

class BancoService
{
    public static function consultarLista()
    {
        $gerente = GerenteConexao::getInstance();        
        $bancoRepository = $gerente->entityManager->getRepository('Banco');
        return $bancoRepository->findAll();
    }

    public static function consultarListaFiltroValor(string $campo, string $valor)
    {
        $gerente = GerenteConexao::getInstance();   
        $sql = "SELECT b FROM Banco b WHERE b.$campo like :valor";     
        $query = $gerente->entityManager->createQuery($sql);
        $query->setParameter("valor", "%$valor%");
        return $query->getResult();
    }

    public static function consultarObjeto(int $id)
    {
        $gerente = GerenteConexao::getInstance();        
        return $gerente->entityManager->find('Banco', $id);
    }

    public static function salvar($banco)
    {
        $gerente = GerenteConexao::getInstance();        
        $gerente->entityManager->persist($banco);
        $gerente->entityManager->flush();
    }

    public static function excluir($banco)
    {
        $gerente = GerenteConexao::getInstance();        
        $gerente->entityManager->remove($banco);
        $gerente->entityManager->flush();
    }

}