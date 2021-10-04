/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [PRODUTO] 
                                                                                
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
    [Table("PRODUTO")]
    public class Produto
    {	
		[Key]
		[Column("ID")]
		public int Id { get; set; }

		[Column("ID_PRODUTO_SUBGRUPO")]
		public int IdProdutoSubgrupo { get; set; }

		[Column("ID_PRODUTO_MARCA")]
		public int IdProdutoMarca { get; set; }

		[Column("ID_PRODUTO_UNIDADE")]
		public int IdProdutoUnidade { get; set; }

		[Column("NOME")]
		public string Nome { get; set; }

		[Column("DESCRICAO")]
		public string Descricao { get; set; }

		[Column("GTIN")]
		public string Gtin { get; set; }

		[Column("CODIGO_INTERNO")]
		public string CodigoInterno { get; set; }

		[Column("VALOR_COMPRA")]
		public System.Nullable<System.Decimal> ValorCompra { get; set; }

		[Column("VALOR_VENDA")]
		public System.Nullable<System.Decimal> ValorVenda { get; set; }

		[Column("NCM")]
		public string Ncm { get; set; }

		[Column("ESTOQUE_MINIMO")]
		public System.Nullable<System.Decimal> EstoqueMinimo { get; set; }

		[Column("ESTOQUE_MAXIMO")]
		public System.Nullable<System.Decimal> EstoqueMaximo { get; set; }

		[Column("QUANTIDADE_ESTOQUE")]
		public System.Nullable<System.Decimal> QuantidadeEstoque { get; set; }

		[Column("DATA_CADASTRO")]
		public System.Nullable<System.DateTime> DataCadastro { get; set; }

		[ForeignKey("IdProdutoSubgrupo")]
		public ProdutoSubgrupo ProdutoSubgrupo { get; set; }

		[ForeignKey("IdProdutoMarca")]
		public ProdutoMarca ProdutoMarca { get; set; }

		[ForeignKey("IdProdutoUnidade")]
		public ProdutoUnidade ProdutoUnidade { get; set; }

    }
}
