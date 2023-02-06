/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [RESERVA] 
                                                                                
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

@DataClassName("Reserva")
@UseRowClass(Reserva)
class Reservas extends Table {
  @override
  String get tableName => 'RESERVA';

  IntColumn get id => integer().named('ID').nullable()();
  IntColumn get idCliente => integer().named('ID_CLIENTE').nullable().customConstraint('NULLABLE REFERENCES CLIENTE(ID)')();
  TextColumn get nomeContato => text().named('NOME_CONTATO').withLength(min: 0, max: 100).nullable()();
  TextColumn get telefoneContato => text().named('TELEFONE_CONTATO').withLength(min: 0, max: 15).nullable()();
  DateTimeColumn get dataReserva => dateTime().named('DATA_RESERVA').nullable()();
  TextColumn get horaReserva => text().named('HORA_RESERVA').withLength(min: 0, max: 8).nullable()();
  IntColumn get quantidadePessoas => integer().named('QUANTIDADE_PESSOAS').nullable()();
  TextColumn get situacao => text().named('SITUACAO').withLength(min: 0, max: 1).nullable()();

  @override
  Set<Column> get primaryKey => {id};  
}

class ReservaMontado {
  Reserva? reserva;
  Cliente? cliente;
  List<Mesa>? listaMesa;

  ReservaMontado({
    this.reserva,
    this.cliente,
    this.listaMesa,
  });
}

class ReservaMesaMontado {
  Reserva? reserva;
  ReservaMesa? reservaMesa;
  Mesa? mesa;

  ReservaMesaMontado({
    this.reserva,
    this.reservaMesa,
    this.mesa,
  });
}
