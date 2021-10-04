/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_CONFIGURACAO_BOLETO] 
                                                                                
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
    [Table("FIN_CONFIGURACAO_BOLETO")]
    public class FinConfiguracaoBoleto
    {	
		[Key]
		[Column("ID")]
		public int Id { get; set; }

		[Column("ID_BANCO_CONTA_CAIXA")]
		public int? IdBancoContaCaixa { get; set; }

		[Column("INSTRUCAO01")]
		public string Instrucao01 { get; set; }

		[Column("INSTRUCAO02")]
		public string Instrucao02 { get; set; }

		[Column("CAMINHO_ARQUIVO_REMESSA")]
		public string CaminhoArquivoRemessa { get; set; }

		[Column("CAMINHO_ARQUIVO_RETORNO")]
		public string CaminhoArquivoRetorno { get; set; }

		[Column("CAMINHO_ARQUIVO_LOGOTIPO")]
		public string CaminhoArquivoLogotipo { get; set; }

		[Column("CAMINHO_ARQUIVO_PDF")]
		public string CaminhoArquivoPdf { get; set; }

		[Column("MENSAGEM")]
		public string Mensagem { get; set; }

		[Column("LOCAL_PAGAMENTO")]
		public string LocalPagamento { get; set; }

		[Column("LAYOUT_REMESSA")]
		public string LayoutRemessa { get; set; }

		[Column("ACEITE")]
		public string Aceite { get; set; }

		[Column("ESPECIE")]
		public string Especie { get; set; }

		[Column("CARTEIRA")]
		public string Carteira { get; set; }

		[Column("CODIGO_CONVENIO")]
		public string CodigoConvenio { get; set; }

		[Column("CODIGO_CEDENTE")]
		public string CodigoCedente { get; set; }

		[Column("TAXA_MULTA")]
		public System.Nullable<System.Decimal> TaxaMulta { get; set; }

		[Column("TAXA_JURO")]
		public System.Nullable<System.Decimal> TaxaJuro { get; set; }

		[Column("DIAS_PROTESTO")]
		public int? DiasProtesto { get; set; }

		[Column("NOSSO_NUMERO_ANTERIOR")]
		public string NossoNumeroAnterior { get; set; }

		[ForeignKey("IdBancoContaCaixa")]
		public BancoContaCaixa BancoContaCaixa { get; set; }

    }
}
