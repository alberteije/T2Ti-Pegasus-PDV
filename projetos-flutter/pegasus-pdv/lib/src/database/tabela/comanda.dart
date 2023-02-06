/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [COMANDA] 
                                                                                
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

@DataClassName("Comanda")
@UseRowClass(Comanda)
class Comandas extends Table {
  @override
  String get tableName => 'COMANDA';

  IntColumn get id => integer().named('ID').nullable()();
  IntColumn get idColaborador => integer().named('ID_COLABORADOR').nullable().customConstraint('NULLABLE REFERENCES COLABORADOR(ID)')();
  IntColumn get idMesa => integer().named('ID_MESA').nullable().customConstraint('NULLABLE REFERENCES MESA(ID)')();
  IntColumn get idCliente => integer().named('ID_CLIENTE').nullable().customConstraint('NULLABLE REFERENCES CLIENTE(ID)')();
  IntColumn get idEmpresaDeliveryPedido => integer().named('ID_EMPRESA_DELIVERY_PEDIDO').nullable().customConstraint('NULLABLE REFERENCES EMPRESA_DELIVERY_PEDIDO(ID)')();
  IntColumn get numero => integer().named('NUMERO').nullable()();
  DateTimeColumn get dataChegada => dateTime().named('DATA_CHEGADA').nullable()();
  TextColumn get horaChegada => text().named('HORA_CHEGADA').withLength(min: 0, max: 8).nullable()();
  DateTimeColumn get dataSaida => dateTime().named('DATA_SAIDA').nullable()();
  TextColumn get horaSaida => text().named('HORA_SAIDA').withLength(min: 0, max: 8).nullable()();
  RealColumn get valorSubtotal => real().named('VALOR_SUBTOTAL').nullable()();
  RealColumn get valorDesconto => real().named('VALOR_DESCONTO').nullable()();
  RealColumn get valorTotal => real().named('VALOR_TOTAL').nullable()();
  TextColumn get tipo => text().named('TIPO').withLength(min: 0, max: 1).nullable()();
  IntColumn get quantidadePessoas => integer().named('QUANTIDADE_PESSOAS').nullable()();
  RealColumn get valorPorPessoa => real().named('VALOR_POR_PESSOA').nullable()();
  TextColumn get situacao => text().named('SITUACAO').withLength(min: 0, max: 1).nullable()(); // Aberta | Cancelada | Fechada
  IntColumn get codigoCompartilhado => integer().named('CODIGO_COMPARTILHADO').nullable()();

  @override
  Set<Column> get primaryKey => {id};  
}

class ComandaMontado {
  Comanda? comanda;
  Cliente? cliente;
  Colaborador? colaborador;
  Mesa? mesa;
  List<ComandaDetalheMontado>? listaComandaDetalheMontado;

  ComandaMontado({
    this.comanda,
    this.cliente,
    this.colaborador,
    this.mesa,
    this.listaComandaDetalheMontado,
  });
}
