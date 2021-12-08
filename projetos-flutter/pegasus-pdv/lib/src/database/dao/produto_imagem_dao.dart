/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [PRODUTO_IMAGEM] 
                                                                                
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

part 'produto_imagem_dao.g.dart';

@UseDao(tables: [
          ProdutoImagems,
		])
class ProdutoImagemDao extends DatabaseAccessor<AppDatabase> with _$ProdutoImagemDaoMixin {
  final AppDatabase db;

  ProdutoImagemDao(this.db) : super(db);

  List<ProdutoImagem> listaProdutoImagem = []; 
  
  Future<List<ProdutoImagem>> consultarLista() async {
    listaProdutoImagem = await select(produtoImagems).get();
    return listaProdutoImagem;
  }  

  Future<List<ProdutoImagem>> consultarListaFiltro(String campo, String valor) async {
    listaProdutoImagem = await (customSelect("SELECT * FROM PRODUTO_IMAGEM WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { produtoImagems }).map((row) {
                                  return ProdutoImagem.fromData(row.data, db);  
                                }).get());
    return listaProdutoImagem;
  }
    
  Future<ProdutoImagem?> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM PRODUTO_IMAGEM WHERE " + campo + " = '" + valor + "'", 
                                readsFrom: { produtoImagems }).map((row) {
                                  return ProdutoImagem.fromData(row.data, db);  
                                }).getSingleOrNull());
  }  
  
  Stream<List<ProdutoImagem>> observarLista() => select(produtoImagems).watch();

  Future<ProdutoImagem?> consultarObjeto(int pId) {
    return (select(produtoImagems)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<ProdutoImagem> pObjeto) {
    return transaction(() async {
      final idInserido = await into(produtoImagems).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<ProdutoImagem> pObjeto) {
    return transaction(() async {
      return update(produtoImagems).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<ProdutoImagem> pObjeto) {
    return transaction(() async {
      return delete(produtoImagems).delete(pObjeto);
    });    
  }

  
  
  static List<String> campos = <String>[
    'ID', 
    'IMAGEM', 
  ];

  static List<String> colunas = <String>[
    'Id', 
    '', 
  ];  
}