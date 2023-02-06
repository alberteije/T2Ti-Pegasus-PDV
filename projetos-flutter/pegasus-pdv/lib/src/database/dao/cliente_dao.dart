/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [CLIENTE] 
                                                                                
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

import 'package:drift/drift.dart';

import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';
import 'package:pegasus_pdv/src/model/model.dart';

part 'cliente_dao.g.dart';

@DriftAccessor(tables: [
          Clientes,
		])
class ClienteDao extends DatabaseAccessor<AppDatabase> with _$ClienteDaoMixin {
  final AppDatabase db;

  List<Cliente>? listaCliente; // será usada para popular a grid na janela do cliente

  ClienteDao(this.db) : super(db);

  Future<List<Cliente>?> consultarLista() async {
    listaCliente = await select(clientes).get();
    aplicarDomains();
    return listaCliente;
  }

  Future<List<Cliente>?> consultarListaFiltro(String campo, String valor) async {
    listaCliente = await (customSelect("SELECT * FROM CLIENTE WHERE $campo like '%$valor%'", 
                                readsFrom: { clientes }).map((row) {
                                  return Cliente.fromData(row.data);  
                                }).get());
    aplicarDomains();
    return listaCliente;
  }

  Stream<List<Cliente>> observarLista() => select(clientes).watch();

  Future<Cliente?> consultarObjeto(int pId) {
    return (select(clientes)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<Cliente?> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM CLIENTE WHERE $campo = '$valor'", 
                                readsFrom: { clientes }).map((row) {
                                  return Cliente.fromData(row.data);  
                                }).getSingleOrNull());
  }  

  Future<int> ultimoId() async {
    final resultado = await customSelect("select MAX(ID) as ULTIMO from CLIENTE").getSingleOrNull();
    return resultado?.data["ULTIMO"] ?? 0;
  } 

  Future<int> inserir(Cliente pObjeto) {
    return transaction(() async {
      final cliente = removerDomains(pObjeto);
      final maxId = await ultimoId();
      pObjeto = pObjeto.copyWith(id: maxId + 1);
      final idInserido = await into(clientes).insert(cliente);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Cliente pObjeto) {
    return transaction(() async {
      final cliente = removerDomains(pObjeto);
      return update(clientes).replace(cliente);
    });    
  } 

  Future<int> excluir(Cliente pObjeto) {
    return transaction(() async {
      return delete(clientes).delete(pObjeto);
    });    
  }

  Future<void> sincronizar(ObjetoSincroniza objetoSincroniza) async {
    (delete(clientes)..where((t) => t.id.isNotNull())).go();      
    var parsed = json.decode(objetoSincroniza.registros!) as List<dynamic>;
    for (var objetoJson in parsed) {
      final objetoDart = Cliente.fromJson(objetoJson);
      into(clientes).insertOnConflictUpdate(objetoDart);
    }
  }

  Cliente removerDomains(Cliente cliente) {
    if (cliente.fidelidadeAviso!= null) {
      cliente = 
      cliente.copyWith(
        fidelidadeAviso: cliente.fidelidadeAviso!.substring(0,1)
      );
    }
    return cliente;
  }

  void aplicarDomains() {
    for (var i = 0; i < listaCliente!.length; i++) {
      switch (listaCliente![i].fidelidadeAviso) {
        case 'Q' :
          listaCliente![i] = listaCliente![i].copyWith(
            fidelidadeAviso: 'Quantidade',);
          break;
        case 'M' :
          listaCliente![i] = listaCliente![i].copyWith(
            fidelidadeAviso: 'Valor',);
          break;
        default:
      }       
    }
  }

	static List<String> campos = <String>[
		'ID', 
		'NOME', 
		'FANTASIA', 
		'EMAIL', 
		'URL', 
		'CPF_CNPJ', 
		'RG', 
		'ORGAO_RG', 
		'DATA_EMISSAO_RG', 
		'SEXO', 
		'INSCRICAO_ESTADUAL', 
		'INSCRICAO_MUNICIPAL', 
		'TIPO_PESSOA', 
		'DATA_CADASTRO', 
		'LOGRADOURO', 
		'NUMERO', 
		'COMPLEMENTO', 
		'CEP', 
		'BAIRRO', 
		'CIDADE', 
		'UF', 
		'TELEFONE', 
		'CELULAR', 
		'CONTATO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Nome', 
		'Fantasia', 
		'Email', 
		'Url', 
		'Cpf Cnpj', 
		'Rg', 
		'Orgao Rg', 
		'Data Emissao Rg', 
		'Sexo', 
		'Inscricao Estadual', 
		'Inscricao Municipal', 
		'Tipo Pessoa', 
		'Data Cadastro', 
		'Logradouro', 
		'Numero', 
		'Complemento', 
		'Cep', 
		'Bairro', 
		'Cidade', 
		'Uf', 
		'Telefone', 
		'Celular', 
		'Contato', 
	];

  
}