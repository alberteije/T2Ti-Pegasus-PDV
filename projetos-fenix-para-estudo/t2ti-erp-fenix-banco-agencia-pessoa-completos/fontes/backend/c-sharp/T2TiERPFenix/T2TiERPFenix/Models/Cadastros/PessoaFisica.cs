using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace T2TiERPFenix.Models
{
    [Table("pessoa_fisica")]
    public class PessoaFisica
    {
        [Key]
        [Column("ID")]
        public int Id { get; set; }

		[Column("CPF")]
		public string Cpf { get; set; }

		[Column("RG")]
		public string Rg { get; set; }

		[Column("ORGAO_RG")]
		public string OrgaoRg { get; set; }

		[Column("DATA_EMISSAO_RG")]
		public System.Nullable<System.DateTime> DataEmissaoRg { get; set; }

		[Column("DATA_NASCIMENTO")]
		public System.Nullable<System.DateTime> DataNascimento { get; set; }

		[Column("SEXO")]
		public string Sexo { get; set; }

		[Column("RACA")]
		public string Raca { get; set; }

		[Column("NACIONALIDADE")]
		public string Nacionalidade { get; set; }

		[Column("NATURALIDADE")]
		public string Naturalidade { get; set; }

		[Column("NOME_PAI")]
		public string NomePai { get; set; }

		[Column("NOME_MAE")]
		public string NomeMae { get; set; }

		[Column("ID_PESSOA")]
        public int IdPessoa { get; set; }

        [ForeignKey("IdPessoa")]
        public Pessoa Pessoa { get; set; }

    }
}
