import 'package:flutter/material.dart';
import 'package:mvc_application/controller.dart';
import 'package:t2ti_erp_fenix/src/view/field_widgets/pessoa_fields.dart';
import 'package:t2ti_erp_fenix/src/model/pessoa.dart';
import 'package:t2ti_erp_fenix/src/service/pessoa_service.dart';
import 'package:t2ti_erp_fenix/src/view/field_widgets/pessoa_juridica_fields.dart';

class PessoaController extends ControllerMVC {

  /// factory - teremos apenas uma instância de PessoaController - singleton
  factory PessoaController() {
    _this ??= PessoaController._();
    return _this;
  }
  static PessoaController _this;
  PessoaController._() : super();

  /// controla a ordenação da lista
  static bool _ordenado;
  static const _SORT_KEY = 'sort_by_alpha';

  /// lista local com os pessoas
  static List<Pessoa> get listaPessoa => _listaPessoa;
  static List<Pessoa> _listaPessoa;

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

  /// retorna a lista de pessoas do service
  static Future<List<Pessoa>> getListaPessoa() async {
    List<Pessoa> listaPessoa = await PessoaService.consultarLista();
    if (_ordenado) listaPessoa.sort();
    return listaPessoa;
  }

  /// consulta novamente a lista de pessoas e chama o setState através do refrescarTela
  static void refrescarLista() async {
    _listaPessoa = await getListaPessoa();
    refrescarTela();
  }

  /// chama o setState
  static refrescarTela() {
    _this?.refresh();
  }

  /// carrega novamente a lista de pessoas, mas dessa vez passando com o _ordenado alterado e refresca a tela
  static void ordenar() async {
    _ordenado = !_ordenado;
    Prefs.setBool(_SORT_KEY, _ordenado);
    _listaPessoa = await getListaPessoa();
    refrescarTela();
  }

  /// chama o service para excluir o pessoa
  static Future<bool> excluir(Pessoa pessoa) async {
    return await PessoaService.excluir(pessoa.toMap);
  }

  /// chama o service para salvar o pessoa e refresca a tela
  static void persistir([Pessoa pessoa]) {
    PessoaService.salvar(pessoa.toMap);
    refrescarLista();
  }

  /// retorna um item da lista como Pessoa e instancia os Fields
  static Pessoa pessoaItemLista(int index) {
    Pessoa pessoa = listaPessoa?.elementAt(index);
    pessoaFieldsLista.init(pessoa);
    return pessoa;
  }

  static PessoaFields get pessoaFields => _pessoaFields;
  static PessoaFields _pessoaFields = PessoaFields();

  static PessoaFieldsLista get pessoaFieldsLista => _pessoaFieldsLista;
  static PessoaFieldsLista _pessoaFieldsLista = PessoaFieldsLista();
  
  static PessoaFieldsPersiste get pessoaFieldsPersiste => _pessoaFieldsPersiste;
  static PessoaFieldsPersiste _pessoaFieldsPersiste = PessoaFieldsPersiste();

  static PessoaJuridicaFieldsPersiste get pessoaJuridicaFieldsPersiste => _pessoaJuridicaFieldsPersiste;
  static PessoaJuridicaFieldsPersiste _pessoaJuridicaFieldsPersiste = PessoaJuridicaFieldsPersiste();

}
