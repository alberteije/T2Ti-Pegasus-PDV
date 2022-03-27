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
using Newtonsoft.Json.Serialization;
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

        [Route("atualiza-dados")]
        [HttpPost]
        public IActionResult AtualizarNfeConfiguracao([FromBody]String corpoRequisicao)
        {
            try
            {
                NfeConfiguracao nfeConfiguracao = JsonConvert.DeserializeObject<NfeConfiguracao>(Biblioteca.Decifrar(corpoRequisicao));

                string cnpj = Biblioteca.Decifrar(Request.Headers["cnpj"]);
                string pdvConfiguracao = Biblioteca.Decifrar(Request.Headers["pdv-configuracao"]);

                var definition = new { decimaisQuantidade = 2, decimaisValor = 2 };
                var pdvConfiguracaoJson = JsonConvert.DeserializeAnonymousType(pdvConfiguracao, definition);

                int decimaisQuantidade = pdvConfiguracaoJson.decimaisQuantidade;
                int decimaisValor = pdvConfiguracaoJson.decimaisValor;

                // chama o método atualizar do service
                nfeConfiguracao = _service.Atualizar(nfeConfiguracao, cnpj, decimaisQuantidade, decimaisValor);

                String retorno = JsonConvert.SerializeObject(nfeConfiguracao, new JsonSerializerSettings { ContractResolver = new CamelCasePropertyNamesContractResolver() });
                return Ok(Biblioteca.Cifrar(retorno));
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Atualizar NfeConfiguracao]", ex));
            }
        }


        //[HttpGet]
        //public IActionResult ConsultarListaNfeConfiguracao([FromQuery]string filter)
        //{
        //    try
        //    {
        //        IEnumerable<NfeConfiguracao> lista;
        //        if (filter == null)
        //        {
        //            lista = _service.ConsultarLista();
        //        }
        //        else
        //        {
        //            // define o filtro
        //            Filtro filtro = new Filtro(filter);
        //            lista = _service.ConsultarListaFiltro(filtro);
        //        }
        //        return Ok(lista);
        //    }
        //    catch (Exception ex)
        //    {
        //        return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista NfeConfiguracao]", ex));
        //    }
        //}

        //[HttpGet("{id}", Name = "ConsultarObjetoNfeConfiguracao")]
        //public IActionResult ConsultarObjetoNfeConfiguracao(int id)
        //{
        //    try
        //    {
        //        var objeto = _service.ConsultarObjeto(id);

        //        if (objeto == null)
        //        {
        //            return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto NfeConfiguracao]", null));
        //        }
        //        else
        //        {
        //            return Ok(objeto);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto NfeConfiguracao]", ex));
        //    }
        //}

        //[HttpPut("{id}")]
        //public IActionResult AlterarNfeConfiguracao([FromBody]NfeConfiguracao objJson, int id)
        //{
        //    try
        //    {
        //        if (!ModelState.IsValid)
        //        {
        //            return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar NfeConfiguracao]", null));
        //        }

        //        if (objJson.Id != id)
        //        {
        //            return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar NfeConfiguracao] - ID do objeto difere do ID da URL.", null));
        //        }

        //        _service.Alterar(objJson);

        //        return ConsultarObjetoNfeConfiguracao(id);
        //    }
        //    catch (Exception ex)
        //    {
        //        return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar NfeConfiguracao]", ex));
        //    }
        //}

        //[HttpDelete("{id}")]
        //public IActionResult ExcluirNfeConfiguracao(int id)
        //{
        //    try
        //    {
        //        var objeto = _service.ConsultarObjeto(id);

        //        _service.Excluir(objeto);

        //        return Ok();
        //    }
        //    catch (Exception ex)
        //    {
        //        return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir NfeConfiguracao]", ex));
        //    }
        //}

    }
}