/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Controller relacionado ao ACBrMonitor 
                                                                                
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
	[Route("acbr-monitor")]
    [Produces("application/json")]
    public class AcbrMonitorController : Controller
    {
		private readonly AcbrMonitorService _service;

        public AcbrMonitorController()
        {
            _service = new AcbrMonitorService();
        }

		[HttpPost]
		[Route("emite-nfce")]
		public IActionResult EmitirNfce([FromBody]string corpoRequisicao)
		{
			string retorno;
			try
			{
				string numero = Request.Headers["numero"];
				string cnpj = Request.Headers["cnpj"];

				string nfceIni = Biblioteca.Decifrar(corpoRequisicao.ToString());
				retorno = _service.EmitirNfce(Biblioteca.Decifrar(numero), Biblioteca.Decifrar(cnpj), nfceIni);
				if (!retorno.Contains("ERRO"))
				{
					var net = new System.Net.WebClient();
					var data = net.DownloadData(retorno);
					var content = new System.IO.MemoryStream(data);
					var contentType = "application/pdf";
					var nomeArquivo = "nfce.pdf";
					net.Dispose();
					return File(content, contentType, nomeArquivo);
				}
				else
				{
					return StatusCode(418, new RetornoJsonErro(418, retorno, null)); // Erro capturado pelo ACBrMonitor
				}
			}
			catch (Exception ex)
			{
				return StatusCode(500,
						new RetornoJsonErro(500, "Erro no Servidor [Emitir NFC-e]", ex));
			}
		}

		[HttpPost]
		[Route("emite-nfce-contingencia")]
		public IActionResult EmitirNfceContingencia([FromBody]String corpoRequisicao)
		{
			string retorno;
			try
			{
				string numero = Request.Headers["numero"];
				string cnpj = Request.Headers["cnpj"];

				string nfceIni = Biblioteca.Decifrar(corpoRequisicao);
				retorno = _service.EmitirNfceContingencia(Biblioteca.Decifrar(numero), Biblioteca.Decifrar(cnpj), nfceIni);
				if (!retorno.Contains("ERRO"))
				{
					var net = new System.Net.WebClient();
					var data = net.DownloadData(retorno);
					var content = new System.IO.MemoryStream(data);
					var contentType = "application/pdf";
					var nomeArquivo = "nfce.pdf";
					net.Dispose();
					return File(content, contentType, nomeArquivo);
				}
				else
				{
					return StatusCode(418, new RetornoJsonErro(418, retorno, null)); // Erro capturado pelo ACBrMonitor
				}
			}
			catch (Exception ex)
			{
				return StatusCode(500,
						new RetornoJsonErro(500, "Erro no Servidor [Emitir NFC-e Contingência]", ex));
			}
		}

		[HttpPost]
		[Route("transmite-nfce-contingenciada")]
		public IActionResult TransmitirNfceContingenciada()
		{
			string retorno;
			try
			{
				string chave = Request.Headers["chave"];
				string cnpj = Request.Headers["cnpj"];

				retorno = _service.TransmitirNfceContingenciada(Biblioteca.Decifrar(chave), Biblioteca.Decifrar(cnpj));
				if (!retorno.Contains("ERRO"))
				{
					var net = new System.Net.WebClient();
					var data = net.DownloadData(retorno);
					var content = new System.IO.MemoryStream(data);
					var contentType = "application/pdf";
					var nomeArquivo = "nfce.pdf";
					net.Dispose();
					return File(content, contentType, nomeArquivo);
				}
				else
				{
					return StatusCode(418, new RetornoJsonErro(418, retorno, null)); // Erro capturado pelo ACBrMonitor
				}
			}
			catch (Exception ex)
			{
				return StatusCode(500,
						new RetornoJsonErro(500, "Erro no Servidor [Transmitir NFC-e Contingenciada]", ex));
			}
		}

		[HttpPost]
		[Route("trata-nota-anterior-contingencia")]
		public IActionResult TratarNotaAnteriorContingencia([FromBody]String corpoRequisicao)
		{
			try
			{
				ObjetoNfe objetoNfe = JsonConvert.DeserializeObject<ObjetoNfe>(Biblioteca.Decifrar(corpoRequisicao));
				string retorno = _service.TratarNotaAnteriorContingencia(objetoNfe);
				return Ok(Biblioteca.Cifrar(retorno));
			}
			catch (Exception ex)
			{
				return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Tratar Nota Anterior Contingencia]", ex));
			}
		}

		[HttpPost]
		[Route("inutiliza-numero-nota")]
		public IActionResult InutilizarNumeroNota([FromBody]String corpoRequisicao)
		{
			try
			{
				ObjetoNfe objetoNfe = JsonConvert.DeserializeObject<ObjetoNfe>(Biblioteca.Decifrar(corpoRequisicao));
				string retorno = _service.InutilizarNumero(objetoNfe);
				return Ok(Biblioteca.Cifrar(retorno));
			}
			catch (Exception ex)
			{
				return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Inutilizar Numero Nota]", ex));
			}
		}

		[HttpPost]
		[Route("cancela-nfce")]
		public IActionResult cancelarNfce([FromBody]String corpoRequisicao)
		{
			try
			{
				ObjetoNfe objetoNfe = JsonConvert.DeserializeObject<ObjetoNfe>(Biblioteca.Decifrar(corpoRequisicao));
				string retorno = _service.CancelarNfce(objetoNfe);
				return Ok(Biblioteca.Cifrar(retorno));
			}
			catch (Exception ex)
			{
				return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Cancelar NFC-e]", ex));
			}
		}

		[HttpPost]
		[Route("gera-pdf-danfe-nfce")]
		public IActionResult GerarPdfDanfeNfce()
		{
			string retorno;
			try
			{
				string chave = Request.Headers["chave"];
				string cnpj = Request.Headers["cnpj"];

				retorno = _service.GerarPdfDanfeNfce(Biblioteca.Decifrar(chave), Biblioteca.Decifrar(cnpj));
				if (!retorno.Contains("ERRO"))
				{
					var net = new System.Net.WebClient();
					var data = net.DownloadData(retorno);
					var content = new System.IO.MemoryStream(data);
					var contentType = "application/pdf";
					var nomeArquivo = "nfce.pdf";
					net.Dispose();
					return File(content, contentType, nomeArquivo);
				}
				else
				{
					return StatusCode(418, new RetornoJsonErro(418, retorno, null)); // Erro capturado pelo ACBrMonitor
				}
			}
			catch (Exception ex)
			{
				return StatusCode(500,
						new RetornoJsonErro(500, "Erro no Servidor [Gerar Pdf Danfe Nfce]", ex));
			}
		}

		[Route("download-xml-periodo")]
        [HttpGet]
        public IActionResult RetornarArquivosXmlPeriodo()
        {
            try
            {
                string periodo = Biblioteca.Decifrar(Request.Headers["periodo"]);
                string cnpj = Biblioteca.Decifrar(Request.Headers["cnpj"]);
                bool retorno = _service.GerarZipArquivosXml(periodo, cnpj);
                if (retorno)
                {
                    string nomeArquivo = "NotasFiscaisNFCe_" + periodo + ".zip";
                    string caminhoArquivo = "C:\\ACBrMonitor\\" + cnpj + "\\" + nomeArquivo;                    
					var net = new System.Net.WebClient();
                    var data = net.DownloadData(caminhoArquivo);
                    var content = new System.IO.MemoryStream(data);
                    var contentType = "application/zip";
                    net.Dispose();
                    return File(content, contentType, nomeArquivo);
                } else
                {
                    return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Retornar XML Período]", null));
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Retornar XML Período]", ex));
            }
        }

        [Route("atualiza-certificado")]
        [HttpPost]
        public IActionResult AtualizarCertificado([FromBody]String corpoRequisicao)
        {
            try
            {
                string senha = Biblioteca.Decifrar(Request.Headers["hash-registro"]);
                string cnpj = Biblioteca.Decifrar(Request.Headers["cnpj"]);
                string certificadoBase64 = Biblioteca.Decifrar(corpoRequisicao);
                _service.AtualizarCertificado(certificadoBase64, senha, cnpj);
                return StatusCode(200, "Certificado atualizado com sucesso.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, new RetornoJsonErro(500, "Erro no Servidor [Atualizar Certificado]", ex));
            }
        }

    }
}