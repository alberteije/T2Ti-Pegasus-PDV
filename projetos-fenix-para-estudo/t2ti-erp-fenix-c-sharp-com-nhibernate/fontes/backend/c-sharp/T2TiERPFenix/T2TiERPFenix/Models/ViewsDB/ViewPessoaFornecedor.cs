/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [VIEW_PESSOA_FORNECEDOR] 
                                                                                
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
    [Table("VIEW_PESSOA_FORNECEDOR")]
    public class ViewPessoaFornecedor
    {	
		[Key]
		[Column("ID")]
		public int Id { get; set; }

		[Column("NOME")]
		public string Nome { get; set; }

		[Column("TIPO")]
		public string Tipo { get; set; }

		[Column("EMAIL")]
		public string Email { get; set; }

		[Column("SITE")]
		public string Site { get; set; }

		[Column("CPF_CNPJ")]
		public string CpfCnpj { get; set; }

		[Column("RG_IE")]
		public string RgIe { get; set; }

		[Column("DESDE")]
		public System.Nullable<System.DateTime> Desde { get; set; }

		[Column("DATA_CADASTRO")]
		public System.Nullable<System.DateTime> DataCadastro { get; set; }

		[Column("OBSERVACAO")]
		public string Observacao { get; set; }

		[Column("ID_PESSOA")]
		public int IdPessoa { get; set; }

    }
}
