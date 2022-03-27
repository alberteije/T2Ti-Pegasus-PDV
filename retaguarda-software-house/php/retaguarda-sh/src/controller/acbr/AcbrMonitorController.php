<?php
/*******************************************************************************
Title: T2Ti ERP 3.0
Description: Controller relacionado ao ACBrMonitor
                                                                                
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

class AcbrMonitorController extends ControllerBase
{

    public function emitirNfce($request, $response, $args)
    {
        try {
            $nfceIni = Biblioteca::decifrar($request->getBody());
            $cnpj = Biblioteca::decifrar($request->getHeaders()['cnpj'][0]);
            $numero = Biblioteca::decifrar($request->getHeaders()['numero'][0]);
                        
			$retorno = AcbrMonitorService::emitirNfce($numero, $cnpj, $nfceIni);

            if (!str_contains($retorno, "ERRO")) {
                $fh = fopen($retorno, 'rb');
                $stream = new Stream($fh); 
                return parent::retornarArquivo($response, $stream, 'application/pdf');                
            } else {
                return parent::tratarErro($response, 418, $retorno, null);                
            }
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Atualizar AcbrMonitor]', $e);
        }
    }

    public function emitirNfceContingencia($request, $response, $args)
    {
        try {
            $nfceIni = Biblioteca::decifrar($request->getBody());
            $cnpj = Biblioteca::decifrar($request->getHeaders()['cnpj'][0]);
            $numero = Biblioteca::decifrar($request->getHeaders()['numero'][0]);
                        
			$retorno = AcbrMonitorService::emitirNfceContingencia($numero, $cnpj, $nfceIni);

            if (!str_contains($retorno, "ERRO")) {
                $fh = fopen($retorno, 'rb');
                $stream = new Stream($fh); 
                return parent::retornarArquivo($response, $stream, 'application/pdf');                
            } else {
                return parent::tratarErro($response, 418, $retorno, null);                
            }
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Atualizar AcbrMonitor]', $e);
        }
    }

    public function transmitirNfceContingenciada($request, $response, $args)
    {
        try {
            $cnpj = Biblioteca::decifrar($request->getHeaders()['cnpj'][0]);
            $chave = Biblioteca::decifrar($request->getHeaders()['chave'][0]);
                        
			$retorno = AcbrMonitorService::transmitirNfceContingenciada($chave, $cnpj);

            if (!str_contains($retorno, "ERRO")) {
                $fh = fopen($retorno, 'rb');
                $stream = new Stream($fh); 
                return parent::retornarArquivo($response, $stream, 'application/pdf');                
            } else {
                return parent::tratarErro($response, 418, $retorno, null);                
            }
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Atualizar AcbrMonitor]', $e);
        }
    }

    public function tratarNotaAnteriorContingencia($request, $response, $args)
    {
        try {
            $objetoNfe = json_decode(Biblioteca::decifrar($request->getBody()));

            $retorno = AcbrMonitorService::tratarNotaAnteriorContingencia($objetoNfe);

            $response->getBody()->write(Biblioteca::cifrar($retorno));
            return $response
                ->withHeader('Content-Type', 'application/json');
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Atualizar AcbrMonitor]', $e);
        }
    }

    public function inutilizarNumeroNota($request, $response, $args)
    {
        try {
            $objetoNfe = json_decode(Biblioteca::decifrar($request->getBody()));

            $retorno = AcbrMonitorService::inutilizarNumero($objetoNfe);

            $response->getBody()->write(Biblioteca::cifrar($retorno));
            return $response
                ->withHeader('Content-Type', 'application/json');
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Atualizar AcbrMonitor]', $e);
        }
    }

    public function cancelarNfce($request, $response, $args)
    {
        try {
            $objetoNfe = json_decode(Biblioteca::decifrar($request->getBody()));

            $retorno = AcbrMonitorService::cancelarNfce($objetoNfe);

            $response->getBody()->write(Biblioteca::cifrar($retorno));
            return $response
                ->withHeader('Content-Type', 'application/json');
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Atualizar AcbrMonitor]', $e);
        }
    }

    public function gerarPdfDanfeNfce($request, $response, $args)
    {
        try {
            $cnpj = Biblioteca::decifrar($request->getHeaders()['cnpj'][0]);
            $chave = Biblioteca::decifrar($request->getHeaders()['chave'][0]);
                        
			$retorno = AcbrMonitorService::gerarPdfDanfeNfce($chave, $cnpj);

            if (!str_contains($retorno, "ERRO")) {
                $fh = fopen($retorno, 'rb');
                $stream = new Stream($fh); 
                return parent::retornarArquivo($response, $stream, 'application/pdf');                
            } else {
                return parent::tratarErro($response, 418, $retorno, null);                
            }
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Atualizar AcbrMonitor]', $e);
        }
    }

    public function retornarArquivosXmlPeriodo($request, $response, $args)
    {
        try {
            $cnpj = Biblioteca::decifrar($request->getHeaders()['cnpj'][0]);
            $periodo = Biblioteca::decifrar($request->getHeaders()['periodo'][0]);

            $retorno = AcbrMonitorService::gerarZipArquivosXml($periodo, $cnpj);

            if ($retorno) {
                $file = "C:\\ACBrMonitor\\" . $cnpj . "\\NotasFiscaisNFCe_" . $periodo . ".zip";
                $fh = fopen($file, 'rb');
                $stream = new Stream($fh); 
                return parent::retornarArquivo($response, $stream, 'application/zip');                    
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

    public function atualizarCertificado($request, $response, $args)
    {
        try {
            // pegaa a string base 64 do corpo
            $certificadoBase64 = Biblioteca::decifrar($request->getBody());

            $cnpj = Biblioteca::decifrar($request->getHeaders()['cnpj'][0]);
            $senha = Biblioteca::decifrar($request->getHeaders()['hash-registro'][0]);
                        
			// chama o método para atualizar o certificado
			AcbrMonitorService::atualizarCertificado($certificadoBase64, $senha, $cnpj);

            $retorno = 'Certificado atualizado com sucesso.';
            $response->getBody()->write($retorno);

            return $response
                ->withStatus(200)
                ->withHeader('Content-Type', 'application/json');
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Atualizar AcbrMonitor]', $e);
        }
    }

}
