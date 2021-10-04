class Banco implements Comparable<Banco> {
  Banco();

  String 
        _id,
        _codigo,
        _nome,
        _url;

  String get id => _id;
  set id(String value){
    if (value == null) value = "";
    _id = value;
  }

  String get codigo => _codigo;
  set codigo(String value){
    if (value == null) value = "";
    _codigo = value;
  }

  String get nome => _nome;
  set nome(String value){
    if (value == null) value = "";
    _nome = value;
  }

  String get url => _url;
  set url(String value){
    if (value == null) value = "";
    _url = value;
  }

  Banco.fromMap(Map m) {
    id = m["id"];
    codigo = m["codigo"];
    nome = m["nome"];
    url = m["url"];
  }

  Map<String, dynamic> get toMap {
    return {
      "id": _id,
      "codigo": _codigo,
      "nome": _nome,
      "url": _url,
    };
  }
  
  @override
  int compareTo(Banco other) => _nome.toLowerCase().compareTo(other._nome.toLowerCase());  
}

