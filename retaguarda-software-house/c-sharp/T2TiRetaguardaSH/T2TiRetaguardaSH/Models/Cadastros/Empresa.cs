/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Model relacionado à tabela [EMPRESA] 
                                                                                
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
using System.Collections.Generic;

namespace T2TiRetaguardaSH.Models
{
    public class Empresa
    {	
		public int Id { get; set; }

		public string RazaoSocial { get; set; }

		public string NomeFantasia { get; set; }

		public string Cnpj { get; set; }

		public string InscricaoEstadual { get; set; }

		public string InscricaoMunicipal { get; set; }

		public string TipoRegime { get; set; }

		public string Crt { get; set; }

		public System.Nullable<System.DateTime> DataConstituicao { get; set; }

		public string Tipo { get; set; }

		public string Email { get; set; }

		public System.Nullable<System.Decimal> AliquotaPis { get; set; }

		public System.Nullable<System.Decimal> AliquotaCofins { get; set; }

		public string Logradouro { get; set; }

		public string Numero { get; set; }

		public string Complemento { get; set; }

		public string Cep { get; set; }

		public string Bairro { get; set; }

		public string Cidade { get; set; }

		public string Uf { get; set; }

		public string Fone { get; set; }

		public string Contato { get; set; }

		public int? CodigoIbgeCidade { get; set; }

		public int? CodigoIbgeUf { get; set; }

		public string Logotipo { get; set; }

		public string Registrado { get; set; }

		public string NaturezaJuridica { get; set; }

		public string Simei { get; set; }

		public string EmailPagamento { get; set; }

		public System.Nullable<System.DateTime> DataRegistro { get; set; }
		public string HoraRegistro { get; set; }

		private IList<NfeConfiguracao> listaNfeConfiguracao;
		public IList<NfeConfiguracao> ListaNfeConfiguracao
		{
			get
			{
				return listaNfeConfiguracao;
			}
			set
			{
				if (value != null)
				{
					listaNfeConfiguracao = value;
					foreach (NfeConfiguracao nfeConfiguracao in listaNfeConfiguracao)
					{
						nfeConfiguracao.Empresa = this;
					}
				}
			}
		}

		private IList<PdvPlanoPagamento> listaPdvPlanoPagamento;
		public IList<PdvPlanoPagamento> ListaPdvPlanoPagamento
		{
			get
			{
				return listaPdvPlanoPagamento;
			}
			set
			{
				if (value != null)
				{
					listaPdvPlanoPagamento = value;
					foreach (PdvPlanoPagamento pdvPlanoPagamento in listaPdvPlanoPagamento)
					{
						pdvPlanoPagamento.Empresa = this;
					}
				}
			}
		}

    }
}
