/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_LANCAMENTO_PAGAR] 
                                                                                
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
using System.Collections.Generic;

namespace T2TiERPFenix.Models
{
    [Table("FIN_LANCAMENTO_PAGAR")]
    public class FinLancamentoPagar
    {	
		[Key]
		[Column("ID")]
		public int Id { get; set; }

		[Column("ID_FIN_DOCUMENTO_ORIGEM")]
		public int IdFinDocumentoOrigem { get; set; }

		[Column("ID_FIN_NATUREZA_FINANCEIRA")]
		public int IdFinNaturezaFinanceira { get; set; }

		[Column("ID_FORNECEDOR")]
		public int IdFornecedor { get; set; }

		[Column("QUANTIDADE_PARCELA")]
		public int QuantidadeParcela { get; set; }

		[Column("VALOR_TOTAL")]
		public System.Nullable<System.Decimal> ValorTotal { get; set; }

		[Column("VALOR_A_PAGAR")]
		public System.Nullable<System.Decimal> ValorAPagar { get; set; }

		[Column("DATA_LANCAMENTO")]
		public System.Nullable<System.DateTime> DataLancamento { get; set; }

		[Column("NUMERO_DOCUMENTO")]
		public string NumeroDocumento { get; set; }

		[Column("IMAGEM_DOCUMENTO")]
		public string ImagemDocumento { get; set; }

		[Column("PRIMEIRO_VENCIMENTO")]
		public System.Nullable<System.DateTime> PrimeiroVencimento { get; set; }

		[Column("INTERVALO_ENTRE_PARCELAS")]
		public int IntervaloEntreParcelas { get; set; }

		[Column("DIA_FIXO")]
		public string DiaFixo { get; set; }

		[ForeignKey("IdFinDocumentoOrigem")]
		public FinDocumentoOrigem FinDocumentoOrigem { get; set; }

		[ForeignKey("IdFinNaturezaFinanceira")]
		public FinNaturezaFinanceira FinNaturezaFinanceira { get; set; }

		[ForeignKey("IdFornecedor")]
		public Fornecedor Fornecedor { get; set; }

		[InverseProperty("FinLancamentoPagar")]
		public IList<FinParcelaPagar> ListaFinParcelaPagar { get; set; }

    }
}
