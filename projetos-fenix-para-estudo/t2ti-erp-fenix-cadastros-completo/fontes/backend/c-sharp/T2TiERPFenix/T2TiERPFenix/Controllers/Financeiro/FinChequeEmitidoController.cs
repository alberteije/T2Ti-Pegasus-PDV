/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [FIN_CHEQUE_EMITIDO] 
                                                                                
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
    [Route("fin-cheque-emitido")]
    [Produces("application/json")]
    public class FinChequeEmitidoController : Controller
    {
        private IRepositoryWrapper _repository;

        public FinChequeEmitidoController(IRepositoryWrapper repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public IActionResult ConsultarListaFinChequeEmitido([FromQuery]string filter)
        {
            try
            {
                IEnumerable<FinChequeEmitido> lista;
                if (filter == null)
                {
                    lista = _repository.FinChequeEmitido.ConsultarLista();
                }
                else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    lista = _repository.FinChequeEmitido.ConsultarListaFiltro(filtro);
                }
                return Ok(lista);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista FinChequeEmitido]", ex));
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoFinChequeEmitido")]
        public IActionResult ConsultarObjetoFinChequeEmitido(int id)
        {
            try
            {
                var objeto = _repository.FinChequeEmitido.ConsultarObjeto(id);

                if (objeto == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto FinChequeEmitido]", null));
                }
                else
                {
                    return Ok(objeto);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto FinChequeEmitido]", ex));
            }
        }

        [HttpPost]
        public IActionResult InserirFinChequeEmitido([FromBody]FinChequeEmitido objJson)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Inserir FinChequeEmitido]", null));
                }
                _repository.FinChequeEmitido.Inserir(objJson);

                return CreatedAtRoute("ConsultarObjetoFinChequeEmitido", new { id = objJson.Id }, objJson);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir FinChequeEmitido]", ex));
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarFinChequeEmitido([FromBody]FinChequeEmitido objJson, int id)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar FinChequeEmitido]", null));
                }

                if (objJson.Id != id)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar FinChequeEmitido] - ID do objeto difere do ID da URL.", null));
                }

                var objBanco = _repository.FinChequeEmitido.ConsultarObjeto(objJson.Id);

                if (objBanco == null)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto com ID inválido [Alterar FinChequeEmitido]", null));
                }

                _repository.FinChequeEmitido.Alterar(objBanco, objJson);

                return ConsultarObjetoFinChequeEmitido(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar FinChequeEmitido]", ex));
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirFinChequeEmitido(int id)
        {
            try
            {
                var objeto = _repository.FinChequeEmitido.ConsultarObjeto(id);

                _repository.FinChequeEmitido.Excluir(objeto);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir FinChequeEmitido]", ex));
            }
        }

    }
}