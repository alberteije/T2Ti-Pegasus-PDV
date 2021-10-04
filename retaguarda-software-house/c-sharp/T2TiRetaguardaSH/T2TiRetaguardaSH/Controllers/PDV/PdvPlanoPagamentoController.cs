/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Controller relacionado à tabela [PDV_PLANO_PAGAMENTO] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
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
using T2TiRetaguardaSH.Models;
using T2TiRetaguardaSH.Services;

namespace T2TiRetaguardaSH.Controllers
{
    [Route("pdv-plano-pagamento")]
    [Produces("application/json")]
    public class PdvPlanoPagamentoController : Controller
    {
		private readonly PdvPlanoPagamentoService _service;

        public PdvPlanoPagamentoController()
        {
            _service = new PdvPlanoPagamentoService();
        }

        [HttpGet]
        public IActionResult ConsultarListaPdvPlanoPagamento([FromQuery]string filter)
        {
            try
            {
                IEnumerable<PdvPlanoPagamento> lista;
                if (filter == null)
                {
                    lista = _service.ConsultarLista();
                }
                else
                {
                    // define o filtro
                    Filtro filtro = new Filtro(filter);
                    lista = _service.ConsultarListaFiltro(filtro);
                }
                return Ok(lista);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Lista PdvPlanoPagamento]", ex));
            }
        }

        [HttpGet("{cnpj}", Name = "ConsultarObjetoPdvPlanoPagamento")]
        public IActionResult ConsultarObjetoPdvPlanoPagamento(string cnpj)
        {
            try
            {
                var objeto = _service.ConsultarPlanoAtivo(cnpj);

                if (objeto == null)
                {
                    return StatusCode(404, new RetornoJsonErro(404, "Registro não localizado [Consultar Objeto PdvPlanoPagamento]", null));
                }
                else
                {
                    return Ok(objeto);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Consultar Objeto PdvPlanoPagamento]", ex));
            }
        }
        
        [HttpPost("{codigo}")]
        public IActionResult ConfirmarTransacao(string codigo)
        {
            string cnpj = Request.Headers["cnpj"];
            var retorno = _service.ConfirmarTransacao(codigo, cnpj);
            /*
    	      Vamos usar os códigos HTTP para nossa conveniência:
    	      200 - achou a transação e vinculou o ID da empresa
    	      404 - não achou o código da transação no banco de dados
    	      418 - achou o código da transação, mas ele já foi utilizado
		    */
            return StatusCode(retorno, retorno);
        }

        [HttpPost]
        public IActionResult InserirPdvPlanoPagamento([FromBody]ObjetoPagSeguro objJson)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return StatusCode(400, new RetornoJsonErro(400, "Objeto inválido [Inserir PdvPlanoPagamento]", null));
                }
                PdvPlanoPagamento retorno = _service.Atualizar(objJson);

                return CreatedAtRoute("ConsultarObjetoPdvPlanoPagamento", new { id = retorno.Id }, objJson);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inserir PdvPlanoPagamento]", ex));
            }
        }

        [HttpDelete("{id}")]
        public IActionResult ExcluirPdvPlanoPagamento(int id)
        {
            try
            {
                var objeto = _service.ConsultarObjeto(id);

                _service.Excluir(objeto);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Excluir PdvPlanoPagamento]", ex));
            }
        }

    }
}