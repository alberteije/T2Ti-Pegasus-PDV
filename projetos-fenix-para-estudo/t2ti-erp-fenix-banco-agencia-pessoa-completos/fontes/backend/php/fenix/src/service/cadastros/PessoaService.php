<?php

class PessoaService extends ServiceBase
{
    public static function consultarLista()
    {
        $gerenteConexao = GerenteConexao::getInstance();
        $objetoRepository = $gerenteConexao->entityManager->getRepository('Pessoa');
        return $objetoRepository->findAll();
    }

    public static function consultarListaFiltroValor(string $campo, string $valor)
    {
        $gerenteConexao = GerenteConexao::getInstance();
        $sql = "SELECT t FROM Pessoa t WHERE t.$campo like :valor";
        $query = $gerenteConexao->entityManager->createQuery($sql);
        $query->setParameter("valor", "%$valor%");
        return $query->getResult();
    }

    public static function consultarObjeto(int $id)
    {
        $gerenteConexao = GerenteConexao::getInstance();
        return $gerenteConexao->entityManager->find('Pessoa', $id);
    }

    public static function salvar($objeto)
    {
        parent::salvarBase($objeto);
    }

    public static function excluir($objeto)
    {
        PessoaService::excluirFilhos($objeto);
        parent::excluirBase($objeto);
    }

    public static function excluirFilhos($objeto)
    {
        $gerenteConexao = GerenteConexao::getInstance();

        // Pessoa Física
        $pessoaFisica = $objeto->getPessoaFisica();
        if ($pessoaFisica != null) {
            $objeto->setPessoaFisica(null);
            $gerenteConexao->entityManager->remove($pessoaFisica);
        }

        // Pessoa Jurídica
        $pessoaJuridica = $objeto->getPessoaJuridica();
        if ($pessoaJuridica != null) {
            $objeto->setPessoaJuridica(null);
            $gerenteConexao->entityManager->remove($pessoaJuridica);
        }

        // Contatos
        $listaContato = $objeto->getListaPessoaContato();
        if ($listaContato != null) {
            for ($i = 0; $i < count($listaContato); $i++) {
                $contato = $listaContato[$i];
                $gerenteConexao->entityManager->remove($contato);
            }
        }

        // Telefones
        $listaTelefone = $objeto->getListaPessoaTelefone();
        if ($listaTelefone != null) {
            for ($i = 0; $i < count($listaTelefone); $i++) {
                $telefone = $listaTelefone[$i];
                $gerenteConexao->entityManager->remove($telefone);
            }
        }

        // Endereços
        $listaEndereco = $objeto->getListaPessoaEndereco();
        if ($listaEndereco != null) {
            for ($i = 0; $i < count($listaEndereco); $i++) {
                $endereco = $listaEndereco[$i];
                $gerenteConexao->entityManager->remove($endereco);
            }
        }

    }
}
