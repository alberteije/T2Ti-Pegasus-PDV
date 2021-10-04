import 'package:flutter/material.dart';
import 'package:mvc_application/controller.dart';
import 'package:t2ti_erp_fenix/src/action/banco_agencia_action.dart';
import 'package:t2ti_erp_fenix/src/model/banco_agencia.dart';
import 'package:t2ti_erp_fenix/src/service/banco_agencia_service.dart';

class BancoAgenciaController extends ControllerMVC {
  factory BancoAgenciaController() {
    _this ??= BancoAgenciaController._();
    return _this;
  }
  static BancoAgenciaController _this;
  BancoAgenciaController._() : super();

  static bool _ordenado;
  static const _SORT_KEY = 'sort_by_alpha';

  @override
  void initState() async {
    await init();
    _ordenado = await Prefs.getBoolF(_SORT_KEY, false);
    bancoAgenciaListando.refresh();
  }

  @override
  void dispose() {
    disposed();
    super.dispose();
  }

  @override
  void onError(FlutterErrorDetails details) =>
      FlutterError.dumpErrorToConsole(details);

  static Future<bool> init() => BancoAgenciaService.initState();

  static void disposed() => BancoAgenciaService.dispose();

  static Future<List<BancoAgencia>> getListaBancoAgencia() async {
    List<BancoAgencia> listaBancoAgencia = await BancoAgenciaService.consultarLista();
    if (_ordenado) listaBancoAgencia.sort();
    return listaBancoAgencia;
  }

  static recarregar() {
    _this?.refresh();
  }

  static Future<List<BancoAgencia>> ordenar() async {
    _ordenado = !_ordenado;
    Prefs.setBool(_SORT_KEY, _ordenado);
    List<BancoAgencia> listaBancoAgencia = await getListaBancoAgencia();
    return listaBancoAgencia;
  }

  static Future<bool> excluir(BancoAgencia bancoAgencia) async {
    return await bancoAgenciaEditando.excluir(bancoAgencia);
  }

  BancoAgencia child(int index) {
    BancoAgencia bancoAgencia = bancoAgenciaListando.items?.elementAt(index);
    bancoAgenciaListando.init(bancoAgencia);
    return bancoAgencia;
  }

  static BancoAgenciaListando get bancoAgenciaListando => _listBancoAgencia;
  static BancoAgenciaListando _listBancoAgencia = BancoAgenciaListando();

  static BancoAgenciaEditando get bancoAgenciaEditando => _editBancoAgencia;
  static BancoAgenciaEditando _editBancoAgencia = BancoAgenciaEditando();
  
  static BancoAgenciaPersistindo get bancoAgenciaPersistindo => _persisteBancoAgencia;
  static BancoAgenciaPersistindo _persisteBancoAgencia = BancoAgenciaPersistindo();
}
