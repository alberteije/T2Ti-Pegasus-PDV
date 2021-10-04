import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/mvc.dart';
import 'package:t2ti_erp_fenix/src/view/field_widgets/pessoa_contato_fields.dart';
import 'package:t2ti_erp_fenix/src/model/pessoa_contato.dart';
import 'package:t2ti_erp_fenix/src/service/pessoa_service.dart';

class PessoaContatoController extends ControllerMVC {

  /// factory - teremos apenas uma instância de PessoaContatoController - singleton
  factory PessoaContatoController() {
    _this ??= PessoaContatoController._();
    return _this;
  }
  static PessoaContatoController _this;
  PessoaContatoController._() : super();

  /// controla a ordenação da lista
  static bool _ordenado;
  static const _SORT_KEY = 'sort_by_alpha';

  /// lista local com os contatos
  static List<PessoaContato> get listaPessoaContato => _listaPessoaContato;
  static List<PessoaContato> _listaPessoaContato;

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

  static Future<bool> init() => PessoaService.initState();

  static void disposed() => PessoaService.dispose();

  /// retorna a lista de contatos do service
  static Future<List<PessoaContato>> getListaPessoaContato() async {
    List<PessoaContato> listaPessoaContato = await PessoaService.consultarListaContato();
    if (_ordenado) listaPessoaContato.sort();
    return listaPessoaContato;
  }

  /// consulta novamente a lista de contatos e chama o setState através do refrescarTela
  static void refrescarLista() async {
    _listaPessoaContato = await getListaPessoaContato();
    refrescarTela();
  }

  /// chama o setState
  static refrescarTela() {
    _this?.refresh();
  }

  /// carrega novamente a lista de contatos, mas dessa vez passando com o _ordenado alterado e refresca a tela
  static void ordenar() async {
    _ordenado = !_ordenado;
    Prefs.setBool(_SORT_KEY, _ordenado);
    _listaPessoaContato = await getListaPessoaContato();
    refrescarTela();
  }

  /// chama o service para excluir o contato
  static Future<bool> excluir(PessoaContato pessoaContato) async {
    return await PessoaService.excluirContato(pessoaContato.toMap);
  }

  /// chama o service para salvar o contato e refresca a tela
  static void persistir([PessoaContato pessoaContato]) {
    PessoaService.salvarContato(pessoaContato.toMap);
    refrescarLista();
  }

  /// retorna um item da lista como PessoaContato e instancia os Fields
  static PessoaContato pessoaContatoItemLista(int index) {
    PessoaContato pessoaContato = listaPessoaContato?.elementAt(index);
    pessoaContatoFieldsLista.init(pessoaContato);
    return pessoaContato;
  }

  static PessoaContatoFields get pessoaContatoFields => _pessoaContatoFields;
  static PessoaContatoFields _pessoaContatoFields = PessoaContatoFields();

  static PessoaContatoFieldsLista get pessoaContatoFieldsLista => _pessoaContatoFieldsLista;
  static PessoaContatoFieldsLista _pessoaContatoFieldsLista = PessoaContatoFieldsLista();
  
  static PessoaContatoFieldsPersiste get pessoaContatoFieldsPersiste => _pessoaContatoFieldsPersiste;
  static PessoaContatoFieldsPersiste _pessoaContatoFieldsPersiste = PessoaContatoFieldsPersiste();
}