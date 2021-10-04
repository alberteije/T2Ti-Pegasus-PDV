unit BancoAgencia;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase, Banco;

type

  [MVCNameCase(ncLowerCase)]
  TBancoAgencia = class(TModelBase)
  private
    FID: Integer;
    FID_BANCO: Integer;
    FNUMERO: string;
    FDIGITO: string;
    FNOME: string;
    FTELEFONE: string;
    FCONTATO: string;
    FOBSERVACAO: string;
    FGERENTE: string;

    FBanco: TBanco;
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    constructor Create; virtual;
    destructor Destroy; override;

    [MVCColumnAttribute('ID', True)]
    [MVCNameAsAttribute('id')]
    property Id: Integer read FID write FID;
    [MVCColumnAttribute('ID_BANCO')]
    [MVCNameAsAttribute('idBanco')]
    property IdBanco: Integer read FID_BANCO write FID_BANCO;
    [MVCColumnAttribute('NUMERO')]
    [MVCNameAsAttribute('numero')]
    property Numero: string read FNUMERO write FNUMERO;
    [MVCColumnAttribute('DIGITO')]
    [MVCNameAsAttribute('digito')]
    property Digito: string read FDIGITO write FDIGITO;
    [MVCColumnAttribute('NOME')]
    [MVCNameAsAttribute('nome')]
    property Nome: string read FNOME write FNOME;
    [MVCColumnAttribute('TELEFONE')]
    [MVCNameAsAttribute('telefone')]
    property Telefone: string read FTELEFONE write FTELEFONE;
    [MVCColumnAttribute('CONTATO')]
    [MVCNameAsAttribute('contato')]
    property Contato: string read FCONTATO write FCONTATO;
    [MVCColumnAttribute('OBSERVACAO')]
    [MVCNameAsAttribute('observacao')]
    property Observacao: string read FOBSERVACAO write FOBSERVACAO;
    [MVCColumnAttribute('GERENTE')]
    [MVCNameAsAttribute('gerente')]
    property Gerente: string read FGERENTE write FGERENTE;

    // objetos vinculados
    [MVCNameAsAttribute('banco')]
    property Banco: TBanco read FBanco write FBanco;
  end;

implementation

{ TBancoAgencia }

constructor TBancoAgencia.Create;
begin
  FBanco := TBanco.Create;
end;

destructor TBancoAgencia.Destroy;
begin
  FBanco.Free;
  inherited;
end;

procedure TBancoAgencia.ValidarInsercao;
begin
  inherited;

end;

procedure TBancoAgencia.ValidarAlteracao;
begin
  inherited;

end;

procedure TBancoAgencia.ValidarExclusao;
begin
  inherited;

end;

end.
