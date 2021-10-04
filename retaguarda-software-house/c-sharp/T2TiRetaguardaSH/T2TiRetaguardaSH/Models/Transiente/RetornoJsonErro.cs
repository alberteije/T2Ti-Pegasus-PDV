using System;

namespace T2TiRetaguardaSH.Models
{
    public class RetornoJsonErro
    {
        public RetornoJsonErro(int codigo, String mensagem, Exception ex)
        {
            Status = codigo;
            Message = mensagem;

            switch (Status)
            {
                case 400:
                    Error = "Bad Request";
                    break;
                case 404:
                    Error = "Not Found";
                    break;
                case 500:
                    Error = "Internal Server Error";
                    break;
                default:
                    Error = "Erro não mapeado";
                    break;
            }

            if (ex != null)
            {
                Message = Message + " - Exceção: " + ex.Message;
                Trace = ex.StackTrace;
            }

        }


        public int Status { get; set; }
        public string Error { get; set; }
        public string Message { get; set; }
        public string Trace { get; set; }

    }
}
