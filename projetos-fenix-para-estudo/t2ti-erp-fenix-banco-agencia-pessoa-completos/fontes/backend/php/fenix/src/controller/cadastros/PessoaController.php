<?php

class PessoaController extends ControllerBase
{

    public function consultarLista($request, $response, $args)
    {
        try {
            if (count($request->getQueryParams()) > 0) {
                $filtro = new Filtro($request->getQueryParams()['filter']);
                $listaConsulta = PessoaService::consultarListaFiltroValor($filtro->campo, $filtro->valor);
            } else {
                $listaConsulta = PessoaService::consultarLista();
            }
            $retorno = json_encode($listaConsulta);
            $response->getBody()->write($retorno);
            return $response->withHeader('Content-Type', 'application/json');
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Consultar Lista Pessoa]', $e);
        }
    }

    public function consultarObjeto($request, $response, $args)
    {
        try {
            $objeto = PessoaService::consultarObjeto($args['id']);

            if ($objeto == null) {
                return parent::tratarErro($response, 404, 'Registro não localizado [Consultar Objeto Pessoa]', null);
            } else {
                $retorno = json_encode($objeto);
                $response->getBody()->write($retorno);
                return $response
                    ->withHeader('Content-Type', 'application/json');
            }
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Consultar Objeto Pessoa]', $e);
        }
    }

    public function inserir($request, $response, $args)
    {
        try {
            // pegar o objeto da requisição
            $objJson = json_decode($request->getBody());

            // valida o objeto
            $objBanco = new Pessoa($objJson);
            if (!isset($objJson)) {
                return parent::tratarErro($response, 400, 'Objeto inválido [Incluir Pessoa] - objeto não enviado.', null);
            }

            PessoaService::salvar($objBanco);

            $retorno = json_encode($objBanco);
            $response->getBody()->write($retorno);

            return $response
                ->withStatus(201)
                ->withHeader('Content-Type', 'application/json');
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Inserir Pessoa]', $e);
        }
    }

    public function alterar($request, $response, $args)
    {
        // pegar o objeto da requisição
        $objJson = json_decode($request->getBody());

        // valida objeto
        $objEntidade = new Pessoa($objJson);
        $mensagemErro = $objEntidade->validarObjetoRequisicao($objJson, $args['id']);
        if ($mensagemErro != '') {
            return parent::tratarErro($response, 400, $mensagemErro, null);
        }

        try {
            $objBanco = PessoaService::consultarObjeto($objJson->id);

            if ($objBanco == null) {
                return parent::tratarErro($response, 400, 'Objeto inválido [Alterar Pessoa]', null);
            } else {
                // exclui os filhos no banco de dados
                PessoaService::excluirFilhos($objBanco);

                $objBanco->mapear($objEntidade);

                // Pessoa Física
                $pessoaFisica = $objEntidade->getPessoaFisica();
                if ($pessoaFisica != null) {
                    $pessoaFisica->setPessoa($objBanco);
                    $objBanco->setPessoaFisica($pessoaFisica);
                }

                // Pessoa Jurídica
                $pessoaJuridica = $objEntidade->getPessoaJuridica();
                if ($pessoaJuridica != null) {
                    $pessoaJuridica->setPessoa($objBanco);
                    $objBanco->setPessoaJuridica($pessoaJuridica);
                }

                // Contatos
                $listaPessoaContato = $objEntidade->getListaPessoaContato();
                if ($listaPessoaContato != null) {
                    $objBanco->setListaPessoaContato($listaPessoaContato);
                }

                // Telefones
                $listaPessoaTelefone = $objEntidade->getListaPessoaTelefone();
                if ($listaPessoaTelefone != null) {
                    $objBanco->setListaPessoaTelefone($listaPessoaTelefone);
                }

                // Enderecos
                $listaPessoaEndereco = $objEntidade->getListaPessoaEndereco();
                if ($listaPessoaEndereco != null) {
                    $objBanco->setListaPessoaEndereco($listaPessoaEndereco);
                }

                PessoaService::salvar($objBanco);

                $retorno = json_encode($objBanco);
                $response->getBody()->write($retorno);
                return $response
                    ->withHeader('Content-Type', 'application/json');
            }
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Objeto inválido [Alterar Pessoa]', $e);
        }
    }

    public function excluir($request, $response, $args)
    {
        try {
            $objBanco = PessoaService::consultarObjeto($args['id']);

            if ($objBanco == null) {
                return parent::tratarErro($response, 400, 'Objeto inválido [Excluir Pessoa]', null);
            } else {
                PessoaService::excluir($objBanco);

                return $response
                    ->withStatus(200)
                    ->withHeader('Content-Type', 'application/json');
            }
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Objeto inválido [Excluir Pessoa]', $e);
        }
    }
}
