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

  List<NfeCabecalho> listaNfeCabecalho; 

  Future<List<NfeCabecalho>> consultarLista() async {
    listaNfeCabecalho = await select(nfeCabecalhos).get();
    return listaNfeCabecalho;
  }

  Future<List<NfeCabecalho>> consultarListaFiltro(String campo, String valor) async {
    listaNfeCabecalho = await (customSelect("SELECT * FROM NFE_CABECALHO WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { nfeCabecalhos }).map((row) {
                                  return NfeCabecalho.fromData(row.data, db);  
                                }).get());
    return listaNfeCabecalho;
  }

  Future<List<NfeCabecalho>> consultarNotasContingenciadasParaInutilizacao() async {
    // retorna a lista de notas que foram contingenciadas, já foram autorizadas, mas por algum erro de comunicação
    // a nota original não teve seu número inutilizado ou cancelado
    final sql = "select *, ID_PDV_VENDA_CABECALHO as idvenda from NFE_CABECALHO where STATUS_NOTA='9' "
                " and idvenda in (select ID_PDV_VENDA_CABECALHO from NFE_CABECALHO where status_nota='4' and ID_PDV_VENDA_CABECALHO=idvenda)";
    listaNfeCabecalho = await (customSelect(sql, 
                                readsFrom: { nfeCabecalhos }).map((row) {
                                  return NfeCabecalho.fromData(row.data, db);  
                                }).get());
    return listaNfeCabecalho;
  }

  Future<NfeCabecalho> consultarObjetoFiltro(String campo, String valor, {String complemento}) async {
    var sql = "SELECT * FROM NFE_CABECALHO WHERE " + campo + " = '" + valor + "'";
    if (complemento != null && complemento != '') {
      sql = sql + complemento;
    }
    final retorno = await customSelect(sql, 
                                readsFrom: { nfeCabecalhos }).map((row) {
                                  return NfeCabecalho.fromData(row.data, db);  
                                }).getSingleOrNull();
      return retorno;
  }

  Future<NfeCabecalho> consultarNotaPorVenda(int idVenda, {String status}) async {
    String sql;
    if (status == null) {
      // não retorna as notas com status CONTINGENCIA (será transmitida e passada para 4) E OFFLINE (será cancelada ou inutilizada)
      sql = "SELECT * FROM NFE_CABECALHO WHERE ID_PDV_VENDA_CABECALHO = '" + idVenda.toString() + "' AND " +
      " (STATUS_NOTA <> '6' AND STATUS_NOTA <> '9')";
    } else {
      sql = "SELECT * FROM NFE_CABECALHO WHERE ID_PDV_VENDA_CABECALHO = '" + idVenda.toString() + "' AND " +
      " STATUS_NOTA = '$status'";
    }
    final retorno = await customSelect(sql, 
                                readsFrom: { nfeCabecalhos }).map((row) {
                                  return NfeCabecalho.fromData(row.data, db);  
                                }).getSingleOrNull();
      return retorno;
  }

  Future<NfeCabecalhoMontado> consultarObjetoMontado(String campo, String valor) async {
    return transaction(() async {
      final objetoNfeCabecalhoMontado = NfeCabecalhoMontado();
      try {        
        // pega o cabeçalho
        final complemento = " AND STATUS_NOTA = '4'";
        objetoNfeCabecalhoMontado.nfeCabecalho = await consultarObjetoFiltro(campo, valor, complemento: complemento);
        if (objetoNfeCabecalhoMontado.nfeCabecalho != null) {
          // pega o destinatário
          objetoNfeCabecalhoMontado.nfeDestinatario = 
            await customSelect("SELECT * FROM NFE_DESTINATARIO WHERE ID_NFE_CABECALHO = '" + objetoNfeCabecalhoMontado.nfeCabecalho.id.toString() + "'", 
              readsFrom: { nfeDestinatarios }).map((row) {
                return NfeDestinatario.fromData(row.data, db);  
              }).getSingleOrNull();
          // pega os detalhes
          objetoNfeCabecalhoMontado.listaNfeDetalheMontado = [];
          final detalhes = await customSelect("SELECT * FROM NFE_DETALHE WHERE ID_NFE_CABECALHO = '" + objetoNfeCabecalhoMontado.nfeCabecalho.id.toString() + "'", 
                                    readsFrom: { nfeCabecalhos }).map((row) {
                                      return NfeDetalhe.fromData(row.data, db);  
                                    }).get();      
          // pega os impostos de cada detalhe
          for (var detalhe in detalhes) {
            // ICMS
            final icms = 
            await customSelect("SELECT * FROM NFE_DETALHE_IMPOSTO_ICMS WHERE ID_NFE_DETALHE = '" + detalhe.id.toString() + "'", 
              readsFrom: { nfeDetalheImpostoIcmss }).map((row) {
                return NfeDetalheImpostoIcms.fromData(row.data, db);  
              }).getSingleOrNull();
            // PIS
            final pis = 
            await customSelect("SELECT * FROM NFE_DETALHE_IMPOSTO_PIS WHERE ID_NFE_DETALHE = '" + detalhe.id.toString() + "'", 
              readsFrom: { nfeDetalheImpostoPiss }).map((row) {
                return NfeDetalheImpostoPis.fromData(row.data, db);  
              }).getSingleOrNull();
            // COFINS
            final cofins = 
            await customSelect("SELECT * FROM NFE_DETALHE_IMPOSTO_COFINS WHERE ID_NFE_DETALHE = '" + detalhe.id.toString() + "'", 
              readsFrom: { nfeDetalheImpostoCofinss }).map((row) {
                return NfeDetalheImpostoCofins.fromData(row.data, db);  
              }).getSingleOrNull();
            // monta tudo
            NfeDetalheMontado nfeDetalheMontado = NfeDetalheMontado(
              nfeDetalhe: detalhe,
              nfeDetalheImpostoIcms: icms,
              nfeDetalheImpostoPis: pis,
              nfeDetalheImpostoCofins: cofins,
            );
            objetoNfeCabecalhoMontado.listaNfeDetalheMontado.add(nfeDetalheMontado);
          }
        }
        return objetoNfeCabecalhoMontado;
      } catch (e) {
        print('Ocorreu um problema ao tentar emitir a NFC-e: ' + e.toString());
        return null;
      }
    });     
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

  Future<bool> alterar(NfeCabecalhoMontado nfeCabecalhoMontado, {bool atualizaFilhos}) {
    return transaction(() async {
      if (atualizaFilhos) {
        await excluirFilhos(nfeCabecalhoMontado);
        await inserirFilhos(nfeCabecalhoMontado, nfeCabecalhoMontado.nfeCabecalho.id);
      }
      return update(nfeCabecalhos).replace(nfeCabecalhoMontado.nfeCabecalho);
    });    
  } 

  Future<void> excluirFilhos(NfeCabecalhoMontado pObjeto) async {
    await (delete(nfeDestinatarios)..where((t) => t.idNfeCabecalho.equals(pObjeto.nfeCabecalho.id))).go();
    await (delete(nfeInformacaoPagamentos)..where((t) => t.idNfeCabecalho.equals(pObjeto.nfeCabecalho.id))).go();
    for (var detalhe in pObjeto.listaNfeDetalheMontado) {
      await (delete(nfeDetalheImpostoIcmss)..where((t) => t.idNfeDetalhe.equals(detalhe.nfeDetalhe.id))).go();
      await (delete(nfeDetalheImpostoPiss)..where((t) => t.idNfeDetalhe.equals(detalhe.nfeDetalhe.id))).go();
      await (delete(nfeDetalheImpostoCofinss)..where((t) => t.idNfeDetalhe.equals(detalhe.nfeDetalhe.id))).go();
    }
    await (delete(nfeDetalhes)..where((t) => t.idNfeCabecalho.equals(pObjeto.nfeCabecalho.id))).go();
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