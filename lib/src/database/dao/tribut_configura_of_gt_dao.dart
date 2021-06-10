/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [TRIBUT_CONFIGURA_OF_GT] 
                                                                                
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

part 'tribut_configura_of_gt_dao.g.dart';

@UseDao(tables: [
          TributConfiguraOfGts,
          TributIcmsUfs,
		])
class TributConfiguraOfGtDao extends DatabaseAccessor<AppDatabase> with _$TributConfiguraOfGtDaoMixin {
  final AppDatabase db;

  TributConfiguraOfGtDao(this.db) : super(db);

  Future<List<TributConfiguraOfGt>> consultarLista() => select(tributConfiguraOfGts).get();

  Future<List<TributConfiguraOfGt>> consultarListaFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM TRIBUT_CONFIGURA_OF_GT WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { tributConfiguraOfGts }).map((row) {
                                  return TributConfiguraOfGt.fromData(row.data, db);  
                                }).get());
  }

  Stream<List<TributConfiguraOfGt>> observarLista() => select(tributConfiguraOfGts).watch();

  Future<TributConfiguraOfGt> consultarObjeto(int pId) {
    return (select(tributConfiguraOfGts)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<TributConfiguraOfGt> pObjeto, List<TributIcmsUf> listaTributIcmsUf) {
    return transaction(() async {
      final idInserido = await into(tributConfiguraOfGts).insert(pObjeto);
      inserirFilhos(pObjeto as TributConfiguraOfGt, listaTributIcmsUf);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<TributConfiguraOfGt> pObjeto, List<TributIcmsUf> listaTributIcmsUf) {
    return transaction(() async {
      excluirFilhos(pObjeto as TributConfiguraOfGt);
      inserirFilhos(pObjeto as TributConfiguraOfGt, listaTributIcmsUf);
      return update(tributConfiguraOfGts).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<TributConfiguraOfGt> pObjeto) {
    return transaction(() async {
      excluirFilhos(pObjeto as TributConfiguraOfGt);
      return delete(tributConfiguraOfGts).delete(pObjeto);
    });    
  }

  void inserirFilhos(TributConfiguraOfGt tributConfiguraOfGt, List<TributIcmsUf> listaTributIcmsUf) {
    for (var objeto in listaTributIcmsUf) {
      if (objeto.id == null) {
        objeto = objeto.copyWith(idTributConfiguraOfGt: tributConfiguraOfGt.id);
      }
      into(tributIcmsUfs).insert(objeto);  
    }
  }
  
  void excluirFilhos(TributConfiguraOfGt tributConfiguraOfGt) {
    (delete(tributIcmsUfs)..where((t) => t.idTributConfiguraOfGt.equals(tributConfiguraOfGt.id))).go();
  }
}