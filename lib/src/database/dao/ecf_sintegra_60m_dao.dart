/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [ECF_SINTEGRA_60M] 
                                                                                
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

part 'ecf_sintegra_60m_dao.g.dart';

@UseDao(tables: [
          EcfSintegra60Ms,
		])
class EcfSintegra60MDao extends DatabaseAccessor<AppDatabase> with _$EcfSintegra60MDaoMixin {
  final AppDatabase db;

  EcfSintegra60MDao(this.db) : super(db);

  Future<List<EcfSintegra60M>> consultarLista() => select(ecfSintegra60Ms).get();

  Future<List<EcfSintegra60M>> consultarListaFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM ECF_SINTEGRA_60M WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { ecfSintegra60Ms }).map((row) {
                                  return EcfSintegra60M.fromData(row.data, db);  
                                }).get());
  }

  Stream<List<EcfSintegra60M>> observarLista() => select(ecfSintegra60Ms).watch();

  Future<EcfSintegra60M> consultarObjeto(int pId) {
    return (select(ecfSintegra60Ms)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<EcfSintegra60M> pObjeto) {
    return transaction(() async {
      final idInserido = await into(ecfSintegra60Ms).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<EcfSintegra60M> pObjeto) {
    return transaction(() async {
      return update(ecfSintegra60Ms).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<EcfSintegra60M> pObjeto) {
    return transaction(() async {
      return delete(ecfSintegra60Ms).delete(pObjeto);
    });    
  }

  
}