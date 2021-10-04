/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [FIN_TIPO_RECEBIMENTO] 
                                                                                
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
    [Route("fin-tipo-recebimento")]
    [Produces("application/json")]
    public class FinTipoRecebimentoController : Controller
    {
        private IRepositoryWrapper _repository;

        public FinTipoRecebimentoController(IRepositoryWrapper repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public IActionResult ConsultarListaFinTipoRecebimento([FromQuery]string filter)
        {
            try
            {
                IEnumerable<FinTipoRecebimento> lista;
                if (filter == null)
                {
                    lista = _repository.FinTipoRecebimento.ConsultarLista();
                }
                else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    lista = _repository.FinTipoRecebimento.ConsultarListaFiltro(filtro);
                }
                return Ok(lista);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista FinTipoRecebimento]", ex));
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoFinTipoRecebimento")]
        public IActionResult ConsultarObjetoFinTipoRecebimento(int id)
        {
            try
            {
                var objeto = _repository.FinTipoRecebimento.ConsultarObjeto(id);

                if (objeto == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto FinTipoRecebimento]", null));
                }
                else
                {
                    return Ok(objeto);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto FinTipoRecebimento]", ex));
            }
        }

        [HttpPost]
        public IActionResult InserirFinTipoRecebimento([FromBody]FinTipoRecebimento objJson)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Inserir FinTipoRecebimento]", null));
                }
                _repository.FinTipoRecebimento.Inserir(objJson);

                return CreatedAtRoute("ConsultarObjetoFinTipoRecebimento", new { id = objJson.Id }, objJson);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir FinTipoRecebimento]", ex));
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarFinTipoRecebimento([FromBody]FinTipoRecebimento objJson, int id)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar FinTipoRecebimento]", null));
                }

                if (objJson.Id != id)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar FinTipoRecebimento] - ID do objeto difere do ID da URL.", null));
                }

                var objBanco = _repository.FinTipoRecebimento.ConsultarObjeto(objJson.Id);

                if (objBanco == null)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto com ID inválido [Alterar FinTipoRecebimento]", null));
                }

                _repository.FinTipoRecebimento.Alterar(objBanco, objJson);

                return ConsultarObjetoFinTipoRecebimento(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar FinTipoRecebimento]", ex));
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirFinTipoRecebimento(int id)
        {
            try
            {
                var objeto = _repository.FinTipoRecebimento.ConsultarObjeto(id);

                _repository.FinTipoRecebimento.Excluir(objeto);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir FinTipoRecebimento]", ex));
            }
        }

    }
}