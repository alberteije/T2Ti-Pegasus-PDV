/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Model relacionado à tabela [NFE_CONFIGURACAO] 
                                                                                
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

namespace T2TiRetaguardaSH.Models
{
    public class NfeConfiguracao
    {	
		public int Id { get; set; }

		public string CertificadoDigitalSerie { get; set; }

		public string CertificadoDigitalCaminho { get; set; }

		public string CertificadoDigitalSenha { get; set; }

		public int? TipoEmissao { get; set; }

		public int? FormatoImpressaoDanfe { get; set; }

		public int? ProcessoEmissao { get; set; }

		public string VersaoProcessoEmissao { get; set; }

		public string CaminhoLogomarca { get; set; }

		public string SalvarXml { get; set; }

		public string CaminhoSalvarXml { get; set; }

		public string CaminhoSchemas { get; set; }

		public string CaminhoArquivoDanfe { get; set; }

		public string CaminhoSalvarPdf { get; set; }

		public string WebserviceUf { get; set; }

		public int WebserviceAmbiente { get; set; }

		public string WebserviceProxyHost { get; set; }

		public int? WebserviceProxyPorta { get; set; }

		public string WebserviceProxyUsuario { get; set; }

		public string WebserviceProxySenha { get; set; }

		public string WebserviceVisualizar { get; set; }

		public string EmailServidorSmtp { get; set; }

		public int? EmailPorta { get; set; }

		public string EmailUsuario { get; set; }

		public string EmailSenha { get; set; }

		public string EmailAssunto { get; set; }

		public string EmailAutenticaSsl { get; set; }

		public string EmailTexto { get; set; }

		public string NfceIdCsc { get; set; }

		public string NfceCsc { get; set; }

		public string NfceModeloImpressao { get; set; }

		public string NfceImprimirItensUmaLinha { get; set; }

		public string NfceImprimirDescontoPorItem { get; set; }

		public string NfceImprimirQrcodeLateral { get; set; }

		public string NfceImprimirGtin { get; set; }

		public string NfceImprimirNomeFantasia { get; set; }

		public string NfceImpressaoTributos { get; set; }

		public System.Nullable<System.Decimal> NfceMargemSuperior { get; set; }

		public System.Nullable<System.Decimal> NfceMargemInferior { get; set; }

		public System.Nullable<System.Decimal> NfceMargemDireita { get; set; }

		public System.Nullable<System.Decimal> NfceMargemEsquerda { get; set; }

		public int? NfceResolucaoImpressao { get; set; }

		public int? NfceTamanhoFonteItem { get; set; }

		public string RespTecCnpj { get; set; }

		public string RespTecContato { get; set; }

		public string RespTecEmail { get; set; }

		public string RespTecFone { get; set; }

		public string RespTecIdCsrt { get; set; }

		public string RespTecHashCsrt { get; set; }

		public Empresa Empresa { get; set; }

    }
}
