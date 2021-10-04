/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_FECHAMENTO_CAIXA_BANCO] 
                                                                                
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
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:fenix/src/infra/biblioteca.dart';
import 'package:fenix/src/model/model.dart';

class FinFechamentoCaixaBanco {
	int id;
	int idBancoContaCaixa;
	DateTime dataFechamento;
	String mesAno;
	String mes;
	String ano;
	double saldoAnterior;
	double recebimentos;
	double pagamentos;
	double saldoConta;
	double chequeNaoCompensado;
	double saldoDisponivel;
	BancoContaCaixa bancoContaCaixa;

	FinFechamentoCaixaBanco({
			this.id,
			this.idBancoContaCaixa,
			this.dataFechamento,
			this.mesAno,
			this.mes,
			this.ano,
			this.saldoAnterior,
			this.recebimentos,
			this.pagamentos,
			this.saldoConta,
			this.chequeNaoCompensado,
			this.saldoDisponivel,
			this.bancoContaCaixa,
		});

	static List<String> campos = <String>[
		'ID', 
		'DATA_FECHAMENTO', 
		'MES_ANO', 
		'MES', 
		'ANO', 
		'SALDO_ANTERIOR', 
		'RECEBIMENTOS', 
		'PAGAMENTOS', 
		'SALDO_CONTA', 
		'CHEQUE_NAO_COMPENSADO', 
		'SALDO_DISPONIVEL', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Data do Fechamento', 
		'Mês/Ano', 
		'Mês', 
		'Ano', 
		'Valor Saldo Anterior', 
		'Total Recebimentos', 
		'Total Pagamentos', 
		'Saldo em Conta', 
		'Cheques Não Compensados', 
		'Saldo Disponível', 
	];

	FinFechamentoCaixaBanco.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idBancoContaCaixa = jsonDados['idBancoContaCaixa'];
		dataFechamento = jsonDados['dataFechamento'] != null ? DateTime.tryParse(jsonDados['dataFechamento']) : null;
		mesAno = jsonDados['mesAno'];
		mes = jsonDados['mes'];
		ano = jsonDados['ano'];
		saldoAnterior = jsonDados['saldoAnterior'] != null ? jsonDados['saldoAnterior'].toDouble() : null;
		recebimentos = jsonDados['recebimentos'] != null ? jsonDados['recebimentos'].toDouble() : null;
		pagamentos = jsonDados['pagamentos'] != null ? jsonDados['pagamentos'].toDouble() : null;
		saldoConta = jsonDados['saldoConta'] != null ? jsonDados['saldoConta'].toDouble() : null;
		chequeNaoCompensado = jsonDados['chequeNaoCompensado'] != null ? jsonDados['chequeNaoCompensado'].toDouble() : null;
		saldoDisponivel = jsonDados['saldoDisponivel'] != null ? jsonDados['saldoDisponivel'].toDouble() : null;
		bancoContaCaixa = jsonDados['bancoContaCaixa'] == null ? null : new BancoContaCaixa.fromJson(jsonDados['bancoContaCaixa']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idBancoContaCaixa'] = this.idBancoContaCaixa ?? 0;
		jsonDados['dataFechamento'] = this.dataFechamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataFechamento) : null;
		jsonDados['mesAno'] = Biblioteca.removerMascara(this.mesAno);
		jsonDados['mes'] = this.mes;
		jsonDados['ano'] = this.ano;
		jsonDados['saldoAnterior'] = this.saldoAnterior;
		jsonDados['recebimentos'] = this.recebimentos;
		jsonDados['pagamentos'] = this.pagamentos;
		jsonDados['saldoConta'] = this.saldoConta;
		jsonDados['chequeNaoCompensado'] = this.chequeNaoCompensado;
		jsonDados['saldoDisponivel'] = this.saldoDisponivel;
		jsonDados['bancoContaCaixa'] = this.bancoContaCaixa == null ? null : this.bancoContaCaixa.toJson;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(FinFechamentoCaixaBanco objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}