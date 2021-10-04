using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace T2TiERPFenix.Models
{
    [Table("pessoa_juridica")]
    public class PessoaJuridica
    {
        [Key]
        [Column("ID")]
        public int Id { get; set; }

        [Column("ID_PESSOA")]
        public int IdPessoa { get; set; }

        [Column("CNPJ")]
        public string CNPJ { get; set; }

        [Column("NOME_FANTASIA")]
        public string NomeFantasia { get; set; }

        [Column("INSCRICAO_ESTADUAL")]
        public string InscricaoEstadual { get; set; }

        [Column("INSCRICAO_MUNICIPAL")]
        public string InscricaoMunicipal { get; set; }

        [Column("DATA_CONSTITUICAO")]
        public DateTime DataConstituicao { get; set; }

        [Column("TIPO_REGIME")]
        public string TipoRegime { get; set; }

        [Column("CRT")]
        public string CRT { get; set; }


    }
}
