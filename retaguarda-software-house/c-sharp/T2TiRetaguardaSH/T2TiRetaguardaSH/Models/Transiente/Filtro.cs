/**
 * Classe transiente para controlar o filtro que vem do cliente.
 * tomar como base o seguinte esquema para criar as condições de filtro (filter conditions)
 * https://github.com/nestjsx/crud/wiki/Requests
 */
namespace T2TiRetaguardaSH.Models
{
    public class Filtro
    {

        public Filtro() { }

        public Filtro(string filter)
        {
            string[] partesDoFiltro = filter.Split("?");

            for (int i = 0; i < partesDoFiltro.Length; i++)
            {
                string[] condicoes = partesDoFiltro[i].Split("||");

                if (i > 0)
                {
                    Where = Where + " AND ";
                }

                // $cont (LIKE %val%, contains)
                if (condicoes[1] == "$cont")
                {
                    Campo = condicoes[0];
                    Valor = condicoes[2];
                    Where = Where + Campo + " like '%" + Valor + "%'";
                }

                // $eq (=, equal)
                if (condicoes[1] == "$eq")
                {
                    Campo = condicoes[0];
                    Valor = condicoes[2];
                    Where = Where + Campo + " = " + Valor + "'";
                }

                // $between (BETWEEN 'DATA1' and 'DATA2')
                if (condicoes[1] == "$between")
                {
                    string[] datas = condicoes[2].Split(",");
                    Campo = condicoes[0];
                    DataInicial = datas[0];
                    DataFinal = datas[1];
                    Where = Where + Campo + " between '" + DataInicial + "' and '" + DataFinal + "'";
                }
            }

        }

        public string Campo { get; set; }
        public string Valor { get; set; }
        public string DataInicial { get; set; }
        public string DataFinal { get; set; }

        public string Where { get; set; }
    }
}
