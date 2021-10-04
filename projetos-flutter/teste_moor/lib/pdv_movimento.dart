import 'package:moor/moor.dart';

import 'database.dart';

@DataClassName("PdvMovimento")
class PdvMovimentos extends Table {
  String get tableName => 'PDV_MOVIMENTO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  DateTimeColumn get dataAbertura => dateTime().named('DATA_ABERTURA').nullable()();
  TextColumn get horaAbertura => text().named('HORA_ABERTURA').withLength(min: 1, max: 8).nullable()();
  DateTimeColumn get dataFechamento => dateTime().named('DATA_FECHAMENTO').nullable()();
  TextColumn get horaFechamento => text().named('HORA_FECHAMENTO').withLength(min: 1, max: 8).nullable()();
  RealColumn get totalSuprimento => real().named('TOTAL_SUPRIMENTO').nullable()();
  RealColumn get totalSangria => real().named('TOTAL_SANGRIA').nullable()();
  RealColumn get totalFinal => real().named('TOTAL_FINAL').nullable()();
}

class MovimentoComFilhos {
  final PdvMovimento movimento;
  final List<PdvSangria> listaSangria;

  MovimentoComFilhos({
    @required this.movimento,
    @required this.listaSangria,
  });
}