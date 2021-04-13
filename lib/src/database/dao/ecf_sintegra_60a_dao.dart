/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [ECF_SINTEGRA_60A] 
                                                                                
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

part 'ecf_sintegra_60a_dao.g.dart';

@UseDao(tables: [
          EcfSintegra60As,
		])
class EcfSintegra60ADao extends DatabaseAccessor<AppDatabase> with _$EcfSintegra60ADaoMixin {
  final AppDatabase db;

  EcfSintegra60ADao(this.db) : super(db);

  Future<List<EcfSintegra60A>> consultarLista() => select(ecfSintegra60As).get();

  Future<List<EcfSintegra60A>> consultarListaFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM ECF_SINTEGRA_60A WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { ecfSintegra60As }).map((row) {
                                  return EcfSintegra60A.fromData(row.data, db);  
                                }).get());
  }

  Stream<List<EcfSintegra60A>> observarLista() => select(ecfSintegra60As).watch();

  Future<EcfSintegra60A> consultarObjeto(int pId) {
    return (select(ecfSintegra60As)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<EcfSintegra60A> pObjeto) {
    return transaction(() async {
      final idInserido = await into(ecfSintegra60As).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<EcfSintegra60A> pObjeto) {
    return transaction(() async {
      return update(ecfSintegra60As).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<EcfSintegra60A> pObjeto) {
    return transaction(() async {
      return delete(ecfSintegra60As).delete(pObjeto);
    });    
  }

  
}