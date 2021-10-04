{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_PARCELA_PAGAR] 
                                                                                
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
unit FinParcelaPagar;

interface

uses
  Generics.Collections, System.SysUtils,
  FinStatusParcela, BancoContaCaixa, FinTipoPagamento, FinChequeEmitido, 
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TFinParcelaPagar = class(TModelBase)
  private
    FId: Integer;
    FIdFinLancamentoPagar: Integer;
    FIdFinStatusParcela: Integer;
    FIdBancoContaCaixa: Integer;
    FIdFinTipoPagamento: Integer;
    FIdFinChequeEmitido: Integer;
    FNumeroParcela: Integer;
    FDataEmissao: TDateTime;
    FDataVencimento: TDateTime;
    FDescontoAte: TDateTime;
    FValor: Extended;
    FTaxaJuro: Extended;
    FTaxaMulta: Extended;
    FTaxaDesconto: Extended;
    FValorJuro: Extended;
    FValorMulta: Extended;
    FValorDesconto: Extended;
    FValorPago: Extended;
    FHistorico: string;
      
    FFinStatusParcela: TFinStatusParcela;
    FBancoContaCaixa: TBancoContaCaixa;
    FFinTipoPagamento: TFinTipoPagamento;
    FFinChequeEmitido: TFinChequeEmitido;
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    constructor Create; virtual;
    destructor Destroy; override;

    [MVCColumnAttribute('ID', True)]
		[MVCNameAsAttribute('id')]
		property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_FIN_LANCAMENTO_PAGAR')]
		[MVCNameAsAttribute('idFinLancamentoPagar')]
		property IdFinLancamentoPagar: Integer read FIdFinLancamentoPagar write FIdFinLancamentoPagar;
    [MVCColumnAttribute('ID_FIN_STATUS_PARCELA')]
		[MVCNameAsAttribute('idFinStatusParcela')]
		property IdFinStatusParcela: Integer read FIdFinStatusParcela write FIdFinStatusParcela;
    [MVCColumnAttribute('ID_BANCO_CONTA_CAIXA')]
		[MVCNameAsAttribute('idBancoContaCaixa')]
		property IdBancoContaCaixa: Integer read FIdBancoContaCaixa write FIdBancoContaCaixa;
    [MVCColumnAttribute('ID_FIN_TIPO_PAGAMENTO')]
		[MVCNameAsAttribute('idFinTipoPagamento')]
		property IdFinTipoPagamento: Integer read FIdFinTipoPagamento write FIdFinTipoPagamento;
    [MVCColumnAttribute('ID_FIN_CHEQUE_EMITIDO')]
		[MVCNameAsAttribute('idFinChequeEmitido')]
		property IdFinChequeEmitido: Integer read FIdFinChequeEmitido write FIdFinChequeEmitido;
    [MVCColumnAttribute('NUMERO_PARCELA')]
		[MVCNameAsAttribute('numeroParcela')]
		property NumeroParcela: Integer read FNumeroParcela write FNumeroParcela;
    [MVCColumnAttribute('DATA_EMISSAO')]
		[MVCNameAsAttribute('dataEmissao')]
		property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
    [MVCColumnAttribute('DATA_VENCIMENTO')]
		[MVCNameAsAttribute('dataVencimento')]
		property DataVencimento: TDateTime read FDataVencimento write FDataVencimento;
    [MVCColumnAttribute('DESCONTO_ATE')]
		[MVCNameAsAttribute('descontoAte')]
		property DescontoAte: TDateTime read FDescontoAte write FDescontoAte;
    [MVCColumnAttribute('VALOR')]
		[MVCNameAsAttribute('valor')]
		property Valor: Extended read FValor write FValor;
    [MVCColumnAttribute('TAXA_JURO')]
		[MVCNameAsAttribute('taxaJuro')]
		property TaxaJuro: Extended read FTaxaJuro write FTaxaJuro;
    [MVCColumnAttribute('TAXA_MULTA')]
		[MVCNameAsAttribute('taxaMulta')]
		property TaxaMulta: Extended read FTaxaMulta write FTaxaMulta;
    [MVCColumnAttribute('TAXA_DESCONTO')]
		[MVCNameAsAttribute('taxaDesconto')]
		property TaxaDesconto: Extended read FTaxaDesconto write FTaxaDesconto;
    [MVCColumnAttribute('VALOR_JURO')]
		[MVCNameAsAttribute('valorJuro')]
		property ValorJuro: Extended read FValorJuro write FValorJuro;
    [MVCColumnAttribute('VALOR_MULTA')]
		[MVCNameAsAttribute('valorMulta')]
		property ValorMulta: Extended read FValorMulta write FValorMulta;
    [MVCColumnAttribute('VALOR_DESCONTO')]
		[MVCNameAsAttribute('valorDesconto')]
		property ValorDesconto: Extended read FValorDesconto write FValorDesconto;
    [MVCColumnAttribute('VALOR_PAGO')]
		[MVCNameAsAttribute('valorPago')]
		property ValorPago: Extended read FValorPago write FValorPago;
    [MVCColumnAttribute('HISTORICO')]
		[MVCNameAsAttribute('historico')]
		property Historico: string read FHistorico write FHistorico;
      
    [MVCNameAsAttribute('finStatusParcela')]
		property FinStatusParcela: TFinStatusParcela read FFinStatusParcela write FFinStatusParcela;
    [MVCNameAsAttribute('bancoContaCaixa')]
		property BancoContaCaixa: TBancoContaCaixa read FBancoContaCaixa write FBancoContaCaixa;
    [MVCNameAsAttribute('finTipoPagamento')]
		property FinTipoPagamento: TFinTipoPagamento read FFinTipoPagamento write FFinTipoPagamento;
    [MVCNameAsAttribute('finChequeEmitido')]
		property FinChequeEmitido: TFinChequeEmitido read FFinChequeEmitido write FFinChequeEmitido;
  end;

implementation

{ TFinParcelaPagar }

constructor TFinParcelaPagar.Create;
begin
  FFinStatusParcela := TFinStatusParcela.Create;
  FBancoContaCaixa := TBancoContaCaixa.Create;
  FFinTipoPagamento := TFinTipoPagamento.Create;
  FFinChequeEmitido := TFinChequeEmitido.Create;
end;

destructor TFinParcelaPagar.Destroy;
begin
  FreeAndNil(FFinStatusParcela);
  FreeAndNil(FBancoContaCaixa);
  FreeAndNil(FFinTipoPagamento);
  FreeAndNil(FFinChequeEmitido);
  inherited;
end;

procedure TFinParcelaPagar.ValidarInsercao;
begin
  inherited;

end;

procedure TFinParcelaPagar.ValidarAlteracao;
begin
  inherited;

end;

procedure TFinParcelaPagar.ValidarExclusao;
begin
  inherited;

end;

end.