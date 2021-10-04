using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace T2TiERPFenix.Models
{
    [Table("pessoa")]
    public class Pessoa
    {
        [Key]
        [Column("ID")]
        public int Id { get; set; }

        [Column("NOME")]
        public string Nome { get; set; }

        [Column("TIPO")]
        public string Tipo { get; set; }

        [Column("SITE")]
        public string Site { get; set; }

        [Column("EMAIL")]
        public string Email { get; set; }

        [Column("CLIENTE")]
        public string Cliente { get; set; }

        [Column("FORNECEDOR")]
        public string Fornecedor { get; set; }

        [Column("TRANSPORTADORA")]
        public string Transportadora { get; set; }

        [Column("COLABORADOR")]
        public string Colaborador { get; set; }

        [Column("CONTADOR")]
        public string Contador { get; set; }

        [InverseProperty("Pessoa")]
        public PessoaJuridica PessoaJuridica { get; set; }

        [InverseProperty("Pessoa")]
        public PessoaFisica PessoaFisica { get; set; }

        [InverseProperty("Pessoa")]
        public IList<PessoaContato> ListaPessoaContato { get; set; }

        [InverseProperty("Pessoa")]
        public IList<PessoaTelefone> ListaPessoaTelefone { get; set; }

        [InverseProperty("Pessoa")]
        public IList<PessoaEndereco> ListaPessoaEndereco { get; set; }
    }
}
