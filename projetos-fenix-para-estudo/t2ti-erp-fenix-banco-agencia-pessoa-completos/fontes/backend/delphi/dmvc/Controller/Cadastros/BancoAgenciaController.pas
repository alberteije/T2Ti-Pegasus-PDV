unit BancoAgenciaController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD Banco Agencia')]
  [MVCPath('/banco-agencia')]
  TBancoAgenciaController = class(TMVCController)
  public
    [MVCDoc('Retorna uma lista de objetos')]
    [MVCPath('/($filtro)')]
    [MVCHTTPMethod([httpGET])]
    procedure ConsultarLista(Context: TWebContext);

    [MVCDoc('Retorna um objeto com base no ID')]
    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpGET])]
    procedure ConsultarObjeto(id: Integer);

    [MVCDoc('Insere um novo objeto')]
    [MVCPath]
    [MVCHTTPMethod([httpPOST])]
    procedure Inserir(Context: TWebContext);

    [MVCDoc('Altera um objeto com base no ID')]
    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpPUT])]
    procedure Alterar(id: Integer);

    [MVCDoc('Exclui um objeto com base no ID')]
    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpDelete])]
    procedure Excluir(id: Integer);
  end;

implementation

{ TBancoAgenciaController }

uses BancoAgenciaService, BancoAgencia, Commons, Filtro;

procedure TBancoAgenciaController.ConsultarLista(Context: TWebContext);
var
  FiltroUrl, FilterWhere: string;
  FiltroObj: TFiltro;
begin
  FiltroUrl := Context.Request.Params['filtro'];
  if FiltroUrl <> '' then
  begin
    ConsultarObjeto(StrToInt(FiltroUrl));
    exit;
  end;

  filterWhere := Context.Request.Params['filter'];
  try
    if FilterWhere = '' then
    begin
      Render<TBancoAgencia>(TBancoAgenciaService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TBancoAgencia>(TBancoAgenciaService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista Banco Agencia] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TBancoAgenciaController.ConsultarObjeto(id: Integer);
var
  BancoAgencia: TBancoAgencia;
begin
  try
    BancoAgencia := TBancoAgenciaService.ConsultarObjeto(id);

    if Assigned(BancoAgencia) then
      Render(BancoAgencia)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto Banco Agencia]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto Banco Agencia] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TBancoAgenciaController.Inserir(Context: TWebContext);
var
  BancoAgencia: TBancoAgencia;
begin
  try
    BancoAgencia := Context.Request.BodyAs<TBancoAgencia>;
    BancoAgencia.IdBanco := BancoAgencia.Banco.Id;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir Banco Agencia] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TBancoAgenciaService.Inserir(BancoAgencia);
    Render(TBancoAgenciaService.ConsultarObjeto(BancoAgencia.Id));
  finally
  end;
end;

procedure TBancoAgenciaController.Alterar(id: Integer);
var
  BancoAgencia, BancoAgenciaDB: TBancoAgencia;
begin
  try
    BancoAgencia := Context.Request.BodyAs<TBancoAgencia>;
    BancoAgencia.IdBanco := BancoAgencia.Banco.Id;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar Banco Agencia] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if BancoAgencia.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar Banco Agencia] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  BancoAgenciaDB := TBancoAgenciaService.ConsultarObjeto(BancoAgencia.id);

  if not Assigned(BancoAgenciaDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar Banco Agencia]',
      '', 0, 400);

  try
    if TBancoAgenciaService.Alterar(BancoAgencia) > 0 then
      Render(TBancoAgenciaService.ConsultarObjeto(BancoAgencia.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar Banco]',
        '', 0, 500);
  finally
    FreeAndNil(BancoAgenciaDB);
  end;
end;

procedure TBancoAgenciaController.Excluir(id: Integer);
var
  BancoAgencia: TBancoAgencia;
begin
  BancoAgencia := TBancoAgenciaService.ConsultarObjeto(id);

  if not Assigned(BancoAgencia) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir Banco Agencia]',
      '', 0, 400);

  try
    if TBancoAgenciaService.Excluir(BancoAgencia) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir Banco Agencia]',
        '', 0, 500);
  finally
    FreeAndNil(BancoAgencia)
  end;
end;

end.
