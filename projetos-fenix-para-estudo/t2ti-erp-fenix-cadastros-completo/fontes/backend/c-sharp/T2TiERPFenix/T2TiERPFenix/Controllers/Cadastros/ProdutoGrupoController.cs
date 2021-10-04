/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [PRODUTO_GRUPO] 
                                                                                
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
    [Route("produto-grupo")]
    [Produces("application/json")]
    public class ProdutoGrupoController : Controller
    {
        private IRepositoryWrapper _repository;

        public ProdutoGrupoController(IRepositoryWrapper repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public IActionResult ConsultarListaProdutoGrupo([FromQuery]string filter)
        {
            try
            {
                IEnumerable<ProdutoGrupo> lista;
                if (filter == null)
                {
                    lista = _repository.ProdutoGrupo.ConsultarLista();
                }
                else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    lista = _repository.ProdutoGrupo.ConsultarListaFiltro(filtro);
                }
                return Ok(lista);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista ProdutoGrupo]", ex));
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoProdutoGrupo")]
        public IActionResult ConsultarObjetoProdutoGrupo(int id)
        {
            try
            {
                var objeto = _repository.ProdutoGrupo.ConsultarObjeto(id);

                if (objeto == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto ProdutoGrupo]", null));
                }
                else
                {
                    return Ok(objeto);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto ProdutoGrupo]", ex));
            }
        }

        [HttpPost]
        public IActionResult InserirProdutoGrupo([FromBody]ProdutoGrupo objJson)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Inserir ProdutoGrupo]", null));
                }
                _repository.ProdutoGrupo.Inserir(objJson);

                return CreatedAtRoute("ConsultarObjetoProdutoGrupo", new { id = objJson.Id }, objJson);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir ProdutoGrupo]", ex));
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarProdutoGrupo([FromBody]ProdutoGrupo objJson, int id)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar ProdutoGrupo]", null));
                }

                if (objJson.Id != id)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar ProdutoGrupo] - ID do objeto difere do ID da URL.", null));
                }

                var objBanco = _repository.ProdutoGrupo.ConsultarObjeto(objJson.Id);

                if (objBanco == null)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto com ID inválido [Alterar ProdutoGrupo]", null));
                }

                _repository.ProdutoGrupo.Alterar(objBanco, objJson);

                return ConsultarObjetoProdutoGrupo(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar ProdutoGrupo]", ex));
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirProdutoGrupo(int id)
        {
            try
            {
                var objeto = _repository.ProdutoGrupo.ConsultarObjeto(id);

                _repository.ProdutoGrupo.Excluir(objeto);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir ProdutoGrupo]", ex));
            }
        }

    }
}