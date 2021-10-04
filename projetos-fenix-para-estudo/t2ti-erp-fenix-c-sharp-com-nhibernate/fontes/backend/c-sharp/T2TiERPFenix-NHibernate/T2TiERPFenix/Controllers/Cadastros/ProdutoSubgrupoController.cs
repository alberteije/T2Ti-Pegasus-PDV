/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [PRODUTO_SUBGRUPO] 
                                                                                
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
    [Route("produto-subgrupo")]
    [Produces("application/json")]
    public class ProdutoSubgrupoController : Controller
    {
        private IRepositoryWrapper _repository;

        public ProdutoSubgrupoController(IRepositoryWrapper repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public IActionResult ConsultarListaProdutoSubgrupo([FromQuery]string filter)
        {
            try
            {
                IEnumerable<ProdutoSubgrupo> lista;
                if (filter == null)
                {
                    lista = _repository.ProdutoSubgrupo.ConsultarLista();
                }
                else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    lista = _repository.ProdutoSubgrupo.ConsultarListaFiltro(filtro);
                }
                return Ok(lista);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista ProdutoSubgrupo]", ex));
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoProdutoSubgrupo")]
        public IActionResult ConsultarObjetoProdutoSubgrupo(int id)
        {
            try
            {
                var objeto = _repository.ProdutoSubgrupo.ConsultarObjeto(id);

                if (objeto == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto ProdutoSubgrupo]", null));
                }
                else
                {
                    return Ok(objeto);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto ProdutoSubgrupo]", ex));
            }
        }

        [HttpPost]
        public IActionResult InserirProdutoSubgrupo([FromBody]ProdutoSubgrupo objJson)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Inserir ProdutoSubgrupo]", null));
                }
                _repository.ProdutoSubgrupo.Inserir(objJson);

                return CreatedAtRoute("ConsultarObjetoProdutoSubgrupo", new { id = objJson.Id }, objJson);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir ProdutoSubgrupo]", ex));
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarProdutoSubgrupo([FromBody]ProdutoSubgrupo objJson, int id)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar ProdutoSubgrupo]", null));
                }

                if (objJson.Id != id)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar ProdutoSubgrupo] - ID do objeto difere do ID da URL.", null));
                }

                var objBanco = _repository.ProdutoSubgrupo.ConsultarObjeto(objJson.Id);

                if (objBanco == null)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto com ID inválido [Alterar ProdutoSubgrupo]", null));
                }

                _repository.ProdutoSubgrupo.Alterar(objBanco, objJson);

                return ConsultarObjetoProdutoSubgrupo(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar ProdutoSubgrupo]", ex));
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirProdutoSubgrupo(int id)
        {
            try
            {
                var objeto = _repository.ProdutoSubgrupo.ConsultarObjeto(id);

                _repository.ProdutoSubgrupo.Excluir(objeto);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir ProdutoSubgrupo]", ex));
            }
        }

    }
}