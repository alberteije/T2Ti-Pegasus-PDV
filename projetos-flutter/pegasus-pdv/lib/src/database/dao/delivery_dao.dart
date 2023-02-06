/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [DELIVERY] 
                                                                                
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

part 'delivery_dao.g.dart';

@DriftAccessor(tables: [
          Deliverys,
          Comandas,
          Colaboradors,
          TaxaEntregas,
		])
class DeliveryDao extends DatabaseAccessor<AppDatabase> with _$DeliveryDaoMixin {
  final AppDatabase db;

  DeliveryDao(this.db) : super(db);

  List<Delivery> listaDelivery = [];
  List<DeliveryMontado> listaDeliveryMontado = [];  

  Future<List<Delivery>> consultarLista() async {
    listaDelivery = await select(deliverys).get();
    return listaDelivery;
  } 

  Future<List<Delivery>> consultarListaFiltro(String campo, String valor) async {
    listaDelivery = await (customSelect("SELECT * FROM DELIVERY WHERE $campo like '%$valor%'", 
                                readsFrom: { deliverys }).map((row) {
                                  return Delivery.fromData(row.data);  
                                }).get());
    return listaDelivery;
  }

  Future<List<DeliveryMontado>?> consultarListaMontado({String? campo, dynamic valor}) async {
    final consulta = select(deliverys)
      .join([
        leftOuterJoin(taxaEntregas, taxaEntregas.id.equalsExp(deliverys.idTaxaEntrega)),
      ])
      .join([
        leftOuterJoin(colaboradors, colaboradors.id.equalsExp(deliverys.idColaborador)),
      ])
      .join([
        leftOuterJoin(comandas, comandas.id.equalsExp(deliverys.idComanda)),
      ]);

    consulta.where(deliverys.id.isNotNull());    
    // consulta.where(comandas.dataChegada.isBetweenValues(dataInicio, dataFim));    

    if (campo != null && campo != '') {      
      final coluna = comandas.$columns.where(((coluna) => coluna.$name == campo)).first;
      if (coluna is TextColumn) {
        consulta.where((coluna as TextColumn).like('%$valor%'));
      } else if (coluna is IntColumn) {
        consulta.where(coluna.equals(int.tryParse(valor)));
      } else if (coluna is RealColumn) {
        consulta.where(coluna.equals(double.tryParse(valor)));
      }
    }

    listaDeliveryMontado = await consulta.map((row) {
      final comanda = row.readTableOrNull(comandas);
      final taxaEntrega = row.readTableOrNull(taxaEntregas);
      final colaborador = row.readTableOrNull(colaboradors);
      final delivery = row.readTableOrNull(deliverys);

      return DeliveryMontado(
        delivery: delivery,
        comanda: comanda,
        taxaEntrega: taxaEntrega,
        colaborador: colaborador,
      );
    }).get();      

    return listaDeliveryMontado;
  }

  Future<Delivery?> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM DELIVERY WHERE $campo = '$valor'", 
                                readsFrom: { deliverys }).map((row) {
                                  return Delivery.fromData(row.data);  
                                }).getSingleOrNull());
  }  
  
  Stream<List<Delivery>> observarLista() => select(deliverys).watch();

  Future<Delivery?> consultarObjeto(int pId) {
    return (select(deliverys)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> ultimoId() async {
    final resultado = await customSelect("select MAX(ID) as ULTIMO from DELIVERY").getSingleOrNull();
    return resultado?.data["ULTIMO"] ?? 0;
  } 

  Future<int> inserir(Delivery pObjeto) {
    return transaction(() async {
      final maxId = await ultimoId();
      pObjeto = pObjeto.copyWith(id: maxId + 1);
      final idInserido = await into(deliverys).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Delivery pObjeto) {
    return transaction(() async {
      return update(deliverys).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Delivery pObjeto) {
    return transaction(() async {
      return delete(deliverys).delete(pObjeto);
    });    
  }

  
}