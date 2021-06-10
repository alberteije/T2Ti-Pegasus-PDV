/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [CONTAS_RECEBER] 
                                                                                
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
import 'package:pegasus_pdv/src/infra/infra.dart';

import '../database.dart';

@DataClassName("ContasReceber")
class ContasRecebers extends Table {
  String get tableName => 'CONTAS_RECEBER';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idCliente => integer().named('ID_CLIENTE').nullable().customConstraint('NULLABLE REFERENCES CLIENTE(ID)')();
  IntColumn get idPdvVendaCabecalho => integer().named('ID_PDV_VENDA_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES PDV_VENDA_CABEALHO(ID)')();
  DateTimeColumn get dataLancamento => dateTime().named('DATA_LANCAMENTO').nullable()();
  DateTimeColumn get dataVencimento => dateTime().named('DATA_VENCIMENTO').nullable()();
  DateTimeColumn get dataRecebimento => dateTime().named('DATA_RECEBIMENTO').nullable()();
  RealColumn get valorAReceber => real().named('VALOR_A_RECEBER').nullable()();
  RealColumn get taxaJuro => real().named('TAXA_JURO').nullable()();
  RealColumn get taxaMulta => real().named('TAXA_MULTA').nullable()();
  RealColumn get taxaDesconto => real().named('TAXA_DESCONTO').nullable()();
  RealColumn get valorJuro => real().named('VALOR_JURO').nullable()();
  RealColumn get valorMulta => real().named('VALOR_MULTA').nullable()();
  RealColumn get valorDesconto => real().named('VALOR_DESCONTO').nullable()();
  RealColumn get valorRecebido => real().named('VALOR_RECEBIDO').nullable()();
  TextColumn get numeroDocumento => text().named('NUMERO_DOCUMENTO').withLength(min: 0, max: 50).nullable()();
  TextColumn get historico => text().named('HISTORICO').withLength(min: 0, max: 250).nullable()();
  TextColumn get statusRecebimento => text().named('STATUS_RECEBIMENTO').withLength(min: 0, max: 1).nullable()();
}

class ContasReceberMontado {
  Cliente cliente;
  ContasReceber contasReceber;

  ContasReceberMontado({
    this.cliente,
    this.contasReceber,
  });

  String getIndex(int index) {
    switch (index) {
      case 0:
        return Biblioteca.formatarData(contasReceber.dataVencimento);
      case 1:
        return contasReceber.historico;
      case 2:
        return Constantes.formatoDecimalValor.format(contasReceber.valorAReceber ?? 0);
    }
    return '';
  }  
}