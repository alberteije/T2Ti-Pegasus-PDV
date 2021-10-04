/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [PDV_CONFIGURACAO_LEITOR_SERIAL] 
                                                                                
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

@DataClassName("PdvConfiguracaoLeitorSerial")
class PdvConfiguracaoLeitorSerials extends Table {
  String get tableName => 'PDV_CONFIGURACAO_LEITOR_SERIAL';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idPdvConfiguracao => integer().named('ID_PDV_CONFIGURACAO').nullable().customConstraint('NULLABLE REFERENCES PDV_CONFIGURACAO(ID)')();
  TextColumn get usa => text().named('USA').withLength(min: 0, max: 1).nullable()();
  TextColumn get porta => text().named('PORTA').withLength(min: 0, max: 4).nullable()();
  IntColumn get baud => integer().named('BAUD').nullable()();
  IntColumn get handShake => integer().named('HAND_SHAKE').nullable()();
  IntColumn get parity => integer().named('PARITY').nullable()();
  IntColumn get stopBits => integer().named('STOP_BITS').nullable()();
  IntColumn get dataBits => integer().named('DATA_BITS').nullable()();
  IntColumn get intervalo => integer().named('INTERVALO').nullable()();
  TextColumn get usarFila => text().named('USAR_FILA').withLength(min: 0, max: 1).nullable()();
  TextColumn get hardFlow => text().named('HARD_FLOW').withLength(min: 0, max: 1).nullable()();
  TextColumn get softFlow => text().named('SOFT_FLOW').withLength(min: 0, max: 1).nullable()();
  TextColumn get sufixo => text().named('SUFIXO').withLength(min: 0, max: 20).nullable()();
  TextColumn get excluirSufixo => text().named('EXCLUIR_SUFIXO').withLength(min: 0, max: 1).nullable()();
}