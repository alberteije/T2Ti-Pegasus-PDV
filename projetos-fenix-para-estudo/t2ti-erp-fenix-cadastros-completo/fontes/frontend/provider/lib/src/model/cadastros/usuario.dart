/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [USUARIO] 
                                                                                
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

class Usuario {
	int id;
	int idColaborador;
	int idPapel;
	String login;
	String senha;
	String administrador;
	DateTime dataCadastro;
	Papel papel;

	Usuario({
			this.id,
			this.idColaborador,
			this.idPapel,
			this.login,
			this.senha,
			this.administrador,
			this.dataCadastro,
			this.papel,
		});

	static List<String> campos = <String>[
		'ID', 
		'LOGIN', 
		'SENHA', 
		'ADMINISTRADOR', 
		'DATA_CADASTRO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Login', 
		'Senha', 
		'É Administrador', 
		'Data de Cadastro', 
	];

	Usuario.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idColaborador = jsonDados['idColaborador'];
		idPapel = jsonDados['idPapel'];
		login = jsonDados['login'];
		senha = jsonDados['senha'];
		administrador = getAdministrador(jsonDados['administrador']);
		dataCadastro = jsonDados['dataCadastro'] != null ? DateTime.tryParse(jsonDados['dataCadastro']) : null;
		papel = jsonDados['papel'] == null ? null : new Papel.fromJson(jsonDados['papel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idColaborador'] = this.idColaborador ?? 0;
		jsonDados['idPapel'] = this.idPapel ?? 0;
		jsonDados['login'] = this.login;
		jsonDados['senha'] = this.senha;
		jsonDados['administrador'] = setAdministrador(this.administrador);
		jsonDados['dataCadastro'] = this.dataCadastro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataCadastro) : null;
		jsonDados['papel'] = this.papel == null ? null : this.papel.toJson;
	
		return jsonDados;
	}
	
    getAdministrador(String administrador) {
    	switch (administrador) {
    		case 'S':
    			return 'Sim';
    			break;
    		case 'N':
    			return 'Não';
    			break;
    		default:
    			return null;
    		}
    	}

    setAdministrador(String administrador) {
    	switch (administrador) {
    		case 'Sim':
    			return 'S';
    			break;
    		case 'Não':
    			return 'N';
    			break;
    		default:
    			return null;
    		}
    	}


	String objetoEncodeJson(Usuario objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}