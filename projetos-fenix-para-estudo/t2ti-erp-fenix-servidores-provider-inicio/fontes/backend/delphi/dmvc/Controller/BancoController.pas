unit BancoController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD Banco')]
  [MVCPath('/banco')]
  TBancoController = class(TMVCController)
  public
    [MVCDoc('Retorna uma lista de objetos')]
    [MVCPath('/($filtro)')]
    [MVCHTTPMethod([httpGET])]
    procedure ConsultarLista(Context: TWebContext);

//    [MVCDoc('Retorna uma lista de objetos com base no Filtro')]
//    [MVCPath('/($campo)/($valor)')]
//    [MVCHTTPMethod([httpGET])]
//    procedure ConsultarListaFiltroValor(campo: string; valor: string);

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

{ TBancoController }

uses BancoService, Banco, Commons, Filtro;

procedure TBancoController.ConsultarLista(Context: TWebContext);
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
      Render<TBanco>(TBancoService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TBanco>(TBancoService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista Banco] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

//procedure TBancoController.ConsultarListaFiltroValor(campo, valor: string);
//begin
//  try
//    Render<TBanco>(TBancoService.ConsultarListaFiltroValor(campo, valor));
//  except
//    on E: EServiceException do
//    begin
//      raise EMVCException.Create
//        ('Erro no Servidor [Consultar Lista Filtro Valor Banco] - Exceção: ' + E.Message,
//        E.StackTrace, 0, 500);
//    end
//    else
//      raise;
//  end;
//end;

procedure TBancoController.ConsultarObjeto(id: Integer);
var
  Banco: TBanco;
begin
  try
    Banco := TBancoService.ConsultarObjeto(id);

    if Assigned(Banco) then
      Render(Banco)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto Banco]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto Banco] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TBancoController.Inserir(Context: TWebContext);
var
  Banco: TBanco;
begin
  try
    Banco := Context.Request.BodyAs<TBanco>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir Banco] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TBancoService.Inserir(Banco);
    Render(200, 'Objeto inserido com sucesso.');
  finally
    FreeAndNil(Banco);
  end;
end;

procedure TBancoController.Alterar(id: Integer);
var
  Banco, BancoDB: TBanco;
begin
  try
    Banco := Context.Request.BodyAs<TBanco>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar Banco] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if Banco.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar Banco] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  BancoDB := TBancoService.ConsultarObjeto(Banco.id);

  if not Assigned(BancoDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar Banco]',
      '', 0, 400);

  try
    TBancoService.Alterar(Banco);
    Render(200, 'Objeto alterado com sucesso.');
  finally
    FreeAndNil(Banco);
    FreeAndNil(BancoDB);
  end;
end;

procedure TBancoController.Excluir(id: Integer);
var
  Banco: TBanco;
begin
  Banco := TBancoService.ConsultarObjeto(id);

  if not Assigned(Banco) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir Banco]',
      '', 0, 400);

  try
    TBancoService.Excluir(Banco);
    Render(200, 'Objeto excluído com sucesso.');
  finally
    FreeAndNil(Banco)
  end;
end;

end.
