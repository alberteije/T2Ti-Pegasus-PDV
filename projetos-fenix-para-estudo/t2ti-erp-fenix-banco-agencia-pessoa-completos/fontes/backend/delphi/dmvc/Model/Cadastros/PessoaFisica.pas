unit PessoaFisica;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TPessoaFisica = class(TModelBase)
  private
    FID: Integer;
    FID_PESSOA: Integer;
    FID_NIVEL_FORMACAO: Integer;
    FID_ESTADO_CIVIL: Integer;
    FCPF: string;
    FRG: string;
    FORGAO_RG: string;
    FDATA_EMISSAO_RG: TDateTime;
    FDATA_NASCIMENTO: TDateTime;
    FSEXO: string;
    FRACA: string;
    FNACIONALIDADE: string;
    FNATURALIDADE: string;
    FNOME_MAE: string;
    FNOME_PAI: string;
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
    [MVCColumnAttribute('ID_NIVEL_FORMACAO')]
    [MVCNameAsAttribute('idNivelFormacao')]
    property IdNivelFormacao: Integer  read FID_NIVEL_FORMACAO write FID_NIVEL_FORMACAO;
    [MVCColumnAttribute('ID_ESTADO_CIVIL')]
    [MVCNameAsAttribute('idEstadoCivil')]
    property IdEstadoCivil: Integer  read FID_ESTADO_CIVIL write FID_ESTADO_CIVIL;
    [MVCColumnAttribute('CPF')]
    [MVCNameAsAttribute('cpf')]
    property Cpf: string  read FCPF write FCPF;
    [MVCColumnAttribute('RG')]
    [MVCNameAsAttribute('rg')]
    property Rg: string  read FRG write FRG;
    [MVCColumnAttribute('ORGAO_RG')]
    [MVCNameAsAttribute('orgaoRg')]
    property OrgaoRg: string  read FORGAO_RG write FORGAO_RG;
    [MVCColumnAttribute('DATA_EMISSAO_RG')]
    [MVCNameAsAttribute('dataEmissaoRg')]
    property DataEmissaoRg: TDateTime  read FDATA_EMISSAO_RG write FDATA_EMISSAO_RG;
    [MVCColumnAttribute('DATA_NASCIMENTO')]
    [MVCNameAsAttribute('dataNascimento')]
    property DataNascimento: TDateTime  read FDATA_NASCIMENTO write FDATA_NASCIMENTO;
    [MVCColumnAttribute('SEXO')]
    [MVCNameAsAttribute('sexo')]
    property Sexo: string  read FSEXO write FSEXO;
    [MVCColumnAttribute('RACA')]
    [MVCNameAsAttribute('raca')]
    property Raca: string  read FRACA write FRACA;
    [MVCColumnAttribute('NACIONALIDADE')]
    [MVCNameAsAttribute('nacionalidade')]
    property Nacionalidade: string  read FNACIONALIDADE write FNACIONALIDADE;
    [MVCColumnAttribute('NATURALIDADE')]
    [MVCNameAsAttribute('naturalidade')]
    property Naturalidade: string  read FNATURALIDADE write FNATURALIDADE;
    [MVCColumnAttribute('NOME_MAE')]
    [MVCNameAsAttribute('nomeMae')]
    property NomeMae: string  read FNOME_MAE write FNOME_MAE;
    [MVCColumnAttribute('NOME_PAI')]
    [MVCNameAsAttribute('nomePai')]
    property NomePai: string  read FNOME_PAI write FNOME_PAI;
  end;

implementation

{ TPessoaFisica }

procedure TPessoaFisica.ValidarInsercao;
begin
  inherited;

end;

procedure TPessoaFisica.ValidarAlteracao;
begin
  inherited;

end;

procedure TPessoaFisica.ValidarExclusao;
begin
  inherited;

end;

end.
