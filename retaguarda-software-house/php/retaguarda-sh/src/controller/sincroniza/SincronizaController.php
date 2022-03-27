<?php
/*******************************************************************************
Title: T2Ti ERP 3.0
Description: Controller relacionado à sincronização de dados 
                                                                                
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

class SincronizaController extends ControllerBase
{

    public function sincronizarServidor($request, $response, $args)
    {
        try {
            // pegaa a string base 64 do corpo
            $bancoSQLite64 = Biblioteca::decifrar($request->getBody());

            $cnpj = Biblioteca::decifrar($request->getHeaders()['cnpj'][0]);
                        
			// chama o método para atualizar o certificado
			SincronizaService::sincronizarServidor($bancoSQLite64, $cnpj);

            $retorno = 'Servidor sincronizado com sucesso.';
            $response->getBody()->write($retorno);

            return $response
                ->withStatus(200)
                ->withHeader('Content-Type', 'application/json');
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Problemas na sincronização [Sincronizar Servidor]', $e);
        }
    }

    public function armazenarMovimento($request, $response, $args)
    {
        try {
            // pegaa a string base 64 do corpo
            $bancoSQLite64 = Biblioteca::decifrar($request->getBody());

            $cnpj = Biblioteca::decifrar($request->getHeaders()['cnpj'][0]);
            $idMovimento = Biblioteca::decifrar($request->getHeaders()['movimento'][0]);
            $idDispositivo = Biblioteca::decifrar($request->getHeaders()['dispositivo'][0]);
            $dispositivo = trim($idDispositivo);
            $dispositivo = str_replace('-', '', $dispositivo);
                        
			// chama o método para atualizar o certificado
			SincronizaService::armazenarMovimento($bancoSQLite64, $cnpj, $idMovimento, $dispositivo);

            $retorno = 'Movimento sincronizado com sucesso.';
            $response->getBody()->write($retorno);

            return $response
                ->withStatus(200)
                ->withHeader('Content-Type', 'application/json');
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Problemas na sincronização [Armazenar Movimento]', $e);
        }
    }

    public function sincronizarCliente($request, $response, $args)
    {
        try {
            $cnpj = Biblioteca::decifrar($request->getHeaders()['cnpj'][0]);
            $listaObjetoSincroniza = SincronizaService::sincronizarCliente($cnpj);
            $retorno = json_encode($listaObjetoSincroniza);
            $response->getBody()->write(Biblioteca::cifrar($retorno));
            return $response->withHeader('Content-Type', 'application/json');
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Problemas na sincronização [Sincronizar Cliente]', $e);
        }
    }


    public function testarTwilio($request, $response, $args)
    {
        try {
            // pegaa a string base 64 do corpo
            $corpo = $request->getBody();
            // $corpo = $request->parsedBody;
                        
			// chama o método para atualizar o certificado
			// SincronizaService::facaAlgumaCoisaComOsDadosQueVieramNoCorpo($corpo);

            $resposta = "";
            $resposta .= "<?xml version='1.0' encoding='UTF-8'?>";
            $resposta .= "<Response>";
            $resposta .= "<Message><Body>Mensagem vinda do PHP.</Body></Message>";
            $resposta .= "</Response>";

            $response->getBody()->write($resposta);

            return $response
                ->withStatus(200)
                ->withHeader('Content-Type', 'text/html');
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Problemas no teste do twilio [Teste Twilio]', $e);
        }
    }

}
