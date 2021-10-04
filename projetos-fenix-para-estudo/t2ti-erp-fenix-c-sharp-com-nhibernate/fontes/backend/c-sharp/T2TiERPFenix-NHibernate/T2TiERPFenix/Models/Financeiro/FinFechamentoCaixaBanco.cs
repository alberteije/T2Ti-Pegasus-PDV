/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_FECHAMENTO_CAIXA_BANCO] 
                                                                                
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
    [Table("FIN_FECHAMENTO_CAIXA_BANCO")]
    public class FinFechamentoCaixaBanco
    {	
		[Key]
		[Column("ID")]
		public int Id { get; set; }

		[Column("ID_BANCO_CONTA_CAIXA")]
		public int? IdBancoContaCaixa { get; set; }

		[Column("DATA_FECHAMENTO")]
		public System.Nullable<System.DateTime> DataFechamento { get; set; }

		[Column("MES_ANO")]
		public string MesAno { get; set; }

		[Column("MES")]
		public string Mes { get; set; }

		[Column("ANO")]
		public string Ano { get; set; }

		[Column("SALDO_ANTERIOR")]
		public System.Nullable<System.Decimal> SaldoAnterior { get; set; }

		[Column("RECEBIMENTOS")]
		public System.Nullable<System.Decimal> Recebimentos { get; set; }

		[Column("PAGAMENTOS")]
		public System.Nullable<System.Decimal> Pagamentos { get; set; }

		[Column("SALDO_CONTA")]
		public System.Nullable<System.Decimal> SaldoConta { get; set; }

		[Column("CHEQUE_NAO_COMPENSADO")]
		public System.Nullable<System.Decimal> ChequeNaoCompensado { get; set; }

		[Column("SALDO_DISPONIVEL")]
		public System.Nullable<System.Decimal> SaldoDisponivel { get; set; }

		[ForeignKey("IdBancoContaCaixa")]
		public BancoContaCaixa BancoContaCaixa { get; set; }

    }
}
