/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [PDV_TIPO_PAGAMENTO] 
                                                                                
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

part 'pdv_tipo_pagamento_dao.g.dart';

@UseDao(tables: [
          PdvTipoPagamentos,
		])
class PdvTipoPagamentoDao extends DatabaseAccessor<AppDatabase> with _$PdvTipoPagamentoDaoMixin {
  final AppDatabase db;

  List<PdvTipoPagamento> listaPdvTipoPagamento; // será usada para popular a grid na janela do pdvTipoPagamento

  PdvTipoPagamentoDao(this.db) : super(db);

  Future<List<PdvTipoPagamento>> consultarLista() async {
    listaPdvTipoPagamento = await select(pdvTipoPagamentos).get();
    return listaPdvTipoPagamento;
  }

  Future<List<PdvTipoPagamento>> consultarListaFiltro(String campo, String valor) async {
    listaPdvTipoPagamento = await (customSelect("SELECT * FROM PDV_TIPO_PAGAMENTO WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { pdvTipoPagamentos }).map((row) {
                                  return PdvTipoPagamento.fromData(row.data, db);  
                                }).get());
    return listaPdvTipoPagamento;
  }

  Future<PdvTipoPagamento> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM PDV_TIPO_PAGAMENTO WHERE " + campo + " = '" + valor + "'", 
                                readsFrom: { pdvTipoPagamentos }).map((row) {
                                  return PdvTipoPagamento.fromData(row.data, db);  
                                }).getSingleOrNull());
  }

  Stream<List<PdvTipoPagamento>> observarLista() => select(pdvTipoPagamentos).watch();

  Future<PdvTipoPagamento> consultarObjeto(int pId) {
    return (select(pdvTipoPagamentos)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<PdvTipoPagamento> pObjeto) {
    return transaction(() async {
      final idInserido = await into(pdvTipoPagamentos).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<PdvTipoPagamento> pObjeto) {
    return transaction(() async {
      return update(pdvTipoPagamentos).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<PdvTipoPagamento> pObjeto) {
    return transaction(() async {
      return delete(pdvTipoPagamentos).delete(pObjeto);
    });    
  }

	static List<String> campos = <String>[
		'ID', 
		'CODIGO', 
		'DESCRICAO', 
		'GERA_PARCELAS', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Codigo', 
		'Descricao', 
		'Gera Parcelas', 
	];

  
}