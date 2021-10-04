{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_CHEQUE_EMITIDO] 
                                                                                
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
unit FinChequeEmitido;

interface

uses
  Generics.Collections, System.SysUtils,
  Cheque, 
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TFinChequeEmitido = class(TModelBase)
  private
    FId: Integer;
    FIdCheque: Integer;
    FDataEmissao: TDateTime;
    FBomPara: TDateTime;
    FDataCompensacao: TDateTime;
    FValor: Extended;
    FNominalA: string;
      
    FCheque: TCheque;
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    constructor Create; virtual;
    destructor Destroy; override;

    [MVCColumnAttribute('ID', True)]
	[MVCNameAsAttribute('id')]
	property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_CHEQUE')]
	[MVCNameAsAttribute('idCheque')]
	property IdCheque: Integer read FIdCheque write FIdCheque;
    [MVCColumnAttribute('DATA_EMISSAO')]
	[MVCNameAsAttribute('dataEmissao')]
	property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
    [MVCColumnAttribute('BOM_PARA')]
	[MVCNameAsAttribute('bomPara')]
	property BomPara: TDateTime read FBomPara write FBomPara;
    [MVCColumnAttribute('DATA_COMPENSACAO')]
	[MVCNameAsAttribute('dataCompensacao')]
	property DataCompensacao: TDateTime read FDataCompensacao write FDataCompensacao;
    [MVCColumnAttribute('VALOR')]
	[MVCNameAsAttribute('valor')]
	property Valor: Extended read FValor write FValor;
    [MVCColumnAttribute('NOMINAL_A')]
	[MVCNameAsAttribute('nominalA')]
	property NominalA: string read FNominalA write FNominalA;
      
    [MVCNameAsAttribute('cheque')]
	property Cheque: TCheque read FCheque write FCheque;
  end;

implementation

{ TFinChequeEmitido }

constructor TFinChequeEmitido.Create;
begin
  FCheque := TCheque.Create;
end;

destructor TFinChequeEmitido.Destroy;
begin
  FreeAndNil(FCheque);
  inherited;
end;

procedure TFinChequeEmitido.ValidarInsercao;
begin
  inherited;

end;

procedure TFinChequeEmitido.ValidarAlteracao;
begin
  inherited;

end;

procedure TFinChequeEmitido.ValidarExclusao;
begin
  inherited;

end;

end.