<?php
/*******************************************************************************
Title: T2Ti ERP 3.0
Description: Controller relacionado à tabela [NFE_CONFIGURACAO] 
                                                                                
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
use Slim\Psr7\Stream;

class NfeConfiguracaoController extends ControllerBase
{

    public function consultarLista($request, $response, $args)
    {
        try {
            if (count($request->getQueryParams()) > 0) {
                $filtro = new Filtro($request->getQueryParams()['filter']);
                $listaConsulta = NfeConfiguracaoService::consultarListaFiltroValor($filtro);
            } else {
                $listaConsulta = NfeConfiguracaoService::consultarLista();
            }
            $retorno = json_encode($listaConsulta);
            $response->getBody()->write($retorno);
            return $response->withHeader('Content-Type', 'application/json');
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Consultar Lista NfeConfiguracao]', $e);
        }
    }

    public function consultarObjeto($request, $response, $args)
    {
        try {
            $objeto = NfeConfiguracaoService::consultarObjeto($args['id']);

            if ($objeto == null) {
                return parent::tratarErro($response, 404, 'Registro não localizado [Consultar Objeto NfeConfiguracao]', null);
            } else {
                $retorno = json_encode($objeto);
                $response->getBody()->write($retorno);
                return $response
                    ->withHeader('Content-Type', 'application/json');
            }
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Consultar Objeto NfeConfiguracao]', $e);
        }
    }

    public function atualizar($request, $response, $args)
    {
        try {
            // pegar o objeto da requisição
            $objJson = json_decode($request->getBody());

            $headers = $request->getHeaders();
            $pdvConfiguracao = $headers['pdv-configuracao'];
            $pdvConfiguracao = json_decode($pdvConfiguracao[0]);
			$decimaisQuantidade = $pdvConfiguracao->decimaisQuantidade;
			$decimaisValor = $pdvConfiguracao->decimaisValor;
                        
			// chama o método atualizar do service e aguarda um objeto para a porta
			$portaMonitor = NfeConfiguracaoService::atualizar($objJson, $args['cnpj'], $decimaisQuantidade, $decimaisValor);

            if (isset($portaMonitor)) {
                $response = $response->withHeader('endereco-monitor', ENDERECO_SERVIDOR);
                $response = $response->withHeader('porta-monitor', $portaMonitor->id);
            }

            $retorno = json_encode($objJson);
            $response->getBody()->write($retorno);

            return $response
                ->withStatus(200)
                ->withHeader('Content-Type', 'application/json');
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Atualizar NfeConfiguracao]', $e);
        }
    }


    public function atualizarCertificado($request, $response, $args)
    {
        try {
            // pegaa a string base 64 do corpo
            $certificadoBase64 = $request->getBody();

            $headers = $request->getHeaders();
            $senha = $headers['hash-registro'];
            $cnpj = $headers['cnpj'];
                        
			// chama o método para atualizar o certificado
			NfeConfiguracaoService::atualizarCertificado($certificadoBase64, $senha, $cnpj);

            $retorno = 'Certificado atualizado com sucesso.';
            $response->getBody()->write($retorno);

            return $response
                ->withStatus(200)
                ->withHeader('Content-Type', 'application/json');
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Atualizar NfeConfiguracao]', $e);
        }
    }

    public function retornarArquivosXmlPeriodo($request, $response, $args)
    {
        try {
            $headers = $request->getHeaders();
            $periodo = $headers['periodo'];
            $cnpj = $headers['cnpj'];

            $retorno = NfeConfiguracaoService::gerarZipArquivosXml($periodo, $cnpj);

            if ($retorno) {
                $file = "C:\\ACBrMonitor\\" . $cnpj . "\\NotasFiscaisNFCe_" . $periodo . ".zip";
                $fh = fopen($file, 'rb');
                $stream = new Stream($fh); 
    
                return $response
                            ->withHeader('Content-Type', 'application/zip')
                            ->withHeader('Content-Description', 'File Transfer')
                            ->withHeader('Content-Transfer-Encoding', 'binary')
                            //->withHeader('Content-Disposition', 'attachment; filename="' . basename($file) . '"') - use se quiser forçar o download
                            ->withHeader('Expires', '0')
                            ->withHeader('Cache-Control', 'must-revalidate, post-check=0, pre-check=0')
                            ->withHeader('Pragma', 'public')
                            ->withBody($stream);     
            } else {
                return $response
                ->withStatus(500)
                ->withBody('Problemas na criação do arquivo [Retornar XML Período]')
                ->withHeader('Content-Type', 'application/json');
            }

		} catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Retornar XML Período]', $e);
        }
    }

    public function alterar($request, $response, $args)
    {
        try {
			// pegar o objeto da requisição
			$objJson = json_decode($request->getBody());

            $objBanco = NfeConfiguracaoService::consultarObjeto($objJson->id);

            if ($objBanco == null) {
                return parent::tratarErro($response, 400, 'Objeto inválido [Alterar NfeConfiguracao]', null);
            } else {
				$objBanco->mapear($objJson);
				
				NfeConfiguracaoService::salvar($objBanco);
				
                $retorno = json_encode($objBanco);
                $response->getBody()->write($retorno);
                return $response
                    ->withHeader('Content-Type', 'application/json');
            }
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Objeto inválido [Alterar NfeConfiguracao]', $e);
        }
    }

    public function excluir($request, $response, $args)
    {
        try {
            $objBanco = NfeConfiguracaoService::consultarObjeto($args['id']);

            if ($objBanco == null) {
                return parent::tratarErro($response, 400, 'Objeto inválido [Excluir NfeConfiguracao]', null);
            } else {
                NfeConfiguracaoService::excluir($objBanco);

                return $response
                    ->withStatus(200)
                    ->withHeader('Content-Type', 'application/json');
            }
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Objeto inválido [Excluir NfeConfiguracao]', $e);
        }
    }
}
