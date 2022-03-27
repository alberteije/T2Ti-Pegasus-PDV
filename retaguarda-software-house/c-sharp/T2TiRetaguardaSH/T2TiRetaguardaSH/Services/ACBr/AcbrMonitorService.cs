/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Service relacionado ao ACBrMonitor
                                                                                
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
using NHibernate;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.IO.Compression;
using System.Text;
using System.Threading;
using T2TiRetaguardaSH.Models;
using T2TiRetaguardaSH.NHibernate;
using T2TiRetaguardaSH.Util;

namespace T2TiRetaguardaSH.Services
{
	public class AcbrMonitorService
    {

		private string CaminhoComCnpj = "";

		public string EmitirNfce(string numero, string cnpj, string nfceIni)
		{
			// configurações
			CaminhoComCnpj = "C:\\ACBrMonitor\\" + cnpj + "\\";

			// salva o arquivo INI em disco
			string caminhoArquivoIniNfce = CaminhoComCnpj + "ini\\nfce\\" + numero + ".ini";
			byte[] arquivoIniBytes = Convert.FromBase64String(nfceIni);
			File.WriteAllBytes(caminhoArquivoIniNfce, arquivoIniBytes);

			// chama o método para criar a nota
			CriarNFe(caminhoArquivoIniNfce);
			// pega o caminho do XML criado
			string caminhoArquivoXml = PegarRetornoSaida("ARQUIVO-XML");
			// chama o método para criar e enviar a nota
			EnviarNFe(caminhoArquivoXml);
			string retorno = PegarRetornoSaida("Envio");
			if (!retorno.Contains("ERRO")) {
				// chama o método para gerar o PDF
				ImprimirDanfe(caminhoArquivoXml);
				// captura o retorno do arquivo SAI
				retorno = PegarRetornoSaida("ARQUIVO-PDF");
			}		
			return retorno;
		}

		public string EmitirNfceContingencia(string numero, string cnpj, string nfceIni)
		{
			// configurações
			CaminhoComCnpj = "C:\\ACBrMonitor\\" + cnpj + "\\";

			// salva o arquivo INI em disco
			string caminhoArquivoIniNfce = CaminhoComCnpj + "ini\\nfce\\" + numero + ".ini";
			byte[] arquivoIniBytes = Convert.FromBase64String(nfceIni);
			File.WriteAllBytes(caminhoArquivoIniNfce, arquivoIniBytes);
		
			// passa para o modo de emissão off-line
			PassarParaModoOffLine();
			// chama o método para criar a nota
			CriarNFe(caminhoArquivoIniNfce);
			// pega o caminho do XML criado
			string caminhoArquivoXml = PegarRetornoSaida("ARQUIVO-XML");
			// chama o método para gerar o PDF
			ImprimirDanfe(caminhoArquivoXml);
			// captura o retorno do arquivo SAI
			string retorno = PegarRetornoSaida("ARQUIVO-PDF");
			// passa para o modo de emissão on-line
			PassarParaModoOnLine();
	  
			return retorno;
		}

		public string TransmitirNfceContingenciada(string chave, string cnpj)
		{
			// configurações
			CaminhoComCnpj = "C:\\ACBrMonitor\\" + cnpj + "\\";

			string caminhoArquivoXml = CaminhoComCnpj + "LOG_NFe\\" + chave + "-nfe.xml";
			// chama o método para criar e enviar a nota
			EnviarNFe(caminhoArquivoXml);
			string retorno = PegarRetornoSaida("Envio");
			if (!retorno.Contains("ERRO")) {
				// chama o método para gerar o PDF
				ImprimirDanfe(caminhoArquivoXml);
				// captura o retorno do arquivo SAI
				retorno = PegarRetornoSaida("ARQUIVO-PDF");
			}		
			return retorno;
		}

