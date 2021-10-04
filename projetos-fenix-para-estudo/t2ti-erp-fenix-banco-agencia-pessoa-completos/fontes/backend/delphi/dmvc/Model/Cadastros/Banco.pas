unit Banco;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TBanco = class(TModelBase)
  private
    FID: Integer;
    FCODIGO: string;
    FNOME: string;
    FURL: string;
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    [MVCColumnAttribute('ID', True)]
    [MVCNameAsAttribute('id')]
    property Id: Integer read FID write FID;
    [MVCColumnAttribute('CODIGO')]
    [MVCNameAsAttribute('codigo')]
    property Codigo: string read FCODIGO write FCODIGO;
    [MVCColumnAttribute('NOME')]
    [MVCNameAsAttribute('nome')]
    property Nome: string read FNOME write FNOME;
    [MVCColumnAttribute('URL')]
    [MVCNameAsAttribute('url')]
    property Url: string read FURL write FURL;
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
