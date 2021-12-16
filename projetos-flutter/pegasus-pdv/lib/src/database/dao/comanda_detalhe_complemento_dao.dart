/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [COMANDA_DETALHE_COMPLEMENTO] 
                                                                                
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

part 'comanda_detalhe_complemento_dao.g.dart';

@UseDao(tables: [
          ComandaDetalheComplementos,
		])
class ComandaDetalheComplementoDao extends DatabaseAccessor<AppDatabase> with _$ComandaDetalheComplementoDaoMixin {
  final AppDatabase db;

  ComandaDetalheComplementoDao(this.db) : super(db);

  List<ComandaDetalheComplemento>? listaComandaDetalheComplemento; 
  
  Future<List<ComandaDetalheComplemento>?> consultarLista() async {
    listaComandaDetalheComplemento = await select(comandaDetalheComplementos).get();
    return listaComandaDetalheComplemento;
  }  

  Future<List<ComandaDetalheComplemento>?> consultarListaFiltro(String campo, String valor) async {
    listaComandaDetalheComplemento = await (customSelect("SELECT * FROM COMANDA_DETALHE_COMPLEMENTO WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { comandaDetalheComplementos }).map((row) {
                                  return ComandaDetalheComplemento.fromData(row.data, db);  
                                }).get());
    return listaComandaDetalheComplemento;
  }
    
  Future<ComandaDetalheComplemento?> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM COMANDA_DETALHE_COMPLEMENTO WHERE " + campo + " = '" + valor + "'", 
                                readsFrom: { comandaDetalheComplementos }).map((row) {
                                  return ComandaDetalheComplemento.fromData(row.data, db);  
                                }).getSingleOrNull());
  }  
  
  Stream<List<ComandaDetalheComplemento>> observarLista() => select(comandaDetalheComplementos).watch();

  Future<ComandaDetalheComplemento?> consultarObjeto(int pId) {
    return (select(comandaDetalheComplementos)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<ComandaDetalheComplemento> pObjeto) {
    return transaction(() async {
      final idInserido = await into(comandaDetalheComplementos).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<ComandaDetalheComplemento> pObjeto) {
    return transaction(() async {
      return update(comandaDetalheComplementos).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<ComandaDetalheComplemento> pObjeto) {
    return transaction(() async {
      return delete(comandaDetalheComplementos).delete(pObjeto);
    });    
  }

  
  
  static List<String> campos = <String>[
    'ID', 
    'QUANTIDADE', 
    'VALOR_UNITARIO', 
    'VALOR_TOTAL', 
  ];

  static List<String> colunas = <String>[
    'Id', 
    'Quantidade', 
    'Valor Unitário', 
    'Valor Total', 
  ];  
}