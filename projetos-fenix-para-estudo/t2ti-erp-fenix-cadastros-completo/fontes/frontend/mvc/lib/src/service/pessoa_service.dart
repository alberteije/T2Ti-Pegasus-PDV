import 'package:mvc_application/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:t2ti_erp_fenix/src/model/pessoa.dart';
import 'package:t2ti_erp_fenix/src/model/pessoa_contato.dart';

class PessoaService extends DBInterface {
  factory PessoaService() {
    _this ??= PessoaService._();
    return _this;
  }

  PessoaService._() : super();
  static PessoaService _this;
  static PessoaService get pessoaService => _this ?? PessoaService();

  @override
  String get name => 't2ti_erp_fenix_grupo_pessoa';

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute("""
        CREATE TABLE PESSOA(
            id INTEGER PRIMARY KEY
            ,nome TEXT
            ,tipo TEXT
            ,site TEXT
            ,email TEXT
            ,cliente TEXT
            ,fornecedor TEXT
            ,transportadora TEXT
            ,colaborador TEXT
            ,contador TEXT            
            );
        """);

    await db.execute("""
        CREATE TABLE PESSOA_FISICA(
            id INTEGER PRIMARY KEY
            ,idPessoa TEXT
            ,idNivelFormacao TEXT
            ,idEstadoCivil TEXT
            ,cpf TEXT
            ,rg TEXT
            ,orgaoRg TEXT
            ,dataEmissaoRg TEXT
            ,dataNascimento TEXT
            ,sexo TEXT
            ,raca TEXT
            ,nacionalidade TEXT
            ,naturalidade TEXT
            ,nomePai TEXT
            ,nomeMae TEXT
            );
        """);

    await db.execute("""
        CREATE TABLE PESSOA_JURIDICA(
            id INTEGER PRIMARY KEY
            ,idPessoa TEXT
            ,cnpj TEXT
            ,nomeFantasia TEXT
            ,inscricaoEstadual TEXT
            ,inscricaoMunicipal TEXT
            ,dataConstituicao TEXT
            ,tipoRegime TEXT
            ,crt TEXT
            );
        """);

    await db.execute("""
        CREATE TABLE PESSOA_CONTATO(
            id INTEGER PRIMARY KEY
            ,idPessoa TEXT
            ,nome TEXT
            ,email TEXT
            ,observacao TEXT
            );
        """);

    await db.execute("""
        CREATE TABLE PESSOA_ENDERECO(
            id INTEGER PRIMARY KEY
            ,idPessoa TEXT
            ,logradouro TEXT
            ,numero TEXT
            ,bairro TEXT
            ,municipioIbge TEXT
            ,uf TEXT
            ,cep TEXT
            ,cidade TEXT
            ,complemento TEXT
            ,principal TEXT
            ,entrega TEXT
            ,cobranca TEXT
            ,correspondencia TEXT
            );
        """);

    await db.execute("""
        CREATE TABLE PESSOA_TELEFONE(
            id INTEGER PRIMARY KEY
            ,idPessoa TEXT
            ,tipo TEXT
            ,numero TEXT
            );
        """);

  }

  @override
  int get version => 1;

  static Future<bool> initState() => PessoaService().init();

  static void dispose() {
    PessoaService().disposed();
  }

  ///CRUD Pessoa
  static Future<List<Pessoa>> consultarLista() async {
    return tratarRetornoQuery(await _this.rawQuery('SELECT * FROM PESSOA'));
  }

  static Future<List<Pessoa>> tratarRetornoQuery(
      List<Map<String, dynamic>> consulta) async {
    List<Pessoa> pessoaList = [];
    for (Map pessoaMap in consulta) {
      Map<String, dynamic> map = pessoaMap.map((key, value) {
        return MapEntry(key, value is int ? value?.toString() : value);
      });
      Pessoa pessoa = Pessoa.fromMap(map);
      pessoaList.add(pessoa);
    }
    return pessoaList;
  }

  consultarObjeto() {}

  static Future<bool> salvar(Map<String, dynamic> pessoa) async {
    Map<String, dynamic> pessoaSalvo = await _this.saveMap('PESSOA', pessoa);
    return pessoaSalvo.isNotEmpty;
  }

  static Future<bool> excluir(Map<String, dynamic> pessoa) async {
    var id = pessoa['id'];
    if (id == null) return Future.value(false);
    List<Map<String, dynamic>> retorno = await _this.rawQuery('DELETE FROM PESSOA WHERE id = $id');
    return retorno.length == 0;
  }

  ///CRUD PessoaContato
  static Future<List<PessoaContato>> consultarListaContato() async {
    return tratarRetornoQueryContato(await _this.rawQuery('SELECT * FROM PESSOA_CONTATO'));
  }

  static Future<List<PessoaContato>> tratarRetornoQueryContato(
      List<Map<String, dynamic>> consulta) async {
    List<PessoaContato> pessoaContatoList = [];
    for (Map pessoaContatoMap in consulta) {
      Map<String, dynamic> map = pessoaContatoMap.map((key, value) {
        return MapEntry(key, value is int ? value?.toString() : value);
      });
      PessoaContato pessoaContato = PessoaContato.fromMap(map);
      pessoaContatoList.add(pessoaContato);
    }
    return pessoaContatoList;
  }

  static Future<bool> salvarContato(Map<String, dynamic> pessoaContato) async {
    Map<String, dynamic> pessoaContatoSalvo = await _this.saveMap('PESSOA_CONTATO', pessoaContato);
    return pessoaContatoSalvo.isNotEmpty;
  }

  static Future<bool> excluirContato(Map<String, dynamic> pessoaContato) async {
    var id = pessoaContato['id'];
    if (id == null) return Future.value(false);
    List<Map<String, dynamic>> retorno = await _this.rawQuery('DELETE FROM PESSOA_CONTATO WHERE id = $id');
    return retorno.length == 0;
  }  

}