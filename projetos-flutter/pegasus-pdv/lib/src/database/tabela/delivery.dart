/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [DELIVERY] 
                                                                                
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

@DataClassName("Delivery")
@UseRowClass(Delivery)
class Deliverys extends Table {
  @override
  String get tableName => 'DELIVERY';

  IntColumn get id => integer().named('ID').nullable()();
  IntColumn get idComanda => integer().named('ID_COMANDA').nullable().customConstraint('NULLABLE REFERENCES COMANDA(ID)')();
  IntColumn get idTaxaEntrega => integer().named('ID_TAXA_ENTREGA').nullable().customConstraint('NULLABLE REFERENCES TAXA_ENTREGA(ID)')();
  IntColumn get idColaborador => integer().named('ID_COLABORADOR').nullable().customConstraint('NULLABLE REFERENCES COLABORADOR(ID)')();
  TextColumn get nomeCliente => text().named('NOME_CLIENTE').withLength(min: 0, max: 100).nullable()();
  TextColumn get telefonePrincipal => text().named('TELEFONE_PRINCIPAL').withLength(min: 0, max: 15).nullable()();
  TextColumn get telefoneRecado => text().named('TELEFONE_RECADO').withLength(min: 0, max: 15).nullable()();
  TextColumn get celular => text().named('CELULAR').withLength(min: 0, max: 15).nullable()();
  TextColumn get logradouro => text().named('LOGRADOURO').withLength(min: 0, max: 250).nullable()();
  TextColumn get numero => text().named('NUMERO').withLength(min: 0, max: 10).nullable()();
  TextColumn get complemento => text().named('COMPLEMENTO').withLength(min: 0, max: 100).nullable()();
  TextColumn get cep => text().named('CEP').withLength(min: 0, max: 8).nullable()();
  TextColumn get bairro => text().named('BAIRRO').withLength(min: 0, max: 100).nullable()();
  TextColumn get cidade => text().named('CIDADE').withLength(min: 0, max: 100).nullable()();
  TextColumn get uf => text().named('UF').withLength(min: 0, max: 2).nullable()();
  RealColumn get valorFrete => real().named('VALOR_FRETE').nullable()();
  RealColumn get valorRecebido => real().named('VALOR_RECEBIDO').nullable()();
  RealColumn get valorAReceber => real().named('VALOR_A_RECEBER').nullable()();
  RealColumn get valorSolicitadoTroco => real().named('VALOR_SOLICITADO_TROCO').nullable()();
  DateTimeColumn get previsaoPreparo => dateTime().named('PREVISAO_PREPARO').nullable()();
  DateTimeColumn get inicioPreparo => dateTime().named('INICIO_PREPARO').nullable()();
  DateTimeColumn get previsaoEntrega => dateTime().named('PREVISAO_ENTREGA').nullable()();
  DateTimeColumn get saiuParaEntrega => dateTime().named('SAIU_PARA_ENTREGA').nullable()();
  DateTimeColumn get entregue => dateTime().named('ENTREGUE').nullable()();
  DateTimeColumn get previsaoRetirada => dateTime().named('PREVISAO_RETIRADA').nullable()();
  DateTimeColumn get prontoParaRetirada => dateTime().named('PRONTO_PARA_RETIRADA').nullable()();
  DateTimeColumn get retirou => dateTime().named('RETIROU').nullable()();

  @override
  Set<Column> get primaryKey => {id};  
}

class DeliveryMontado {
  Delivery? delivery;
  Comanda? comanda;
  TaxaEntrega? taxaEntrega;
  Colaborador? colaborador;

  DeliveryMontado({
    this.delivery,
    this.comanda,
    this.taxaEntrega,
    this.colaborador,
  });
}
