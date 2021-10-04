using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace T2TiERPFenix.Models
{
    [Table("pessoa_telefone")]
    public class PessoaTelefone
    {
        [Key]
        [Column("ID")]
        public int Id { get; set; }

        [Column("TIPO")]
        public string Tipo { get; set; }

        [Column("NUMERO")]
        public string Numero { get; set; }

        [Column("ID_PESSOA")]
        public int IdPessoa { get; set; }

        [ForeignKey("IdPessoa")]
        public Pessoa Pessoa { get; set; }

    }
}
