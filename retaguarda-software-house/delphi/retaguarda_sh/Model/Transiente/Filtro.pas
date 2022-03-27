/// classe transiente que controla o filtro
/// tomar como base o seguinte esquema para criar as condições de filtro (filter conditions)
/// https://github.com/nestjsx/crud/wiki/Requests
/// Syntax:
///    ?filter=field||$condition||value

unit Filtro;

interface

uses
  Classes, System.StrUtils, System.SysUtils;

type

  TFiltro = class
  private
    FCampo: string;
    FValor: string;
    FDataInicial: string;
    FDataFinal: string;
    FCondicao: string;
    FWhere: string;
  public
    constructor Create(Filter: string);

    property Campo: string read FCampo write FCampo;
    property Valor: string read FValor write FValor;
    property DataInicial: string read FDataInicial write FDataInicial;
    property DataFinal: string read FDataFinal write FDataFinal;
    property Condicao: string read FCondicao write FCondicao;
    property Where: string read FWhere write FWhere;
  end;

implementation

{ TFiltro }

constructor TFiltro.Create(Filter: string);
var
  Condicoes: TStrings;
  Datas: TStrings;
  PartesDoFiltro: TStrings;
  I: Integer;
begin
  PartesDoFiltro := TStringList.Create;
  Condicoes := TStringList.Create;
  Datas := TStringList.Create;
  try
    Filter := StringReplace(Filter, '||', '*', [rfReplaceAll, rfIgnoreCase]);

    // separa as partes do filtro, caso existam
    ExtractStrings(['?'], [], PChar(Filter), PartesDoFiltro);

    for I := 0 to PartesDoFiltro.Count - 1 do
    begin
      Condicoes.Clear;
      ExtractStrings(['*'], [], PChar(PartesDoFiltro[I]), Condicoes);

      Condicao := Condicoes[1];

      if I > 0 then
        Where := Where + ' AND ';

      // $cont (LIKE %val%, contains)
      if Condicao = '$cont' then
      begin
        Campo := Condicoes[0];
        Valor := Condicoes[2];
        Where := Where + Campo + ' like "%' + Valor + '%"';
      end;

      // $eq (=, equal)
      if Condicao = '$eq' then
      begin
        Campo := Condicoes[0];
        Valor := Condicoes[2];
        Where := Where + Campo + ' = "' + Valor + '"';
      end;

      // $between (BETWEEN, between, accepts two values)
      if Condicao = '$between' then
      begin
        Campo := Condicoes[0];
        ExtractStrings([','], [], PChar(Condicoes[2]), Datas);
        DataInicial := Datas[0];
        DataFinal := Datas[1];
        Where := Where + Campo + ' between ' + QuotedStr(DataInicial) + ' and ' + QuotedStr(DataFinal);
      end;
    end;

  finally
    Condicoes.Free;
	  Datas.Free;
    PartesDoFiltro.Free;
  end;
end;

end.
