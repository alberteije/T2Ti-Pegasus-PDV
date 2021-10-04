unit ServerMethodsUnit1;

interface

uses SysUtils, Classes, Windows, uRESTDWBase, uDWConsts, uDWConstsData, uDWJSONTools, uDWJSONObject,
     System.JSON, Dialogs, ServerUtils, SysTypes,
     {$IFDEF FPC}
     {$ELSE}
     FireDAC.Dapt,
     FireDAC.Phys.FBDef,
     FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
     FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, Data.DB,
     FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
     FireDAC.Stan.StorageJSON;
     {$ENDIF}

Type
{$METHODINFO ON}
  TServerMethodsComp = Class(TServerMethods)
  Private
  public
   { Public declarations }
   Constructor Create    (aOwner : TComponent); Override;
   Destructor  Destroy; Override;
   Procedure   vReplyEvent(SendType   : TSendEvent;
                           Context    : String;
                           Var Params : TDWParams;
                           Var Result : String;
                           AccessTag  : String);
  End;
{$METHODINFO OFF}

implementation

uses StrUtils, RestDWServerFormU;


Constructor TServerMethodsComp.Create (aOwner : TComponent);
Begin
 Inherited Create (aOwner);
 OnReplyEvent := vReplyEvent;
End;

Destructor TServerMethodsComp.Destroy;
Begin
 Inherited Destroy;
End;

Procedure TServerMethodsComp.vReplyEvent(SendType   : TSendEvent;
                                         Context    : String;
                                         Var Params : TDWParams;
                                         Var Result : String;
                                         AccessTag  : String);
Var
 JSONObject : TJSONObject;
Begin
 JSONObject := TJSONObject.Create;
 Case SendType Of
  sePOST   :
   Begin
    JSONObject.AddPair(TJSONPair.Create('STATUS',   'NOK'));
    JSONObject.AddPair(TJSONPair.Create('MENSAGEM', 'Método não encontrado'));
    Result := JSONObject.ToJSON;
   End;
 End;
 JSONObject.Free;
End;

End.




