unit Banco;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TBanco = class(TModelBase)
  private
    FId: Integer;
    FCodigo: string;
    FNome: string;
    FUrl: string;
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    [MVCColumn('ID', True)]
    [MapperJSONSer('id')]
    property Id: Integer read FId write FId;
    [MVCColumn('CODIGO')]
    [MapperJSONSer('codigo')]
    property Codigo: string read FCodigo write FCodigo;
    [MVCColumn('NOME')]
    [MapperJSONSer('nome')]
    property Nome: string read FNome write FNome;
    [MVCColumn('URL')]
    [MapperJSONSer('url')]
    property Url: string read FUrl write FUrl;
  end;

implementation

{ TBanco }

procedure TBanco.ValidarInsercao;
begin
  inherited;

end;

procedure TBanco.ValidarAlteracao;
begin
  inherited;

end;

procedure TBanco.ValidarExclusao;
begin
  inherited;

end;

end.
