/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [CARDAPIO_PERGUNTA_PADRAO] 
                                                                                
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

part 'cardapio_pergunta_padrao_dao.g.dart';

@UseDao(tables: [
          CardapioPerguntaPadraos,
          CardapioRespostaPadraos,
		])
class CardapioPerguntaPadraoDao extends DatabaseAccessor<AppDatabase> with _$CardapioPerguntaPadraoDaoMixin {
  final AppDatabase db;

  CardapioPerguntaPadraoDao(this.db) : super(db);

  Future<List<CardapioPerguntaPadrao>?> consultarLista() => select(cardapioPerguntaPadraos).get();

  Future<List<CardapioPerguntaPadrao>?> consultarListaFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM CARDAPIO_PERGUNTA_PADRAO WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { cardapioPerguntaPadraos }).map((row) {
                                  return CardapioPerguntaPadrao.fromData(row.data, db);  
                                }).get());
  }

  Future<CardapioPerguntaPadrao?> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM CARDAPIO_PERGUNTA_PADRAO WHERE " + campo + " = '" + valor + "'", 
                                readsFrom: { cardapioPerguntaPadraos }).map((row) {
                                  return CardapioPerguntaPadrao.fromData(row.data, db);  
                                }).getSingleOrNull());
  }  
  
  Stream<List<CardapioPerguntaPadrao>> observarLista() => select(cardapioPerguntaPadraos).watch();

  Future<CardapioPerguntaPadrao?> consultarObjeto(int pId) {
    return (select(cardapioPerguntaPadraos)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<List<CardapioPerguntaPadraoMontado>> consultarListaPerguntaMontado(int idCardapio) async {
    final List<CardapioPerguntaPadraoMontado> listaRetorno = [];

    final listaPerguntas = await (customSelect("SELECT * FROM CARDAPIO_PERGUNTA_PADRAO WHERE ID_CARDAPIO = '" + idCardapio.toString() + "'", 
                                readsFrom: { cardapioPerguntaPadraos }).map((row) {
                                  return CardapioPerguntaPadrao.fromData(row.data, db);  
                                }).get());

    int idFake = 0;
    for (var pergunta in listaPerguntas) {
      CardapioPerguntaPadraoMontado perguntaMontado = CardapioPerguntaPadraoMontado(
        id: ++idFake,
        cardapioPerguntaPadrao: pergunta,

        // pega as respostas
        listaCardapioRespostaPadrao: await (
          customSelect("SELECT * FROM CARDAPIO_RESPOSTA_PADRAO WHERE ID_CARDAPIO_PERGUNTA_PADRAO = '" + pergunta.id.toString() + "'", 
                                readsFrom: { cardapioRespostaPadraos }).map((row) {
                                  return CardapioRespostaPadrao.fromData(row.data, db);  
                                }).get()),

      );
      listaRetorno.add(perguntaMontado);
    }

    return listaRetorno;
  }  

  Future<int> inserir(Insertable<CardapioPerguntaPadrao> pObjeto) {
    return transaction(() async {
      final idInserido = await into(cardapioPerguntaPadraos).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<CardapioPerguntaPadrao> pObjeto) {
    return transaction(() async {
      return update(cardapioPerguntaPadraos).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<CardapioPerguntaPadrao> pObjeto) {
    return transaction(() async {
      return delete(cardapioPerguntaPadraos).delete(pObjeto);
    });    
  }

  
}