import 'package:moor/moor.dart';

@DataClassName("PdvSangria")
class PdvSangrias extends Table {
  String get tableName => 'PDV_SANGRIA';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idPdvMovimento => integer().named('ID_PDV_MOVIMENTO').nullable().customConstraint('NULLABLE REFERENCES PDV_MOVIMENTO(ID)')();
  DateTimeColumn get dataSangria => dateTime().named('DATA_SANGRIA').nullable()();
  TextColumn get horaSangria => text().named('HORA_SANGRIA').withLength(min: 1, max: 8).nullable()();
  RealColumn get valor => real().named('VALOR').nullable()();
  TextColumn get observacao => text().named('OBSERVACAO').withLength(min: 1, max: 250).nullable()();
}