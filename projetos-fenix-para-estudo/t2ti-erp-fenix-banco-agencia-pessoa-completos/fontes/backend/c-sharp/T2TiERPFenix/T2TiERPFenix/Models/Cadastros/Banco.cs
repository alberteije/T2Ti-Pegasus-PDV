using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace T2TiERPFenix.Models
{
    [Table("banco")]
    public class Banco
    {
        [Key]
        [Column("ID")]
        public int Id { get; set; }

        [Column("CODIGO")]
        public string Codigo { get; set; }

        [Column("NOME")]
        public string Nome { get; set; }

        [Column("URL")]
        public string Url { get; set; }

    }
}
