/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [CHEQUE] 
                                                                                
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

class Cheque {
	int id;
	int idTalonarioCheque;
	int numero;
	String statusCheque;
	DateTime dataStatus;

	Cheque({
			this.id,
			this.idTalonarioCheque,
			this.numero,
			this.statusCheque,
			this.dataStatus,
		});

	static List<String> campos = <String>[
		'ID', 
		'NUMERO', 
		'STATUS_CHEQUE', 
		'DATA_STATUS', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Número', 
		'Status', 
		'Data do Status', 
	];

	Cheque.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idTalonarioCheque = jsonDados['idTalonarioCheque'];
		numero = jsonDados['numero'];
		statusCheque = getStatusCheque(jsonDados['statusCheque']);
		dataStatus = jsonDados['dataStatus'] != null ? DateTime.tryParse(jsonDados['dataStatus']) : null;
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idTalonarioCheque'] = this.idTalonarioCheque ?? 0;
		jsonDados['numero'] = this.numero ?? 0;
		jsonDados['statusCheque'] = setStatusCheque(this.statusCheque);
		jsonDados['dataStatus'] = this.dataStatus != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataStatus) : null;
	
		return jsonDados;
	}
	
    getStatusCheque(String statusCheque) {
    	switch (statusCheque) {
    		case '0':
    			return 'Em Ser';
    			break;
    		case '1':
    			return 'Baixado';
    			break;
    		case '2':
    			return 'Utilizado';
    			break;
    		case '3':
    			return 'Compensado';
    			break;
    		case '4':
    			return 'Cancelado';
    			break;
    		default:
    			return null;
    		}
    	}

    setStatusCheque(String statusCheque) {
    	switch (statusCheque) {
    		case 'Em Ser':
    			return '0';
    			break;
    		case 'Baixado':
    			return '1';
    			break;
    		case 'Utilizado':
    			return '2';
    			break;
    		case 'Compensado':
    			return '3';
    			break;
    		case 'Cancelado':
    			return '4';
    			break;
    		default:
    			return null;
    		}
    	}


	String objetoEncodeJson(Cheque objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}