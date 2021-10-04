/********************************************************************************
Title: T2Ti ERP Fenix
Description: Biblioteca de funções.

The MIT License

Copyright: Copyright (C) 2020 T2Ti.COM

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

       The author may be contacted at:
           t2ti.com@gmail.com

@author T2Ti.COM
@version 1.0
********************************************************************************/

using System;
using System.Diagnostics;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Net;
using System.Net.Mail;

namespace T2TiRetaguardaSH.Util
{

    public static class Biblioteca
    {

        public static bool EnviarEmail(string assunto, string destino, string corpo)
        {
            string nomeArquivoIni = "c:\\t2ti\\config-email.ini";
            IniFile iniFile = new IniFile(nomeArquivoIni);

            string host = iniFile.IniReadString("Email", "Host");
            int port = iniFile.IniReadInt("Email", "Port");
            //string from = iniFile.IniReadString("Email", "From");
            //string bccList = iniFile.get("Email", "BccList");
            string userName = iniFile.IniReadString("Email", "Username");
            string password = iniFile.IniReadString("Email", "Password");

            var fromAddress = new MailAddress(userName, "From Name");
            var toAddress = new MailAddress(destino, "To Name");
            
            var smtp = new SmtpClient
            {
                Host = host,
                Port = port,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(fromAddress.Address, password)
            };
            using (var message = new MailMessage(fromAddress, toAddress)
            {
                Subject = assunto,
                Body = corpo
            })
            {
                smtp.Send(message);
            }

            return true;
        }

        public static string QuotedStr(string pValor)
        {
            return "'" + pValor + "'";
        }

        public static string VerificaNULL(string Texto, int Tipo)
        {
            switch (Tipo)
            {
                case 0:
                    if (Texto.Trim() == "")
                        return "NULL";
                    else
                        return Texto.Trim();
                case 1:
                    if (Texto.Trim() == "")
                        return "NULL";
                    else
                        return Biblioteca.QuotedStr(Texto.Trim());
                case 2:
                    if (Texto.Trim() == "")
                        return "";
                    else
                        return (Texto.Trim());
                default:
                    return "";
            }
        }


        //  Valida o CNPJ digitado 
        public static bool ValidaCNPJ(string cnpj)
        {
            int[] multiplicador1 = new int[12] { 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2 };
            int[] multiplicador2 = new int[13] { 6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2 };
            int soma;
            int resto;
            string digito;
            string tempCnpj;

            cnpj = cnpj.Trim();
            cnpj = cnpj.Replace(".", "").Replace("-", "").Replace("/", "");

            if (cnpj.Length != 14)
                return false;

            tempCnpj = cnpj.Substring(0, 12);
            soma = 0;

            for (int i = 0; i < 12; i++)
                soma += int.Parse(tempCnpj[i].ToString()) * multiplicador1[i];

            resto = (soma % 11);

            if (resto < 2)
                resto = 0;
            else
                resto = 11 - resto;

            digito = resto.ToString();
            tempCnpj = tempCnpj + digito;
            soma = 0;

            for (int i = 0; i < 13; i++)
                soma += int.Parse(tempCnpj[i].ToString()) * multiplicador2[i];

            resto = (soma % 11);

            if (resto < 2)
                resto = 0;
            else
                resto = 11 - resto;

            digito = digito + resto.ToString();

            return cnpj.EndsWith(digito);
        }


        //  Valida o CPF digitado 
        public static bool ValidaCPF(string cpf)
        {
            // Caso coloque todos os numeros iguais
            int[] multiplicador1 = new int[9] { 10, 9, 8, 7, 6, 5, 4, 3, 2 };
            int[] multiplicador2 = new int[10] { 11, 10, 9, 8, 7, 6, 5, 4, 3, 2 };
            string tempCpf;
            string digito;
            int soma;
            int resto;

            cpf = cpf.Trim();
            cpf = cpf.Replace(".", "").Replace("-", "");

            if (cpf.Length != 11)
                return false;

            tempCpf = cpf.Substring(0, 9);
            soma = 0;

            for (int i = 0; i < 9; i++)
                soma += int.Parse(tempCpf[i].ToString()) * multiplicador1[i];

            resto = soma % 11;

            if (resto < 2)
                resto = 0;
            else
                resto = 11 - resto;

            digito = resto.ToString();
            tempCpf = tempCpf + digito;
            soma = 0;

            for (int i = 0; i < 10; i++)
                soma += int.Parse(tempCpf[i].ToString()) * multiplicador2[i];

            resto = soma % 11;

            if (resto < 2)
                resto = 0;
            else
                resto = 11 - resto;

            digito = digito + resto.ToString();
            return cpf.EndsWith(digito);
        }

        //  Valida a UF digitada 
        public static bool ValidaEstado(string Dado)
        {
            const string Estados = "SPMGRJRSSCPRESDFMTMSGOTOBASEALPBPEMARNCEPIPAAMAPFNACRRRO"; int Posicao;
            bool Result;

            Result = true;
            if (Dado != "")
            {
                Posicao = Estados.IndexOf(Dado.ToUpper());
                if ((Posicao == 0) || ((Posicao % 2) == 0))
                {
                    Result = false;
                }
            }
            return Result;
        }


