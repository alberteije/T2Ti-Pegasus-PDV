/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [PDV_FECHAMENTO] 
                                                                                
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

part 'pdv_fechamento_dao.g.dart';

@UseDao(tables: [
          PdvFechamentos,
		])
class PdvFechamentoDao extends DatabaseAccessor<AppDatabase> with _$PdvFechamentoDaoMixin {
  final AppDatabase db;

  PdvFechamentoDao(this.db) : super(db);

  Future<List<PdvFechamento>> consultarLista() => select(pdvFechamentos).get();

  Future<List<PdvFechamento>> consultarListaFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM PDV_FECHAMENTO WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { pdvFechamentos }).map((row) {
                                  return PdvFechamento.fromData(row.data, db);  
                                }).get());
  }

  Future<List<PdvFechamento>> consultarListaMovimento(int idMovimento) async {
    return (customSelect("SELECT * FROM PDV_FECHAMENTO WHERE ID_PDV_MOVIMENTO= '" + idMovimento.toString() + "'", 
                                readsFrom: { pdvFechamentos }).map((row) {
                                  return PdvFechamento.fromData(row.data, db);  
                                }).get());
  }

  Stream<List<PdvFechamento>> observarLista() => select(pdvFechamentos).watch();

  Future<PdvFechamento> consultarObjeto(int pId) {
    return (select(pdvFechamentos)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<PdvFechamento> pObjeto) {
    return transaction(() async {
      final idInserido = await into(pdvFechamentos).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<PdvFechamento> pObjeto) {
    return transaction(() async {
      return update(pdvFechamentos).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<PdvFechamento> pObjeto) {
    return transaction(() async {
      return delete(pdvFechamentos).delete(pObjeto);
    });    
  }

  
}