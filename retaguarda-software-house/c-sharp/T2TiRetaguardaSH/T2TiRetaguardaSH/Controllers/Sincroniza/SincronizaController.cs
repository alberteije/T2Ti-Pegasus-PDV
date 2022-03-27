/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Controller relacionado à sincronização de dados 
                                                                                
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
using Newtonsoft.Json;
using System;
using T2TiRetaguardaSH.Models;
using T2TiRetaguardaSH.Services;
using T2TiRetaguardaSH.Util;

namespace T2TiRetaguardaSH.Controllers
{
	[Route("sincroniza")]
    [Produces("application/json")]
    public class SincronizaController : Controller
    {
		private readonly SincronizaService _service;

        public SincronizaController()
        {
            _service = new SincronizaService();
        }

        [Route("upload")]
        [HttpPost]
        public IActionResult SincronizarServidor([FromBody]String corpoRequisicao)
        {
            try
            {
                string cnpj = Biblioteca.Decifrar(Request.Headers["cnpj"]);
                string bancoSQLite64 = Biblioteca.Decifrar(corpoRequisicao);
                _service.SincronizarServidor(bancoSQLite64, cnpj);
                return StatusCode(200, "Servidor sincronizado com sucesso.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Problemas na sincronização [Sincronizar Servidor]", ex));
            }
        }

        [Route("upload-movimento")]
        [HttpPost]
        public IActionResult ArmazenarMovimento([FromBody]String corpoRequisicao)
        {
            try
            {
                string cnpj = Biblioteca.Decifrar(Request.Headers["cnpj"]);
                string idMovimento = Biblioteca.Decifrar(Request.Headers["movimento"]);
                string idDispositivo = Biblioteca.Decifrar(Request.Headers["dispositivo"]);
                idDispositivo = idDispositivo.Replace("-", "").Trim();
                string bancoSQLite64 = Biblioteca.Decifrar(corpoRequisicao);
                _service.ArmazenarMovimento(bancoSQLite64, cnpj, idMovimento, idDispositivo);
                return StatusCode(200, "Movimento sincronizado com sucesso.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Problemas na sincronização [Armazenar Movimento]", ex));
            }
        }

        [Route("download")]
        [HttpGet]
        public IActionResult SincronizarCliente()
        {
            try
            {
                string cnpj = Biblioteca.Decifrar(Request.Headers["cnpj"]);
                string retorno = _service.SincronizarCliente(cnpj);
                return Ok(Biblioteca.Cifrar(retorno));
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Problemas na sincronização [Sincronizar Cliente]", ex));
            }
        }


        [Route("twilio")]
        [HttpPost]
        public IActionResult TestarTwilio([FromForm]String corpoRequisicao)
        {
            try
            {
                string corpo = corpoRequisicao;
                //_service.FazerAlgumaCoisaComOsDadosQueForamEnviadosPeloWhatsApp(corpo);

                String resposta = "";
                resposta += "<?xml version='1.0' encoding='UTF-8'?>";
                resposta += "<Response>";
                resposta += "<Message><Body>Mensagem vinda do C-Sharp.</Body></Message>";
                resposta += "</Response>";

                return Content(resposta, "text/html");
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Problemas no teste to twilio [Teste Twilio]", ex));
            }
        }

    }
}