        public static string MD5File(string file)
        {
            using (FileStream stream = File.OpenRead(file))
            {
                MD5 md5 = new MD5CryptoServiceProvider();
                byte[] checksum = md5.ComputeHash(stream);
                return (BitConverter.ToString(checksum)).Replace("-", string.Empty);
            }
        }


        public static string MD5String(string texto)
        {
            MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider();
            byte[] byteArray = Encoding.ASCII.GetBytes(texto);

            byteArray = md5.ComputeHash(byteArray);

            StringBuilder hashedValue = new StringBuilder();

            foreach (byte b in byteArray)
            {
                hashedValue.Append(b.ToString("x2"));
            }

            return hashedValue.ToString();
        }


        public static decimal ArredondaTruncaValor(string Operacao, decimal? Valor, int Casas)
        {
            if (Operacao == "A")
            {
                return Math.Round(Valor.Value, Casas);
            }
            else
            {
                string sValor;
                int nPos;

                // Transforma o valor em string
                sValor = Valor.ToString();

                // Verifica se possui ponto decimal
                nPos = sValor.IndexOf(",");
                if (nPos > 0)
                {
                    sValor = sValor.Substring(0, nPos + Casas);
                }

                return Convert.ToDecimal(sValor);
            }

        }

        public static decimal TruncaValor(decimal? Value, int Casas)
        {
            string sValor;
            int nPos;

            // Transforma o valor em string
            sValor = Value.ToString();

            // Verifica se possui ponto decimal
            nPos = sValor.IndexOf(",");
            if (nPos > 0)
            {
                sValor = sValor.Substring(0, nPos + Casas);
            }

            return Convert.ToDecimal(sValor);
        }

        public static string FormataFloat(string Tipo, decimal? Valor)
        {
            int i;
            string Mascara;

            Mascara = "0.";

            if (Tipo == "Q")
            {
                for (i = 1; i <= Constantes.DECIMAIS_QUANTIDADE; i++)
                    Mascara = Mascara + "0";
            }
            else if (Tipo == "V")
            {
                for (i = 1; i <= Constantes.DECIMAIS_VALOR; i++)
                    Mascara = Mascara + "0";
            }

            return Convert.ToDecimal(Valor).ToString(Mascara);
        }

        public static string DevolveConteudoDelimitado(string Delimidador, string Linha)
        {
            int PosBarra;
            string Result;

            PosBarra = Linha.IndexOf(Delimidador);
            Result = (Linha.Substring(PosBarra - 1, 1)).Replace("[#]", "|");
            Linha = Linha.Remove(0, PosBarra);
            return Result;
        }

        public static string TiraPontos(string Str)
        {
            int i;
            string xStr;
            string Result;

            xStr = "";
            for (i = 1; i <= Str.Trim().Length; i++)
                if (("/-.)(,".IndexOf(Str.Substring(1, i)) == 0)) xStr = xStr + Str[i];

            xStr = xStr.Replace(" ", "");

            Result = xStr;
            return Result;
        }


        public static DateTime TextoParaData(string pData)
        {
            int Dia, Mes, Ano;
            System.DateTime Result;

            if ((pData != "") && (pData != "0000-00-00"))
            {
                Dia = Convert.ToInt32(pData.Substring(2, 9));
                Mes = Convert.ToInt32(pData.Substring(2, 6));
                Ano = Convert.ToInt32(pData.Substring(4, 1));
                Result = new DateTime(Ano, Mes, Dia);
            }
            else
            {
                Result = new DateTime();
            }
            return Result;
        }


        public static string DataParaTexto(DateTime pData)
        {
            return pData.ToString("YYYY-MM-DD");
        }

        public static string DataParaHora(DateTime pData)
        {
            return pData.ToString("HH:mm:ss");
        }

        public static string Encripta(string pChave)
        {
            string chaveCriptografada;
            Byte[] b = System.Text.ASCIIEncoding.ASCII.GetBytes(pChave);
            chaveCriptografada = Convert.ToBase64String(b);
            return chaveCriptografada;
        }


        public static string Desencripta(string pChave)
        {
            string chaveDecriptografada;
            Byte[] b = Convert.FromBase64String(pChave);
            chaveDecriptografada = System.Text.ASCIIEncoding.ASCII.GetString(b);
            return chaveDecriptografada;
        }


        /// <summary>
        /// Get substring of specified number of characters on the right.
        /// </summary>
        public static string Right(this string value, int length)
        {
            if (String.IsNullOrEmpty(value)) return string.Empty;

            return value.Length <= length ? value : value.Substring(value.Length - length);
        }


