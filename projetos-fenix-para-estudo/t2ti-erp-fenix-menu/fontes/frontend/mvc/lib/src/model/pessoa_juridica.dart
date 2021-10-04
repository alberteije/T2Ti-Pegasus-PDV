class PessoaJuridica implements Comparable<PessoaJuridica> {
  PessoaJuridica(
    this._id,
    this._idPessoa,
    this._cnpj,
    this._nomeFantasia,
    this._inscricaoEstadual,
    this._inscricaoMunicipal,
    this._dataConstituicao,
    this._tipoRegime,
    this._crt,
  );

  String 
        _id,
        _idPessoa,
        _cnpj,
        _nomeFantasia,
        _inscricaoEstadual,
        _inscricaoMunicipal,
        _dataConstituicao,
        _tipoRegime,
        _crt;

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

  String get cnpj => _cnpj;
  set cnpj(String value){
    if (value == null) value = "";
    _cnpj = value;
  }

  String get nomeFantasia => _nomeFantasia;
  set nomeFantasia(String value){
    if (value == null) value = "";
    _nomeFantasia = value;
  }

  String get inscricaoEstadual => _inscricaoEstadual;
  set inscricaoEstadual(String value){
    if (value == null) value = "";
    _inscricaoEstadual = value;
  }

  String get inscricaoMunicipal => _inscricaoMunicipal;
  set inscricaoMunicipal(String value){
    if (value == null) value = "";
    _inscricaoMunicipal = value;
  }

  String get dataConstituicao => _dataConstituicao;
  set dataConstituicao(String value){
    if (value == null) value = "";
    _dataConstituicao = value;
  }

  String get tipoRegime => _tipoRegime;
  set tipoRegime(String value){
    if (value == null) value = "";
    _tipoRegime = value;
  }

  String get crt => _crt;
  set crt(String value){
    if (value == null) value = "";
    _crt = value;
  }

  PessoaJuridica.fromMap(Map m) {
    id = m["id"];
    idPessoa = m["idPessoa"];
    cnpj = m["cnpj"];
    nomeFantasia = m["nomeFantasia"];
    inscricaoEstadual = m["inscricaoEstadual"];
    inscricaoMunicipal = m["inscricaoMunicipal"];
    dataConstituicao = m["dataConstituicao"];
    tipoRegime = m["tipoRegime"];
    crt = m["crt"];
  }

  Map<String, dynamic> get toMap {
    return {
      "id":_id,
      "idPessoa":_idPessoa,
      "cnpj":_cnpj,
      "nomeFantasia":_nomeFantasia,
      "inscricaoEstadual":_inscricaoEstadual,
      "inscricaoMunicipal":_inscricaoMunicipal,
      "dataConstituicao":_dataConstituicao,
      "tipoRegime":_tipoRegime,
      "crt":_crt,
    };
  }  

  @override
  int compareTo(PessoaJuridica other) => _cnpj.compareTo(other._cnpj);
}