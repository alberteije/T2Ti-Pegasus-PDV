/// Classe que armazena listas fixas que são carregadas em DropdownButtons
class DropdownLista {
  /// singleton
  factory DropdownLista() {
    _this ??= DropdownLista._();
    return _this;
  }
  static DropdownLista _this;
  DropdownLista._() : super();

  static const List<String> listaUF = <String>[
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO'
  ];

}
