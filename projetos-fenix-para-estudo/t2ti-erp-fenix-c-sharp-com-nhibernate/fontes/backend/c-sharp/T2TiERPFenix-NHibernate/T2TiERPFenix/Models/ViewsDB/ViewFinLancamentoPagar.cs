/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [VIEW_FIN_LANCAMENTO_PAGAR] 
                                                                                
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
    [Table("VIEW_FIN_LANCAMENTO_PAGAR")]
    public class ViewFinLancamentoPagar
    {	
		[Key]
		[Column("ID")]
		public int Id { get; set; }

		[Column("ID_FIN_LANCAMENTO_PAGAR")]
		public int IdFinLancamentoPagar { get; set; }

		[Column("QUANTIDADE_PARCELA")]
		public int QuantidadeParcela { get; set; }

		[Column("VALOR_LANCAMENTO")]
		public System.Nullable<System.Decimal> ValorLancamento { get; set; }

		[Column("DATA_LANCAMENTO")]
		public System.Nullable<System.DateTime> DataLancamento { get; set; }

		[Column("NUMERO_DOCUMENTO")]
		public string NumeroDocumento { get; set; }

		[Column("ID_FIN_PARCELA_PAGAR")]
		public int IdFinParcelaPagar { get; set; }

		[Column("NUMERO_PARCELA")]
		public int NumeroParcela { get; set; }

		[Column("DATA_VENCIMENTO")]
		public System.Nullable<System.DateTime> DataVencimento { get; set; }

		[Column("VALOR_PARCELA")]
		public System.Nullable<System.Decimal> ValorParcela { get; set; }

		[Column("TAXA_JURO")]
		public System.Nullable<System.Decimal> TaxaJuro { get; set; }

		[Column("VALOR_JURO")]
		public System.Nullable<System.Decimal> ValorJuro { get; set; }

		[Column("TAXA_MULTA")]
		public System.Nullable<System.Decimal> TaxaMulta { get; set; }

		[Column("VALOR_MULTA")]
		public System.Nullable<System.Decimal> ValorMulta { get; set; }

		[Column("TAXA_DESCONTO")]
		public System.Nullable<System.Decimal> TaxaDesconto { get; set; }

		[Column("VALOR_DESCONTO")]
		public System.Nullable<System.Decimal> ValorDesconto { get; set; }

		[Column("SIGLA_DOCUMENTO")]
		public string SiglaDocumento { get; set; }

		[Column("NOME_FORNECEDOR")]
		public string NomeFornecedor { get; set; }

		[Column("ID_FIN_STATUS_PARCELA")]
		public int IdFinStatusParcela { get; set; }

		[Column("SITUACAO_PARCELA")]
		public string SituacaoParcela { get; set; }

		[Column("DESCRICAO_SITUACAO_PARCELA")]
		public string DescricaoSituacaoParcela { get; set; }

		[Column("ID_BANCO_CONTA_CAIXA")]
		public int IdBancoContaCaixa { get; set; }

		[Column("NOME_CONTA_CAIXA")]
		public string NomeContaCaixa { get; set; }

    }
}
