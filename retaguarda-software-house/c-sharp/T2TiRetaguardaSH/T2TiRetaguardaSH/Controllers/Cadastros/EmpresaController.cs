/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Controller relacionado à tabela [EMPRESA] 
                                                                                
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
using T2TiRetaguardaSH.Models;
using T2TiRetaguardaSH.Services;
using T2TiRetaguardaSH.Util;

namespace T2TiRetaguardaSH.Controllers
{
    [Route("empresa")]
    [Produces("application/json")]
    public class EmpresaController : Controller
    {
		private readonly EmpresaService _service;

        public EmpresaController()
        {
            _service = new EmpresaService();
        }

        [HttpPost]
        public IActionResult AtualizarEmpresa([FromBody]String corpoRequisicao)
        {
            try
            {
                Empresa empresa = JsonConvert.DeserializeObject<Empresa>(Biblioteca.Decifrar(corpoRequisicao));
                _service.Atualizar(empresa);
                empresa = _service.ConsultarObjetoFiltro("CNPJ = '" + empresa.Cnpj + "'");
                String retorno = JsonConvert.SerializeObject(empresa, new JsonSerializerSettings { ContractResolver = new CamelCasePropertyNamesContractResolver() });
                return Ok(Biblioteca.Cifrar(retorno));
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Atualizar Empresa]", ex));
            }
        }

        [Route("registra-empresa")]
        [HttpPost]
        public IActionResult RegistrarEmpresa([FromBody]String corpoRequisicao)
        {
            try
            {
                Empresa empresa = JsonConvert.DeserializeObject<Empresa>(Biblioteca.Decifrar(corpoRequisicao));
                _service.Registrar(empresa);
                empresa = _service.ConsultarObjetoFiltro("CNPJ = '" + empresa.Cnpj + "'");
                String retorno = JsonConvert.SerializeObject(empresa, new JsonSerializerSettings { ContractResolver = new CamelCasePropertyNamesContractResolver() });
                return Ok(Biblioteca.Cifrar(retorno));
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Registrar Empresa]", ex));
            }
        }

        [Route("envia-email-confirmacao")]
        [HttpPost]
        public IActionResult EnviarEmailConfirmacao([FromBody]String corpoRequisicao)
        {
            try
            {
                Empresa empresa = JsonConvert.DeserializeObject<Empresa>(Biblioteca.Decifrar(corpoRequisicao));
                _service.EnviarEmailConfirmacao(empresa);
                empresa = _service.ConsultarObjetoFiltro("CNPJ = '" + empresa.Cnpj + "'");
                String retorno = JsonConvert.SerializeObject(empresa, new JsonSerializerSettings { ContractResolver = new CamelCasePropertyNamesContractResolver() });
                return Ok(Biblioteca.Cifrar(retorno));
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Enviar Email Confirmacao]", ex));
            }
        }

        [Route("confere-codigo-confirmacao")]
        [HttpPost]
        public IActionResult ConferirCodigoConfirmacao([FromBody]String corpoRequisicao)
        {
            try
            {
                Empresa empresa = JsonConvert.DeserializeObject<Empresa>(Biblioteca.Decifrar(corpoRequisicao));
                _service.ConferirCodigoConfirmacao(empresa, Biblioteca.Decifrar(Request.Headers["codigo-confirmacao"]));
                empresa = _service.ConsultarObjetoFiltro("CNPJ = '" + empresa.Cnpj + "'");
                String retorno = JsonConvert.SerializeObject(empresa, new JsonSerializerSettings { ContractResolver = new CamelCasePropertyNamesContractResolver() });
                return Ok(Biblioteca.Cifrar(retorno));
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Conferir Codigo Confirmacao]", ex));
            }
        }

        //[HttpGet]
        //public IActionResult ConsultarListaEmpresa([FromQuery]string filter)
        //{
        //    try
        //    {
        //        IEnumerable<Empresa> lista;
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
        //        return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista Empresa]", ex));
        //    }
        //}

        //[HttpGet("{cnpj}", Name = "ConsultarObjetoEmpresa")]
        //public IActionResult ConsultarObjetoEmpresa(string cnpj)
        //{
        //    try
        //    {
        //        var objeto = _service.ConsultarObjetoFiltro("CNPJ = '" + cnpj + "'");

        //        if (objeto == null)
        //        {
        //            return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto Empresa]", null));
        //        }
        //        else
        //        {
        //            return Ok(objeto);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto Empresa]", ex));
        //    }
        //}

        //[HttpPut("{id}")]
        //public IActionResult AlterarEmpresa([FromBody]Empresa objJson, int id)
        //{
        //    try
        //    {
        //        if (!ModelState.IsValid)
        //        {
        //            return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar Empresa]", null));
        //        }

        //        if (objJson.Id != id)
        //        {
        //            return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar Empresa] - ID do objeto difere do ID da URL.", null));
        //        }

        //        _service.Alterar(objJson);

        //        return ConsultarObjetoEmpresa(objJson.Cnpj);
        //    }
        //    catch (Exception ex)
        //    {
        //        return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar Empresa]", ex));
        //    }
        //}

        //[HttpDelete("{id}")]
        //public IActionResult ExcluirEmpresa(int id)
        //{
        //    try
        //    {
        //        var objeto = _service.ConsultarObjeto(id);

        //        _service.Excluir(objeto);

        //        return Ok();
        //    }
        //    catch (Exception ex)
        //    {
        //        return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir Empresa]", ex));
        //    }
        //}

    }
}