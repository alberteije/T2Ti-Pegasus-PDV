/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [PRODUTO_FICHA_TECNICA] 
                                                                                
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

part 'produto_ficha_tecnica_dao.g.dart';

@UseDao(tables: [
          ProdutoFichaTecnicas,
		])
class ProdutoFichaTecnicaDao extends DatabaseAccessor<AppDatabase> with _$ProdutoFichaTecnicaDaoMixin {
  final AppDatabase db;

  ProdutoFichaTecnicaDao(this.db) : super(db);

  Future<List<ProdutoFichaTecnica>> consultarLista() => select(produtoFichaTecnicas).get();

  Future<List<ProdutoFichaTecnica>> consultarListaFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM PRODUTO_FICHA_TECNICA WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { produtoFichaTecnicas }).map((row) {
                                  return ProdutoFichaTecnica.fromData(row.data, db);  
                                }).get());
  }

  Stream<List<ProdutoFichaTecnica>> observarLista() => select(produtoFichaTecnicas).watch();

  Future<ProdutoFichaTecnica> consultarObjeto(int pId) {
    return (select(produtoFichaTecnicas)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<ProdutoFichaTecnica> pObjeto) {
    return transaction(() async {
      final idInserido = await into(produtoFichaTecnicas).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<ProdutoFichaTecnica> pObjeto) {
    return transaction(() async {
      return update(produtoFichaTecnicas).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<ProdutoFichaTecnica> pObjeto) {
    return transaction(() async {
      return delete(produtoFichaTecnicas).delete(pObjeto);
    });    
  }

  
}