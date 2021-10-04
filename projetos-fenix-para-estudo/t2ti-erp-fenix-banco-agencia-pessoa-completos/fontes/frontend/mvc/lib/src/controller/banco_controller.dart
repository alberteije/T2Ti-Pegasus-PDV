import 'package:flutter/material.dart';
import 'package:mvc_application/controller.dart';
import 'package:t2ti_erp_fenix/src/view/field_widgets/banco_fields.dart';
import 'package:t2ti_erp_fenix/src/model/banco.dart';
import 'package:t2ti_erp_fenix/src/service/banco_service.dart';

class BancoController extends ControllerMVC {

  /// factory - teremos apenas uma instância de BancoController - singleton
  factory BancoController() {
    _this ??= BancoController._();
    return _this;
  }
  static BancoController _this;
  BancoController._() : super();

  /// controla a ordenação da lista
  static bool _ordenado;
  static const _SORT_KEY = 'sort_by_alpha';

  /// lista local com os bancos
  static List<Banco> get listaBanco => _listaBanco;
  static List<Banco> _listaBanco;

  @override
  void initState() async {
    await init();
    _ordenado = await Prefs.getBoolF(_SORT_KEY, false);
    refrescarLista();
  }

  @override
  void dispose() {
    disposed();
    super.dispose();
  }

  @override
  void onError(FlutterErrorDetails details) =>
      FlutterError.dumpErrorToConsole(details);

  static Future<bool> init() => BancoService.initState();

  static void disposed() => BancoService.dispose();

  /// retorna a lista de bancos do service
  static Future<List<Banco>> getListaBanco() async {
    List<Banco> listaBanco = await BancoService.consultarLista();
    if (_ordenado) listaBanco.sort();
    return listaBanco;
  }

  /// consulta novamente a lista de bancos e chama o setState através do refrescarTela
  static void refrescarLista() async {
    _listaBanco = await getListaBanco();
    refrescarTela();
  }

  /// chama o setState
  static refrescarTela() {
    _this?.refresh();
  }

  /// carrega novamente a lista de bancos, mas dessa vez passando com o _ordenado alterado e refresca a tela
  static void ordenar() async {
    _ordenado = !_ordenado;
    Prefs.setBool(_SORT_KEY, _ordenado);
    _listaBanco = await getListaBanco();
    refrescarTela();
  }

  /// chama o service para excluir o banco
  static Future<bool> excluir(Banco banco) async {
    return await BancoService.excluir(banco.toMap);
  }

  /// chama o service para salvar o banco e refresca a tela
  static void persistir([Banco banco]) {
    BancoService.salvar(banco.toMap);
    refrescarLista();
  }

  /// retorna um item da lista como Banco e instancia os Fields
  Banco bancoItemLista(int index) {
    Banco banco = listaBanco?.elementAt(index);
    bancoFieldsLista.init(banco);
    return banco;
  }

  static BancoFields get bancoFields => _bancoFields;
  static BancoFields _bancoFields = BancoFields();

  static BancoFieldsLista get bancoFieldsLista => _bancoFieldsLista;
  static BancoFieldsLista _bancoFieldsLista = BancoFieldsLista();
  
  static BancoFieldsPersiste get bancoFieldsPersiste => _bancoFieldsPersiste;
  static BancoFieldsPersiste _bancoFieldsPersiste = BancoFieldsPersiste();
}
