/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [VIEW_PESSOA_COLABORADOR] 
                                                                                
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
    [Route("view-pessoa-colaborador")]
    [Produces("application/json")]
    public class ViewPessoaColaboradorController : Controller
    {
        private IRepositoryWrapper _repository;

        public ViewPessoaColaboradorController(IRepositoryWrapper repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public IActionResult ConsultarListaViewPessoaColaborador([FromQuery]string filter)
        {
            try
            {
                IEnumerable<ViewPessoaColaborador> lista;
                if (filter == null)
                {
                    lista = _repository.ViewPessoaColaborador.ConsultarLista();
                }
                else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    lista = _repository.ViewPessoaColaborador.ConsultarListaFiltro(filtro);
                }
                return Ok(lista);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista ViewPessoaColaborador]", ex));
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoViewPessoaColaborador")]
        public IActionResult ConsultarObjetoViewPessoaColaborador(int id)
        {
            try
            {
                var objeto = _repository.ViewPessoaColaborador.ConsultarObjeto(id);

                if (objeto == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto ViewPessoaColaborador]", null));
                }
                else
                {
                    return Ok(objeto);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto ViewPessoaColaborador]", ex));
            }
        }

        [HttpPost]
        public IActionResult InserirViewPessoaColaborador([FromBody]ViewPessoaColaborador objJson)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Inserir ViewPessoaColaborador]", null));
                }
                _repository.ViewPessoaColaborador.Inserir(objJson);

                return CreatedAtRoute("ConsultarObjetoViewPessoaColaborador", new { id = objJson.Id }, objJson);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir ViewPessoaColaborador]", ex));
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarViewPessoaColaborador([FromBody]ViewPessoaColaborador objJson, int id)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar ViewPessoaColaborador]", null));
                }

                if (objJson.Id != id)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar ViewPessoaColaborador] - ID do objeto difere do ID da URL.", null));
                }

                var objBanco = _repository.ViewPessoaColaborador.ConsultarObjeto(objJson.Id);

                if (objBanco == null)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto com ID inválido [Alterar ViewPessoaColaborador]", null));
                }

                _repository.ViewPessoaColaborador.Alterar(objBanco, objJson);

                return ConsultarObjetoViewPessoaColaborador(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar ViewPessoaColaborador]", ex));
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirViewPessoaColaborador(int id)
        {
            try
            {
                var objeto = _repository.ViewPessoaColaborador.ConsultarObjeto(id);

                _repository.ViewPessoaColaborador.Excluir(objeto);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir ViewPessoaColaborador]", ex));
            }
        }

    }
}