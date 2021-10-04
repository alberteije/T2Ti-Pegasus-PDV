/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_PARCELA_RECEBER] 
                                                                                
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
    [Table("FIN_PARCELA_RECEBER")]
    public class FinParcelaReceber
    {	
		[Key]
		[Column("ID")]
		public int Id { get; set; }

		[Column("ID_FIN_LANCAMENTO_RECEBER")]
		public int IdFinLancamentoReceber { get; set; }

		[Column("ID_FIN_STATUS_PARCELA")]
		public int IdFinStatusParcela { get; set; }

		[Column("ID_FIN_TIPO_RECEBIMENTO")]
		public int IdFinTipoRecebimento { get; set; }

		[Column("ID_BANCO_CONTA_CAIXA")]
		public int IdBancoContaCaixa { get; set; }

		[Column("ID_FIN_CHEQUE_RECEBIDO")]
		public int IdFinChequeRecebido { get; set; }

		[Column("NUMERO_PARCELA")]
		public int NumeroParcela { get; set; }

		[Column("DATA_EMISSAO")]
		public System.Nullable<System.DateTime> DataEmissao { get; set; }

		[Column("DATA_VENCIMENTO")]
		public System.Nullable<System.DateTime> DataVencimento { get; set; }

		[Column("DESCONTO_ATE")]
		public System.Nullable<System.DateTime> DescontoAte { get; set; }

		[Column("VALOR")]
		public System.Nullable<System.Decimal> Valor { get; set; }

		[Column("TAXA_JURO")]
		public System.Nullable<System.Decimal> TaxaJuro { get; set; }

		[Column("TAXA_MULTA")]
		public System.Nullable<System.Decimal> TaxaMulta { get; set; }

		[Column("TAXA_DESCONTO")]
		public System.Nullable<System.Decimal> TaxaDesconto { get; set; }

		[Column("VALOR_JURO")]
		public System.Nullable<System.Decimal> ValorJuro { get; set; }

		[Column("VALOR_MULTA")]
		public System.Nullable<System.Decimal> ValorMulta { get; set; }

		[Column("VALOR_DESCONTO")]
		public System.Nullable<System.Decimal> ValorDesconto { get; set; }

		[Column("EMITIU_BOLETO")]
		public string EmitiuBoleto { get; set; }

		[Column("BOLETO_NOSSO_NUMERO")]
		public string BoletoNossoNumero { get; set; }

		[Column("VALOR_RECEBIDO")]
		public System.Nullable<System.Decimal> ValorRecebido { get; set; }

		[Column("HISTORICO")]
		public string Historico { get; set; }

		[ForeignKey("IdFinStatusParcela")]
		public FinStatusParcela FinStatusParcela { get; set; }

		[ForeignKey("IdFinTipoRecebimento")]
		public FinTipoRecebimento FinTipoRecebimento { get; set; }

		[ForeignKey("IdBancoContaCaixa")]
		public BancoContaCaixa BancoContaCaixa { get; set; }

		[ForeignKey("IdFinChequeRecebido")]
		public FinChequeRecebido FinChequeRecebido { get; set; }

		[ForeignKey("IdFinLancamentoReceber")]
		public FinLancamentoReceber FinLancamentoReceber { get; set; }

    }
}
