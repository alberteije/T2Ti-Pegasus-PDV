/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_CHEQUE_EMITIDO] 
                                                                                
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
import 'package:fenix/src/model/model.dart';

class FinChequeEmitido {
	int id;
	int idCheque;
	DateTime dataEmissao;
	DateTime bomPara;
	DateTime dataCompensacao;
	double valor;
	String nominalA;
	Cheque cheque;

	FinChequeEmitido({
			this.id,
			this.idCheque,
			this.dataEmissao,
			this.bomPara,
			this.dataCompensacao,
			this.valor,
			this.nominalA,
			this.cheque,
		});

	static List<String> campos = <String>[
		'ID', 
		'DATA_EMISSAO', 
		'BOM_PARA', 
		'DATA_COMPENSACAO', 
		'VALOR', 
		'NOMINAL_A', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Valor', 
		'Nominal A', 
	];

	FinChequeEmitido.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idCheque = jsonDados['idCheque'];
		dataEmissao = jsonDados['dataEmissao'] != null ? DateTime.tryParse(jsonDados['dataEmissao']) : null;
		bomPara = jsonDados['bomPara'] != null ? DateTime.tryParse(jsonDados['bomPara']) : null;
		dataCompensacao = jsonDados['dataCompensacao'] != null ? DateTime.tryParse(jsonDados['dataCompensacao']) : null;
		valor = jsonDados['valor'] != null ? jsonDados['valor'].toDouble() : null;
		nominalA = jsonDados['nominalA'];
		cheque = jsonDados['cheque'] == null ? null : new Cheque.fromJson(jsonDados['cheque']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idCheque'] = this.idCheque ?? 0;
		jsonDados['dataEmissao'] = this.dataEmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataEmissao) : null;
		jsonDados['bomPara'] = this.bomPara != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.bomPara) : null;
		jsonDados['dataCompensacao'] = this.dataCompensacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataCompensacao) : null;
		jsonDados['valor'] = this.valor;
		jsonDados['nominalA'] = this.nominalA;
		jsonDados['cheque'] = this.cheque == null ? null : this.cheque.toJson;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(FinChequeEmitido objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}