/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [BANCO_AGENCIA] 
                                                                                
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
import 'package:fenix/src/model/model.dart';

class BancoAgencia {
	int id;
	int idBanco;
	String numero;
	String digito;
	String nome;
	String telefone;
	String contato;
	String observacao;
	String gerente;
	Banco banco;

	BancoAgencia({
			this.id,
			this.idBanco,
			this.numero,
			this.digito,
			this.nome,
			this.telefone,
			this.contato,
			this.observacao,
			this.gerente,
			this.banco,
		});

	static List<String> campos = <String>[
		'ID', 
		'NUMERO', 
		'DIGITO', 
		'NOME', 
		'TELEFONE', 
		'CONTATO', 
		'OBSERVACAO', 
		'GERENTE', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Número', 
		'Dígito', 
		'Nome', 
		'Telefone', 
		'Contato', 
		'Observação', 
		'Gerente', 
	];

	BancoAgencia.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idBanco = jsonDados['idBanco'];
		numero = jsonDados['numero'];
		digito = jsonDados['digito'];
		nome = jsonDados['nome'];
		telefone = jsonDados['telefone'];
		contato = jsonDados['contato'];
		observacao = jsonDados['observacao'];
		gerente = jsonDados['gerente'];
		banco = jsonDados['banco'] == null ? null : new Banco.fromJson(jsonDados['banco']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idBanco'] = this.idBanco ?? 0;
		jsonDados['numero'] = this.numero;
		jsonDados['digito'] = this.digito;
		jsonDados['nome'] = this.nome;
		jsonDados['telefone'] = Biblioteca.removerMascara(this.telefone);
		jsonDados['contato'] = this.contato;
		jsonDados['observacao'] = this.observacao;
		jsonDados['gerente'] = this.gerente;
		jsonDados['banco'] = this.banco == null ? null : this.banco.toJson;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(BancoAgencia objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}