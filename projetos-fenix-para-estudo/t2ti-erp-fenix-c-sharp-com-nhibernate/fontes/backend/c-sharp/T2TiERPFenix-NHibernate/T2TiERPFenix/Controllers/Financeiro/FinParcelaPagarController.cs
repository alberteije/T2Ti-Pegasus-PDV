/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [FIN_PARCELA_PAGAR] 
                                                                                
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
    [Route("fin-parcela-pagar")]
    [Produces("application/json")]
    public class FinParcelaPagarController : Controller
    {
        private IRepositoryWrapper _repository;

        public FinParcelaPagarController(IRepositoryWrapper repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public IActionResult ConsultarListaFinParcelaPagar([FromQuery]string filter)
        {
            try
            {
                IEnumerable<FinParcelaPagar> lista;
                if (filter == null)
                {
                    lista = _repository.FinParcelaPagar.ConsultarLista();
                }
                else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    lista = _repository.FinParcelaPagar.ConsultarListaFiltro(filtro);
                }
                return Ok(lista);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista FinParcelaPagar]", ex));
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoFinParcelaPagar")]
        public IActionResult ConsultarObjetoFinParcelaPagar(int id)
        {
            try
            {
                var objeto = _repository.FinParcelaPagar.ConsultarObjeto(id);

                if (objeto == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto FinParcelaPagar]", null));
                }
                else
                {
                    return Ok(objeto);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto FinParcelaPagar]", ex));
            }
        }

        [HttpPost]
        public IActionResult InserirFinParcelaPagar([FromBody]FinParcelaPagar objJson)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Inserir FinParcelaPagar]", null));
                }
                _repository.FinParcelaPagar.Inserir(objJson);

                return CreatedAtRoute("ConsultarObjetoFinParcelaPagar", new { id = objJson.Id }, objJson);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir FinParcelaPagar]", ex));
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarFinParcelaPagar([FromBody]FinParcelaPagar objJson, int id)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar FinParcelaPagar]", null));
                }

                if (objJson.Id != id)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar FinParcelaPagar] - ID do objeto difere do ID da URL.", null));
                }

                var objBanco = _repository.FinParcelaPagar.ConsultarObjeto(objJson.Id);

                if (objBanco == null)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto com ID inválido [Alterar FinParcelaPagar]", null));
                }

                _repository.FinParcelaPagar.Alterar(objBanco, objJson);

                return ConsultarObjetoFinParcelaPagar(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar FinParcelaPagar]", ex));
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirFinParcelaPagar(int id)
        {
            try
            {
                var objeto = _repository.FinParcelaPagar.ConsultarObjeto(id);

                _repository.FinParcelaPagar.Excluir(objeto);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir FinParcelaPagar]", ex));
            }
        }

    }
}