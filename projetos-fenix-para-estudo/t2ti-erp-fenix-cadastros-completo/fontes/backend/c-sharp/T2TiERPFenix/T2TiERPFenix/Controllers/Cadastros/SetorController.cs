/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [SETOR] 
                                                                                
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
    [Route("setor")]
    [Produces("application/json")]
    public class SetorController : Controller
    {
        private IRepositoryWrapper _repository;

        public SetorController(IRepositoryWrapper repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public IActionResult ConsultarListaSetor([FromQuery]string filter)
        {
            try
            {
                IEnumerable<Setor> lista;
                if (filter == null)
                {
                    lista = _repository.Setor.ConsultarLista();
                }
                else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    lista = _repository.Setor.ConsultarListaFiltro(filtro);
                }
                return Ok(lista);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista Setor]", ex));
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoSetor")]
        public IActionResult ConsultarObjetoSetor(int id)
        {
            try
            {
                var objeto = _repository.Setor.ConsultarObjeto(id);

                if (objeto == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto Setor]", null));
                }
                else
                {
                    return Ok(objeto);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto Setor]", ex));
            }
        }

        [HttpPost]
        public IActionResult InserirSetor([FromBody]Setor objJson)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Inserir Setor]", null));
                }
                _repository.Setor.Inserir(objJson);

                return CreatedAtRoute("ConsultarObjetoSetor", new { id = objJson.Id }, objJson);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir Setor]", ex));
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarSetor([FromBody]Setor objJson, int id)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar Setor]", null));
                }

                if (objJson.Id != id)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar Setor] - ID do objeto difere do ID da URL.", null));
                }

                var objBanco = _repository.Setor.ConsultarObjeto(objJson.Id);

                if (objBanco == null)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto com ID inválido [Alterar Setor]", null));
                }

                _repository.Setor.Alterar(objBanco, objJson);

                return ConsultarObjetoSetor(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar Setor]", ex));
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirSetor(int id)
        {
            try
            {
                var objeto = _repository.Setor.ConsultarObjeto(id);

                _repository.Setor.Excluir(objeto);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir Setor]", ex));
            }
        }

    }
}