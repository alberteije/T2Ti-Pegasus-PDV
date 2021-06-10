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
          NfeAcessoXmls,
          NfeCteReferenciados,
          NfeCupomFiscalReferenciados,
          NfeDetalhes,
          NfeNfReferenciadas,
          NfeProcessoReferenciados,
          NfeProdRuralReferenciadas,
          NfeReferenciadas,
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

  Future<int> inserir(Insertable<NfeCabecalho> pObjeto, List<NfeAcessoXml> listaNfeAcessoXml, List<NfeCteReferenciado> listaNfeCteReferenciado, List<NfeCupomFiscalReferenciado> listaNfeCupomFiscalReferenciado, List<NfeDetalhe> listaNfeDetalhe, List<NfeNfReferenciada> listaNfeNfReferenciada, List<NfeProcessoReferenciado> listaNfeProcessoReferenciado, List<NfeProdRuralReferenciada> listaNfeProdRuralReferenciada, List<NfeReferenciada> listaNfeReferenciada) {
    return transaction(() async {
      final idInserido = await into(nfeCabecalhos).insert(pObjeto);
      // inserirFilhos(pObjeto as NfeCabecalho, listaNfeAcessoXml);
      // inserirFilhos(pObjeto as NfeCabecalho, listaNfeCteReferenciado);
      // inserirFilhos(pObjeto as NfeCabecalho, listaNfeCupomFiscalReferenciado);
      // inserirFilhos(pObjeto as NfeCabecalho, listaNfeDetalhe);
      // inserirFilhos(pObjeto as NfeCabecalho, listaNfeNfReferenciada);
      // inserirFilhos(pObjeto as NfeCabecalho, listaNfeProcessoReferenciado);
      // inserirFilhos(pObjeto as NfeCabecalho, listaNfeProdRuralReferenciada);
      // inserirFilhos(pObjeto as NfeCabecalho, listaNfeReferenciada);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<NfeCabecalho> pObjeto, List<NfeAcessoXml> listaNfeAcessoXml, List<NfeCteReferenciado> listaNfeCteReferenciado, List<NfeCupomFiscalReferenciado> listaNfeCupomFiscalReferenciado, List<NfeDetalhe> listaNfeDetalhe, List<NfeNfReferenciada> listaNfeNfReferenciada, List<NfeProcessoReferenciado> listaNfeProcessoReferenciado, List<NfeProdRuralReferenciada> listaNfeProdRuralReferenciada, List<NfeReferenciada> listaNfeReferenciada) {
    return transaction(() async {
      // excluirFilhos(pObjeto as NfeCabecalho);
      // excluirFilhos(pObjeto as NfeCabecalho);
      // excluirFilhos(pObjeto as NfeCabecalho);
      // excluirFilhos(pObjeto as NfeCabecalho);
      // excluirFilhos(pObjeto as NfeCabecalho);
      // excluirFilhos(pObjeto as NfeCabecalho);
      // excluirFilhos(pObjeto as NfeCabecalho);
      // excluirFilhos(pObjeto as NfeCabecalho);
      // inserirFilhos(pObjeto as NfeCabecalho, listaNfeAcessoXml);
      // inserirFilhos(pObjeto as NfeCabecalho, listaNfeCteReferenciado);
      // inserirFilhos(pObjeto as NfeCabecalho, listaNfeCupomFiscalReferenciado);
      // inserirFilhos(pObjeto as NfeCabecalho, listaNfeDetalhe);
      // inserirFilhos(pObjeto as NfeCabecalho, listaNfeNfReferenciada);
      // inserirFilhos(pObjeto as NfeCabecalho, listaNfeProcessoReferenciado);
      // inserirFilhos(pObjeto as NfeCabecalho, listaNfeProdRuralReferenciada);
      // inserirFilhos(pObjeto as NfeCabecalho, listaNfeReferenciada);
      return update(nfeCabecalhos).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<NfeCabecalho> pObjeto) {
    return transaction(() async {
      excluirFilhos(pObjeto as NfeCabecalho);
      excluirFilhos(pObjeto as NfeCabecalho);
      excluirFilhos(pObjeto as NfeCabecalho);
      excluirFilhos(pObjeto as NfeCabecalho);
      excluirFilhos(pObjeto as NfeCabecalho);
      excluirFilhos(pObjeto as NfeCabecalho);
      excluirFilhos(pObjeto as NfeCabecalho);
      excluirFilhos(pObjeto as NfeCabecalho);
      return delete(nfeCabecalhos).delete(pObjeto);
    });    
  }

  void inserirFilhos(NfeCabecalho nfeCabecalho, List<NfeAcessoXml> listaNfeAcessoXml, List<NfeCteReferenciado> listaNfeCteReferenciado, List<NfeCupomFiscalReferenciado> listaNfeCupomFiscalReferenciado, List<NfeDetalhe> listaNfeDetalhe, List<NfeNfReferenciada> listaNfeNfReferenciada, List<NfeProcessoReferenciado> listaNfeProcessoReferenciado, List<NfeProdRuralReferenciada> listaNfeProdRuralReferenciada, List<NfeReferenciada> listaNfeReferenciada) {
    for (var objeto in listaNfeAcessoXml) {
      if (objeto.id == null) {
        objeto = objeto.copyWith(idNfeCabecalho: nfeCabecalho.id);
      }
      into(nfeAcessoXmls).insert(objeto);  
    }
    for (var objeto in listaNfeCteReferenciado) {
      if (objeto.id == null) {
        objeto = objeto.copyWith(idNfeCabecalho: nfeCabecalho.id);
      }
      into(nfeCteReferenciados).insert(objeto);  
    }
    for (var objeto in listaNfeCupomFiscalReferenciado) {
      if (objeto.id == null) {
        objeto = objeto.copyWith(idNfeCabecalho: nfeCabecalho.id);
      }
      into(nfeCupomFiscalReferenciados).insert(objeto);  
    }
    for (var objeto in listaNfeDetalhe) {
      if (objeto.id == null) {
        objeto = objeto.copyWith(idNfeCabecalho: nfeCabecalho.id);
      }
      into(nfeDetalhes).insert(objeto);  
    }
    for (var objeto in listaNfeNfReferenciada) {
      if (objeto.id == null) {
        objeto = objeto.copyWith(idNfeCabecalho: nfeCabecalho.id);
      }
      into(nfeNfReferenciadas).insert(objeto);  
    }
    for (var objeto in listaNfeProcessoReferenciado) {
      if (objeto.id == null) {
        objeto = objeto.copyWith(idNfeCabecalho: nfeCabecalho.id);
      }
      into(nfeProcessoReferenciados).insert(objeto);  
    }
    for (var objeto in listaNfeProdRuralReferenciada) {
      if (objeto.id == null) {
        objeto = objeto.copyWith(idNfeCabecalho: nfeCabecalho.id);
      }
      into(nfeProdRuralReferenciadas).insert(objeto);  
    }
    for (var objeto in listaNfeReferenciada) {
      if (objeto.id == null) {
        objeto = objeto.copyWith(idNfeCabecalho: nfeCabecalho.id);
      }
      into(nfeReferenciadas).insert(objeto);  
    }
  }
  
  void excluirFilhos(NfeCabecalho nfeCabecalho) {
    (delete(nfeAcessoXmls)..where((t) => t.idNfeCabecalho.equals(nfeCabecalho.id))).go();
    (delete(nfeCteReferenciados)..where((t) => t.idNfeCabecalho.equals(nfeCabecalho.id))).go();
    (delete(nfeCupomFiscalReferenciados)..where((t) => t.idNfeCabecalho.equals(nfeCabecalho.id))).go();
    (delete(nfeDetalhes)..where((t) => t.idNfeCabecalho.equals(nfeCabecalho.id))).go();
    (delete(nfeNfReferenciadas)..where((t) => t.idNfeCabecalho.equals(nfeCabecalho.id))).go();
    (delete(nfeProcessoReferenciados)..where((t) => t.idNfeCabecalho.equals(nfeCabecalho.id))).go();
    (delete(nfeProdRuralReferenciadas)..where((t) => t.idNfeCabecalho.equals(nfeCabecalho.id))).go();
    (delete(nfeReferenciadas)..where((t) => t.idNfeCabecalho.equals(nfeCabecalho.id))).go();
  }
}