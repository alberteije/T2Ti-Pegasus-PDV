unit PessoaJuridica;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TPessoaJuridica = class(TModelBase)
  private
    FID: Integer;
    FID_PESSOA: Integer;
    FCNPJ: string;
    FNOME_FANTASIA: string;
    FINSCRICAO_ESTADUAL: string;
    FINSCRICAO_MUNICIPAL: string;
    FDATA_CONSTITUICAO: TDateTime;
    FTIPO_REGIME: string;
    FCRT: string;
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
    [MVCColumnAttribute('CNPJ')]
    [MVCNameAsAttribute('cnpj')]
    property Cnpj: string  read FCNPJ write FCNPJ;
    [MVCColumnAttribute('NOME_FANTASIA')]
    [MVCNameAsAttribute('nomeFantasia')]
    property NomeFantasia: string  read FNOME_FANTASIA write FNOME_FANTASIA;
    [MVCColumnAttribute('INSCRICAO_ESTADUAL')]
    [MVCNameAsAttribute('inscricaoEstadual')]
    property InscricaoEstadual: string  read FINSCRICAO_ESTADUAL write FINSCRICAO_ESTADUAL;
    [MVCColumnAttribute('INSCRICAO_MUNICIPAL')]
    [MVCNameAsAttribute('inscricaoMunicipal')]
    property InscricaoMunicipal: string  read FINSCRICAO_MUNICIPAL write FINSCRICAO_MUNICIPAL;
    [MVCColumnAttribute('DATA_CONSTITUICAO')]
    [MVCNameAsAttribute('dataConstituicao')]
    property DataConstituicao: TDateTime  read FDATA_CONSTITUICAO write FDATA_CONSTITUICAO;
    [MVCColumnAttribute('TIPO_REGIME')]
    [MVCNameAsAttribute('tipoRegime')]
    property tipoRegime: string  read FTIPO_REGIME write FTIPO_REGIME;
    [MVCColumnAttribute('CRT')]
    [MVCNameAsAttribute('crt')]
    property Crt: string  read FCRT write FCRT;
  end;

implementation

{ TPessoaJuridica }

procedure TPessoaJuridica.ValidarInsercao;
begin
  inherited;

end;

procedure TPessoaJuridica.ValidarAlteracao;
begin
  inherited;

end;

procedure TPessoaJuridica.ValidarExclusao;
begin
  inherited;

end;

end.
