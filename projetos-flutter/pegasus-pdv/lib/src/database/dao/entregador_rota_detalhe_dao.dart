/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [ENTREGADOR_ROTA_DETALHE] 
                                                                                
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

part 'entregador_rota_detalhe_dao.g.dart';

@UseDao(tables: [
          EntregadorRotaDetalhes,
		])
class EntregadorRotaDetalheDao extends DatabaseAccessor<AppDatabase> with _$EntregadorRotaDetalheDaoMixin {
  final AppDatabase db;

  EntregadorRotaDetalheDao(this.db) : super(db);

  Future<List<EntregadorRotaDetalhe>?> consultarLista() => select(entregadorRotaDetalhes).get();

  Future<List<EntregadorRotaDetalhe>?> consultarListaFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM ENTREGADOR_ROTA_DETALHE WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { entregadorRotaDetalhes }).map((row) {
                                  return EntregadorRotaDetalhe.fromData(row.data, db);  
                                }).get());
  }

  Future<EntregadorRotaDetalhe?> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM ENTREGADOR_ROTA_DETALHE WHERE " + campo + " = '" + valor + "'", 
                                readsFrom: { entregadorRotaDetalhes }).map((row) {
                                  return EntregadorRotaDetalhe.fromData(row.data, db);  
                                }).getSingleOrNull());
  }  
  
  Stream<List<EntregadorRotaDetalhe>> observarLista() => select(entregadorRotaDetalhes).watch();

  Future<EntregadorRotaDetalhe?> consultarObjeto(int pId) {
    return (select(entregadorRotaDetalhes)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<EntregadorRotaDetalhe> pObjeto) {
    return transaction(() async {
      final idInserido = await into(entregadorRotaDetalhes).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<EntregadorRotaDetalhe> pObjeto) {
    return transaction(() async {
      return update(entregadorRotaDetalhes).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<EntregadorRotaDetalhe> pObjeto) {
    return transaction(() async {
      return delete(entregadorRotaDetalhes).delete(pObjeto);
    });    
  }

  
}