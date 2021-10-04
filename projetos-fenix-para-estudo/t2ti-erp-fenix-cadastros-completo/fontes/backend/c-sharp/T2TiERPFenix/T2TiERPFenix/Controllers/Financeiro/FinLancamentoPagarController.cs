/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [FIN_LANCAMENTO_PAGAR] 
                                                                                
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
    [Route("fin-lancamento-pagar")]
    [Produces("application/json")]
    public class FinLancamentoPagarController : Controller
    {
        private IRepositoryWrapper _repository;

        public FinLancamentoPagarController(IRepositoryWrapper repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public IActionResult ConsultarListaFinLancamentoPagar([FromQuery]string filter)
        {
            try
            {
                IEnumerable<FinLancamentoPagar> lista;
                if (filter == null)
                {
                    lista = _repository.FinLancamentoPagar.ConsultarLista();
                }
                else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    lista = _repository.FinLancamentoPagar.ConsultarListaFiltro(filtro);
                }
                return Ok(lista);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista FinLancamentoPagar]", ex));
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoFinLancamentoPagar")]
        public IActionResult ConsultarObjetoFinLancamentoPagar(int id)
        {
            try
            {
                var objeto = _repository.FinLancamentoPagar.ConsultarObjeto(id);

                if (objeto == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto FinLancamentoPagar]", null));
                }
                else
                {
                    return Ok(objeto);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto FinLancamentoPagar]", ex));
            }
        }

        [HttpPost]
        public IActionResult InserirFinLancamentoPagar([FromBody]FinLancamentoPagar objJson)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Inserir FinLancamentoPagar]", null));
                }
                _repository.FinLancamentoPagar.Inserir(objJson);

                return CreatedAtRoute("ConsultarObjetoFinLancamentoPagar", new { id = objJson.Id }, objJson);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir FinLancamentoPagar]", ex));
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarFinLancamentoPagar([FromBody]FinLancamentoPagar objJson, int id)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar FinLancamentoPagar]", null));
                }

                if (objJson.Id != id)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar FinLancamentoPagar] - ID do objeto difere do ID da URL.", null));
                }

                var objBanco = _repository.FinLancamentoPagar.ConsultarObjeto(objJson.Id);

                if (objBanco == null)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto com ID inválido [Alterar FinLancamentoPagar]", null));
                }

                _repository.FinLancamentoPagar.Alterar(objBanco, objJson);

                return ConsultarObjetoFinLancamentoPagar(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar FinLancamentoPagar]", ex));
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirFinLancamentoPagar(int id)
        {
            try
            {
                var objeto = _repository.FinLancamentoPagar.ConsultarObjeto(id);

                _repository.FinLancamentoPagar.Excluir(objeto);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir FinLancamentoPagar]", ex));
            }
        }

    }
}