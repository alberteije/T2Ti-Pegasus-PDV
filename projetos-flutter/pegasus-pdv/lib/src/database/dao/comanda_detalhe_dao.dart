/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [COMANDA_DETALHE] 
                                                                                
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

part 'comanda_detalhe_dao.g.dart';

@UseDao(tables: [
          ComandaDetalhes,
          ComandaDetalheComplementos,
          Produtos,
		])
class ComandaDetalheDao extends DatabaseAccessor<AppDatabase> with _$ComandaDetalheDaoMixin {
  final AppDatabase db;

  ComandaDetalheDao(this.db) : super(db);

  Future<List<ComandaDetalhe>?> consultarLista() => select(comandaDetalhes).get();

  Future<List<ComandaDetalhe>?> consultarListaFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM COMANDA_DETALHE WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { comandaDetalhes }).map((row) {
                                  return ComandaDetalhe.fromData(row.data, db);  
                                }).get());
  }

  Future<ComandaDetalhe?> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM COMANDA_DETALHE WHERE " + campo + " = '" + valor + "'", 
                                readsFrom: { comandaDetalhes }).map((row) {
                                  return ComandaDetalhe.fromData(row.data, db);  
                                }).getSingleOrNull());
  }  
  
  Future<List<ComandaDetalheMontado>?> consultarListaMontado(int idComanda) async {
    final List<ComandaDetalheMontado> listaComandaDetalheMontado = [];

    final listaComandaDetalhe = await (customSelect("SELECT * FROM COMANDA_DETALHE WHERE ID_COMANDA = '"  + idComanda.toString() + "'", 
                                readsFrom: { comandaDetalhes }).map((row) {
                                  return ComandaDetalhe.fromData(row.data, db);  
                                }).get());

    for (var comandaDetalhe in listaComandaDetalhe) {
      var listaComandaDetalheComplemento = await (customSelect("SELECT * FROM COMANDA_DETALHE_COMPLEMENTO WHERE ID_COMANDA_DETALHE = '"  + comandaDetalhe.id.toString() + "'", 
                                readsFrom: { comandaDetalheComplementos }).map((row) {
                                  return ComandaDetalheComplemento.fromData(row.data, db);  
                                }).get());
      ComandaDetalheMontado comandaDetalheMontado = ComandaDetalheMontado(
        comandaDetalhe: comandaDetalhe,
        produtoMontado: await db.produtoDao.consultarObjetoMontado(pId: comandaDetalhe.idProduto!),
        listaComandaDetalheComplemento: listaComandaDetalheComplemento,
      );
      listaComandaDetalheMontado.add(comandaDetalheMontado);
    }

    return listaComandaDetalheMontado;
  }

  Stream<List<ComandaDetalhe>> observarLista() => select(comandaDetalhes).watch();

  Future<ComandaDetalhe?> consultarObjeto(int pId) {
    return (select(comandaDetalhes)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<ComandaDetalhe> pObjeto) {
    return transaction(() async {
      final idInserido = await into(comandaDetalhes).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<ComandaDetalhe> pObjeto) {
    return transaction(() async {
      return update(comandaDetalhes).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<ComandaDetalhe> pObjeto) {
    return transaction(() async {
      return delete(comandaDetalhes).delete(pObjeto);
    });    
  }

  
}