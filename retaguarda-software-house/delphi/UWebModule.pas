unit UWebModule;

interface

uses System.SysUtils, System.Classes, Web.HTTPApp,
  UAuthCriteria,
  mvcframework, MVCFramework.JWT;

type
  TFWebModule = class(TWebModule)
    procedure WebModuleCreate(Sender: TObject);
  private
    FEngine: TMVCEngine;
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TFWebModule;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

uses
  // outras classes do MVC
  MVCFramework.Commons,
  MVCFramework.Middleware.JWT,
  MVCFramework.Middleware.Compression,

  // cadastros
  EmpresaController,

  // nfe
  NfeConfiguracaoController,

  // pdv
  PdvPlanoPagamentoController,
  PdvTipoPlanoController,

  MVCFramework.Middleware.CORS,
  Constantes;

{$R *.dfm}

procedure TFWebModule.WebModuleCreate(Sender: TObject);
var
  lClaimsSetup: TJWTClaimsSetup;
begin
  // Token - JWT
  lClaimsSetup := procedure(const JWT: TJWT)
    begin
      JWT.Claims.Issuer := 'T2Ti.COM';
      JWT.Claims.ExpirationTime := Now + 7;
      JWT.Claims.NotBefore := Now; // valid since now
      JWT.Claims.IssuedAt := Now;
//      JWT.CustomClaims['t2ti'] := 'pegasus-pdv';
    end;

  FEngine := TMVCEngine.Create(self);

  FEngine.AddMiddleware(TMVCJWTAuthenticationMiddleware.Create(
    TAuthCriteria.Create,
    lClaimsSetup,
    TConstantes.CHAVE,
    TConstantes.ROTA_JWT
    ));

  // cadastros
  FEngine.AddController(TEmpresaController);

  // nfe
  FEngine.AddController(TNfeConfiguracaoController);

  // pdv
  FEngine.AddController(TPdvTipoPlanoController);
  FEngine.AddController(TPdvPlanoPagamentoController);
end;

end.
