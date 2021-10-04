/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [PESSOA_ENDERECO] 
                                                                                
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
    [Table("PESSOA_ENDERECO")]
    public class PessoaEndereco
    {	
		[Key]
		[Column("ID")]
		public int Id { get; set; }

		//[Column("ID_PESSOA")]
		//public int IdPessoa { get; set; }

		[Column("LOGRADOURO")]
		public string Logradouro { get; set; }

		[Column("NUMERO")]
		public string Numero { get; set; }

		[Column("BAIRRO")]
		public string Bairro { get; set; }

		[Column("MUNICIPIO_IBGE")]
		public int MunicipioIbge { get; set; }

		[Column("UF")]
		public string Uf { get; set; }

		[Column("CEP")]
		public string Cep { get; set; }

		[Column("CIDADE")]
		public string Cidade { get; set; }

		[Column("COMPLEMENTO")]
		public string Complemento { get; set; }

		[Column("PRINCIPAL")]
		public string Principal { get; set; }

		[Column("ENTREGA")]
		public string Entrega { get; set; }

		[Column("COBRANCA")]
		public string Cobranca { get; set; }

		[Column("CORRESPONDENCIA")]
		public string Correspondencia { get; set; }

		[ForeignKey("IdPessoa")]
		public Pessoa Pessoa { get; set; }

    }
}