        public static string Modulo11(string chave)
        {
            int soma = 0; // Vai guardar a Soma
            int mod = -1; // Vai guardar o Resto da divisão
            int dv = -1;  // Vai guardar o DigitoVerificador
            int pesso = 2; // vai guardar o pesso de multiplicacao

            //percorrendo cada caracter da chave da direita para esquerda para fazer os calculos com o pesso
            for (int i = chave.Length - 1; i != -1; i--)
            {
                int ch = Convert.ToInt32(chave[i].ToString());
                soma += ch * pesso;
                //sempre que for 9 voltamos o pesso a 2
                if (pesso < 9)
                    pesso += 1;
                else
                    pesso = 2;
            }

            //Agora que tenho a soma vamos pegar o resto da divisão por 11
            mod = soma % 11;
            //Aqui temos uma regrinha, se o resto da divisão for 0 ou 1 então o dv vai ser 0
            if (mod == 0 || mod == 1)
                dv = 0;
            else
                dv = 11 - mod;

            return dv.ToString();
        }

        public static int UFToInt(string pUF)
        {
            if (pUF == "RO")
            {
                return 11;
            }
            else if (pUF == "AC")
            {
                return 12;
            }
            else if (pUF == "AM")
            {
                return 13;
            }
            else if (pUF == "RR")
            {
                return 14;
            }
            else if (pUF == "PA")
            {
                return 15;
            }
            else if (pUF == "AP")
            {
                return 16;
            }
            else if (pUF == "TO")
            {
                return 17;
            }
            else if (pUF == "MA")
            {
                return 21;
            }
            else if (pUF == "PI")
            {
                return 22;
            }
            else if (pUF == "CE")
            {
                return 23;
            }
            else if (pUF == "RN")
            {
                return 24;
            }
            else if (pUF == "PB")
            {
                return 25;
            }
            else if (pUF == "PE")
            {
                return 26;
            }
            else if (pUF == "AL")
            {
                return 27;
            }
            else if (pUF == "SE")
            {
                return 28;
            }
            else if (pUF == "BA")
            {
                return 29;
            }
            else if (pUF == "MG")
            {
                return 31;
            }
            else if (pUF == "ES")
            {
                return 32;
            }
            else if (pUF == "RJ")
            {
                return 33;
            }
            else if (pUF == "SP")
            {
                return 35;
            }
            else if (pUF == "PR")
            {
                return 41;
            }
            else if (pUF == "SC")
            {
                return 42;
            }
            else if (pUF == "RS")
            {
                return 43;
            }
            else if (pUF == "MS")
            {
                return 50;
            }
            else if (pUF == "MT")
            {
                return 51;
            }
            else if (pUF == "GO")
            {
                return 52;
            }
            else if (pUF == "DF")
            {
                return 53;
            }
            else
            {
                return 0;
            }
        }

        public static string IntToUF(int pUF)
        {
            if (pUF == 11)
            {
                return "RO";
            }
            else if (pUF == 12)
            {
                return "AC";
            }
            else if (pUF == 13)
            {
                return "AM";
            }
            else if (pUF == 14)
            {
                return "RR";
            }
            else if (pUF == 15)
            {
                return "PA";
            }
            else if (pUF == 16)
            {
                return "AP";
            }
            else if (pUF == 17)
            {
                return "TO";
            }
            else if (pUF == 21)
            {
                return "MA";
            }
            else if (pUF == 22)
            {
                return "PI";
            }
            else if (pUF == 23)
            {
                return "CE";
            }
            else if (pUF == 24)
            {
                return "RN";
            }
            else if (pUF == 25)
            {
                return "PB";
            }
            else if (pUF == 26)
            {
                return "PE";
            }
            else if (pUF == 27)
            {
                return "AL";
            }
            else if (pUF == 28)
            {
                return "SE";
            }
            else if (pUF == 29)
            {
                return "BA";
            }
            else if (pUF == 31)
            {
                return "MG";
            }
            else if (pUF == 32)
            {
                return "ES";
            }
            else if (pUF == 33)
            {
                return "RJ";
            }
            else if (pUF == 35)
            {
                return "SP";
            }
            else if (pUF == 41)
            {
                return "PR";
            }
            else if (pUF == 42)
            {
                return "SC";
            }
            else if (pUF == 43)
            {
                return "RS";
            }
            else if (pUF == 50)
            {
                return "MS";
            }
            else if (pUF == 51)
            {
                return "MT";
            }
            else if (pUF == 52)
            {
                return "GO";
            }
            else if (pUF == 53)
            {
                return "DF";
            }
            else
            {
                return "";
            }
        }

        public static string PegarPlanoPdv(string descricaoProduto)
        {
            if (descricaoProduto.Contains("Mensal"))
            {
                return "M";
            }
            else if (descricaoProduto.Contains("Semestral"))
            {
                return "S";
            }
            else if (descricaoProduto.Contains("Anual"))
            {
                return "A";
            }
            else
            {
                return "";
            }
        }

        public static string PegarModuloFiscalPdv(string descricaoProduto)
        {
            if (descricaoProduto.Contains("NFC"))
            {
                return "NFC";
            }
            else if (descricaoProduto.Contains("SAT"))
            {
                return "SAT";
            }
            else if (descricaoProduto.Contains("MFE"))
            {
                return "MFE";
            }
            else
            {
                return "";
            }
        }

        public static void KillTask(String processName)
        {
            try
            {
                foreach (Process proc in Process.GetProcessesByName(processName))
                {
                    proc.Kill();
                }
            }
            finally
            {
            }
        }
    }
}
