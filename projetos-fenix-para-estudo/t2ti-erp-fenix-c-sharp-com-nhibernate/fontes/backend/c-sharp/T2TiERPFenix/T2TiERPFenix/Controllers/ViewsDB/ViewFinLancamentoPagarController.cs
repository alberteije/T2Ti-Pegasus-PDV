/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [VIEW_FIN_LANCAMENTO_PAGAR] 
                                                                                
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
    [Route("view-fin-lancamento-pagar")]
    [Produces("application/json")]
    public class ViewFinLancamentoPagarController : Controller
    {
        private IRepositoryWrapper _repository;

        public ViewFinLancamentoPagarController(IRepositoryWrapper repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public IActionResult ConsultarListaViewFinLancamentoPagar([FromQuery]string filter)
        {
            try
            {
                IEnumerable<ViewFinLancamentoPagar> lista;
                if (filter == null)
                {
                    lista = _repository.ViewFinLancamentoPagar.ConsultarLista();
                }
                else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    lista = _repository.ViewFinLancamentoPagar.ConsultarListaFiltro(filtro);
                }
                return Ok(lista);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista ViewFinLancamentoPagar]", ex));
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoViewFinLancamentoPagar")]
        public IActionResult ConsultarObjetoViewFinLancamentoPagar(int id)
        {
            try
            {
                var objeto = _repository.ViewFinLancamentoPagar.ConsultarObjeto(id);

                if (objeto == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto ViewFinLancamentoPagar]", null));
                }
                else
                {
                    return Ok(objeto);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto ViewFinLancamentoPagar]", ex));
            }
        }

        [HttpPost]
        public IActionResult InserirViewFinLancamentoPagar([FromBody]ViewFinLancamentoPagar objJson)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Inserir ViewFinLancamentoPagar]", null));
                }
                _repository.ViewFinLancamentoPagar.Inserir(objJson);

                return CreatedAtRoute("ConsultarObjetoViewFinLancamentoPagar", new { id = objJson.Id }, objJson);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir ViewFinLancamentoPagar]", ex));
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarViewFinLancamentoPagar([FromBody]ViewFinLancamentoPagar objJson, int id)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar ViewFinLancamentoPagar]", null));
                }

                if (objJson.Id != id)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar ViewFinLancamentoPagar] - ID do objeto difere do ID da URL.", null));
                }

                var objBanco = _repository.ViewFinLancamentoPagar.ConsultarObjeto(objJson.Id);

                if (objBanco == null)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto com ID inválido [Alterar ViewFinLancamentoPagar]", null));
                }

                _repository.ViewFinLancamentoPagar.Alterar(objBanco, objJson);

                return ConsultarObjetoViewFinLancamentoPagar(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar ViewFinLancamentoPagar]", ex));
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirViewFinLancamentoPagar(int id)
        {
            try
            {
                var objeto = _repository.ViewFinLancamentoPagar.ConsultarObjeto(id);

                _repository.ViewFinLancamentoPagar.Excluir(objeto);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir ViewFinLancamentoPagar]", ex));
            }
        }

    }
}