		public string TratarNotaAnteriorContingencia(ObjetoNfe objetoNfe)
		{
			// configurações
			CaminhoComCnpj = "C:\\ACBrMonitor\\" + objetoNfe.Cnpj + "\\";

			string caminhoArquivoXml = CaminhoComCnpj + "LOG_NFe\\" + objetoNfe.ChaveAcesso + "-nfe.xml";

			// vamos verificar o status da nota
			ApagarArquivoSaida();
			GerarArquivoEntrada("NFE.ConsultarNFe(" + caminhoArquivoXml + ")");
			AguardarArquivoSaida();

			string retorno = PegarRetornoSaida("Consulta");
			if (!retorno.Contains("ERRO")) {
				// se a nota anterior foi emitida = cancela. senão = inutiliza.
				if (retorno.Contains("Autorizado")) {
					retorno = CancelarNfce(objetoNfe);
				} else {
					retorno = InutilizarNumero(objetoNfe);
				}
			}
		
			return retorno;
		}

		public string InutilizarNumero(ObjetoNfe objetoNfe)
		{
			// configurações
			CaminhoComCnpj = "C:\\ACBrMonitor\\" + objetoNfe.Cnpj + "\\";

			ApagarArquivoSaida();

			GerarArquivoEntrada("NFE.InutilizarNFe("
				  +objetoNfe.Cnpj +", "
				  +objetoNfe.Justificativa +", "
				  +objetoNfe.Ano +", "
				  +objetoNfe.Modelo +", "
				  +objetoNfe.Serie +", "
				  +objetoNfe.NumeroInicial +", "
				  +objetoNfe.NumeroFinal +")");

			AguardarArquivoSaida();
			return PegarRetornoSaida("Inutilizacao");
		}

		public string CancelarNfce(ObjetoNfe objetoNfe)
		{
			CaminhoComCnpj = "C:\\ACBrMonitor\\" + objetoNfe.Cnpj + "\\";

			ApagarArquivoSaida();
			GerarArquivoEntrada("NFe.CANCELARNFE(" + objetoNfe.ChaveAcesso + ", " + objetoNfe.Justificativa + ", " + objetoNfe.Cnpj + ")");

			AguardarArquivoSaida();
			return PegarRetornoSaida("Cancelamento");
		}

		public string GerarPdfDanfeNfce(string chave, string cnpj)
		{
			// configurações
			CaminhoComCnpj = "C:\\ACBrMonitor\\" + cnpj + "\\";

			// pega o caminho do arquivo XML da nota em contingência
			string caminhoArquivoXml = CaminhoComCnpj + "LOG_NFe\\" + chave + "-nfe.xml";
			// chama o método para gerar o PDF
			ImprimirDanfe(caminhoArquivoXml);
			// captura o retorno do arquivo SAI
			return PegarRetornoSaida("ARQUIVO-PDF");	
		}

		public void EnviarNFe(string caminhoArquivoXml)
		{
			ApagarArquivoSaida();
			GerarArquivoEntrada("NFE.EnviarNFe(" + caminhoArquivoXml + ", 001, , , , 1, , )");
			AguardarArquivoSaida();
		}

		public void CriarNFe(string caminhoArquivoIniNfce)
		{
			ApagarArquivoSaida();
			GerarArquivoEntrada("NFE.CriarNFe(" + caminhoArquivoIniNfce + ")");
			AguardarArquivoSaida();
		}

		public void ImprimirDanfe(string caminhoArquivoXml)
		{
			ApagarArquivoSaida();
			GerarArquivoEntrada("NFE.ImprimirDanfePDF(" + caminhoArquivoXml + ", , , 1,)");
			AguardarArquivoSaida();
		}

		public bool PassarParaModoOffLine()
		{
			ApagarArquivoSaida();
			GerarArquivoEntrada("NFE.SetFormaEmissao(9)"); // 9=offline
			return AguardarArquivoSaida();
		}

		public bool PassarParaModoOnLine()
		{
			ApagarArquivoSaida();
			GerarArquivoEntrada("NFE.SetFormaEmissao(1)"); // 1=normal
			return AguardarArquivoSaida();
		}

