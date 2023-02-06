/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [PRODUTO_PROMOCAO] 
                                                                                
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

part 'produto_promocao_dao.g.dart';

@DriftAccessor(tables: [
          ProdutoPromocaos,
		])
class ProdutoPromocaoDao extends DatabaseAccessor<AppDatabase> with _$ProdutoPromocaoDaoMixin {
  final AppDatabase db;

  ProdutoPromocaoDao(this.db) : super(db);

  Future<List<ProdutoPromocao>> consultarLista() => select(produtoPromocaos).get();

  Future<List<ProdutoPromocao>> consultarListaFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM PRODUTO_PROMOCAO WHERE $campo like '%$valor%'", 
                                readsFrom: { produtoPromocaos }).map((row) {
                                  return ProdutoPromocao.fromData(row.data);  
                                }).get());
  }

  Stream<List<ProdutoPromocao>> observarLista() => select(produtoPromocaos).watch();

  Future<ProdutoPromocao?> consultarObjeto(int pId) {
    return (select(produtoPromocaos)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> ultimoId() async {
    final resultado = await customSelect("select MAX(ID) as ULTIMO from PRODUTO_PROMOCAO").getSingleOrNull();
    return resultado?.data["ULTIMO"] ?? 0;
  } 

  Future<int> inserir(ProdutoPromocao pObjeto) {
    return transaction(() async {
      final maxId = await ultimoId();
      pObjeto = pObjeto.copyWith(id: maxId + 1);
      final idInserido = await into(produtoPromocaos).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(ProdutoPromocao pObjeto) {
    return transaction(() async {
      return update(produtoPromocaos).replace(pObjeto);
    });    
  } 

  Future<int> excluir(ProdutoPromocao pObjeto) {
    return transaction(() async {
      return delete(produtoPromocaos).delete(pObjeto);
    });    
  }

  Future<void> sincronizar(ObjetoSincroniza objetoSincroniza) async {
    (delete(produtoPromocaos)..where((t) => t.id.isNotNull())).go();      
    var parsed = json.decode(objetoSincroniza.registros!) as List<dynamic>;
    for (var objetoJson in parsed) {
      final objetoDart = ProdutoPromocao.fromJson(objetoJson);
      into(produtoPromocaos).insertOnConflictUpdate(objetoDart);
    }
  }

  
}