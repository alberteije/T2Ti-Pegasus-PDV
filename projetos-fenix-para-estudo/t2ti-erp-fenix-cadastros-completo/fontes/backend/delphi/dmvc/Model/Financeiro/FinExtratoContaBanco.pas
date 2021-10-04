{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_EXTRATO_CONTA_BANCO] 
                                                                                
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
unit FinExtratoContaBanco;

interface

uses
  Generics.Collections, System.SysUtils,
  BancoContaCaixa, 
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TFinExtratoContaBanco = class(TModelBase)
  private
    FId: Integer;
    FIdBancoContaCaixa: Integer;
    FMesAno: string;
    FMes: string;
    FAno: string;
    FDataMovimento: TDateTime;
    FDataBalancete: TDateTime;
    FHistorico: string;
    FDocumento: string;
    FValor: Extended;
    FConciliado: string;
    FObservacao: string;
      
    FBancoContaCaixa: TBancoContaCaixa;
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
    [MVCColumnAttribute('MES_ANO')]
	[MVCNameAsAttribute('mesAno')]
	property MesAno: string read FMesAno write FMesAno;
    [MVCColumnAttribute('MES')]
	[MVCNameAsAttribute('mes')]
	property Mes: string read FMes write FMes;
    [MVCColumnAttribute('ANO')]
	[MVCNameAsAttribute('ano')]
	property Ano: string read FAno write FAno;
    [MVCColumnAttribute('DATA_MOVIMENTO')]
	[MVCNameAsAttribute('dataMovimento')]
	property DataMovimento: TDateTime read FDataMovimento write FDataMovimento;
    [MVCColumnAttribute('DATA_BALANCETE')]
	[MVCNameAsAttribute('dataBalancete')]
	property DataBalancete: TDateTime read FDataBalancete write FDataBalancete;
    [MVCColumnAttribute('HISTORICO')]
	[MVCNameAsAttribute('historico')]
	property Historico: string read FHistorico write FHistorico;
    [MVCColumnAttribute('DOCUMENTO')]
	[MVCNameAsAttribute('documento')]
	property Documento: string read FDocumento write FDocumento;
    [MVCColumnAttribute('VALOR')]
	[MVCNameAsAttribute('valor')]
	property Valor: Extended read FValor write FValor;
    [MVCColumnAttribute('CONCILIADO')]
	[MVCNameAsAttribute('conciliado')]
	property Conciliado: string read FConciliado write FConciliado;
    [MVCColumnAttribute('OBSERVACAO')]
	[MVCNameAsAttribute('observacao')]
	property Observacao: string read FObservacao write FObservacao;
      
    [MVCNameAsAttribute('bancoContaCaixa')]
	property BancoContaCaixa: TBancoContaCaixa read FBancoContaCaixa write FBancoContaCaixa;
  end;

implementation

{ TFinExtratoContaBanco }

constructor TFinExtratoContaBanco.Create;
begin
  FBancoContaCaixa := TBancoContaCaixa.Create;
end;

destructor TFinExtratoContaBanco.Destroy;
begin
  FreeAndNil(FBancoContaCaixa);
  inherited;
end;

procedure TFinExtratoContaBanco.ValidarInsercao;
begin
  inherited;

end;

procedure TFinExtratoContaBanco.ValidarAlteracao;
begin
  inherited;

end;

procedure TFinExtratoContaBanco.ValidarExclusao;
begin
  inherited;

end;

end.