{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [TALONARIO_CHEQUE] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2020 T2Ti.COM                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (alberteije@gmail.com)                    
@version 1.0.0
*******************************************************************************}
unit TalonarioCheque;

interface

uses
  Generics.Collections, System.SysUtils,
  Cheque, BancoContaCaixa, 
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TTalonarioCheque = class(TModelBase)
  private
    FId: Integer;
    FIdBancoContaCaixa: Integer;
    FTalao: string;
    FNumero: Integer;
    FStatusTalao: string;
      
    FBancoContaCaixa: TBancoContaCaixa;
    FListaCheque: TObjectList<TCheque>;
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    constructor Create; virtual;
    destructor Destroy; override;

    [MVCColumnAttribute('ID', True)]
	[MVCNameAsAttribute('id')]
	property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_BANCO_CONTA_CAIXA')]
	[MVCNameAsAttribute('idBancoContaCaixa')]
	property IdBancoContaCaixa: Integer read FIdBancoContaCaixa write FIdBancoContaCaixa;
    [MVCColumnAttribute('TALAO')]
	[MVCNameAsAttribute('talao')]
	property Talao: string read FTalao write FTalao;
    [MVCColumnAttribute('NUMERO')]
	[MVCNameAsAttribute('numero')]
	property Numero: Integer read FNumero write FNumero;
    [MVCColumnAttribute('STATUS_TALAO')]
	[MVCNameAsAttribute('statusTalao')]
	property StatusTalao: string read FStatusTalao write FStatusTalao;
      
    [MVCNameAsAttribute('bancoContaCaixa')]
	property BancoContaCaixa: TBancoContaCaixa read FBancoContaCaixa write FBancoContaCaixa;
    [MapperListOf(TCheque)]
	[MVCNameAsAttribute('listaCheque')]
	property ListaCheque: TObjectList<TCheque> read FListaCheque write FListaCheque;
  end;

implementation

{ TTalonarioCheque }

constructor TTalonarioCheque.Create;
begin
  FListaCheque := TObjectList<TCheque>.Create;
  FBancoContaCaixa := TBancoContaCaixa.Create;
end;

destructor TTalonarioCheque.Destroy;
begin
  FreeAndNil(FListaCheque);
  FreeAndNil(FBancoContaCaixa);
  inherited;
end;

procedure TTalonarioCheque.ValidarInsercao;
begin
  inherited;

end;

procedure TTalonarioCheque.ValidarAlteracao;
begin
  inherited;

end;

procedure TTalonarioCheque.ValidarExclusao;
begin
  inherited;

end;

end.