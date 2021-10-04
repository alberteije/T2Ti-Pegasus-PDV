/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [NFCE_PLANO_PAGAMENTO] 
                                                                                
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

part 'nfce_plano_pagamento_dao.g.dart';

@UseDao(tables: [
          NfcePlanoPagamentos,
		])
class NfcePlanoPagamentoDao extends DatabaseAccessor<AppDatabase> with _$NfcePlanoPagamentoDaoMixin {
  final AppDatabase db;

  NfcePlanoPagamentoDao(this.db) : super(db);

  Future<List<NfcePlanoPagamento>> consultarLista() => select(nfcePlanoPagamentos).get();

  Future<List<NfcePlanoPagamento>> consultarListaFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM NFCE_PLANO_PAGAMENTO WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { nfcePlanoPagamentos }).map((row) {
                                  return NfcePlanoPagamento.fromData(row.data, db);  
                                }).get());
  }

  Stream<List<NfcePlanoPagamento>> observarLista() => select(nfcePlanoPagamentos).watch();

  Future<NfcePlanoPagamento> consultarObjeto(int pId) {
    return (select(nfcePlanoPagamentos)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  // retorna um registro caso a data seja maior ou igual ao dia de hoje
  Future<NfcePlanoPagamento> consultarPlanoAtivo() {
    return (select(nfcePlanoPagamentos)
    ..where((t) => t.dataPlanoExpira.isBiggerOrEqualValue(DateTime.now()))
    ..where((t) => t.statusPagamento.equals('3')) //3-pago
    ).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<NfcePlanoPagamento> pObjeto) {
    return transaction(() async {
      final idInserido = await into(nfcePlanoPagamentos).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<NfcePlanoPagamento> pObjeto) {
    return transaction(() async {
      return update(nfcePlanoPagamentos).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<NfcePlanoPagamento> pObjeto) {
    return transaction(() async {
      return delete(nfcePlanoPagamentos).delete(pObjeto);
    });    
  }

  
}