		public bool GerarZipArquivosXml(string periodo, string cnpj)
		{
			using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
			{
				string filtro = "CNPJ = '" + cnpj + "'";
				Empresa empresa = new EmpresaService().ConsultarObjetoFiltro(filtro);
				if (empresa != null)
				{
					string diretorio = "C:\\ACBrMonitor\\" + cnpj + "\\DFes\\" + periodo;
					string arquivo = "C:\\ACBrMonitor\\" + cnpj + "\\NotasFiscaisNFCe_" + periodo + ".zip";
					if (File.Exists(arquivo))
					{
						File.Delete(arquivo);
					}
					ZipFile.CreateFromDirectory(diretorio, arquivo);
					return true;
				}
				else
				{
					return false;
				}
			}
		}

		public void AtualizarCertificado(string certificadoBase64, string senha, string cnpj)
		{
			using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
			{
				string filtro = "CNPJ = '" + cnpj + "'";
				Empresa empresa = new EmpresaService().ConsultarObjetoFiltro(filtro);
				if (empresa != null)
				{
					// configura os caminhos
					string CaminhoComCnpj = "C:\\ACBrMonitor\\" + empresa.Cnpj + '\\';
					string caminhoArquivoCertificado = CaminhoComCnpj + empresa.Cnpj + ".pfx";

					// converte e salva o arquivo do certificado em disco
					byte[] certificadoBytes = Convert.FromBase64String(certificadoBase64);
					File.WriteAllBytes(caminhoArquivoCertificado, certificadoBytes);

					ApagarArquivoSaida();
					GerarArquivoEntrada("NFE.SetCertificado(" + caminhoArquivoCertificado + "," + senha + ")");
					AguardarArquivoSaida();

					Biblioteca.KillTask("ACBrMonitor_" + empresa.Cnpj + ".exe");
					string caminhoExecutavel = CaminhoComCnpj + "ACBrMonitor_" + empresa.Cnpj + ".exe";
					Process.Start(caminhoExecutavel);
				}
			}

		}

		private void GerarArquivoEntrada(string comando)
		{
			StreamWriter arquivoEntrada = new StreamWriter(CaminhoComCnpj + "ent.txt", true, Encoding.ASCII);
			arquivoEntrada.Write(comando);
			arquivoEntrada.Close();		
		}

		private string PegarRetornoSaida(string operacao)
		{
			string retorno = "";
			IniFile arquivoSaida = new IniFile(CaminhoComCnpj, "sai.txt");

			// carrega o conteúdo completo do arquivo
			string arquivoCompleto = System.IO.File.ReadAllText(CaminhoComCnpj + "sai.txt");

			string codigoStatus = arquivoSaida.IniReadString(operacao, "CStat", "");
			string motivo = arquivoSaida.IniReadString(operacao, "XMotivo", "");

			string caminhoArquivoXml = "";
		
			if (operacao.Equals("ARQUIVO-XML")) 
			{
				caminhoArquivoXml = arquivoCompleto;
				caminhoArquivoXml = caminhoArquivoXml.Replace("OK: ", "").Trim();
				return caminhoArquivoXml; 
			} 
			else if (operacao.Equals("ARQUIVO-PDF")) 
			{
				retorno = arquivoCompleto;
				retorno = retorno.Replace("OK: Arquivo criado em: ", "").Trim();
				return retorno;
			} 
			else if (operacao.Equals("Envio")) 
			{
				retorno = motivo;
			} 
			else if (operacao.Equals("Cancelamento")) 
			{
				retorno =  motivo;
			} 
			else if (operacao.Equals("Consulta")) 
			{
				retorno = motivo;
			} 
			else if (operacao.Equals("Inutilizacao")) 
			{
				return arquivoCompleto;
			}
			
			List<string> listaStatus = new List<string>{ "", "100", "102", "135" }; // se o status não for um dos que estiverem nessa lista, vamos retornar um erro.
			
			if (!listaStatus.Contains(codigoStatus)) {
				return "[ERRO] - [" + codigoStatus + "] " + motivo;
			}

			return retorno;
		}

		private bool ApagarArquivoSaida()
		{
			File.Delete(CaminhoComCnpj + "sai.txt");
			return true;
		}

		private bool AguardarArquivoSaida()
		{
			int tempoEspera = 0;
			while (!File.Exists(CaminhoComCnpj + "sai.txt"))
			{
				Thread.Sleep(1000);
				tempoEspera++;

				if (tempoEspera > 30)
				{
					return false;
				}
			}
			return true;
		}

    }

}