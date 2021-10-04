import 'package:mvc_application/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:t2ti_erp_fenix/src/model/banco_agencia.dart';

class BancoAgenciaService extends DBInterface {
  factory BancoAgenciaService() {
    _this ??= BancoAgenciaService._();
    return _this;
  }

  BancoAgenciaService._() : super();
  static BancoAgenciaService _this;
  static BancoAgenciaService get bancoAgenciaService => _this ?? BancoAgenciaService();

  @override
  String get name => 't2ti_erp_agencia';

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute("""
        CREATE TABLE BANCO_AGENCIA(
            id INTEGER PRIMARY KEY
            ,idBanco TEXT
            ,numero TEXT
            ,digito TEXT
            ,nome TEXT
            ,telefone TEXT
            ,contato TEXT
            ,observacao TEXT
            ,gerente TEXT
            )
        """);
  }

  @override
  int get version => 1;

  static Future<bool> initState() => BancoAgenciaService().init();

  static void dispose() {
    BancoAgenciaService().disposed();
  }

  ///CRUD
  static Future<List<BancoAgencia>> consultarLista() async {
    return tratarRetornoQuery(await _this.rawQuery('SELECT * FROM BANCO_AGENCIA'));
  }

  static Future<List<BancoAgencia>> tratarRetornoQuery(
      List<Map<String, dynamic>> consulta) async {
    List<BancoAgencia> bancoAgenciaList = [];
    for (Map bancoAgenciaMap in consulta) {
      Map<String, dynamic> map = bancoAgenciaMap.map((key, value) {
        return MapEntry(key, value is int ? value?.toString() : value);
      });
      BancoAgencia bancoAgencia = BancoAgencia.fromMap(map);
      bancoAgenciaList.add(bancoAgencia);
    }
    return bancoAgenciaList;
  }

  consultarObjeto() {}

  static Future<bool> salvar(Map<String, dynamic> bancoAgencia) async {
    Map<String, dynamic> bancoAgenciaSalvo = await _this.saveMap('BANCO_AGENCIA', bancoAgencia);
    return bancoAgenciaSalvo.isNotEmpty;
  }

  static Future<bool> excluir(Map<String, dynamic> bancoAgencia) async {
    var id = bancoAgencia['id'];
    if (id == null) return Future.value(false);
    List<Map<String, dynamic>> retorno = await _this.rawQuery('DELETE FROM BANCO_AGENCIA WHERE id = $id');
    return retorno.length > 0;
  }
}