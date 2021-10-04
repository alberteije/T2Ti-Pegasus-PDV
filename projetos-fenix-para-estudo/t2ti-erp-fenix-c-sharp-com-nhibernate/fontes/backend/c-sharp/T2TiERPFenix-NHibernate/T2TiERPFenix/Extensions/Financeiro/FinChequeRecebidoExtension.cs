/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Extension relacionado à tabela [FIN_CHEQUE_RECEBIDO] 
                                                                                
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
                                                                                
@author Albert Eije (alberteije@gmail.com)                    
@version 1.0.0
*******************************************************************************/
using T2TiERPFenix.Models;

namespace T2TiERPFenix.Extensions
{
    public static class FinChequeRecebidoExtension
    {
        public static void Map(this FinChequeRecebido objBanco, FinChequeRecebido objJson)
        {
			objBanco.Cpf = objJson.Cpf;
			objBanco.Cnpj = objJson.Cnpj;
			objBanco.Nome = objJson.Nome;
			objBanco.CodigoBanco = objJson.CodigoBanco;
			objBanco.CodigoAgencia = objJson.CodigoAgencia;
			objBanco.Conta = objJson.Conta;
			objBanco.Numero = objJson.Numero;
			objBanco.DataEmissao = objJson.DataEmissao;
			objBanco.BomPara = objJson.BomPara;
			objBanco.DataCompensacao = objJson.DataCompensacao;
			objBanco.Valor = objJson.Valor;
			objBanco.CustodiaData = objJson.CustodiaData;
			objBanco.CustodiaTarifa = objJson.CustodiaTarifa;
			objBanco.CustodiaComissao = objJson.CustodiaComissao;
			objBanco.DescontoData = objJson.DescontoData;
			objBanco.DescontoTarifa = objJson.DescontoTarifa;
			objBanco.DescontoComissao = objJson.DescontoComissao;
			
        }
    }
}
