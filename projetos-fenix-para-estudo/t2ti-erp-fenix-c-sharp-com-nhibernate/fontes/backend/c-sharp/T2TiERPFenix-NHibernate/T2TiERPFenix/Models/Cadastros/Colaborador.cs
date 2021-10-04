/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [COLABORADOR] 
                                                                                
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
	[Table("COLABORADOR")]
	public class Colaborador
	{
		[Key]
		[Column("ID")]
		public int Id { get; set; }

		[Column("ID_PESSOA")]
		public int IdPessoa { get; set; }

		[Column("ID_CARGO")]
		public int IdCargo { get; set; }

		[Column("ID_SETOR")]
		public int IdSetor { get; set; }

		[Column("MATRICULA")]
		public string Matricula { get; set; }

		[Column("DATA_CADASTRO")]
		public System.Nullable<System.DateTime> DataCadastro { get; set; }

		[Column("DATA_ADMISSAO")]
		public System.Nullable<System.DateTime> DataAdmissao { get; set; }

		[Column("DATA_DEMISSAO")]
		public System.Nullable<System.DateTime> DataDemissao { get; set; }

		[Column("CTPS_NUMERO")]
		public string CtpsNumero { get; set; }

		[Column("CTPS_SERIE")]
		public string CtpsSerie { get; set; }

		[Column("CTPS_DATA_EXPEDICAO")]
		public System.Nullable<System.DateTime> CtpsDataExpedicao { get; set; }

		[Column("CTPS_UF")]
		public string CtpsUf { get; set; }

		[Column("OBSERVACAO")]
		public string Observacao { get; set; }

		[InverseProperty("Colaborador")]
		public Usuario Usuario { get; set; }

		[ForeignKey("IdPessoa")]
		public Pessoa Pessoa { get; set; }

		[ForeignKey("IdCargo")]
		public Cargo Cargo { get; set; }

		[ForeignKey("IdSetor")]
		public Setor Setor { get; set; }

	}
}
