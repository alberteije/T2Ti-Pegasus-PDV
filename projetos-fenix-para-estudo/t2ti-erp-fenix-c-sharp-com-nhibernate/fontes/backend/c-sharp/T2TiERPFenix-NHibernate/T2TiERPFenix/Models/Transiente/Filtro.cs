/**
 * Classe transiente para controlar o filtro que vem do cliente.
 * tomar como base o seguinte esquema para criar as condições de filtro (filter conditions)
 * https://github.com/nestjsx/crud/wiki/Requests
 */
namespace T2TiERPFenix.Models
{
    public class Filtro
    {
        public Filtro(string filter)
        {
            string[] condicoes = filter.Split("||");

            // $cont (LIKE %val%, contains)
            if (condicoes[1] == "$cont")
            {
                Campo = condicoes[0];
                Valor = condicoes[2];
            }

            // $between (BETWEEN 'DATA1' and 'DATA2')
            if (condicoes[1] == "$between")
            {
                Campo = condicoes[0];
                string[] datas = condicoes[2].Split(",");
                DataInicial = datas[0];
                DataFinal = datas[1];
            }

        }

        public string Campo { get; set; }
        public string Valor { get; set; }
        public string DataInicial { get; set; }
        public string DataFinal { get; set; }

        public string Where {
            set { }

            get
            {
                string where;
                // verifica se o valor é diferente de vazio e se for filtra por campo/valor
                if (!Valor.Equals(""))
                {
                   where = Campo + " like '%" + Valor + "%'";
                }
                // se o valor for vazio, filtra pelo período
                else
                {
                    where = Campo + " between " + DataInicial + " and " + DataFinal;
                }

                return where;
            }

        }
    }
}
