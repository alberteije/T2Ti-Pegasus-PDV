using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace T2TiERPFenix.Models
{
    [Table("pessoa_endereco")]
    public class PessoaEndereco
    {
        [Key]
        [Column("ID")]
        public int Id { get; set; }

		[Column("LOGRADOURO")]
		public string Logradouro { get; set; }

		[Column("NUMERO")]
		public string Numero { get; set; }

		[Column("BAIRRO")]
		public string Bairro { get; set; }

		[Column("MUNICIPIO_IBGE")]
		public int MunicipioIbge { get; set; }

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

		[Column("UF")]
		public string Uf { get; set; }

		[Column("CEP")]
		public string Cep { get; set; }

		[Column("CIDADE")]
		public string Cidade { get; set; }

		[Column("ID_PESSOA")]
        public int IdPessoa { get; set; }

        [ForeignKey("IdPessoa")]
        public Pessoa Pessoa { get; set; }

    }
}
