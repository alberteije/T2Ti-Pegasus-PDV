/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [BANCO] 
                                                                                
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
using T2TiERPFenix.Services;

namespace T2TiERPFenix.Controllers
{
    [Route("banco")]
    [Produces("application/json")]
    public class BancoController : Controller
    {
        private IRepositoryWrapper _repository;
        private BancoService _service;

        public BancoController(IRepositoryWrapper repository)
        {
            _repository = repository;
            _service = new BancoService();
        }

        [HttpGet]
        public IActionResult ConsultarListaBanco([FromQuery]string filter)
        {
            try
            {
                IEnumerable<Banco> lista;
                if (filter == null)
                {
                    //lista = _repository.Banco.ConsultarLista();
                    lista = _service.ConsultarLista();
                }
                else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    //lista = _repository.Banco.ConsultarListaFiltro(filtro);
                    lista = _service.ConsultarListaFiltro(filtro);
                }
                return Ok(lista);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista Banco]", ex));
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoBanco")]
        public IActionResult ConsultarObjetoBanco(int id)
        {
            try
            {
                //var objeto = _repository.Banco.ConsultarObjeto(id);
                var objeto = _service.ConsultarObjeto(id);

                if (objeto == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto Banco]", null));
                }
                else
                {
                    return Ok(objeto);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto Banco]", ex));
            }
        }

        [HttpPost]
        public IActionResult InserirBanco([FromBody]Banco objJson)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Inserir Banco]", null));
                }
                //_repository.Banco.Inserir(objJson);
                _service.Inserir(objJson);

                return CreatedAtRoute("ConsultarObjetoBanco", new { id = objJson.Id }, objJson);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir Banco]", ex));
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarBanco([FromBody]Banco objJson, int id)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar Banco]", null));
                }

                if (objJson.Id != id)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar Banco] - ID do objeto difere do ID da URL.", null));
                }

                //var objBanco = _repository.Banco.ConsultarObjeto(objJson.Id);                

                //                if (objBanco == null)
                //                {
                //                    return StatusCode(400, new RetornoJsonErro(400, "Objeto com ID inválido [Alterar Banco]", null));
                //                }

                //                _repository.Banco.Alterar(objBanco, objJson);
                _service.Alterar(objJson);

                return ConsultarObjetoBanco(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar Banco]", ex));
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirBanco(int id)
        {
            try
            {
                //var objeto = _repository.Banco.ConsultarObjeto(id);
                var objeto = _service.ConsultarObjeto(id);

                //_repository.Banco.Excluir(objeto);
                _service.Excluir(objeto);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir Banco]", ex));
            }
        }

    }
}