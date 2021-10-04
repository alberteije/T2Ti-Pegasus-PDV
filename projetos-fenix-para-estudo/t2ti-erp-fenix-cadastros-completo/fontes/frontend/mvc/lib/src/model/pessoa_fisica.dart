class PessoaFisica implements Comparable<PessoaFisica> {
  PessoaFisica();

  String 
        _id,
        _idPessoa,
        _idNivelFormacao,
        _idEstadoCivil,
        _cpf,
        _rg,
        _orgaoRg,
        _dataEmissaoRg,
        _dataNascimento,
        _sexo,
        _raca,
        _nacionalidade,
        _naturalidade,
        _nomePai,
        _nomeMae;

  String get id => _id;
  set id(String value){
    if (value == null) value = "";
    _id = value;
  }

  String get idPessoa => _idPessoa;
  set idPessoa(String value){
    if (value == null) value = "";
    _idPessoa = value;
  }

  String get idNivelFormacao => _idNivelFormacao;
  set idNivelFormacao(String value){
    if (value == null) value = "";
    _idNivelFormacao = value;
  }

  String get idEstadoCivil => _idEstadoCivil;
  set idEstadoCivil(String value){
    if (value == null) value = "";
    _idEstadoCivil = value;
  }

  String get cpf => _cpf;
  set cpf(String value){
    if (value == null) value = "";
    _cpf = value;
  }

  String get rg => _rg;
  set rg(String value){
    if (value == null) value = "";
    _rg = value;
  }

  String get orgaoRg => _orgaoRg;
  set orgaoRg(String value){
    if (value == null) value = "";
    _orgaoRg = value;
  }

  String get dataEmissaoRg => _dataEmissaoRg;
  set dataEmissaoRg(String value){
    if (value == null) value = "";
    _dataEmissaoRg = value;
  }

  String get dataNascimento => _dataNascimento;
  set dataNascimento(String value){
    if (value == null) value = "";
    _dataNascimento = value;
  }

  String get sexo => _sexo;
  set sexo(String value){
    if (value == null) value = "";
    _sexo = value;
  }

  String get raca => _raca;
  set raca(String value){
    if (value == null) value = "";
    _raca = value;
  }

  String get nacionalidade => _nacionalidade;
  set nacionalidade(String value){
    if (value == null) value = "";
    _nacionalidade = value;
  }

  String get naturalidade => _naturalidade;
  set naturalidade(String value){
    if (value == null) value = "";
    _naturalidade = value;
  }

  String get nomePai => _nomePai;
  set nomePai(String value){
    if (value == null) value = "";
    _nomePai = value;
  }

  String get nomeMae => _nomeMae;
  set nomeMae(String value){
    if (value == null) value = "";
    _nomeMae = value;
  }

  PessoaFisica.fromMap(Map m) {
    id = m["id"];
    idNivelFormacao = m["idNivelFormacao"];
    idEstadoCivil = m["idEstadoCivil"];
    cpf = m["cpf"];
    rg = m["rg"];
    orgaoRg = m["orgaoRg"];
    dataEmissaoRg = m["dataEmissaoRg"];
    dataNascimento = m["dataNascimento"];
    sexo = m["sexo"];
    raca = m["raca"];
    nacionalidade = m["nacionalidade"];
    naturalidade = m["naturalidade"];
    nomePai = m["nomePai"];
    nomeMae = m["nomeMae"];
  }

  Map<String, dynamic> get toMap {
    return {
      "id":_id,
      "idNivelFormacao":_idNivelFormacao,
      "idEstadoCivil":_idEstadoCivil,
      "cpf":_cpf,
      "rg":_rg,
      "orgaoRg":_orgaoRg,
      "dataEmissaoRg":_dataEmissaoRg,
      "dataNascimento":_dataNascimento,
      "sexo":_sexo,
      "raca":_raca,
      "nacionalidade":_nacionalidade,
      "naturalidade":_naturalidade,
      "nomePai":_nomePai,
      "nomeMae":_nomeMae,
    };
  }  

  @override
  int compareTo(PessoaFisica other) => _idEstadoCivil.compareTo(other._idEstadoCivil);
}