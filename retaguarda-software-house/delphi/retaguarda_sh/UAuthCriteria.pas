unit UAuthCriteria;

interface

uses
  MVCFramework, System.Generics.Collections;

type
  TAuthCriteria = class(TInterfacedObject, IMVCAuthenticationHandler)
  public
    procedure OnRequest(const AContext: TWebContext;
      const AControllerQualifiedClassName: string; const AActionName: string;
      var AAuthenticationRequired: Boolean);
    procedure OnAuthentication(const AContext: TWebContext;
      const AUserName: string; const APassword: string;
      AUserRoles: TList<String>; var AIsValid: Boolean;
      const ASessionData: TDictionary<string, string>);
    procedure OnAuthorization(const AContext: TWebContext;
      AUserRoles: TList<string>; const AControllerQualifiedClassName: string;
      const AActionName: string; var AIsAuthorized: Boolean);
  end;

implementation

uses
  System.SysUtils;(*, Usuario, UsuarioService;*)

{ TAuthCriteria }

procedure TAuthCriteria.OnAuthentication(const AContext: TWebContext;
const AUserName, APassword: string; AUserRoles: TList<string>;
var AIsValid: Boolean; const ASessionData: TDictionary<String, String>);
//var
//  Usuario: TUsuario;
begin
  AIsValid := True;

//  Usuario := TUsuarioService.Login(AUserName, APassword);
//  if Assigned(Usuario) then
//  begin
//    AIsValid := True;
//    AUserRoles.Add(Usuario.Papel.Nome);
//  end;

  if not AIsValid then
  begin
    Exit;
  end;

//  if AUserName = 'user1' then
//  begin
//    AUserRoles.Add('role1');
//  end
//  else if AUserName = 'user2' then
//  begin
//    AUserRoles.Add('role2');
//  end
//  else if AUserName = 'user3' then
//  begin
//    AUserRoles.Add('role1');
//    AUserRoles.Add('role2');
//  end;
//  AIsValid := AUserRoles.Count > 0;
end;

procedure TAuthCriteria.OnAuthorization(const AContext: TWebContext;
  AUserRoles: System.Generics.Collections.TList<String>;
  const AControllerQualifiedClassName, AActionName: string;
  var AIsAuthorized: Boolean);
begin
  AIsAuthorized := True;

  if AUserRoles.Contains('ADM') then
  begin
    AIsAuthorized := True;
  end;

//  if AUserRoles.Contains('role1') then
//  begin
//    AIsAuthorized := AIsAuthorized or (AActionName = 'ActionForRole1');
//  end;
//  if AUserRoles.Contains('role2') then
//  begin
//    AIsAuthorized := AIsAuthorized or (AActionName = 'ActionForRole2');
//  end;
end;

procedure TAuthCriteria.OnRequest(const AContext: TWebContext;
  const AControllerQualifiedClassName, AActionName: string;
  var AAuthenticationRequired: Boolean);
begin
  AAuthenticationRequired := False;
//  AAuthenticationRequired := True;
//  if (AControllerQualifiedClassName = 'PdvPlanoPagamentoController.TPdvPlanoPagamentoController') and (AActionName = 'Inserir') then
//    AAuthenticationRequired := False;
end;

end.
