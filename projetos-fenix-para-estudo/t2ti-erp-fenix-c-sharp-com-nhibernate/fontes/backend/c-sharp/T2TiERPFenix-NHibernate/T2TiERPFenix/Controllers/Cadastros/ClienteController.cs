/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [CLIENTE] 
                                                                                
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
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using T2TiERPFenix.Models;
using T2TiERPFenix.Repository;

namespace T2TiERPFenix.Controllers
{
    [Route("cliente")]
    [Produces("application/json")]
    public class ClienteController : Controller
    {
        private IRepositoryWrapper _repository;

        public ClienteController(IRepositoryWrapper repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public IActionResult ConsultarListaCliente([FromQuery]string filter)
        {
            try
            {
                IEnumerable<Cliente> lista;
                if (filter == null)
                {
                    lista = _repository.Cliente.ConsultarLista();
                }
                else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    lista = _repository.Cliente.ConsultarListaFiltro(filtro);
                }
                return Ok(lista);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista Cliente]", ex));
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoCliente")]
        public IActionResult ConsultarObjetoCliente(int id)
        {
            try
            {
                var objeto = _repository.Cliente.ConsultarObjeto(id);

                if (objeto == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto Cliente]", null));
                }
                else
                {
                    return Ok(objeto);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto Cliente]", ex));
            }
        }

        [HttpPost]
        public IActionResult InserirCliente([FromBody]Cliente objJson)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Inserir Cliente]", null));
                }
                _repository.Cliente.Inserir(objJson);

                return CreatedAtRoute("ConsultarObjetoCliente", new { id = objJson.Id }, objJson);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir Cliente]", ex));
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarCliente([FromBody]Cliente objJson, int id)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar Cliente]", null));
                }

                if (objJson.Id != id)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar Cliente] - ID do objeto difere do ID da URL.", null));
                }

                var objBanco = _repository.Cliente.ConsultarObjeto(objJson.Id);

                if (objBanco == null)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto com ID inválido [Alterar Cliente]", null));
                }

                _repository.Cliente.Alterar(objBanco, objJson);

                return ConsultarObjetoCliente(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar Cliente]", ex));
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirCliente(int id)
        {
            try
            {
                var objeto = _repository.Cliente.ConsultarObjeto(id);

                _repository.Cliente.Excluir(objeto);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir Cliente]", ex));
            }
        }

    }
}