import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:fenix/src/infra/biblioteca.dart';

class PessoaJuridica {
  int id;
  int idPessoa;
  String cnpj;
  String nomeFantasia;
  String inscricaoEstadual;
  String inscricaoMunicipal;
  DateTime dataConstituicao;
  String tipoRegime;
  String crt;

  PessoaJuridica(
      {this.id,
      this.idPessoa,
      this.cnpj,
      this.nomeFantasia,
      this.inscricaoEstadual,
      this.inscricaoMunicipal,
      this.dataConstituicao,
      this.tipoRegime,
      this.crt,});

  static List<String> campos = <String>[
    'ID',
    'CNPJ',
    'NOME_FANTASIA',
    'INSCRICAO_ESTADUAL',
    'INSCRICAO_MUNICIPAL',
    'DATA_CONSTITUICAO',
    'TIPO_REGIME',
    'CRT'
  ];

  static List<String> colunas = <String>[
    'Id',
    'CNPJ',
    'Nome Fantasia',
    'Inscricao Estadual',
    'Inscricao Municipal',
    'Data Constituicao',
    'Tipo Regime',
    'CRT'
  ];

  PessoaJuridica.fromJson(Map<String, dynamic> jsonDados) {
    id = jsonDados['id'];
    idPessoa = jsonDados['idPessoa'];
    cnpj = jsonDados['cnpj'];
    nomeFantasia = jsonDados['nomeFantasia'];
    inscricaoEstadual = jsonDados['inscricaoEstadual'];
    inscricaoMunicipal = jsonDados['inscricaoMunicipal'];
    dataConstituicao = jsonDados['dataConstituicao'] != null ? DateTime.parse(jsonDados['dataConstituicao']) : null;
    tipoRegime = getTipoRegime(jsonDados['tipoRegime']); // DropdownButton
    crt = getCrt(jsonDados['crt']); // DropdownButton
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = new Map<String, dynamic>();
    jsonDados['id'] = this.id ?? 0;
    jsonDados['idPessoa'] = this.idPessoa ?? 0;
    jsonDados['cnpj'] = Biblioteca.removerMascara(this.cnpj); // remove a máscara com o método strip
    jsonDados['nomeFantasia'] = this.nomeFantasia;
    jsonDados['inscricaoEstadual'] = this.inscricaoEstadual;
    jsonDados['inscricaoMunicipal'] = this.inscricaoMunicipal;
    jsonDados['dataConstituicao'] = this.dataConstituicao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataConstituicao) : null;
    jsonDados['tipoRegime'] = this.tipoRegime?.substring(0, 1); // DropdownButton
    jsonDados['crt'] = this.crt?.substring(0, 1); // DropdownButton
    return jsonDados;
  }

  getTipoRegime(String tipoRegime) {
    switch (tipoRegime) {
      case '1':
        return '1-Lucro Real';
        break;
      case '2':
        return '2-Lucro Presumido';
        break;
      case '3':
        return '3-Simples Nacional';
        break;
      default:
        return null;
    }
  }

  getCrt(String crt) {
    switch (tipoRegime) {
      case '1':
        return '1-Simples Nacional';
        break;
      case '2':
        return '2-Simples Nacional - Excesso';
        break;
      case '3':
        return '3-Regime Normal';
        break;
      default:
        return null;
    }
  }
}

String objetoEncodeJson(PessoaJuridica objeto) {
  final jsonDados = objeto.toJson;
  return json.encode(jsonDados);
}
