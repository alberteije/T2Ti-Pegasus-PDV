using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace T2TiERPFenix.Models
{
    [Table("cargo")]
    public class Cargo
    {
        [Key]
        [Column("ID")]
        public int Id { get; set; }

        [Required(ErrorMessage = "O Nome é obrigatório")]
        [StringLength(50, ErrorMessage = "O Nome não pode ser maior que 50 caracteres")]
        [Column("NOME")]
        public string Nome { get; set; }

        [Column("DESCRICAO")]
        public string Descricao { get; set; }

        [Column("SALARIO")]
        public decimal Salario { get; set; }

        [Column("CBO_1994")]
        public string CBO1994 { get; set; }

        [Column("CBO_2002")]
        public string CBO2002 { get; set; }
    }
}