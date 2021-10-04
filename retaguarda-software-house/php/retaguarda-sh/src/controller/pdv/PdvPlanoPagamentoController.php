<?php
/*******************************************************************************
Title: T2Ti ERP 3.0
Description: Controller relacionado à tabela [PDV_PLANO_PAGAMENTO] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
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
class PdvPlanoPagamentoController extends ControllerBase
{

    public function consultarLista($request, $response, $args)
    {
        try {
            if (count($request->getQueryParams()) > 0) {
                $filtro = new Filtro($request->getQueryParams()['filter']);
                $listaConsulta = PdvPlanoPagamentoService::consultarListaFiltroValor($filtro);
            } else {
                $listaConsulta = PdvPlanoPagamentoService::consultarLista();
            }
            $retorno = json_encode($listaConsulta);
            $response->getBody()->write($retorno);
            return $response->withHeader('Content-Type', 'application/json');
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Consultar Lista PdvPlanoPagamento]', $e);
        }
    }

    public function consultarObjeto($request, $response, $args)
    {
        try {
            $objeto = PdvPlanoPagamentoService::consultarPlanoAtivo($args['cnpj']);

            if ($objeto == null) {
                return parent::tratarErro($response, 404, 'Registro não localizado [Consultar Objeto PdvPlanoPagamento]', null);
            } else {
                $retorno = json_encode($objeto);
                $response->getBody()->write($retorno);
                return $response
                    ->withHeader('Content-Type', 'application/json');
            }
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Consultar Objeto PdvPlanoPagamento]', $e);
        }
    }

    public function inserir($request, $response, $args)
    {
        try {
            // pegar o objeto da requisição
            $objetoPagSeguroEnviado = json_decode($request->getBody());

            // valida o objeto
            if (!isset($objetoPagSeguroEnviado)) {
                return parent::tratarErro($response, 400, 'Objeto inválido [Atualizar PdvPlanoPagamento] - objeto não enviado.', null);
            }

            PdvPlanoPagamentoService::atualizar($objetoPagSeguroEnviado);
			
            $retorno = "Dados atualizados com sucesso.";
            $response->getBody()->write($retorno);

            return $response
                ->withStatus(201)
                ->withHeader('Content-Type', 'application/json');
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Atualizar PdvPlanoPagamento]', $e);
        }
    }

    public function alterar($request, $response, $args)
    {
        try {
			// pegar o objeto da requisição
			$objJson = json_decode($request->getBody());

            $objBanco = PdvPlanoPagamentoService::consultarObjeto($objJson->id);

            if ($objBanco == null) {
                return parent::tratarErro($response, 400, 'Objeto inválido [Alterar PdvPlanoPagamento]', null);
            } else {
				$objBanco->mapear($objJson);
				
				PdvPlanoPagamentoService::salvar($objBanco);
				
                $retorno = json_encode($objBanco);
                $response->getBody()->write($retorno);
                return $response
                    ->withHeader('Content-Type', 'application/json');
            }
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Objeto inválido [Alterar PdvPlanoPagamento]', $e);
        }
    }

    public function excluir($request, $response, $args)
    {
        try {
            $objBanco = PdvPlanoPagamentoService::consultarObjeto($args['id']);

            if ($objBanco == null) {
                return parent::tratarErro($response, 400, 'Objeto inválido [Excluir PdvPlanoPagamento]', null);
            } else {
                PdvPlanoPagamentoService::excluir($objBanco);

                return $response
                    ->withStatus(200)
                    ->withHeader('Content-Type', 'application/json');
            }
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Objeto inválido [Excluir PdvPlanoPagamento]', $e);
        }
    }

    public function confirmarTransacao($request, $response, $args)
    {
        try {
            $headers = $request->getHeaders();
            $cnpj = $headers['cnpj'];

            $retorno = PdvPlanoPagamentoService::confirmarTransacao($args['codigo'], $cnpj);
            /*
                Vamos usar os códigos HTTP para nossa conveniência:
                200 - achou a transação e vinculou o ID da empresa
                404 - não achou o código da transação no banco de dados
                418 - achou o código da transação, mas ele já foi utilizado
            */
            return $response
            ->withStatus($retorno)
            ->withHeader('Content-Type', 'application/json')
            ->withBody($retorno);             
		} catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Gerar PDF NF-e]', $e);
        }
    }

}
