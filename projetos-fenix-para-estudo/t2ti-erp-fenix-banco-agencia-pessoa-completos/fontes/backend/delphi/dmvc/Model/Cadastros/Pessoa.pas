unit Pessoa;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase, Generics.Collections, System.SysUtils,
  PessoaFisica, PessoaJuridica, PessoaContato, PessoaTelefone, PessoaEndereco;

type

  [MVCNameCase(ncLowerCase)]
  TPessoa = class(TModelBase)
  private
    FID: Integer;
    FNOME: string;
    FTIPO: string;
    FSITE: string;
    FEMAIL: string;
    FCLIENTE: string;
    FFORNECEDOR: string;
    FTRANSPORTADORA: string;
    FCOLABORADOR: string;
    FCONTADOR: string;

    FPessoaFisica: TPessoaFisica;
    FPessoaJuridica: TPessoaJuridica;

    FListaPessoaContato: TObjectList<TPessoaContato>;
    FListaPessoaEndereco: TObjectList<TPessoaEndereco>;
    FListaPessoaTelefone: TObjectList<TPessoaTelefone>;
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    constructor Create; virtual;
    destructor Destroy; override;

    [MVCColumnAttribute('ID', True)]
    [MVCNameAsAttribute('id')]
    property Id: Integer  read FID write FID;
    [MVCColumnAttribute('NOME')]
    [MVCNameAsAttribute('nome')]
    property Nome: string  read FNOME write FNOME;
    [MVCColumnAttribute('TIPO')]
    [MVCNameAsAttribute('tipo')]
    property Tipo: string  read FTIPO write FTIPO;
    [MVCColumnAttribute('SITE')]
    [MVCNameAsAttribute('site')]
    property Site: string  read FSITE write FSITE;
    [MVCColumnAttribute('EMAIL')]
    [MVCNameAsAttribute('email')]
    property Email: string  read FEMAIL write FEMAIL;
    [MVCColumnAttribute('CLIENTE')]
    [MVCNameAsAttribute('cliente')]
    property Cliente: string  read FCLIENTE write FCLIENTE;
    [MVCColumnAttribute('FORNECEDOR')]
    [MVCNameAsAttribute('fornecedor')]
    property Fornecedor: string  read FFORNECEDOR write FFORNECEDOR;
    [MVCColumnAttribute('TRANSPORTADORA')]
    [MVCNameAsAttribute('transportadora')]
    property Transportadora: string  read FTRANSPORTADORA write FTRANSPORTADORA;
    [MVCColumnAttribute('COLABORADOR')]
    [MVCNameAsAttribute('colaborador')]
    property Colaborador: string  read FCOLABORADOR write FCOLABORADOR;
    [MVCColumnAttribute('CONTADOR')]
    [MVCNameAsAttribute('contador')]
    property Contador: string  read FCONTADOR write FCONTADOR;

    // objetos vinculados
    [MVCNameAsAttribute('pessoaFisica')]
    property PessoaFisica: TPessoaFisica read FPessoaFisica write FPessoaFisica;

    [MVCNameAsAttribute('pessoaJuridica')]
    property PessoaJuridica: TPessoaJuridica read FPessoaJuridica write FPessoaJuridica;

    [MapperListOf(TPessoaContato)]
    [MVCNameAsAttribute('listaPessoaContato')]
    property ListaPessoaContato: TObjectList<TPessoaContato> read FListaPessoaContato write FListaPessoaContato;

    [MapperListOf(TPessoaTelefone)]
    [MVCNameAsAttribute('listaPessoaTelefone')]
    property ListaPessoaTelefone: TObjectList<TPessoaTelefone> read FListaPessoaTelefone write FListaPessoaTelefone;

    [MapperListOf(TPessoaEndereco)]
    [MVCNameAsAttribute('listaPessoaEndereco')]
    property ListaPessoaEndereco: TObjectList<TPessoaEndereco> read FListaPessoaEndereco write FListaPessoaEndereco;
  end;

implementation

{ TPessoa }

constructor TPessoa.Create;
begin
  FPessoaFisica := TPessoaFisica.Create;
  FPessoaJuridica := TPessoaJuridica.Create;
//
  FListaPessoaContato := TObjectList<TPessoaContato>.Create;
  FListaPessoaEndereco := TObjectList<TPessoaEndereco>.Create;
  FListaPessoaTelefone := TObjectList<TPessoaTelefone>.Create;
end;

destructor TPessoa.Destroy;
begin
  FreeAndNil(FListaPessoaContato);
  FreeAndNil(FListaPessoaEndereco);
  FreeAndNil(FListaPessoaTelefone);
//
  FreeAndNil(FPessoaFisica);
  FreeAndNil(FPessoaJuridica);
  inherited;
end;

procedure TPessoa.ValidarInsercao;
begin
  inherited;

end;

procedure TPessoa.ValidarAlteracao;
begin
  inherited;

end;

procedure TPessoa.ValidarExclusao;
begin
  inherited;

end;

end.
