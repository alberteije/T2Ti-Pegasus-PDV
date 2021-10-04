unit PessoaEndereco;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TPessoaEndereco = class(TModelBase)
  private
    FID: Integer;
    FID_PESSOA: Integer;
    FLOGRADOURO: string;
    FNUMERO: string;
    FCOMPLEMENTO: string;
    FBAIRRO: string;
    FCIDADE: string;
    FCEP: string;
    FMUNICIPIO_IBGE: Integer;
    FUF: string;
    FPRINCIPAL: string;
    FENTREGA: string;
    FCOBRANCA: string;
    FCORRESPONDENCIA: string;
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
    [MVCColumnAttribute('LOGRADOURO')]
    [MVCNameAsAttribute('logradouro')]
    property Logradouro: string  read FLOGRADOURO write FLOGRADOURO;
    [MVCColumnAttribute('NUMERO')]
    [MVCNameAsAttribute('numero')]
    property Numero: string  read FNUMERO write FNUMERO;
    [MVCColumnAttribute('COMPLEMENTO')]
    [MVCNameAsAttribute('complemento')]
    property Complemento: string  read FCOMPLEMENTO write FCOMPLEMENTO;
    [MVCColumnAttribute('BAIRRO')]
    [MVCNameAsAttribute('bairro')]
    property Bairro: string  read FBAIRRO write FBAIRRO;
    [MVCColumnAttribute('CIDADE')]
    [MVCNameAsAttribute('cidade')]
    property Cidade: string  read FCIDADE write FCIDADE;
    [MVCColumnAttribute('CEP')]
    [MVCNameAsAttribute('cep')]
    property Cep: string  read FCEP write FCEP;
    [MVCColumnAttribute('MUNICIPIO_IBGE')]
    [MVCNameAsAttribute('municipioIbge')]
    property MunicipioIbge: Integer  read FMUNICIPIO_IBGE write FMUNICIPIO_IBGE;
    [MVCColumnAttribute('UF')]
    [MVCNameAsAttribute('uf')]
    property Uf: string  read FUF write FUF;
    [MVCColumnAttribute('PRINCIPAL')]
    [MVCNameAsAttribute('principal')]
    property Principal: string  read FPRINCIPAL write FPRINCIPAL;
    [MVCColumnAttribute('ENTREGA')]
    [MVCNameAsAttribute('entrega')]
    property Entrega: string  read FENTREGA write FENTREGA;
    [MVCColumnAttribute('COBRANCA')]
    [MVCNameAsAttribute('cobranca')]
    property Cobranca: string  read FCOBRANCA write FCOBRANCA;
    [MVCColumnAttribute('CORRESPONDENCIA')]
    [MVCNameAsAttribute('correpondencia')]
    property Correspondencia: string  read FCORRESPONDENCIA write FCORRESPONDENCIA;
  end;

implementation

{ TPessoaEndereco }

procedure TPessoaEndereco.ValidarInsercao;
begin
  inherited;

end;

procedure TPessoaEndereco.ValidarAlteracao;
begin
  inherited;

end;

procedure TPessoaEndereco.ValidarExclusao;
begin
  inherited;

end;

end.
