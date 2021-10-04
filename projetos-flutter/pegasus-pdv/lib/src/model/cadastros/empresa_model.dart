/*
Title: T2Ti ERP 3.0                                                                
Description: Model relacionado à tabela [EMPRESA] 
                                                                                
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

import 'package:intl/intl.dart';
import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/infra/infra.dart';

class EmpresaModel {
  int id;
  String razaoSocial;
  String nomeFantasia;
  String cnpj;
  String inscricaoEstadual;
  String inscricaoMunicipal;
  String tipoRegime;
  String crt;
  DateTime dataConstituicao;
  String tipo;		
  String email;
  String logradouro;
  String numero;
  String complemento;
  String cep;
  String bairro;
  String cidade;
  String uf;
  String fone;
  String contato;
  int codigoIbgeCidade;
  int codigoIbgeUf;
  String logotipo;
  String registrado;
  String naturezaJuridica;
  String simei;
  String emailPagamento;
  DateTime dataRegistro;
  String horaRegistro;

	EmpresaModel({
		this.id,
		this.razaoSocial,
		this.nomeFantasia,
		this.cnpj,
		this.inscricaoEstadual,
		this.inscricaoMunicipal,
		this.tipoRegime,
		this.crt,
		this.dataConstituicao,
		this.tipo,		
    this.email,
		this.logradouro,
		this.numero,
		this.complemento,
		this.cep,
		this.bairro,
		this.cidade,
		this.uf,
		this.fone,
		this.contato,
		this.codigoIbgeCidade,
		this.codigoIbgeUf,
		this.logotipo,
		this.registrado,
		this.naturezaJuridica,
		this.simei,
		this.emailPagamento,
    this.dataRegistro,
    this.horaRegistro,
	});

  EmpresaModel.fromDB(Empresa empresa) {
		this.razaoSocial = empresa.razaoSocial;
		this.nomeFantasia = empresa.nomeFantasia;
		this.cnpj = empresa.cnpj;
		this.inscricaoEstadual = empresa.inscricaoEstadual;
		this.inscricaoMunicipal = empresa.inscricaoMunicipal;
		this.tipoRegime = empresa.tipoRegime;
		this.crt = empresa.crt;
		this.dataConstituicao = empresa.dataConstituicao;
		this.tipo = empresa.tipo;		
    this.email = empresa.email;
		this.logradouro = empresa.logradouro;
		this.numero = empresa.numero;
		this.complemento = empresa.complemento;
		this.cep = empresa.cep;
		this.bairro = empresa.bairro;
		this.cidade = empresa.cidade;
		this.uf = empresa.uf;
		this.fone = empresa.fone;
		this.contato = empresa.contato;
		this.codigoIbgeCidade = empresa.codigoIbgeCidade;
		this.codigoIbgeUf = empresa.codigoIbgeUf;
		this.logotipo = empresa.logotipo.toString();
		this.registrado = empresa.registrado == true ? 'S' : 'N';
		this.naturezaJuridica = empresa.naturezaJuridica;
		this.simei = empresa.simei == true ? 'S' : 'N';
		this.emailPagamento = empresa.emailPagamento;
    this.dataRegistro = empresa.dataRegistro;
    this.horaRegistro = empresa.horaRegistro;
  }

	EmpresaModel.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		razaoSocial = jsonDados['razaoSocial'];
		nomeFantasia = jsonDados['nomeFantasia'];
		cnpj = jsonDados['cnpj'];
		inscricaoEstadual = jsonDados['inscricaoEstadual'];
		inscricaoMunicipal = jsonDados['inscricaoMunicipal'];
		tipoRegime = jsonDados['tipoRegime'];
		crt = jsonDados['crt'];
		dataConstituicao = jsonDados['dataConstituicao'] != null ? DateTime.tryParse(jsonDados['dataConstituicao'].toString().substring(0,10)) : null;
		tipo = jsonDados['tipo'];
		email = jsonDados['email'];
		logradouro = jsonDados['logradouro'];
		numero = jsonDados['numero'];
		complemento = jsonDados['complemento'];
		cep = jsonDados['cep'];
		bairro = jsonDados['bairro'];
		cidade = jsonDados['cidade'];
		uf = jsonDados['uf'];
		fone = jsonDados['fone'];
		contato = jsonDados['contato'];
		codigoIbgeCidade = jsonDados['codigoIbgeCidade'];
		codigoIbgeUf = jsonDados['codigoIbgeUf'];
		logotipo = jsonDados['logotipo'];
		registrado = jsonDados['registrado'];
		naturezaJuridica = jsonDados['naturezaJuridica'];
		simei = jsonDados['simei'];
		emailPagamento = jsonDados['emailPagamento'];
		dataRegistro = jsonDados['dataRegistro'] != null ? DateTime.tryParse(jsonDados['dataRegistro'].toString().substring(0,10)) : null;
		horaRegistro = jsonDados['horaRegistro'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['razaoSocial'] = this.razaoSocial;
		jsonDados['nomeFantasia'] = this.nomeFantasia;
		jsonDados['cnpj'] = Biblioteca.removerMascara(this.cnpj);
		jsonDados['inscricaoEstadual'] = this.inscricaoEstadual;
		jsonDados['inscricaoMunicipal'] = this.inscricaoMunicipal;
		jsonDados['tipoRegime'] = setTipoRegime(this.tipoRegime);
		jsonDados['crt'] = setCrt(this.crt);
		jsonDados['dataConstituicao'] = this.dataConstituicao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataConstituicao) : null;
		jsonDados['tipo'] = setTipo(this.tipo);
		jsonDados['email'] = this.email;
		jsonDados['logradouro'] = this.logradouro;
		jsonDados['numero'] = this.numero;
		jsonDados['complemento'] = this.complemento;
		jsonDados['cep'] = Biblioteca.removerMascara(this.cep);
		jsonDados['bairro'] = this.bairro;
		jsonDados['cidade'] = this.cidade;
		jsonDados['uf'] = this.uf;
		jsonDados['fone'] = this.fone;
		jsonDados['contato'] = this.contato;
		jsonDados['codigoIbgeCidade'] = this.codigoIbgeCidade ?? 0;
		jsonDados['codigoIbgeUf'] = this.codigoIbgeUf ?? 0;
		jsonDados['logotipo'] = this.logotipo;
		jsonDados['registrado'] = this.registrado;
		jsonDados['naturezaJuridica'] = naturezaJuridica;
		jsonDados['simei'] = simei;
		jsonDados['emailPagamento'] = emailPagamento;
		jsonDados['dataRegistro'] = this.dataRegistro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataRegistro) : null;
		jsonDados['horaRegistro'] = horaRegistro;

		return jsonDados;
	}

  setTipoRegime(String tipoRegime) {
    switch (tipoRegime) {
      case '1-Lucro REAL':
        return '1';
        break;
      case '2-Lucro presumido':
        return '2';
        break;
      case '3-Simples nacional':
        return '3';
        break;
      default:
        return null;
    }
  }

  setCrt(String crt) {
    switch (crt) {
      case '1-Simples Nacional':
        return '1';
        break;
      case '2-Simples Nacional - excesso de sublimite da receita bruta':
        return '2';
        break;
      case '3-Regime Normal':
        return '3';
        break;
      default:
        return null;
    }
  }

  setTipo(String tipo) {
    switch (tipo) {
      case 'Matriz':
        return 'M';
        break;
      case 'Filial':
        return 'F';
        break;
      default:
        return null;
    }
  }

	String objetoEncodeJson(EmpresaModel objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}