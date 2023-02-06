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
  int? id;
  String? razaoSocial;
  String? nomeFantasia;
  String? cnpj;
  String? inscricaoEstadual;
  String? inscricaoMunicipal;
  String? tipoRegime;
  String? crt;
  DateTime? dataConstituicao;
  String? tipo;		
  String? email;
  String? logradouro;
  String? numero;
  String? complemento;
  String? cep;
  String? bairro;
  String? cidade;
  String? uf;
  String? fone;
  String? contato;
  int? codigoIbgeCidade;
  int? codigoIbgeUf;
  String? logotipo;
  String? registrado;
  String? naturezaJuridica;
  String? simei;
  String? emailPagamento;
  DateTime? dataRegistro;
  String? horaRegistro;

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
		razaoSocial = empresa.razaoSocial;
		nomeFantasia = empresa.nomeFantasia;
		cnpj = empresa.cnpj;
		inscricaoEstadual = empresa.inscricaoEstadual;
		inscricaoMunicipal = empresa.inscricaoMunicipal;
		tipoRegime = empresa.tipoRegime;
		crt = empresa.crt;
		dataConstituicao = empresa.dataConstituicao;
		tipo = empresa.tipo;		
    email = empresa.email;
		logradouro = empresa.logradouro;
		numero = empresa.numero;
		complemento = empresa.complemento;
		cep = empresa.cep;
		bairro = empresa.bairro;
		cidade = empresa.cidade;
		uf = empresa.uf;
		fone = empresa.fone;
		contato = empresa.contato;
		codigoIbgeCidade = empresa.codigoIbgeCidade;
		codigoIbgeUf = empresa.codigoIbgeUf;
		logotipo = empresa.logotipo.toString();
		registrado = empresa.registrado == true ? 'S' : 'N';
		naturezaJuridica = empresa.naturezaJuridica;
		simei = empresa.simei == true ? 'S' : 'N';
		emailPagamento = empresa.emailPagamento;
    dataRegistro = empresa.dataRegistro;
    horaRegistro = empresa.horaRegistro;
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
		dataConstituicao = Biblioteca.tratarDataJson(jsonDados['dataConstituicao']);
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
		dataRegistro = Biblioteca.tratarDataJson(jsonDados['dataRegistro']);
		horaRegistro = jsonDados['horaRegistro'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = <String, dynamic>{};

		jsonDados['id'] = id ?? 0;
		jsonDados['razaoSocial'] = razaoSocial;
		jsonDados['nomeFantasia'] = nomeFantasia;
		jsonDados['cnpj'] = Biblioteca.removerMascara(cnpj);
		jsonDados['inscricaoEstadual'] = inscricaoEstadual;
		jsonDados['inscricaoMunicipal'] = inscricaoMunicipal;
		jsonDados['tipoRegime'] = setTipoRegime(tipoRegime);
		jsonDados['crt'] = setCrt(crt);
		jsonDados['dataConstituicao'] = dataConstituicao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataConstituicao!) : null;
		jsonDados['tipo'] = setTipo(tipo);
		jsonDados['email'] = email;
		jsonDados['logradouro'] = logradouro;
		jsonDados['numero'] = numero;
		jsonDados['complemento'] = complemento;
		jsonDados['cep'] = Biblioteca.removerMascara(cep);
		jsonDados['bairro'] = bairro;
		jsonDados['cidade'] = cidade;
		jsonDados['uf'] = uf;
		jsonDados['fone'] = fone;
		jsonDados['contato'] = contato;
		jsonDados['codigoIbgeCidade'] = codigoIbgeCidade ?? 0;
		jsonDados['codigoIbgeUf'] = codigoIbgeUf ?? 0;
		jsonDados['logotipo'] = logotipo;
		jsonDados['registrado'] = registrado;
		jsonDados['naturezaJuridica'] = naturezaJuridica;
		jsonDados['simei'] = simei;
		jsonDados['emailPagamento'] = emailPagamento;
		jsonDados['dataRegistro'] = dataRegistro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataRegistro!) : null;
		jsonDados['horaRegistro'] = horaRegistro;

		return jsonDados;
	}

  setTipoRegime(String? tipoRegime) {
    switch (tipoRegime) {
      case '1-Lucro REAL':
        return '1';
      case '2-Lucro presumido':
        return '2';
      case '3-Simples nacional':
        return '3';
      default:
        return null;
    }
  }

  setCrt(String? crt) {
    switch (crt) {
      case '1-Simples Nacional':
        return '1';
      case '2-Simples Nacional - excesso de sublimite da receita bruta':
        return '2';
      case '3-Regime Normal':
        return '3';
      default:
        return null;
    }
  }

  setTipo(String? tipo) {
    switch (tipo) {
      case 'Matriz':
        return 'M';
      case 'Filial':
        return 'F';
      default:
        return null;
    }
  }

	String objetoEncodeJson() {
	  final jsonDados = toJson;
	  return json.encode(jsonDados);
	}
	
}