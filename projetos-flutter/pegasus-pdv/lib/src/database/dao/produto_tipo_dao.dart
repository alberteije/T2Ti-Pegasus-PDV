/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [PRODUTO_TIPO] 
                                                                                
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

part 'produto_tipo_dao.g.dart';

@DriftAccessor(tables: [
          ProdutoTipos,
		])
class ProdutoTipoDao extends DatabaseAccessor<AppDatabase> with _$ProdutoTipoDaoMixin {
  final AppDatabase db;

  ProdutoTipoDao(this.db) : super(db);

  List<ProdutoTipo>? listaProdutoTipo; 
  
  Future<List<ProdutoTipo>?> consultarLista() async {
    listaProdutoTipo = await select(produtoTipos).get();
    return listaProdutoTipo;
  }  

  Future<List<ProdutoTipo>?> consultarListaFiltro(String campo, String valor) async {
    listaProdutoTipo = await (customSelect("SELECT * FROM PRODUTO_TIPO WHERE $campo like '%$valor%'", 
                                readsFrom: { produtoTipos }).map((row) {
                                  return ProdutoTipo.fromData(row.data);  
                                }).get());
    return listaProdutoTipo;
  }
    
  Future<ProdutoTipo?> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM PRODUTO_TIPO WHERE $campo = '$valor'", 
                                readsFrom: { produtoTipos }).map((row) {
                                  return ProdutoTipo.fromData(row.data);  
                                }).getSingleOrNull());
  }  
  
  Stream<List<ProdutoTipo>> observarLista() => select(produtoTipos).watch();

  Future<ProdutoTipo?> consultarObjeto(int pId) {
    return (select(produtoTipos)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> ultimoId() async {
    final resultado = await customSelect("select MAX(ID) as ULTIMO from PRODUTO_TIPO").getSingleOrNull();
    return resultado?.data["ULTIMO"] ?? 0;
  } 

  Future<int> inserir(ProdutoTipo pObjeto) {
    return transaction(() async {
      final maxId = await ultimoId();
      pObjeto = pObjeto.copyWith(id: maxId + 1);
      final idInserido = await into(produtoTipos).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(ProdutoTipo pObjeto) {
    return transaction(() async {
      return update(produtoTipos).replace(pObjeto);
    });    
  } 

  Future<int> excluir(ProdutoTipo pObjeto) {
    return transaction(() async {
      return delete(produtoTipos).delete(pObjeto);
    });    
  }

  Future<void> sincronizar(ObjetoSincroniza objetoSincroniza) async {
    (delete(produtoTipos)..where((t) => t.id.isNotNull())).go();      
    var parsed = json.decode(objetoSincroniza.registros!) as List<dynamic>;
    for (var objetoJson in parsed) {
      final objetoDart = ProdutoTipo.fromJson(objetoJson);
      into(produtoTipos).insertOnConflictUpdate(objetoDart);
    }
  }
  
  
  static List<String> campos = <String>[
    'ID', 
    'CODIGO', 
    'DESCRICAO', 
  ];

  static List<String> colunas = <String>[
    'Id', 
    'Código', 
    'Descrição', 
  ];  
}