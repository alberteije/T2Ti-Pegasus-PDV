using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace T2TiERPFenix.Models
{
    [Table("banco_agencia")]
    public class BancoAgencia
    {
        [Key]
        [Column("ID")]
        public int Id { get; set; }

		[Column("NUMERO")]
		public string Numero { get; set; }

		[Column("DIGITO")]
		public string Digito { get; set; }

		[Column("NOME")]
		public string Nome { get; set; }

		[Column("TELEFONE")]
		public string Telefone { get; set; }

		[Column("CONTATO")]
		public string Contato { get; set; }

		[Column("OBSERVACAO")]
		public string Observacao { get; set; }

		[Column("GERENTE")]
		public string Gerente { get; set; }

		[Column("ID_BANCO")]
		public int IdBanco { get; set; }

		[ForeignKey("IdBanco")]
		public Banco Banco { get; set; }

	}
}
