unit PessoaContato;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TPessoaContato = class(TModelBase)
  private
    FID: Integer;
    FID_PESSOA: Integer;
    FNOME: String;
    FEMAIL: String;
    FOBSERVACAO: string;
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
    [MVCColumnAttribute('NOME')]
    [MVCNameAsAttribute('nome')]
    property Nome: string read FNOME write FNOME;
    [MVCColumnAttribute('EMAIL')]
    [MVCNameAsAttribute('email')]
    property Email: string  read FEMAIL write FEMAIL;
    [MVCColumnAttribute('OBSERVACAO')]
    [MVCNameAsAttribute('observacao')]
    property Observacao: string read FOBSERVACAO write FOBSERVACAO;
  end;

implementation

{ TPessoaContato }

procedure TPessoaContato.ValidarInsercao;
begin
  inherited;

end;

procedure TPessoaContato.ValidarAlteracao;
begin
  inherited;

end;

procedure TPessoaContato.ValidarExclusao;
begin
  inherited;

end;

end.
