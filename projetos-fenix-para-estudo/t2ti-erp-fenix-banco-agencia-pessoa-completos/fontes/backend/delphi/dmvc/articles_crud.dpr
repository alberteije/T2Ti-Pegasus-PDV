program articles_crud;

{$APPTYPE CONSOLE}


uses
  System.SysUtils,
  IdHTTPWebBrokerBridge,
  Web.WebReq,
  Web.WebBroker,
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  Controllers.Base in 'Controllers.Base.pas',
  Controllers.Articles in 'Controllers.Articles.pas',
  Services in 'Services.pas',
  BusinessObjects in 'BusinessObjects.pas',
  MainDM in 'MainDM.pas' {dmMain: TDataModule},
  Commons in 'Commons.pas',
  UDataModuleConexao in 'UDataModuleConexao.pas' {FDataModuleConexao: TDataModule},
  ModelBase in 'Model\ModelBase.pas',
  ServiceBase in 'Service\ServiceBase.pas',
  Filtro in 'Model\Transiente\Filtro.pas',
  BancoAgenciaController in 'Controller\Cadastros\BancoAgenciaController.pas',
  BancoController in 'Controller\Cadastros\BancoController.pas',
  PessoaController in 'Controller\Cadastros\PessoaController.pas',
  Banco in 'Model\Cadastros\Banco.pas',
  BancoAgencia in 'Model\Cadastros\BancoAgencia.pas',
  Pessoa in 'Model\Cadastros\Pessoa.pas',
  PessoaFisica in 'Model\Cadastros\PessoaFisica.pas',
  PessoaJuridica in 'Model\Cadastros\PessoaJuridica.pas',
  BancoAgenciaService in 'Service\Cadastros\BancoAgenciaService.pas',
  BancoService in 'Service\Cadastros\BancoService.pas',
  PessoaService in 'Service\Cadastros\PessoaService.pas',
  PessoaContato in 'Model\Cadastros\PessoaContato.pas',
  PessoaTelefone in 'Model\Cadastros\PessoaTelefone.pas',
  PessoaEndereco in 'Model\Cadastros\PessoaEndereco.pas';

{$R *.res}


procedure RunServer(APort: Integer);
var
  LServer: TIdHTTPWebBrokerBridge;
begin
  WriteLn('T2Ti ERP Fenix - versão 0.0.1 - DMVC');
  WriteLn(Format('Servidor iniciado na porta %d', [APort]));
  LServer := TIdHTTPWebBrokerBridge.Create(nil);
  try
    LServer.DefaultPort := APort;
    LServer.MaxConnections := 1024;
    LServer.Active := True;
    WriteLn('Pressione ENTER para finalizar o servidor');
    ReadLn;
  finally
    LServer.Free;
  end;
end;

begin
  ReportMemoryLeaksOnShutdown := True;
  try
    if WebRequestHandler <> nil then
      WebRequestHandler.WebModuleClass := WebModuleClass;
    RunServer(8085);
  except
    on E: Exception do
      WriteLn(E.ClassName, ': ', E.Message);
  end

end.
