/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [FIN_EXTRATO_CONTA_BANCO] 
                                                                                
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
    [Route("fin-extrato-conta-banco")]
    [Produces("application/json")]
    public class FinExtratoContaBancoController : Controller
    {
        private IRepositoryWrapper _repository;

        public FinExtratoContaBancoController(IRepositoryWrapper repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public IActionResult ConsultarListaFinExtratoContaBanco([FromQuery]string filter)
        {
            try
            {
                IEnumerable<FinExtratoContaBanco> lista;
                if (filter == null)
                {
                    lista = _repository.FinExtratoContaBanco.ConsultarLista();
                }
                else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    lista = _repository.FinExtratoContaBanco.ConsultarListaFiltro(filtro);
                }
                return Ok(lista);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista FinExtratoContaBanco]", ex));
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoFinExtratoContaBanco")]
        public IActionResult ConsultarObjetoFinExtratoContaBanco(int id)
        {
            try
            {
                var objeto = _repository.FinExtratoContaBanco.ConsultarObjeto(id);

                if (objeto == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto FinExtratoContaBanco]", null));
                }
                else
                {
                    return Ok(objeto);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto FinExtratoContaBanco]", ex));
            }
        }

        [HttpPost]
        public IActionResult InserirFinExtratoContaBanco([FromBody]FinExtratoContaBanco objJson)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Inserir FinExtratoContaBanco]", null));
                }
                _repository.FinExtratoContaBanco.Inserir(objJson);

                return CreatedAtRoute("ConsultarObjetoFinExtratoContaBanco", new { id = objJson.Id }, objJson);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir FinExtratoContaBanco]", ex));
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarFinExtratoContaBanco([FromBody]FinExtratoContaBanco objJson, int id)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar FinExtratoContaBanco]", null));
                }

                if (objJson.Id != id)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar FinExtratoContaBanco] - ID do objeto difere do ID da URL.", null));
                }

                var objBanco = _repository.FinExtratoContaBanco.ConsultarObjeto(objJson.Id);

                if (objBanco == null)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto com ID inválido [Alterar FinExtratoContaBanco]", null));
                }

                _repository.FinExtratoContaBanco.Alterar(objBanco, objJson);

                return ConsultarObjetoFinExtratoContaBanco(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar FinExtratoContaBanco]", ex));
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirFinExtratoContaBanco(int id)
        {
            try
            {
                var objeto = _repository.FinExtratoContaBanco.ConsultarObjeto(id);

                _repository.FinExtratoContaBanco.Excluir(objeto);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir FinExtratoContaBanco]", ex));
            }
        }

    }
}