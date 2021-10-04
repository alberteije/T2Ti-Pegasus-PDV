/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [BANCO_CONTA_CAIXA] 
                                                                                
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
    [Route("banco-conta-caixa")]
    [Produces("application/json")]
    public class BancoContaCaixaController : Controller
    {
        private IRepositoryWrapper _repository;

        public BancoContaCaixaController(IRepositoryWrapper repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public IActionResult ConsultarListaBancoContaCaixa([FromQuery]string filter)
        {
            try
            {
                IEnumerable<BancoContaCaixa> lista;
                if (filter == null)
                {
                    lista = _repository.BancoContaCaixa.ConsultarLista();
                }
                else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    lista = _repository.BancoContaCaixa.ConsultarListaFiltro(filtro);
                }
                return Ok(lista);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista BancoContaCaixa]", ex));
            }
        }

        [HttpGet("{id}", Name = "ConsultarObjetoBancoContaCaixa")]
        public IActionResult ConsultarObjetoBancoContaCaixa(int id)
        {
            try
            {
                var objeto = _repository.BancoContaCaixa.ConsultarObjeto(id);

                if (objeto == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto BancoContaCaixa]", null));
                }
                else
                {
                    return Ok(objeto);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto BancoContaCaixa]", ex));
            }
        }

        [HttpPost]
        public IActionResult InserirBancoContaCaixa([FromBody]BancoContaCaixa objJson)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Inserir BancoContaCaixa]", null));
                }
                _repository.BancoContaCaixa.Inserir(objJson);

                return CreatedAtRoute("ConsultarObjetoBancoContaCaixa", new { id = objJson.Id }, objJson);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir BancoContaCaixa]", ex));
            }
        }

        [HttpPut("{id}")]
        public IActionResult AlterarBancoContaCaixa([FromBody]BancoContaCaixa objJson, int id)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar BancoContaCaixa]", null));
                }

                if (objJson.Id != id)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Alterar BancoContaCaixa] - ID do objeto difere do ID da URL.", null));
                }

                var objBanco = _repository.BancoContaCaixa.ConsultarObjeto(objJson.Id);

                if (objBanco == null)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto com ID inválido [Alterar BancoContaCaixa]", null));
                }

                _repository.BancoContaCaixa.Alterar(objBanco, objJson);

                return ConsultarObjetoBancoContaCaixa(id);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Alterar BancoContaCaixa]", ex));
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirBancoContaCaixa(int id)
        {
            try
            {
                var objeto = _repository.BancoContaCaixa.ConsultarObjeto(id);

                _repository.BancoContaCaixa.Excluir(objeto);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir BancoContaCaixa]", ex));
            }
        }

    }
}