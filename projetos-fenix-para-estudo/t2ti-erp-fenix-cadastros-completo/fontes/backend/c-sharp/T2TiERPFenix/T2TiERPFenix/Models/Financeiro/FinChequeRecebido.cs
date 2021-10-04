/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_CHEQUE_RECEBIDO] 
                                                                                
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
    [Table("FIN_CHEQUE_RECEBIDO")]
    public class FinChequeRecebido
    {	
		[Key]
		[Column("ID")]
		public int Id { get; set; }

		[Column("ID_PESSOA")]
		public int IdPessoa { get; set; }

		[Column("CPF")]
		public string Cpf { get; set; }

		[Column("CNPJ")]
		public string Cnpj { get; set; }

		[Column("NOME")]
		public string Nome { get; set; }

		[Column("CODIGO_BANCO")]
		public string CodigoBanco { get; set; }

		[Column("CODIGO_AGENCIA")]
		public string CodigoAgencia { get; set; }

		[Column("CONTA")]
		public string Conta { get; set; }

		[Column("NUMERO")]
		public int Numero { get; set; }

		[Column("DATA_EMISSAO")]
		public System.Nullable<System.DateTime> DataEmissao { get; set; }

		[Column("BOM_PARA")]
		public System.Nullable<System.DateTime> BomPara { get; set; }

		[Column("DATA_COMPENSACAO")]
		public System.Nullable<System.DateTime> DataCompensacao { get; set; }

		[Column("VALOR")]
		public System.Nullable<System.Decimal> Valor { get; set; }

		[Column("CUSTODIA_DATA")]
		public System.Nullable<System.DateTime> CustodiaData { get; set; }

		[Column("CUSTODIA_TARIFA")]
		public System.Nullable<System.Decimal> CustodiaTarifa { get; set; }

		[Column("CUSTODIA_COMISSAO")]
		public System.Nullable<System.Decimal> CustodiaComissao { get; set; }

		[Column("DESCONTO_DATA")]
		public System.Nullable<System.DateTime> DescontoData { get; set; }

		[Column("DESCONTO_TARIFA")]
		public System.Nullable<System.Decimal> DescontoTarifa { get; set; }

		[Column("DESCONTO_COMISSAO")]
		public System.Nullable<System.Decimal> DescontoComissao { get; set; }

		[Column("VALOR_RECEBIDO")]
		public System.Nullable<System.Decimal> ValorRecebido { get; set; }

		[ForeignKey("IdPessoa")]
		public Pessoa Pessoa { get; set; }

    }
}
