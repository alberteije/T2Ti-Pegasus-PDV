/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [DELIVERY_ACERTO] 
                                                                                
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

part 'delivery_acerto_dao.g.dart';

@DriftAccessor(tables: [
          DeliveryAcertos,
          DeliveryAcertoComandas,
		])
class DeliveryAcertoDao extends DatabaseAccessor<AppDatabase> with _$DeliveryAcertoDaoMixin {
  final AppDatabase db;

  DeliveryAcertoDao(this.db) : super(db);

  Future<List<DeliveryAcerto>?> consultarLista() => select(deliveryAcertos).get();

  Future<List<DeliveryAcerto>?> consultarListaFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM DELIVERY_ACERTO WHERE $campo like '%$valor%'", 
                                readsFrom: { deliveryAcertos }).map((row) {
                                  return DeliveryAcerto.fromData(row.data);  
                                }).get());
  }

  Future<DeliveryAcerto?> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect("SELECT * FROM DELIVERY_ACERTO WHERE $campo = '$valor'", 
                                readsFrom: { deliveryAcertos }).map((row) {
                                  return DeliveryAcerto.fromData(row.data);  
                                }).getSingleOrNull());
  }  
  
  Stream<List<DeliveryAcerto>> observarLista() => select(deliveryAcertos).watch();

  Future<DeliveryAcerto?> consultarObjeto(int pId) {
    return (select(deliveryAcertos)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> ultimoId() async {
    final resultado = await customSelect("select MAX(ID) as ULTIMO from DELIVERY_ACERTO").getSingleOrNull();
    return resultado?.data["ULTIMO"] ?? 0;
  } 

  Future<int> inserir(DeliveryAcerto pObjeto) {
    return transaction(() async {
      final maxId = await ultimoId();
      pObjeto = pObjeto.copyWith(id: maxId + 1);
      final idInserido = await into(deliveryAcertos).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(DeliveryAcerto pObjeto) {
    return transaction(() async {
      return update(deliveryAcertos).replace(pObjeto);
    });    
  } 

  Future<int> excluir(DeliveryAcerto pObjeto) {
    return transaction(() async {
      return delete(deliveryAcertos).delete(pObjeto);
    });    
  }

  Future<bool> atualizar(DeliveryAcertoMontado deliveryAcertoMontado) async {
    bool deuCerto = false;
    if (deliveryAcertoMontado.deliveryAcertoComanda!.id != null) {
      await update(deliveryAcertos).replace(deliveryAcertoMontado.deliveryAcerto!);
      deuCerto = true;
    } else {
      final idInserido = await into(deliveryAcertos).insert(deliveryAcertoMontado.deliveryAcerto!);
      deliveryAcertoMontado.deliveryAcertoComanda = deliveryAcertoMontado.deliveryAcertoComanda!.copyWith(
        idDeliveryAcerto: idInserido,
        idDelivery: deliveryAcertoMontado.delivery!.id,
      );
      await into(deliveryAcertoComandas).insert(deliveryAcertoMontado.deliveryAcertoComanda!);
      deuCerto = true;
    }
    return deuCerto;
  } 

  
}