/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_PARCELA_PAGAR] 
                                                                                
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
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace T2TiERPFenix.Models
{
    public class FinParcelaPagar
    {	
		public int Id { get; set; }

		//[Column("ID_FIN_LANCAMENTO_PAGAR")]
		//public int? IdFinLancamentoPagar { get; set; }

		//[Column("ID_FIN_STATUS_PARCELA")]
		//public int? IdFinStatusParcela { get; set; }

		//[Column("ID_FIN_TIPO_PAGAMENTO")]
		//public int? IdFinTipoPagamento { get; set; }

		//[Column("ID_FIN_CHEQUE_EMITIDO")]
		//public int? IdFinChequeEmitido { get; set; }

		public int? NumeroParcela { get; set; }

		public System.Nullable<System.DateTime> DataEmissao { get; set; }

		public System.Nullable<System.DateTime> DataVencimento { get; set; }

		public System.Nullable<System.DateTime> DescontoAte { get; set; }

		public System.Nullable<System.Decimal> Valor { get; set; }

		public System.Nullable<System.Decimal> TaxaJuro { get; set; }

		public System.Nullable<System.Decimal> TaxaMulta { get; set; }

		public System.Nullable<System.Decimal> TaxaDesconto { get; set; }

		public System.Nullable<System.Decimal> ValorJuro { get; set; }

		public System.Nullable<System.Decimal> ValorMulta { get; set; }

		public System.Nullable<System.Decimal> ValorDesconto { get; set; }

		public System.Nullable<System.Decimal> ValorPago { get; set; }

		public string Historico { get; set; }

		public FinStatusParcela FinStatusParcela { get; set; }

		public FinTipoPagamento FinTipoPagamento { get; set; }

		public FinChequeEmitido FinChequeEmitido { get; set; }

		public FinLancamentoPagar FinLancamentoPagar { get; set; }

    }
}
