/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Service relacionado à tabela [NFE_CONFIGURACAO] 
                                                                                
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
using T2TiRetaguardaSH.Models;
using T2TiRetaguardaSH.NHibernate;
using T2TiRetaguardaSH.Util;

namespace T2TiRetaguardaSH.Services
{
    public class NfeConfiguracaoService
    {

        public IEnumerable<NfeConfiguracao> ConsultarLista()
        {
            IList<NfeConfiguracao> Resultado = null;
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<NfeConfiguracao> DAL = new NHibernateDAL<NfeConfiguracao>(Session);
                Resultado = DAL.Select(new NfeConfiguracao());
            }
            return Resultado;
        }

        public IEnumerable<NfeConfiguracao> ConsultarListaFiltro(Filtro filtro)
        {
            IList<NfeConfiguracao> Resultado = null;
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                var consultaSql = "from NfeConfiguracao where " + filtro.Where;
                NHibernateDAL<NfeConfiguracao> DAL = new NHibernateDAL<NfeConfiguracao>(Session);
                Resultado = DAL.SelectListaSql<NfeConfiguracao>(consultaSql);
            }
            return Resultado;
        }
		
        public NfeConfiguracao ConsultarObjeto(int id)
        {
            NfeConfiguracao Resultado = null;
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<NfeConfiguracao> DAL = new NHibernateDAL<NfeConfiguracao>(Session);
                Resultado = DAL.SelectId<NfeConfiguracao>(id);
            }
            return Resultado;
        }
        public NfeConfiguracao ConsultarObjetoFiltro(string filtro)
        {
            NfeConfiguracao Resultado = null;
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                var consultaSql = "from NfeConfiguracao where " + filtro;
                NHibernateDAL<NfeConfiguracao> DAL = new NHibernateDAL<NfeConfiguracao>(Session);
                Resultado = DAL.SelectObjetoSql<NfeConfiguracao>(consultaSql);
            }
            return Resultado;
        }
        public void Inserir(NfeConfiguracao objeto)
        {
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<NfeConfiguracao> DAL = new NHibernateDAL<NfeConfiguracao>(Session);
                DAL.SaveOrUpdate(objeto);
                Session.Flush();
            }
        }

        public void Alterar(NfeConfiguracao objeto)
        {
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<NfeConfiguracao> DAL = new NHibernateDAL<NfeConfiguracao>(Session);
                DAL.SaveOrUpdate(objeto);
                Session.Flush();
            }
        }

        public void Excluir(NfeConfiguracao objeto)
        {
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<NfeConfiguracao> DAL = new NHibernateDAL<NfeConfiguracao>(Session);
                DAL.Delete(objeto);
                Session.Flush();
            }
        }

        public AcbrMonitorPorta Atualizar(NfeConfiguracao nfeConfiguracao, string cnpj, int decimaisQuantidade, int decimaisValor) 
        {
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                string filtro = "CNPJ = '" + cnpj + "'";
                Empresa empresa = new EmpresaService().ConsultarObjetoFiltro(filtro);
                if (empresa != null)
                {
					// salva o objeto de configuração no banco de dados
                    nfeConfiguracao.Empresa = empresa;
                    nfeConfiguracao.CaminhoSalvarXml.Replace("\\", "\\\\");
                    nfeConfiguracao.CaminhoSalvarPdf.Replace("\\", "\\\\");
                    filtro = "ID_EMPRESA = " + empresa.Id.ToString();
                    NfeConfiguracao configuracao = ConsultarObjetoFiltro(filtro);
                    if (configuracao != null)
                    {
                        nfeConfiguracao.Id = configuracao.Id;
                        Alterar(nfeConfiguracao);
                    }
                    else
                    {
                        Inserir(nfeConfiguracao);
                    }

					// verificar se já existe uma porta definida para o monitor da empresa
					// ALTER TABLE acbr_monitor_porta AUTO_INCREMENT=3435; - executa um comando no banco de dados para definir a porta inicial para o ID
					filtro = "ID_EMPRESA = " + empresa.Id.ToString();
					AcbrMonitorPortaService acbrMonitorPortaService = new AcbrMonitorPortaService();
					AcbrMonitorPorta portaMonitor = acbrMonitorPortaService.ConsultarObjetoFiltro(filtro);
					if (portaMonitor == null)
					{
						portaMonitor = new AcbrMonitorPorta();
						portaMonitor.Empresa = empresa;
						acbrMonitorPortaService.Inserir(portaMonitor);
					}

					// criar a pasta do monitor para a empresa
					CriarPastaAcbrMonitor(cnpj);

					// configurar o arquivo INI
					ConfigurarArquivoIniMonitor(nfeConfiguracao, empresa, decimaisQuantidade, decimaisValor, portaMonitor.Id);

					return portaMonitor;					
				} 
				else 
				{
					return null;
				}
					

            }
        }

        private void CriarPastaAcbrMonitor(string cnpj)
        {
            string command = "c:\\ACBrMonitor\\CopiarBase.bat " + cnpj;
            var process = Process.Start(command);
            process.WaitForExit();
        }

        private void ConfigurarArquivoIniMonitor(NfeConfiguracao nfeConfiguracao, Empresa empresa, int decimaisQuantidade, int decimaisValor, int portaMonitor)
        {
            string caminhoComCnpj = "C:\\ACBrMonitor\\" + empresa.Cnpj + "\\";
            nfeConfiguracao.CaminhoSalvarPdf = caminhoComCnpj + "PDF";
            nfeConfiguracao.CaminhoSalvarXml = caminhoComCnpj + "DFes";

            string nomeArquivoIni = caminhoComCnpj + "ACBrMonitor.ini";
            IniFile acbrMonitorIni = new IniFile(nomeArquivoIni);

            try
            {
                //*******************************************************************************************
                //  [ACBrMonitor]
                //*******************************************************************************************
                acbrMonitorIni.IniWriteString("ACBrMonitor", "TCP_Porta", portaMonitor.ToString());

                //*******************************************************************************************
                //  [ACBrNFeMonitor]
                //*******************************************************************************************
                acbrMonitorIni.IniWriteString("ACBrNFeMonitor", "Arquivo_Log_Comp", caminhoComCnpj + "LOG_DFe.TXT");
                acbrMonitorIni.IniWriteString("ACBrNFeMonitor", "ArquivoWebServices", caminhoComCnpj + "ACBrNFeServicos.ini");
                acbrMonitorIni.IniWriteString("ACBrNFeMonitor", "ArquivoWebServicesCTe", caminhoComCnpj + "ACBrCTeServicos.ini");
                acbrMonitorIni.IniWriteString("ACBrNFeMonitor", "ArquivoWebServicesMDFe", caminhoComCnpj + "ACBrMDFeServicos.ini");
                acbrMonitorIni.IniWriteString("ACBrNFeMonitor", "ArquivoWebServicesGNRe", caminhoComCnpj + "ACBrGNREServicos.ini");
                acbrMonitorIni.IniWriteString("ACBrNFeMonitor", "ArquivoWebServiceseSocial", caminhoComCnpj + "ACBreSocialServicos.ini");
                acbrMonitorIni.IniWriteString("ACBrNFeMonitor", "ArquivoWebServicesReinf", caminhoComCnpj + "ACBrReinfServicos.ini");
                acbrMonitorIni.IniWriteString("ACBrNFeMonitor", "ArquivoWebServicesBPe", caminhoComCnpj + "ACBrBPeServicos.ini");

                //*******************************************************************************************
                //  [WebService]
                //*******************************************************************************************
                // tpAmb - 1-Produção/ 2-Homologação
                // OBS: o monitor leva em conta o índice do Radiogroup, ou seja, será 0 para produção e 1 para homologação
                int ambiente = nfeConfiguracao.WebserviceAmbiente - 1;
                acbrMonitorIni.IniWriteString("WebService", "Ambiente", ambiente.ToString());
                acbrMonitorIni.IniWriteString("WebService", "UF", empresa.Uf);

                //*******************************************************************************************
                //  [RespTecnico]
                //*******************************************************************************************
                if (nfeConfiguracao.RespTecHashCsrt != "0")
                    acbrMonitorIni.IniWriteString("RespTecnico", "CSRT", nfeConfiguracao.RespTecHashCsrt);
                if (nfeConfiguracao.RespTecIdCsrt != "0")
                    acbrMonitorIni.IniWriteString("RespTecnico", "idCSRT", nfeConfiguracao.RespTecIdCsrt);

                //*******************************************************************************************
                //  [NFCe]
                //*******************************************************************************************
                acbrMonitorIni.IniWriteString("NFCe", "IdToken", nfeConfiguracao.NfceIdCsc);
                acbrMonitorIni.IniWriteString("NFCe", "Token", nfeConfiguracao.NfceCsc);
                if (nfeConfiguracao.NfceModeloImpressao == "A4")
                    acbrMonitorIni.IniWriteString("NFCe", "ModoImpressaoEvento", "0");
                else
                    acbrMonitorIni.IniWriteString("NFCe", "ModoImpressaoEvento", "1");
                if (nfeConfiguracao.NfceImprimirItensUmaLinha == "S")
                    acbrMonitorIni.IniWriteString("NFCe", "ImprimirItem1Linha", "1");
                else
                    acbrMonitorIni.IniWriteString("NFCe", "ImprimirItem1Linha", "0");
                if (nfeConfiguracao.NfceImprimirDescontoPorItem == "S")
                    acbrMonitorIni.IniWriteString("NFCe", "ImprimirDescAcresItem", "1");
                else
                    acbrMonitorIni.IniWriteString("NFCe", "ImprimirDescAcresItem", "0");
                if (nfeConfiguracao.NfceImprimirQrcodeLateral == "S")
                    acbrMonitorIni.IniWriteString("NFCe", "QRCodeLateral", "1");
                else
                    acbrMonitorIni.IniWriteString("NFCe", "QRCodeLateral", "0");
                if (nfeConfiguracao.NfceImprimirGtin == "S")
                    acbrMonitorIni.IniWriteString("NFCe", "UsaCodigoEanImpressao", "1");
                else
                    acbrMonitorIni.IniWriteString("NFCe", "UsaCodigoEanImpressao", "0");
                if (nfeConfiguracao.NfceImprimirNomeFantasia == "S")
                    acbrMonitorIni.IniWriteString("NFCe", "ImprimeNomeFantasia", "1");
                else
                    acbrMonitorIni.IniWriteString("NFCe", "ImprimeNomeFantasia", "0");
                if (nfeConfiguracao.NfceImpressaoTributos == "S")
                    acbrMonitorIni.IniWriteString("NFCe", "ExibeTotalTributosItem", "1");
                else
                    acbrMonitorIni.IniWriteString("NFCe", "ExibeTotalTributosItem", "0");

                //*******************************************************************************************
                //  [DANFCe]
                //*******************************************************************************************
                acbrMonitorIni.IniWriteString("DANFCe", "MargemInf", nfeConfiguracao.NfceMargemInferior.ToString().Replace(".", ","));
                acbrMonitorIni.IniWriteString("DANFCe", "MargemSup", nfeConfiguracao.NfceMargemSuperior.ToString().Replace(".", ","));
                acbrMonitorIni.IniWriteString("DANFCe", "MargemDir", nfeConfiguracao.NfceMargemDireita.ToString().Replace(".", ","));
                acbrMonitorIni.IniWriteString("DANFCe", "MargemEsq", nfeConfiguracao.NfceMargemEsquerda.ToString().Replace(".", ","));
                acbrMonitorIni.IniWriteString("DANFCe", "LarguraBobina", nfeConfiguracao.NfceResolucaoImpressao.ToString());

                //*******************************************************************************************
                //  [FonteLinhaItem]
                //*******************************************************************************************
                acbrMonitorIni.IniWriteString("FonteLinhaItem", "Size", nfeConfiguracao.NfceTamanhoFonteItem.ToString());

                //*******************************************************************************************
                //  [DANFE]
                //*******************************************************************************************
                acbrMonitorIni.IniWriteString("DANFE", "PathPDF", nfeConfiguracao.CaminhoSalvarPdf);
                acbrMonitorIni.IniWriteString("DANFE", "DecimaisQTD", decimaisQuantidade.ToString());
                acbrMonitorIni.IniWriteString("DANFE", "DecimaisValor", decimaisValor.ToString());

                //*******************************************************************************************
                //  [Arquivos]
                //*******************************************************************************************
                acbrMonitorIni.IniWriteString("Arquivos", "PathNFe", nfeConfiguracao.CaminhoSalvarXml);
                acbrMonitorIni.IniWriteString("Arquivos", "PathInu", caminhoComCnpj + "Inutilizacao");
                acbrMonitorIni.IniWriteString("Arquivos", "PathDPEC", caminhoComCnpj + "EPEC");
                acbrMonitorIni.IniWriteString("Arquivos", "PathEvento", caminhoComCnpj + "Evento");
                acbrMonitorIni.IniWriteString("Arquivos", "PathArqTXT", caminhoComCnpj + "TXT");
                acbrMonitorIni.IniWriteString("Arquivos", "PathDonwload", caminhoComCnpj + "DistribuicaoDFe");
            }
            finally
            {
                Biblioteca.KillTask("ACBrMonitor_" + empresa.Cnpj + ".exe");
                string caminhoExecutavel = caminhoComCnpj + "ACBrMonitor_" + empresa.Cnpj + ".exe";
                Process.Start(caminhoExecutavel);
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
                    // encerra o Monitor
                    Biblioteca.KillTask("ACBrMonitor_" + empresa.Cnpj + ".exe");

                    // configura os caminhos
                    string caminhoComCnpj = "C:\\ACBrMonitor\\" + empresa.Cnpj + '\\';
                    string caminhoArquivoCertificado = caminhoComCnpj + empresa.Cnpj + ".pfx";

                    // converte e salva o arquivo do certificado em disco
                    byte[] certificadoBytes = Convert.FromBase64String(certificadoBase64);
                    File.WriteAllBytes(caminhoArquivoCertificado, certificadoBytes);

                    // vamos alterar o monitor para receber dados em arquivo TXT para armazenar os dados do certificado
                    // faremos dessa maneira porque o monitor criptografa a senha
                    string nomeArquivoIni = caminhoComCnpj + "ACBrMonitor.ini";
                    IniFile acbrMonitorIni = new IniFile(nomeArquivoIni);

                    try
                    {
                        //*******************************************************************************************
                        //  [ACBrMonitor]
                        //*******************************************************************************************
                        acbrMonitorIni.IniWriteString("ACBrMonitor", "Modo_TCP", "0");
                        acbrMonitorIni.IniWriteString("ACBrMonitor", "Modo_TXT", "1");
                    }
                    finally
                    {
                        string caminhoExecutavel = caminhoComCnpj + "ACBrMonitor_" + empresa.Cnpj + ".exe";
                        Process.Start(caminhoExecutavel);
                    }

                    GerarArquivoEntradaMonitor(caminhoArquivoCertificado, senha, cnpj);

                    while (!File.Exists("C:\\ACBrMonitor\\" + cnpj + "\\sai.txt")) { }

                    // altera novamente o monitor para o modo TCP
                    try
                    {
                        //*******************************************************************************************
                        //  [ACBrMonitor]
                        //*******************************************************************************************
                        acbrMonitorIni.IniWriteString("ACBrMonitor", "Modo_TCP", "1");
                        acbrMonitorIni.IniWriteString("ACBrMonitor", "Modo_TXT", "0");
                    }
                    finally
                    {
                        Biblioteca.KillTask("ACBrMonitor_" + empresa.Cnpj + ".exe");
                        string caminhoExecutavel = caminhoComCnpj + "ACBrMonitor_" + empresa.Cnpj + ".exe";
                        Process.Start(caminhoExecutavel);
                    }

                }
            }

        }
        private void GerarArquivoEntradaMonitor(string caminhoArquivoCertificado, string senha, string cnpj)
        {
            try
            {
                //  apaga o arquivo 'SAI.TXT'
                File.Delete("c:\\ACBrMonitor\\" + cnpj + "\\SAI.TXT");

                //  cria o arquivo 'ENT.TXT'
                StreamWriter ArquivoEntrada = new StreamWriter("c:\\ACBrMonitor\\" + cnpj + "\\ENT.TXT", true, Encoding.ASCII);
                ArquivoEntrada.Write("NFE.SetCertificado(" + caminhoArquivoCertificado + "," + senha + ")");
                ArquivoEntrada.Close();
            }
            finally
            {
            }
        }
        public bool GerarZipArquivosXml(string periodo, string cnpj)
        {
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                string filtro = "CNPJ = '" + cnpj + "'";
                Empresa empresa = new EmpresaService().ConsultarObjetoFiltro(filtro);
                if (empresa != null)
                {
                    ZipFile.CreateFromDirectory("C:\\ACBrMonitor\\" + cnpj + "\\DFes\\NFCe\\" + periodo, "C:\\ACBrMonitor\\" + cnpj + "\\NotasFiscaisNFCe_" + periodo + ".zip");
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

    }

}