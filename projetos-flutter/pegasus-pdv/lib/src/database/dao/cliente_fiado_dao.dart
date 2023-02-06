/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [CLIENTE_FIADO] 
                                                                                
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
import 'package:drift/drift.dart';

import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

part 'cliente_fiado_dao.g.dart';

@DriftAccessor(tables: [
          ClienteFiados,
          Clientes,
          PdvVendaCabecalhos,
		])
class ClienteFiadoDao extends DatabaseAccessor<AppDatabase> with _$ClienteFiadoDaoMixin {
  final AppDatabase db;

  ClienteFiadoDao(this.db) : super(db);

  List<ClienteFiado>? listaClienteFiado; 
  List<ClienteFiadoMontado>? listaClienteFiadoMontado; 
  
  Future<List<ClienteFiado>?> consultarLista() async {
    listaClienteFiado = await select(clienteFiados).get();
    return listaClienteFiado;
  }  

  Future<List<ClienteFiado>?> consultarListaFiltro(String campo, String valor) async {
    listaClienteFiado = await (customSelect("SELECT * FROM CLIENTE_FIADO WHERE $campo like '%$valor%'", 
                                readsFrom: { clienteFiados }).map((row) {
                                  return ClienteFiado.fromData(row.data);  
                                }).get());
    return listaClienteFiado;
  }
    
  Future<List<ClienteFiadoMontado>?> consultarListaMontado({required int idCliente, required int mes, required int ano, required String status}) async {
    final consulta = select(clienteFiados)
      .join([
        leftOuterJoin(clientes, clientes.id.equalsExp(clienteFiados.idCliente)),
      ])
      .join([
        leftOuterJoin(pdvVendaCabecalhos, pdvVendaCabecalhos.id.equalsExp(clienteFiados.idPdvVendaCabecalho)),
      ]);

    consulta.where(clienteFiados.dataLancamento.month.equals(mes));
    consulta.where(clienteFiados.dataLancamento.year.equals(ano));
    consulta.where(clienteFiados.idCliente.equals(idCliente));

    switch (status) {
      case 'Pagar':
        consulta.where(clienteFiados.dataPagamento.isNull());
        break;
      case 'Pago':
        consulta.where(clienteFiados.dataPagamento.isNotNull());
        break;
      default:
    }

    listaClienteFiadoMontado = await consulta.map((row) {
        final cliente = row.readTableOrNull(clientes);
        final clienteFiado = row.readTableOrNull(clienteFiados);
        final pdvVendaCabecalho = row.readTableOrNull(pdvVendaCabecalhos);

        return ClienteFiadoMontado(
          cliente: cliente, 
          clienteFiado: clienteFiado,
          pdvVendaCabecalho: pdvVendaCabecalho,
        );
      }).get();
    return listaClienteFiadoMontado;
  }
    
  Future<ClienteFiado?> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM CLIENTE_FIADO WHERE $campo = '$valor'", 
                                readsFrom: { clienteFiados }).map((row) {
                                  return ClienteFiado.fromData(row.data);  
                                }).getSingleOrNull());
  }  
  
  Stream<List<ClienteFiado>> observarLista() => select(clienteFiados).watch();

  Future<ClienteFiado?> consultarObjeto(int pId) {
    return (select(clienteFiados)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> consultarPendencia(int pIdCliente) async {
    final resultado = await customSelect("select count(*) as QUANTIDADE from CLIENTE_FIADO "
                                         " where ID_CLIENTE='$pIdCliente' and DATA_PAGAMENTO IS NULL").getSingleOrNull();
    return resultado?.data["QUANTIDADE"] ?? 0;
  } 

  Future<int> ultimoId() async {
    final resultado = await customSelect("select MAX(ID) as ULTIMO from CLIENTE_FIADO").getSingleOrNull();
    return resultado?.data["ULTIMO"] ?? 0;
  } 

  Future<int> inserir(ClienteFiado pObjeto) {
    return transaction(() async {
      await (delete(clienteFiados)..where((t) => t.idPdvVendaCabecalho.equals(pObjeto.idPdvVendaCabecalho!))).go();
      final maxId = await ultimoId();
      pObjeto = pObjeto.copyWith(id: maxId + 1);
      final idInserido = await into(clienteFiados).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(ClienteFiado pObjeto) {
    return transaction(() async {
      return update(clienteFiados).replace(pObjeto);
    });    
  } 

  Future<int> excluir(ClienteFiado pObjeto) {
    return transaction(() async {
      return delete(clienteFiados).delete(pObjeto);
    });    
  }  
  
  static List<String> campos = <String>[
    'ID', 
    'VALOR_PENDENTE', 
    'DATA_PAGAMENTO', 
  ];

  static List<String> colunas = <String>[
    'Id', 
    'Valor Pendente', 
    'Data Pagamento', 
  ];  
}