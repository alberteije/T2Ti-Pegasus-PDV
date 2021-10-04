import 'package:mvc_application/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:t2ti_erp_fenix/src/model/banco.dart';

class BancoService extends DBInterface {
  factory BancoService() {
    _this ??= BancoService._();
    return _this;
  }

  BancoService._() : super();
  static BancoService _this;
  static BancoService get bancoService => _this ?? BancoService();

  @override
  String get name => 't2ti_erp_fenix';

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute("""
        CREATE TABLE BANCO(
            id INTEGER PRIMARY KEY
            ,codigo TEXT
            ,nome TEXT
            ,url TEXT
            )
        """);
  }

  @override
  int get version => 1;

  static Future<bool> initState() => BancoService().init();

  static void dispose() {
    BancoService().disposed();
  }

  ///CRUD
  static Future<List<Banco>> consultarLista() async {
    return tratarRetornoQuery(await _this.rawQuery('SELECT * FROM BANCO'));
  }

  static Future<List<Banco>> tratarRetornoQuery(
      List<Map<String, dynamic>> consulta) async {
    List<Banco> bancoList = [];
    for (Map bancoMap in consulta) {
      Map<String, dynamic> map = bancoMap.map((key, value) {
        return MapEntry(key, value is int ? value?.toString() : value);
      });
      Banco banco = Banco.fromMap(map);
      bancoList.add(banco);
    }
    return bancoList;
  }

  consultarObjeto() {}

  static Future<bool> salvar(Map<String, dynamic> banco) async {
    Map<String, dynamic> bancoSalvo = await _this.saveMap('BANCO', banco);
    return bancoSalvo.isNotEmpty;
  }

  static Future<bool> excluir(Map<String, dynamic> banco) async {
    var id = banco['id'];
    if (id == null) return Future.value(false);
    List<Map<String, dynamic>> retorno = await _this.rawQuery('DELETE FROM BANCO WHERE id = $id');
    return retorno.length == 0;
  }
}