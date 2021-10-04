unit PessoaTelefone;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TPessoaTelefone = class(TModelBase)
  private
    FID: Integer;
    FID_PESSOA: Integer;
    FTIPO: string;
    FNUMERO: string;
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    [MVCColumnAttribute('ID', True)]
    [MVCNameAsAttribute('id')]
    property Id: Integer  read FID write FID;
    [MVCColumnAttribute('ID_PESSOA')]
    [MVCNameAsAttribute('idPessoa')]
    property IdPessoa: Integer  read FID_PESSOA write FID_PESSOA;
    [MVCColumnAttribute('TIPO')]
    [MVCNameAsAttribute('tipo')]
    property Tipo: string read FTIPO write FTIPO;
    [MVCColumnAttribute('NUMERO')]
    [MVCNameAsAttribute('numero')]
    property Numero: string read FNUMERO write FNUMERO;
  end;

implementation

{ TPessoaTelefone }

procedure TPessoaTelefone.ValidarInsercao;
begin
  inherited;

end;

procedure TPessoaTelefone.ValidarAlteracao;
begin
  inherited;

end;

procedure TPessoaTelefone.ValidarExclusao;
begin
  inherited;

end;

end.
