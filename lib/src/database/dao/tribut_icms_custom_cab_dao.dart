/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [TRIBUT_ICMS_CUSTOM_CAB] 
                                                                                
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

part 'tribut_icms_custom_cab_dao.g.dart';

@UseDao(tables: [
          TributIcmsCustomCabs,
          TributIcmsCustomDets,
		])
class TributIcmsCustomCabDao extends DatabaseAccessor<AppDatabase> with _$TributIcmsCustomCabDaoMixin {
  final AppDatabase db;

  TributIcmsCustomCabDao(this.db) : super(db);

  Future<List<TributIcmsCustomCab>> consultarLista() => select(tributIcmsCustomCabs).get();

  Future<List<TributIcmsCustomCab>> consultarListaFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM TRIBUT_ICMS_CUSTOM_CAB WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { tributIcmsCustomCabs }).map((row) {
                                  return TributIcmsCustomCab.fromData(row.data, db);  
                                }).get());
  }

  Stream<List<TributIcmsCustomCab>> observarLista() => select(tributIcmsCustomCabs).watch();

  Future<TributIcmsCustomCab> consultarObjeto(int pId) {
    return (select(tributIcmsCustomCabs)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<TributIcmsCustomCab> pObjeto, List<TributIcmsCustomDet> listaTributIcmsCustomDet) {
    return transaction(() async {
      final idInserido = await into(tributIcmsCustomCabs).insert(pObjeto);
      await inserirFilhos(pObjeto as TributIcmsCustomCab, listaTributIcmsCustomDet);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<TributIcmsCustomCab> pObjeto, List<TributIcmsCustomDet> listaTributIcmsCustomDet) {
    return transaction(() async {
      await excluirFilhos(pObjeto as TributIcmsCustomCab);
      await inserirFilhos(pObjeto as TributIcmsCustomCab, listaTributIcmsCustomDet);
      return update(tributIcmsCustomCabs).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<TributIcmsCustomCab> pObjeto) {
    return transaction(() async {
      await excluirFilhos(pObjeto as TributIcmsCustomCab);
      return delete(tributIcmsCustomCabs).delete(pObjeto);
    });    
  }

  Future<void> inserirFilhos(TributIcmsCustomCab tributIcmsCustomCab, List<TributIcmsCustomDet> listaTributIcmsCustomDet) async {
    for (var objeto in listaTributIcmsCustomDet) {
      if (objeto.id == null) {
        objeto = objeto.copyWith(idTributIcmsCustomCab: tributIcmsCustomCab.id);
      }
      await into(tributIcmsCustomDets).insert(objeto);  
    }
  }
  
  Future<void> excluirFilhos(TributIcmsCustomCab tributIcmsCustomCab) async {
    await (delete(tributIcmsCustomDets)..where((t) => t.idTributIcmsCustomCab.equals(tributIcmsCustomCab.id))).go();
  }
}