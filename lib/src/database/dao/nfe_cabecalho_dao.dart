/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [NFE_CABECALHO] 
                                                                                
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

part 'nfe_cabecalho_dao.g.dart';

@UseDao(tables: [
          NfeCabecalhos,
          NfeDestinatarios,
          NfeDetalhes,
          NfeDetalheImpostoIcmss,
          NfeDetalheImpostoPiss,
          NfeDetalheImpostoCofinss,
          NfeInformacaoPagamentos,
		])
class NfeCabecalhoDao extends DatabaseAccessor<AppDatabase> with _$NfeCabecalhoDaoMixin {
  final AppDatabase db;

  NfeCabecalhoDao(this.db) : super(db);

  Future<List<NfeCabecalho>> consultarLista() => select(nfeCabecalhos).get();

  Future<List<NfeCabecalho>> consultarListaFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM NFE_CABECALHO WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { nfeCabecalhos }).map((row) {
                                  return NfeCabecalho.fromData(row.data, db);  
                                }).get());
  }

  Stream<List<NfeCabecalho>> observarLista() => select(nfeCabecalhos).watch();

  Future<NfeCabecalho> consultarObjeto(int pId) {
    return (select(nfeCabecalhos)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(NfeCabecalhoMontado nfeCabecalhoMontado) {
    return transaction(() async {
      final idInserido = await into(nfeCabecalhos).insert(nfeCabecalhoMontado.nfeCabecalho);
      await inserirFilhos(nfeCabecalhoMontado, idInserido);
      await db.nfeNumeroDao.atualizarNumero();
      return idInserido;
    });    
  } 

  Future<bool> alterar(NfeCabecalhoMontado nfeCabecalhoMontado) {
    return transaction(() async {
      return update(nfeCabecalhos).replace(nfeCabecalhoMontado.nfeCabecalho);
    });    
  } 

  Future<void> inserirFilhos(NfeCabecalhoMontado nfeCabecalhoMontado, int idMestre) async {
    nfeCabecalhoMontado.nfeDestinatario = nfeCabecalhoMontado.nfeDestinatario.copyWith(idNfeCabecalho: idMestre);
    await into(nfeDestinatarios).insert(nfeCabecalhoMontado.nfeDestinatario);  

    for (var pagamento in nfeCabecalhoMontado.listaNfeInformacaoPagamento) {
      pagamento = pagamento.copyWith(idNfeCabecalho: idMestre);
      await into(nfeInformacaoPagamentos).insert(pagamento);  
    }

    for (var detalhe in nfeCabecalhoMontado.listaNfeDetalheMontado) {
      detalhe.nfeDetalhe = detalhe.nfeDetalhe.copyWith(idNfeCabecalho: idMestre);
      final idDetalhe = await into(nfeDetalhes).insert(detalhe.nfeDetalhe);  
      detalhe.nfeDetalheImpostoIcms = detalhe.nfeDetalheImpostoIcms.copyWith(idNfeDetalhe: idDetalhe);
      await into(nfeDetalheImpostoIcmss).insert(detalhe.nfeDetalheImpostoIcms);  
      detalhe.nfeDetalheImpostoPis = detalhe.nfeDetalheImpostoPis.copyWith(idNfeDetalhe: idDetalhe);
      await into(nfeDetalheImpostoPiss).insert(detalhe.nfeDetalheImpostoPis);  
      detalhe.nfeDetalheImpostoCofins = detalhe.nfeDetalheImpostoCofins.copyWith(idNfeDetalhe: idDetalhe);
      await into(nfeDetalheImpostoCofinss).insert(detalhe.nfeDetalheImpostoCofins);  
    }
  }
  
}