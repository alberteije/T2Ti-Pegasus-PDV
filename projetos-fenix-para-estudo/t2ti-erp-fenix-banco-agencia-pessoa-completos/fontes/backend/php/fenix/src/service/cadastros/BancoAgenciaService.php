<?php

class BancoAgenciaService extends ServiceBase
{
    public static function consultarLista()
    {
        $gerenteConexao = GerenteConexao::getInstance();        
        $objetoRepository = $gerenteConexao->entityManager->getRepository('BancoAgencia');
        return $objetoRepository->findAll();
    }

    public static function consultarListaFiltroValor(string $campo, string $valor)
    {
        $gerenteConexao = GerenteConexao::getInstance();   
        $sql = "SELECT t FROM BancoAgencia t WHERE t.$campo like :valor";     
        $query = $gerenteConexao->entityManager->createQuery($sql);
        $query->setParameter("valor", "%$valor%");
        return $query->getResult();
    }

    public static function consultarObjeto(int $id)
    {
        $gerenteConexao = GerenteConexao::getInstance();        
        return $gerenteConexao->entityManager->find('BancoAgencia', $id);
    }

    public static function salvar($objeto)
    {
        parent::salvarBase($objeto);
    }

    public static function excluir($objeto)
    {
        parent::excluirBase($objeto);
    }

}