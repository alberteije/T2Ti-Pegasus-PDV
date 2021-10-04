/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [PDV_VENDA_DETALHE] 
                                                                                
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

part 'pdv_venda_detalhe_dao.g.dart';

@UseDao(tables: [
          PdvVendaDetalhes,
          Produtos,
		])
class PdvVendaDetalheDao extends DatabaseAccessor<AppDatabase> with _$PdvVendaDetalheDaoMixin {
  final AppDatabase db;

  PdvVendaDetalheDao(this.db) : super(db);

  Future<List<PdvVendaDetalhe>> consultarLista() => select(pdvVendaDetalhes).get();

  Future<List<PdvVendaDetalhe>> consultarListaFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM PDV_VENDA_DETALHE WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { pdvVendaDetalhes }).map((row) {
                                  return PdvVendaDetalhe.fromData(row.data, db);  
                                }).get());
  }

  Stream<List<PdvVendaDetalhe>> observarLista() => select(pdvVendaDetalhes).watch();

  Future<List<VendaDetalhe>> consultarListaComProduto(int pId) {
    final consulta = select(pdvVendaDetalhes)
      .join([
        leftOuterJoin(produtos, produtos.id.equalsExp(pdvVendaDetalhes.idProduto)),
      ]);

    consulta.where(pdvVendaDetalhes.idPdvVendaCabecalho.equals(pId));

    return consulta.map((row) {
        final vendaDetalhe = row.readTableOrNull(pdvVendaDetalhes);
        final produto = row.readTableOrNull(produtos);

        return VendaDetalhe(pdvVendaDetalhe: vendaDetalhe, produto: produto);
      }).get();
  }

  Future<PdvVendaDetalhe> consultarObjeto(int pId) {
    return (select(pdvVendaDetalhes)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<PdvVendaDetalhe> pObjeto) {
    return transaction(() async {
      final idInserido = await into(pdvVendaDetalhes).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<PdvVendaDetalhe> pObjeto) {
    return transaction(() async {
      return update(pdvVendaDetalhes).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<PdvVendaDetalhe> pObjeto) {
    return transaction(() async {
      return delete(pdvVendaDetalhes).delete(pObjeto);
    });    
  }

  
}