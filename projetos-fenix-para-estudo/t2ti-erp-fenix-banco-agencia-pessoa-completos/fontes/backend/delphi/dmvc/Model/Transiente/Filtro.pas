/// classe transiente que controla o filtro
/// tomar como base o seguinte esquema para criar as condições de filtro (filter conditions)
/// https://github.com/nestjsx/crud/wiki/Requests
unit Filtro;

interface

uses
  Classes, System.StrUtils, System.SysUtils;

type

  TFiltro = class
  private
    FCampo: string;
    FValor: string;
    FDataInicial: TDateTime;
    FDataFinal: TDateTime;
    FWhere: string;
  public
    constructor Create(Filter: string);

    property Campo: string read FCampo write FCampo;
    property Valor: string read FValor write FValor;
    property DataInicial: TDateTime read FDataInicial write FDataInicial;
    property DataFinal: TDateTime read FDataFinal write FDataFinal;
    property Where: string read FWhere write FWhere;
  end;

implementation

{ TFiltro }

constructor TFiltro.Create(Filter: string);
var
  Condicoes: TStrings;
begin
  Condicoes := TStringList.Create;
  try
    Filter := StringReplace(Filter, '||', '-', [rfReplaceAll, rfIgnoreCase]);
    ExtractStrings(['-'], [], PChar(Filter), Condicoes);

    // $cont (LIKE %val%, contains)
    if Condicoes[1] = '$cont' then
    begin
      Campo := Condicoes[0];
      Valor := Condicoes[2];
    end;

  finally
    Condicoes.Free;
  end;
end;

end.
