{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_PARCELA_RECEBER] 
                                                                                
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
unit FinParcelaReceber;

interface

uses
  Generics.Collections, System.SysUtils,
  FinStatusParcela, FinTipoRecebimento, BancoContaCaixa, FinChequeRecebido, 
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TFinParcelaReceber = class(TModelBase)
  private
    FId: Integer;
    FIdFinLancamentoReceber: Integer;
    FIdFinStatusParcela: Integer;
    FIdFinTipoRecebimento: Integer;
    FIdBancoContaCaixa: Integer;
    FIdFinChequeRecebido: Integer;
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
    FEmitiuBoleto: string;
    FBoletoNossoNumero: string;
    FValorRecebido: Extended;
    FHistorico: string;
      
    FFinStatusParcela: TFinStatusParcela;
    FFinTipoRecebimento: TFinTipoRecebimento;
    FBancoContaCaixa: TBancoContaCaixa;
    FFinChequeRecebido: TFinChequeRecebido;
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    constructor Create; virtual;
    destructor Destroy; override;

    [MVCColumnAttribute('ID', True)]
		[MVCNameAsAttribute('id')]
		property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_FIN_LANCAMENTO_RECEBER')]
		[MVCNameAsAttribute('idFinLancamentoReceber')]
		property IdFinLancamentoReceber: Integer read FIdFinLancamentoReceber write FIdFinLancamentoReceber;
    [MVCColumnAttribute('ID_FIN_STATUS_PARCELA')]
		[MVCNameAsAttribute('idFinStatusParcela')]
		property IdFinStatusParcela: Integer read FIdFinStatusParcela write FIdFinStatusParcela;
    [MVCColumnAttribute('ID_FIN_TIPO_RECEBIMENTO')]
		[MVCNameAsAttribute('idFinTipoRecebimento')]
		property IdFinTipoRecebimento: Integer read FIdFinTipoRecebimento write FIdFinTipoRecebimento;
    [MVCColumnAttribute('ID_BANCO_CONTA_CAIXA')]
		[MVCNameAsAttribute('idBancoContaCaixa')]
		property IdBancoContaCaixa: Integer read FIdBancoContaCaixa write FIdBancoContaCaixa;
    [MVCColumnAttribute('ID_FIN_CHEQUE_RECEBIDO')]
		[MVCNameAsAttribute('idFinChequeRecebido')]
		property IdFinChequeRecebido: Integer read FIdFinChequeRecebido write FIdFinChequeRecebido;
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
    [MVCColumnAttribute('EMITIU_BOLETO')]
		[MVCNameAsAttribute('emitiuBoleto')]
		property EmitiuBoleto: string read FEmitiuBoleto write FEmitiuBoleto;
    [MVCColumnAttribute('BOLETO_NOSSO_NUMERO')]
		[MVCNameAsAttribute('boletoNossoNumero')]
		property BoletoNossoNumero: string read FBoletoNossoNumero write FBoletoNossoNumero;
    [MVCColumnAttribute('VALOR_RECEBIDO')]
		[MVCNameAsAttribute('valorRecebido')]
		property ValorRecebido: Extended read FValorRecebido write FValorRecebido;
    [MVCColumnAttribute('HISTORICO')]
		[MVCNameAsAttribute('historico')]
		property Historico: string read FHistorico write FHistorico;
      
    [MVCNameAsAttribute('finStatusParcela')]
		property FinStatusParcela: TFinStatusParcela read FFinStatusParcela write FFinStatusParcela;
    [MVCNameAsAttribute('finTipoRecebimento')]
		property FinTipoRecebimento: TFinTipoRecebimento read FFinTipoRecebimento write FFinTipoRecebimento;
    [MVCNameAsAttribute('bancoContaCaixa')]
		property BancoContaCaixa: TBancoContaCaixa read FBancoContaCaixa write FBancoContaCaixa;
    [MVCNameAsAttribute('finChequeRecebido')]
		property FinChequeRecebido: TFinChequeRecebido read FFinChequeRecebido write FFinChequeRecebido;
  end;

implementation

{ TFinParcelaReceber }

constructor TFinParcelaReceber.Create;
begin
  FFinStatusParcela := TFinStatusParcela.Create;
  FFinTipoRecebimento := TFinTipoRecebimento.Create;
  FBancoContaCaixa := TBancoContaCaixa.Create;
  FFinChequeRecebido := TFinChequeRecebido.Create;
end;

destructor TFinParcelaReceber.Destroy;
begin
  FreeAndNil(FFinStatusParcela);
  FreeAndNil(FFinTipoRecebimento);
  FreeAndNil(FBancoContaCaixa);
  FreeAndNil(FFinChequeRecebido);
  inherited;
end;

procedure TFinParcelaReceber.ValidarInsercao;
begin
  inherited;

end;

procedure TFinParcelaReceber.ValidarAlteracao;
begin
  inherited;

end;

procedure TFinParcelaReceber.ValidarExclusao;
begin
  inherited;

end;

end.