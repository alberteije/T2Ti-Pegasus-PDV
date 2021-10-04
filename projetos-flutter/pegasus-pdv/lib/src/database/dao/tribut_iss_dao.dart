/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [TRIBUT_ISS] 
                                                                                
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

part 'tribut_iss_dao.g.dart';

@UseDao(tables: [
          TributIsss,
		])
class TributIssDao extends DatabaseAccessor<AppDatabase> with _$TributIssDaoMixin {
  final AppDatabase db;

  TributIssDao(this.db) : super(db);

  Future<List<TributIss>> consultarLista() => select(tributIsss).get();

  Future<List<TributIss>> consultarListaFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM TRIBUT_ISS WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { tributIsss }).map((row) {
                                  return TributIss.fromData(row.data, db);  
                                }).get());
  }

  Stream<List<TributIss>> observarLista() => select(tributIsss).watch();

  Future<TributIss> consultarObjeto(int pId) {
    return (select(tributIsss)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<TributIss> pObjeto) {
    return transaction(() async {
      final idInserido = await into(tributIsss).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<TributIss> pObjeto) {
    return transaction(() async {
      return update(tributIsss).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<TributIss> pObjeto) {
    return transaction(() async {
      return delete(tributIsss).delete(pObjeto);
    });    
  }

  
}