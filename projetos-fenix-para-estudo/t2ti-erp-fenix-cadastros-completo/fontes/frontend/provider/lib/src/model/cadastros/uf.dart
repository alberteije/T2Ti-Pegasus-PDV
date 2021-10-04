/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [UF] 
                                                                                
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


class Uf {
	int id;
	String sigla;
	String nome;
	int codigoIbge;

	Uf({
			this.id,
			this.sigla,
			this.nome,
			this.codigoIbge,
		});

	static List<String> campos = <String>[
		'ID', 
		'SIGLA', 
		'NOME', 
		'CODIGO_IBGE', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Sigla', 
		'Nome', 
		'Código IBGE UF', 
	];

	Uf.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		sigla = jsonDados['sigla'];
		nome = jsonDados['nome'];
		codigoIbge = jsonDados['codigoIbge'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['sigla'] = this.sigla;
		jsonDados['nome'] = this.nome;
		jsonDados['codigoIbge'] = this.codigoIbge ?? 0;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(Uf objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}