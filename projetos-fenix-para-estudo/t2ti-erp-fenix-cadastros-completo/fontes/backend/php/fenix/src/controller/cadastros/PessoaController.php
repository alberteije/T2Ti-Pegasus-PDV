<?php
/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [PESSOA] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2020 T2Ti.COM                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (alberteije@gmail.com)                    
@version 1.0.0
*******************************************************************************/
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
            $objEntidade = new Pessoa($objJson);
            if (!isset($objJson)) {
                return parent::tratarErro($response, 400, 'Objeto inválido [Incluir Pessoa] - objeto não enviado.', null);
            }

            $pessoaFisica = $objEntidade->getPessoaFisica();
            if ($pessoaFisica != null) {
                $pessoaFisica->setNivelFormacao(NivelFormacaoService::consultarObjeto($objJson->pessoaFisica->nivelFormacao->id));
                $pessoaFisica->setEstadoCivil(EstadoCivilService::consultarObjeto($objJson->pessoaFisica->estadoCivil->id));
            }

            PessoaService::salvar($objEntidade);
			
            $retorno = json_encode($objEntidade);
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
				PessoaService::excluirFilhos($objBanco);
				$objBanco->mapear($objEntidade);
				
				$pessoaFisica = $objEntidade->getPessoaFisica();
				if ($pessoaFisica != null) {
					$pessoaFisica->setPessoa($objBanco);
					$objBanco->setPessoaFisica($pessoaFisica);
                    $pessoaFisica->setNivelFormacao(NivelFormacaoService::consultarObjeto($objJson->pessoaFisica->nivelFormacao->id));
                    $pessoaFisica->setEstadoCivil(EstadoCivilService::consultarObjeto($objJson->pessoaFisica->estadoCivil->id));
                }

				$pessoaJuridica = $objEntidade->getPessoaJuridica();
				if ($pessoaJuridica != null) {
					$pessoaJuridica->setPessoa($objBanco);
					$objBanco->setPessoaJuridica($pessoaJuridica);
				}

				$listaPessoaContato = $objEntidade->getListaPessoaContato();
				if ($listaPessoaContato != null) {
					$objBanco->setListaPessoaContato($listaPessoaContato);
				}

				$listaPessoaEndereco = $objEntidade->getListaPessoaEndereco();
				if ($listaPessoaEndereco != null) {
					$objBanco->setListaPessoaEndereco($listaPessoaEndereco);
				}

				$listaPessoaTelefone = $objEntidade->getListaPessoaTelefone();
				if ($listaPessoaTelefone != null) {
					$objBanco->setListaPessoaTelefone($listaPessoaTelefone);
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
