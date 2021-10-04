<?php

declare(strict_types=1);

class ServiceBase
{

    public static function salvarBase($objeto)
    {
        $gerenteConexao = GerenteConexao::getInstance();        
        $gerenteConexao->entityManager->persist($objeto);
        $gerenteConexao->entityManager->flush();
    }

    public static function excluirBase($objeto)
    {
        $gerenteConexao = GerenteConexao::getInstance();        
        $gerenteConexao->entityManager->remove($objeto);
        $gerenteConexao->entityManager->flush();
    }

}