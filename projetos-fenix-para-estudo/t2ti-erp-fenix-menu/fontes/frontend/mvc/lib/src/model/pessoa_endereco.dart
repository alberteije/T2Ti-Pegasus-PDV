class PessoaEndereco implements Comparable<PessoaEndereco> {
  PessoaEndereco();

  String 
        _id,
        _idPessoa,
        _logradouro,
        _numero,
        _bairro,
        _municipioIbge,
        _uf,
        _cep,
        _cidade,
        _complemento,
        _principal,
        _entrega,
        _cobranca,
        _correspondencia;

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

  String get logradouro => _logradouro;
  set logradouro(String value){
    if (value == null) value = "";
    _logradouro = value;
  }

  String get numero => _numero;
  set numero(String value){
    if (value == null) value = "";
    _numero = value;
  }

  String get bairro => _bairro;
  set bairro(String value){
    if (value == null) value = "";
    _bairro = value;
  }

  String get municipioIbge => _municipioIbge;
  set municipioIbge(String value){
    if (value == null) value = "";
    _municipioIbge = value;
  }

  String get uf => _uf;
  set uf(String value){
    if (value == null) value = "";
    _uf = value;
  }

  String get cep => _cep;
  set cep(String value){
    if (value == null) value = "";
    _cep = value;
  }

  String get cidade => _cidade;
  set cidade(String value){
    if (value == null) value = "";
    _cidade = value;
  }

  String get complemento => _complemento;
  set complemento(String value){
    if (value == null) value = "";
    _complemento = value;
  }

  String get principal => _principal;
  set principal(String value){
    if (value == null) value = "";
    _principal = value;
  }

  String get entrega => _entrega;
  set entrega(String value){
    if (value == null) value = "";
    _entrega = value;
  }

  String get cobranca => _cobranca;
  set cobranca(String value){
    if (value == null) value = "";
    _cobranca = value;
  }

  String get correspondencia => _correspondencia;
  set correspondencia(String value){
    if (value == null) value = "";
    _correspondencia = value;
  }

  PessoaEndereco.fromMap(Map m) {
    id = m["id"];
    idPessoa = m["idPessoa"];
    logradouro = m["logradouro"];
    numero = m["numero"];
    bairro = m["bairro"];
    municipioIbge = m["municipioIbge"];
    uf = m["uf"];
    cep = m["cep"];
    cidade = m["cidade"];
    complemento = m["complemento"];
    principal = m["principal"];
    entrega = m["entrega"];
    cobranca = m["cobranca"];
    correspondencia = m["correspondencia"];
  }

  Map<String, dynamic> get toMap {
    return {
      "id":_id,
      "idPessoa":_idPessoa,
      "logradouro":_logradouro,
      "numero":_numero,
      "bairro":_bairro,
      "municipioIbge":_municipioIbge,
      "uf":_uf,
      "cep":_cep,
      "cidade":_cidade,
      "complemento":_complemento,
      "principal":_principal,
      "entrega":_entrega,
      "cobranca":_cobranca,
      "correspondencia":_correspondencia,
    };
  }  

  @override
  int compareTo(PessoaEndereco other) => _logradouro.compareTo(other._logradouro);
}