/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [PESSOA_TELEFONE] 
                                                                                
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

import 'package:fenix/src/infra/biblioteca.dart';

class PessoaTelefone {
	int id;
	int idPessoa;
	String tipo;
	String numero;

	PessoaTelefone({
			this.id,
			this.idPessoa,
			this.tipo,
			this.numero,
		});

	static List<String> campos = <String>[
		'ID', 
		'TIPO', 
		'NUMERO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Tipoe', 
		'Número', 
	];

	PessoaTelefone.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idPessoa = jsonDados['idPessoa'];
		tipo = getTipo(jsonDados['tipo']);
		numero = jsonDados['numero'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idPessoa'] = this.idPessoa ?? 0;
		jsonDados['tipo'] = setTipo(this.tipo);
		jsonDados['numero'] = Biblioteca.removerMascara(this.numero);
	
		return jsonDados;
	}
	
    getTipo(String tipo) {
    	switch (tipo) {
    		case '0':
    			return 'Residencial';
    			break;
    		case '1':
    			return 'Comercial';
    			break;
    		case '2':
    			return 'Celular';
    			break;
    		case '3':
    			return 'Outro';
    			break;
    		default:
    			return null;
    		}
    	}

    setTipo(String tipo) {
    	switch (tipo) {
    		case 'Residencial':
    			return '0';
    			break;
    		case 'Comercial':
    			return '1';
    			break;
    		case 'Celular':
    			return '2';
    			break;
    		case 'Outro':
    			return '3';
    			break;
    		default:
    			return null;
    		}
    	}


	String objetoEncodeJson(PessoaTelefone objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}