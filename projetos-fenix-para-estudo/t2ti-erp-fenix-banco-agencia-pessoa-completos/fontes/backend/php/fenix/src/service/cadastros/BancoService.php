<?php

class BancoService extends ServiceBase
{
    public static function consultarLista()
    {
        $gerenteConexao = GerenteConexao::getInstance();        
        $objetoRepository = $gerenteConexao->entityManager->getRepository('Banco');
        return $objetoRepository->findAll();
    }

    public static function consultarListaFiltroValor(string $campo, string $valor)
    {
        $gerenteConexao = GerenteConexao::getInstance();   
        $sql = "SELECT t FROM Banco t WHERE t.$campo like :valor";     
        $query = $gerenteConexao->entityManager->createQuery($sql);
        $query->setParameter("valor", "%$valor%");
        return $query->getResult();
    }

    public static function consultarObjeto(int $id)
    {
        $gerenteConexao = GerenteConexao::getInstance();        
        return $gerenteConexao->entityManager->find('Banco', $id);
    }

    public static function salvar($objeto)
    {
        parent::salvarBase($objeto);
        // $gerenteConexao = GerenteConexao::getInstance();        
        // $gerenteConexao->entityManager->persist($objeto);
        // $gerenteConexao->entityManager->flush();
    }

    public static function excluir($objeto)
    {
        parent::excluirBase($objeto);
        // $gerenteConexao = GerenteConexao::getInstance();        
        // $gerenteConexao->entityManager->remove($objeto);
        // $gerenteConexao->entityManager->flush();
    }

}