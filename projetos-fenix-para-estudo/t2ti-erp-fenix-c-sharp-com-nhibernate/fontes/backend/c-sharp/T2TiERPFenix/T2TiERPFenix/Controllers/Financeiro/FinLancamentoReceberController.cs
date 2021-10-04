/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [FIN_LANCAMENTO_RECEBER] 
                                                                                
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
    [Route("fin-lancamento-receber")]
    [Produces("application/json")]
    public class FinLancamentoReceberController : Controller
    {
        private IRepositoryWrapper _repository;

        public FinLancamentoReceberController(IRepositoryWrapper repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public IActionResult ConsultarListaFinLancamentoReceber([FromQuery]string filter)
        {
            try
            {
                IEnumerable<FinLancamentoReceber> lista;
                if (filter == null)
                {
                    lista = _repository.FinLancamentoReceber.ConsultarLista();
                }
                else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    lista = _repository.FinLancamentoReceber.ConsultarListaFiltro(filtro);
                }
                return Ok(lista);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista FinLancamentoReceber]", ex));
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoFinLancamentoReceber")]
        public IActionResult ConsultarObjetoFinLancamentoReceber(int id)
        {
            try
            {
                var objeto = _repository.FinLancamentoReceber.ConsultarObjeto(id);

                if (objeto == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto FinLancamentoReceber]", null));
                }
                else
                {
                    return Ok(objeto);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto FinLancamentoReceber]", ex));
            }
        }

        [HttpPost]
        public IActionResult InserirFinLancamentoReceber([FromBody]FinLancamentoReceber objJson)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Inserir FinLancamentoReceber]", null));
                }
                _repository.FinLancamentoReceber.Inserir(objJson);

                return CreatedAtRoute("ConsultarObjetoFinLancamentoReceber", new { id = objJson.Id }, objJson);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir FinLancamentoReceber]", ex));
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarFinLancamentoReceber([FromBody]FinLancamentoReceber objJson, int id)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar FinLancamentoReceber]", null));
                }

                if (objJson.Id != id)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar FinLancamentoReceber] - ID do objeto difere do ID da URL.", null));
                }

                var objBanco = _repository.FinLancamentoReceber.ConsultarObjeto(objJson.Id);

                if (objBanco == null)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto com ID inválido [Alterar FinLancamentoReceber]", null));
                }

                _repository.FinLancamentoReceber.Alterar(objBanco, objJson);

                return ConsultarObjetoFinLancamentoReceber(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar FinLancamentoReceber]", ex));
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirFinLancamentoReceber(int id)
        {
            try
            {
                var objeto = _repository.FinLancamentoReceber.ConsultarObjeto(id);

                _repository.FinLancamentoReceber.Excluir(objeto);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir FinLancamentoReceber]", ex));
            }
        }

    }
}