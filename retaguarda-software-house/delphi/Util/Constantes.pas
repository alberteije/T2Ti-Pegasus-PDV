{ *******************************************************************************
Title: T2Ti ERP
Description: Unit para armazenas as constantes do sistema

The MIT License

Copyright: Copyright (C) 2020 T2Ti.COM

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

The author may be contacted at:
t2ti.com@gmail.com</p>

@author Albert Eije (T2Ti.COM)
@version 3.0
******************************************************************************* }
unit Constantes;

interface

uses
  IniFiles;

type

  TConstantes = class
    const
      {$WRITEABLECONST ON}
      MAXIMO_REGISTROS_RETORNADOS = 50;
      QUANTIDADE_POR_PAGINA = 50;
      DECIMAIS_QUANTIDADE: Integer = 3;
      DECIMAIS_VALOR: Integer = 2;
      // carregados do arquivo INI
      CHAVE: string = '';
      ENDERECO_SERVIDOR: string = '';
      PORTA_SERVIDOR: string = '';
      ROTA_JWT: string = '';
      BD_SERVER: string = '';
      BD_PORTA: string = '';
      BD_BANCO: string = '';
      BD_USUARIO: string = '';
      BD_SENHA: string = '';
      {$WRITEABLECONST OFF}
    public
      constructor Create;
  end;

implementation

constructor TConstantes.Create;
var
  IniFile: TIniFile;
begin
  inherited;

  try
    IniFile := TIniFile.Create('c:\t2ti\ini\config-server.ini');

    // servidor
    CHAVE := IniFile.ReadString('Servidor', 'chave', '');
    ENDERECO_SERVIDOR := IniFile.ReadString('Servidor', 'endereco', '');
    PORTA_SERVIDOR := IniFile.ReadString('Servidor', 'porta', '');
    ROTA_JWT := IniFile.ReadString('Servidor', 'rotajwt', '');

    // banco de dados
    BD_SERVER := IniFile.ReadString('MySQL', 'servidor', '');
    BD_PORTA := IniFile.ReadString('MySQL', 'porta', '');
    BD_BANCO := IniFile.ReadString('MySQL', 'banco', '');
    BD_USUARIO := IniFile.ReadString('MySQL', 'usuario', '');
    BD_SENHA := IniFile.ReadString('MySQL', 'senha', '');
  finally
    IniFile.Free;
  end;
end;

end.
