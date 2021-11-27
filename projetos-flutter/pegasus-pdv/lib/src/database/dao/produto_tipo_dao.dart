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
import 'package:moor/moor.dart';

import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

part 'produto_tipo_dao.g.dart';

@UseDao(tables: [
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
    listaProdutoTipo = await (customSelect("SELECT * FROM PRODUTO_TIPO WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { produtoTipos }).map((row) {
                                  return ProdutoTipo.fromData(row.data, db);  
                                }).get());
    return listaProdutoTipo;
  }
    
  Future<ProdutoTipo?> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM PRODUTO_TIPO WHERE " + campo + " = '" + valor + "'", 
                                readsFrom: { produtoTipos }).map((row) {
                                  return ProdutoTipo.fromData(row.data, db);  
                                }).getSingleOrNull());
  }  
  
  Stream<List<ProdutoTipo>> observarLista() => select(produtoTipos).watch();

  Future<ProdutoTipo?> consultarObjeto(int pId) {
    return (select(produtoTipos)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<ProdutoTipo> pObjeto) {
    return transaction(() async {
      final idInserido = await into(produtoTipos).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<ProdutoTipo> pObjeto) {
    return transaction(() async {
      return update(produtoTipos).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<ProdutoTipo> pObjeto) {
    return transaction(() async {
      return delete(produtoTipos).delete(pObjeto);
    });    
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