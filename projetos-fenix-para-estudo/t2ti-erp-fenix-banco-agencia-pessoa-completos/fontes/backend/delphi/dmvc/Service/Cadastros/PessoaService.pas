unit PessoaService;

interface

uses
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils,
  //
  Pessoa, PessoaFisica, PessoaJuridica, PessoaContato, PessoaTelefone, PessoaEndereco;

type

  TPessoaService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(const ListaPessoa: TObjectList<TPessoa>); overload;
    class procedure AnexarObjetosVinculados(const APessoa: TPessoa); overload;
    class procedure InserirObjetosFilhos(APessoa: TPessoa);
    class procedure ExcluirObjetosFilhos(APessoa: TPessoa);
  public
    class function ConsultarLista: TObjectList<TPessoa>;
    class function ConsultarListaFiltroValor(campo: string; valor: string): TObjectList<TPessoa>;
    class function ConsultarObjeto(const AId: Integer): TPessoa;
    class procedure Inserir(APessoa: TPessoa);
    class function Alterar(APessoa: TPessoa): Integer;
    class function Excluir(APessoa: TPessoa): Integer;
  end;

var
  sql: string;


implementation

{ TPessoaService }

class procedure TPessoaService.AnexarObjetosVinculados(const APessoa: TPessoa);
begin
  // Pessoa Física
  sql := 'SELECT * FROM PESSOA_FISICA WHERE ID_PESSOA = ' + APessoa.Id.ToString;
  APessoa.PessoaFisica := GetQuery(sql).AsObject<TPessoaFisica>;

  // Pessoa Jurídica
  sql := 'SELECT * FROM PESSOA_JURIDICA WHERE ID_PESSOA = ' + APessoa.Id.ToString;
  APessoa.PessoaJuridica := GetQuery(sql).AsObject<TPessoaJuridica>;

  // Pessoa Contato
  sql := 'SELECT * FROM PESSOA_CONTATO WHERE ID_PESSOA = ' + APessoa.Id.ToString;
  APessoa.ListaPessoaContato := GetQuery(sql).AsObjectList<TPessoaContato>;

  // Pessoa Telefone
  sql := 'SELECT * FROM PESSOA_TELEFONE WHERE ID_PESSOA = ' + APessoa.Id.ToString;
  APessoa.ListaPessoaTelefone := GetQuery(sql).AsObjectList<TPessoaTelefone>;

  // Pessoa Endereço
  sql := 'SELECT * FROM PESSOA_ENDERECO WHERE ID_PESSOA = ' + APessoa.Id.ToString;
  APessoa.ListaPessoaEndereco := GetQuery(sql).AsObjectList<TPessoaEndereco>;
end;

class procedure TPessoaService.AnexarObjetosVinculados(const ListaPessoa: TObjectList<TPessoa>);
var
  Pessoa: TPessoa;
begin
  for Pessoa in ListaPessoa do
  begin
    AnexarObjetosVinculados(Pessoa);
  end;
end;

class function TPessoaService.ConsultarLista: TObjectList<TPessoa>;
begin
  sql := 'SELECT * FROM PESSOA ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TPessoa>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TPessoaService.ConsultarListaFiltroValor(campo, valor: string): TObjectList<TPessoa>;
begin
  sql := 'SELECT * FROM PESSOA where ' + campo + ' like "%' + valor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TPessoa>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TPessoaService.ConsultarObjeto(const AId: Integer): TPessoa;
begin
  sql := 'SELECT * FROM PESSOA WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TPessoa>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TPessoaService.Inserir(APessoa: TPessoa);
begin
  APessoa.ValidarInsercao;
  APessoa.Id := InserirBase(APessoa, 'PESSOA');

  InserirObjetosFilhos(APessoa);
end;

class function TPessoaService.Alterar(APessoa: TPessoa): Integer;
begin
  APessoa.ValidarAlteracao;
  Result := AlterarBase(APessoa, 'PESSOA');

  ExcluirObjetosFilhos(APessoa);
  InserirObjetosFilhos(APessoa);
end;

class procedure TPessoaService.InserirObjetosFilhos(APessoa: TPessoa);
var
  Contato: TPessoaContato;
  Endereco: TPessoaEndereco;
  Telefone: TPessoaTelefone;
begin
  // Pessoa Física
  if APessoa.PessoaFisica.Cpf <> '' then
  begin
    APessoa.PessoaFisica.IdPessoa := APessoa.Id;
    InserirBase(APessoa.PessoaFisica, 'PESSOA_FISICA');
  end;

  // Pessoa Jurídica
  if APessoa.PessoaJuridica.Cnpj <> '' then
  begin
    APessoa.PessoaJuridica.IdPessoa := APessoa.Id;
    InserirBase(APessoa.PessoaJuridica, 'PESSOA_JURIDICA');
  end;

  // Contatos
  for Contato in APessoa.ListaPessoaContato do
  begin
    Contato.IdPessoa := APessoa.Id;
    InserirBase(Contato, 'PESSOA_CONTATO');
  end;

  // Telefones
  for Telefone in APessoa.ListaPessoaTelefone do
  begin
    Telefone.IdPessoa := APessoa.Id;
    InserirBase(Telefone, 'PESSOA_TELEFONE');
  end;

  // Enderecos
  for Endereco in APessoa.ListaPessoaEndereco do
  begin
    Endereco.IdPessoa := APessoa.Id;
    InserirBase(Endereco, 'PESSOA_ENDERECO');
  end;
end;

class function TPessoaService.Excluir(APessoa: TPessoa): Integer;
begin
  APessoa.ValidarExclusao;
  ExcluirObjetosFilhos(APessoa);
  Result := ExcluirBase(APessoa.Id, 'PESSOA');
end;

class procedure TPessoaService.ExcluirObjetosFilhos(APessoa: TPessoa);
begin
  ExcluirFilho(APessoa.Id, 'PESSOA_FISICA', 'ID_PESSOA');
  ExcluirFilho(APessoa.Id, 'PESSOA_JURIDICA', 'ID_PESSOA');
  ExcluirFilho(APessoa.Id, 'PESSOA_CONTATO', 'ID_PESSOA');
  ExcluirFilho(APessoa.Id, 'PESSOA_TELEFONE', 'ID_PESSOA');
  ExcluirFilho(APessoa.Id, 'PESSOA_ENDERECO', 'ID_PESSOA');
end;

end.
