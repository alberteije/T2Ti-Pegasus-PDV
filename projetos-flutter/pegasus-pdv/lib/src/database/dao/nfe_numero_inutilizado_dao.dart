/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [NFE_NUMERO_INUTILIZADO] 
                                                                                
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

part 'nfe_numero_inutilizado_dao.g.dart';

@UseDao(tables: [
          NfeNumeroInutilizados,
		])
class NfeNumeroInutilizadoDao extends DatabaseAccessor<AppDatabase> with _$NfeNumeroInutilizadoDaoMixin {
  final AppDatabase db;

  NfeNumeroInutilizadoDao(this.db) : super(db);

  Future<List<NfeNumeroInutilizado>> consultarLista() => select(nfeNumeroInutilizados).get();

  Future<List<NfeNumeroInutilizado>> consultarListaFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM NFE_NUMERO_INUTILIZADO WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { nfeNumeroInutilizados }).map((row) {
                                  return NfeNumeroInutilizado.fromData(row.data, db);  
                                }).get());
  }

  Stream<List<NfeNumeroInutilizado>> observarLista() => select(nfeNumeroInutilizados).watch();

  Future<NfeNumeroInutilizado> consultarObjeto(int pId) {
    return (select(nfeNumeroInutilizados)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<NfeNumeroInutilizado> pObjeto) {
    return transaction(() async {
      final idInserido = await into(nfeNumeroInutilizados).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<NfeNumeroInutilizado> pObjeto) {
    return transaction(() async {
      return update(nfeNumeroInutilizados).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<NfeNumeroInutilizado> pObjeto) {
    return transaction(() async {
      return delete(nfeNumeroInutilizados).delete(pObjeto);
    });    
  }

  
}