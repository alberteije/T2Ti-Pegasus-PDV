/*
Title: T2Ti ERP 3.0                                                              
Description: Model - Model para o histórico de pagamentos da NFC-e
retaguarda da SH
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
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
import 'dart:convert';

class NfcePlanoPagamentoModel {
	int id;
	DateTime dataSolicitacao;
	DateTime dataPagamento;
  String plano;
  double valor;
  String statusPagamento;
  String codigoTransacao;
  String metodoPagamento;
  String codigoTipoPagamento;
	DateTime dataPlanoExpira;
  String emailPagamento;

	NfcePlanoPagamentoModel({
			this.id,
			this.dataSolicitacao,
			this.dataPagamento,
			this.plano,
			this.valor,
			this.statusPagamento,
			this.codigoTransacao,
			this.metodoPagamento,
			this.codigoTipoPagamento,
			this.dataPlanoExpira,
			this.emailPagamento,
		});

	NfcePlanoPagamentoModel.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
    dataSolicitacao = jsonDados['dataSolicitacao'] != null ? DateTime.tryParse(jsonDados['dataSolicitacao'].toString().substring(0,10)) : null;
    dataPagamento = jsonDados['dataPagamento'] != null ? DateTime.tryParse(jsonDados['dataPagamento'].toString().substring(0,10)) : null;
    plano = jsonDados['plano'];
    valor = jsonDados['valor'] != null ? jsonDados['valor'].toDouble() : null;
    statusPagamento = jsonDados['statusPagamento'];
    codigoTransacao = jsonDados['codigoTransacao'];
    metodoPagamento = jsonDados['metodoPagamento'];
    codigoTipoPagamento = jsonDados['codigoTipoPagamento'];
    dataPlanoExpira = jsonDados['dataPlanoExpira'] != null ? DateTime.tryParse(jsonDados['dataPlanoExpira'].toString().substring(0,10)) : null;
    emailPagamento = jsonDados['emailPagamento'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;

    jsonDados['dataSolicitacao'] = dataSolicitacao;
    jsonDados['dataPagamento'] = dataPagamento;
    jsonDados['plano'] = plano;
    jsonDados['valor'] = valor;
    jsonDados['statusPagamento'] = statusPagamento;
    jsonDados['codigoTransacao'] = codigoTransacao;
    jsonDados['metodoPagamento'] = metodoPagamento;
    jsonDados['codigoTipoPagamento'] = codigoTipoPagamento;
    jsonDados['dataPlanoExpira'] = dataPlanoExpira;
    jsonDados['emailPagamento'] = emailPagamento;
	
		return jsonDados;
	}
	
	String objetoEncodeJson(NfcePlanoPagamentoModel objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}