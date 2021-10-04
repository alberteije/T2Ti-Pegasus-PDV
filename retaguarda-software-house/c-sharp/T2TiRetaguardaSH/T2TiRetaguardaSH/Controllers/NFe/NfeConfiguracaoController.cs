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
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using T2TiRetaguardaSH.Models;
using T2TiRetaguardaSH.Services;
using T2TiRetaguardaSH.Util;

namespace T2TiRetaguardaSH.Controllers
{
    [Route("nfe-configuracao")]
    [Produces("application/json")]
    public class NfeConfiguracaoController : Controller
    {
		private readonly NfeConfiguracaoService _service;

        public NfeConfiguracaoController()
        {
            _service = new NfeConfiguracaoService();
        }

        [HttpGet]
        public IActionResult ConsultarListaNfeConfiguracao([FromQuery]string filter)
        {
            try
            {
                IEnumerable<NfeConfiguracao> lista;
                if (filter == null)
                {
                    lista = _service.ConsultarLista();
                }
                else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    lista = _service.ConsultarListaFiltro(filtro);
                }
                return Ok(lista);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista NfeConfiguracao]", ex));
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoNfeConfiguracao")]
        public IActionResult ConsultarObjetoNfeConfiguracao(int id)
        {
            try
            {
                var objeto = _service.ConsultarObjeto(id);

                if (objeto == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto NfeConfiguracao]", null));
                }
                else
                {
                    return Ok(objeto);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto NfeConfiguracao]", ex));
            }
        }

        [HttpGet]
        public IActionResult RetornarArquivosXmlPeriodo()
        {
            try
            {
                string periodo = Request.Headers["periodo"];
                string cnpj = Request.Headers["cnpj"];
                bool retorno = _service.GerarZipArquivosXml(periodo, cnpj);
                if (retorno)
                {
                    string nomeArquivo = "NotasFiscaisNFCe_" + periodo + ".zip";
                    string caminhoArquivo = "C:\\ACBrMonitor\\" + cnpj + "\\" + nomeArquivo;
                    var net = new System.Net.WebClient();
                    var data = net.DownloadData(caminhoArquivo);
                    var content = new System.IO.MemoryStream(data);
                    var contentType = "application/zip";
                    net.Dispose();
                    return File(content, contentType, nomeArquivo);
                } else
                {
                    return StatusCode(500, new RetornoJsonErro(500, "Problemas na criação do arquivo [Retornar XML Período]", null));
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Gerar RetornarArquivosXmlPeriodo]", ex));
            }
        }

        [HttpPost("{cnpj}")]
        public IActionResult AtualizarNfeConfiguracao([FromBody]NfeConfiguracao objJson, string cnpj)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Atualizar NfeConfiguracao]", null));
                }

                string pdvConfiguracao = Request.Headers["pdv-configuracao"];
                var definition = new { decimaisQuantidade = 2, decimaisValor = 2 };
                var pdvConfiguracaoJson = JsonConvert.DeserializeAnonymousType(pdvConfiguracao, definition);

                int decimaisQuantidade = pdvConfiguracaoJson.decimaisQuantidade;
                int decimaisValor = pdvConfiguracaoJson.decimaisValor;

                // chama o método atualizar do service e aguarda um objeto para a porta
                AcbrMonitorPorta portaMonitor = _service.Atualizar(objJson, cnpj, decimaisQuantidade, decimaisValor);

                // configura o cabeçalho de retorno, enviando a porta e o endereço do servidor
				if (portaMonitor != null) 
				{
					Response.Headers.Add("endereco-monitor", Constantes.ENDERECO_SERVIDOR);
					Response.Headers.Add("porta-monitor", portaMonitor.Id.ToString());
				}

                return CreatedAtRoute("ConsultarObjetoNfeConfiguracao", new { id = objJson.Id }, objJson);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Atualizar NfeConfiguracao]", ex));
            }
        }

        [HttpPost]
        public IActionResult AtualizarCertificado([FromBody]string certificadoBase64)
        {
            try
            {
                string senha = Request.Headers["hash-registro"];
                string cnpj = Request.Headers["cnpj"];
                _service.AtualizarCertificado(certificadoBase64, senha, cnpj);
                return StatusCode(200, "Certificado atualizado com sucesso.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir NfeConfiguracao]", ex));
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarNfeConfiguracao([FromBody]NfeConfiguracao objJson, int id)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar NfeConfiguracao]", null));
                }

                if (objJson.Id != id)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar NfeConfiguracao] - ID do objeto difere do ID da URL.", null));
                }

                _service.Alterar(objJson);

                return ConsultarObjetoNfeConfiguracao(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar NfeConfiguracao]", ex));
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirNfeConfiguracao(int id)
        {
            try
            {
                var objeto = _service.ConsultarObjeto(id);

                _service.Excluir(objeto);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir NfeConfiguracao]", ex));
            }
        }

    }
}