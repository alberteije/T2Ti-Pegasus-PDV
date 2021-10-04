program RestDWServerProject;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  RestDWServerFormU in 'RestDWServerFormU.pas' {RestDWForm},
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas' {ServerMethods1: TDataModule},
  uDmService in 'uDmService.pas' {ServerMethodDM: TDataModule},
  EmployeeController in 'EmployeeController.pas',
  BancoController in 'BancoController.pas',
  PessoaController in 'PessoaController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TRestDWForm, RestDWForm);
  Application.CreateForm(TServerMethodDM, ServerMethodDM);
  Application.Run;
end.
