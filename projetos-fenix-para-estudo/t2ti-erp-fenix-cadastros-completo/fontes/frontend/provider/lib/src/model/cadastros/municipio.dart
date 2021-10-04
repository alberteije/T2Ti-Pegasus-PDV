/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [MUNICIPIO] 
                                                                                
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

import 'package:fenix/src/model/model.dart';

class Municipio {
	int id;
	int idUf;
	String nome;
	int codigoIbge;
	int codigoReceitaFederal;
	int codigoEstadual;
	Uf uf;

	Municipio({
			this.id,
			this.idUf,
			this.nome,
			this.codigoIbge,
			this.codigoReceitaFederal,
			this.codigoEstadual,
			this.uf,
		});

	static List<String> campos = <String>[
		'ID', 
		'NOME', 
		'CODIGO_IBGE', 
		'CODIGO_RECEITA_FEDERAL', 
		'CODIGO_ESTADUAL', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Nome', 
		'Município IBGE', 
		'Código Receita Federal', 
		'Código Estadual', 
	];

	Municipio.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idUf = jsonDados['idUf'];
		nome = jsonDados['nome'];
		codigoIbge = jsonDados['codigoIbge'];
		codigoReceitaFederal = jsonDados['codigoReceitaFederal'];
		codigoEstadual = jsonDados['codigoEstadual'];
		uf = jsonDados['uf'] == null ? null : new Uf.fromJson(jsonDados['uf']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idUf'] = this.idUf ?? 0;
		jsonDados['nome'] = this.nome;
		jsonDados['codigoIbge'] = this.codigoIbge ?? 0;
		jsonDados['codigoReceitaFederal'] = this.codigoReceitaFederal ?? 0;
		jsonDados['codigoEstadual'] = this.codigoEstadual ?? 0;
		jsonDados['uf'] = this.uf == null ? null : this.uf.toJson;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(Municipio objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}