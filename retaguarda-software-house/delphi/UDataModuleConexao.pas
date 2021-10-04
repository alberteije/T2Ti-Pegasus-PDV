unit UDataModuleConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL,
  FireDAC.DApt.Intf,
  FireDAC.DApt;

type
  TFDataModuleConexao = class(TDataModule)
    Conexao: TFDConnection;
    FDTransaction: TFDTransaction;
    FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FDataModuleConexao: TFDataModuleConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Constantes;

{$R *.dfm}

procedure TFDataModuleConexao.DataModuleCreate(Sender: TObject);
begin
  Conexao.Params.Clear;
  Conexao.Params.Add('DriverID=MySQL');
  Conexao.Params.Add('Server=' + TConstantes.BD_SERVER);
  Conexao.Params.Add('Port=' + TConstantes.BD_PORTA);
  Conexao.Params.Add('Database=' + TConstantes.BD_BANCO);
  Conexao.Params.Add('CharacterSet=utf8');
  Conexao.Params.Add('User_Name=' + TConstantes.BD_USUARIO);
  Conexao.Params.Add('Password=' + TConstantes.BD_SENHA);
  Conexao.DriverName := 'MySQL';
  Conexao.Connected := True;
end;

end.
