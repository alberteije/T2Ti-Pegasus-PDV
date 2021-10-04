/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [PESSOA] 
                                                                                
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

class Pessoa {
	int id;
	String nome;
	String tipo;
	String site;
	String email;
	String cliente;
	String fornecedor;
	String transportadora;
	String colaborador;
	String contador;
	PessoaFisica pessoaFisica;
	PessoaJuridica pessoaJuridica;
	List<PessoaContato> listaPessoaContato = [];
	List<PessoaEndereco> listaPessoaEndereco = [];
	List<PessoaTelefone> listaPessoaTelefone = [];

	Pessoa({
			this.id,
			this.nome,
			this.tipo = 'Física',
			this.site,
			this.email,
			this.cliente,
			this.fornecedor,
			this.transportadora,
			this.colaborador,
			this.contador,
			this.pessoaFisica,
			this.pessoaJuridica,
			this.listaPessoaContato,
			this.listaPessoaEndereco,
			this.listaPessoaTelefone,
		});

	static List<String> campos = <String>[
		'ID', 
		'NOME', 
		'TIPO', 
		'SITE', 
		'EMAIL', 
		'CLIENTE', 
		'FORNECEDOR', 
		'TRANSPORTADORA', 
		'COLABORADOR', 
		'CONTADOR', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Nome', 
		'Tipo', 
		'Site', 
		'E-Mail', 
		'Pessoa é Cliente', 
		'Pessoa é Fornecedor', 
		'Pessoa é Transportadora', 
		'Pessoa é Colaborador', 
		'Pessoa é Contador', 
	];

	Pessoa.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		nome = jsonDados['nome'];
		tipo = getTipo(jsonDados['tipo']);
		site = jsonDados['site'];
		email = jsonDados['email'];
		cliente = getCliente(jsonDados['cliente']);
		fornecedor = getFornecedor(jsonDados['fornecedor']);
		transportadora = getTransportadora(jsonDados['transportadora']);
		colaborador = getColaborador(jsonDados['colaborador']);
		contador = getContador(jsonDados['contador']);
		pessoaFisica = jsonDados['pessoaFisica'] == null ? null : new PessoaFisica.fromJson(jsonDados['pessoaFisica']);
		pessoaJuridica = jsonDados['pessoaJuridica'] == null ? null : new PessoaJuridica.fromJson(jsonDados['pessoaJuridica']);
		listaPessoaContato = (jsonDados['listaPessoaContato'] as Iterable)?.map((m) => PessoaContato.fromJson(m))?.toList() ?? [];
		listaPessoaEndereco = (jsonDados['listaPessoaEndereco'] as Iterable)?.map((m) => PessoaEndereco.fromJson(m))?.toList() ?? [];
		listaPessoaTelefone = (jsonDados['listaPessoaTelefone'] as Iterable)?.map((m) => PessoaTelefone.fromJson(m))?.toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['nome'] = this.nome;
		jsonDados['tipo'] = setTipo(this.tipo);
		jsonDados['site'] = this.site;
		jsonDados['email'] = this.email;
		jsonDados['cliente'] = setCliente(this.cliente);
		jsonDados['fornecedor'] = setFornecedor(this.fornecedor);
		jsonDados['transportadora'] = setTransportadora(this.transportadora);
		jsonDados['colaborador'] = setColaborador(this.colaborador);
		jsonDados['contador'] = setContador(this.contador);
		jsonDados['pessoaFisica'] = this.pessoaFisica == null ? null : this.pessoaFisica.toJson;
		jsonDados['pessoaJuridica'] = this.pessoaJuridica == null ? null : this.pessoaJuridica.toJson;
		

		var listaPessoaContatoLocal = [];
		for (PessoaContato objeto in this.listaPessoaContato ?? []) {
			listaPessoaContatoLocal.add(objeto.toJson);
		}
		jsonDados['listaPessoaContato'] = listaPessoaContatoLocal;
		

		var listaPessoaEnderecoLocal = [];
		for (PessoaEndereco objeto in this.listaPessoaEndereco ?? []) {
			listaPessoaEnderecoLocal.add(objeto.toJson);
		}
		jsonDados['listaPessoaEndereco'] = listaPessoaEnderecoLocal;
		

		var listaPessoaTelefoneLocal = [];
		for (PessoaTelefone objeto in this.listaPessoaTelefone ?? []) {
			listaPessoaTelefoneLocal.add(objeto.toJson);
		}
		jsonDados['listaPessoaTelefone'] = listaPessoaTelefoneLocal;
	
		return jsonDados;
	}
	
    getTipo(String tipo) {
    	switch (tipo) {
    		case 'F':
    			return 'Física';
    			break;
    		case 'J':
    			return 'Jurídica';
    			break;
    		default:
    			return null;
    		}
    	}

    setTipo(String tipo) {
    	switch (tipo) {
    		case 'Física':
    			return 'F';
    			break;
    		case 'Jurídica':
    			return 'J';
    			break;
    		default:
    			return null;
    		}
    	}

    getCliente(String cliente) {
    	switch (cliente) {
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

    setCliente(String cliente) {
    	switch (cliente) {
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

    getFornecedor(String fornecedor) {
    	switch (fornecedor) {
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

    setFornecedor(String fornecedor) {
    	switch (fornecedor) {
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

    getTransportadora(String transportadora) {
    	switch (transportadora) {
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

    setTransportadora(String transportadora) {
    	switch (transportadora) {
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

    getColaborador(String colaborador) {
    	switch (colaborador) {
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

    setColaborador(String colaborador) {
    	switch (colaborador) {
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

    getContador(String contador) {
    	switch (contador) {
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

    setContador(String contador) {
    	switch (contador) {
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


	String objetoEncodeJson(Pessoa objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}