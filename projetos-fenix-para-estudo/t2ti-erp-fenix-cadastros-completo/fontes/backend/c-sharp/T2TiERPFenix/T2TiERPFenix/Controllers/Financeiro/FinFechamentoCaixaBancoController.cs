/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [FIN_FECHAMENTO_CAIXA_BANCO] 
                                                                                
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
    [Route("fin-fechamento-caixa-banco")]
    [Produces("application/json")]
    public class FinFechamentoCaixaBancoController : Controller
    {
        private IRepositoryWrapper _repository;

        public FinFechamentoCaixaBancoController(IRepositoryWrapper repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public IActionResult ConsultarListaFinFechamentoCaixaBanco([FromQuery]string filter)
        {
            try
            {
                IEnumerable<FinFechamentoCaixaBanco> lista;
                if (filter == null)
                {
                    lista = _repository.FinFechamentoCaixaBanco.ConsultarLista();
                }
                else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    lista = _repository.FinFechamentoCaixaBanco.ConsultarListaFiltro(filtro);
                }
                return Ok(lista);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista FinFechamentoCaixaBanco]", ex));
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoFinFechamentoCaixaBanco")]
        public IActionResult ConsultarObjetoFinFechamentoCaixaBanco(int id)
        {
            try
            {
                var objeto = _repository.FinFechamentoCaixaBanco.ConsultarObjeto(id);

                if (objeto == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto FinFechamentoCaixaBanco]", null));
                }
                else
                {
                    return Ok(objeto);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto FinFechamentoCaixaBanco]", ex));
            }
        }

        [HttpPost]
        public IActionResult InserirFinFechamentoCaixaBanco([FromBody]FinFechamentoCaixaBanco objJson)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Inserir FinFechamentoCaixaBanco]", null));
                }
                _repository.FinFechamentoCaixaBanco.Inserir(objJson);

                return CreatedAtRoute("ConsultarObjetoFinFechamentoCaixaBanco", new { id = objJson.Id }, objJson);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir FinFechamentoCaixaBanco]", ex));
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarFinFechamentoCaixaBanco([FromBody]FinFechamentoCaixaBanco objJson, int id)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar FinFechamentoCaixaBanco]", null));
                }

                if (objJson.Id != id)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar FinFechamentoCaixaBanco] - ID do objeto difere do ID da URL.", null));
                }

                var objBanco = _repository.FinFechamentoCaixaBanco.ConsultarObjeto(objJson.Id);

                if (objBanco == null)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto com ID inválido [Alterar FinFechamentoCaixaBanco]", null));
                }

                _repository.FinFechamentoCaixaBanco.Alterar(objBanco, objJson);

                return ConsultarObjetoFinFechamentoCaixaBanco(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar FinFechamentoCaixaBanco]", ex));
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirFinFechamentoCaixaBanco(int id)
        {
            try
            {
                var objeto = _repository.FinFechamentoCaixaBanco.ConsultarObjeto(id);

                _repository.FinFechamentoCaixaBanco.Excluir(objeto);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir FinFechamentoCaixaBanco]", ex));
            }
        }

    }
}