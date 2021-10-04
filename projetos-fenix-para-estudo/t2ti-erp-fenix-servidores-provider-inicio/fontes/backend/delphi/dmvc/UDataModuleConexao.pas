unit UDataModuleConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client;

type
  TFDataModuleConexao = class(TDataModule)
    Conexao: TFDConnection;
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

{$R *.dfm}

procedure TFDataModuleConexao.DataModuleCreate(Sender: TObject);
begin
  Conexao.Params.Clear;
  Conexao.Params.Add('DriverID=MySQL');
  Conexao.Params.Add('Server=localhost');
  Conexao.Params.Add('Port=3306');
  Conexao.Params.Add('Database=fenix');
  Conexao.Params.Add('CharacterSet=utf8');
  Conexao.Params.Add('User_Name=root');
  Conexao.Params.Add('Password=root');
  Conexao.DriverName := 'MySQL';
  Conexao.Connected := True;
end;

end.
