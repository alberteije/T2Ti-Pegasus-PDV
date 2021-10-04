{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_LANCAMENTO_RECEBER] 
                                                                                
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
unit FinLancamentoReceber;

interface

uses
  Generics.Collections, System.SysUtils,
  FinParcelaReceber, FinDocumentoOrigem, FinNaturezaFinanceira, Cliente, 
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TFinLancamentoReceber = class(TModelBase)
  private
    FId: Integer;
    FIdFinDocumentoOrigem: Integer;
    FIdFinNaturezaFinanceira: Integer;
    FIdCliente: Integer;
    FQuantidadeParcela: Integer;
    FValorTotal: Extended;
    FValorAReceber: Extended;
    FDataLancamento: TDateTime;
    FNumeroDocumento: string;
    FPrimeiroVencimento: TDateTime;
    FTaxaComissao: Extended;
    FValorComissao: Extended;
    FIntervaloEntreParcelas: Integer;
    FDiaFixo: string;
      
    FFinDocumentoOrigem: TFinDocumentoOrigem;
    FFinNaturezaFinanceira: TFinNaturezaFinanceira;
    FCliente: TCliente;
    FListaFinParcelaReceber: TObjectList<TFinParcelaReceber>;
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    constructor Create; virtual;
    destructor Destroy; override;

    [MVCColumnAttribute('ID', True)]
		[MVCNameAsAttribute('id')]
		property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_FIN_DOCUMENTO_ORIGEM')]
		[MVCNameAsAttribute('idFinDocumentoOrigem')]
		property IdFinDocumentoOrigem: Integer read FIdFinDocumentoOrigem write FIdFinDocumentoOrigem;
    [MVCColumnAttribute('ID_FIN_NATUREZA_FINANCEIRA')]
		[MVCNameAsAttribute('idFinNaturezaFinanceira')]
		property IdFinNaturezaFinanceira: Integer read FIdFinNaturezaFinanceira write FIdFinNaturezaFinanceira;
    [MVCColumnAttribute('ID_CLIENTE')]
		[MVCNameAsAttribute('idCliente')]
		property IdCliente: Integer read FIdCliente write FIdCliente;
    [MVCColumnAttribute('QUANTIDADE_PARCELA')]
		[MVCNameAsAttribute('quantidadeParcela')]
		property QuantidadeParcela: Integer read FQuantidadeParcela write FQuantidadeParcela;
    [MVCColumnAttribute('VALOR_TOTAL')]
		[MVCNameAsAttribute('valorTotal')]
		property ValorTotal: Extended read FValorTotal write FValorTotal;
    [MVCColumnAttribute('VALOR_A_RECEBER')]
		[MVCNameAsAttribute('valorAReceber')]
		property ValorAReceber: Extended read FValorAReceber write FValorAReceber;
    [MVCColumnAttribute('DATA_LANCAMENTO')]
		[MVCNameAsAttribute('dataLancamento')]
		property DataLancamento: TDateTime read FDataLancamento write FDataLancamento;
    [MVCColumnAttribute('NUMERO_DOCUMENTO')]
		[MVCNameAsAttribute('numeroDocumento')]
		property NumeroDocumento: string read FNumeroDocumento write FNumeroDocumento;
    [MVCColumnAttribute('PRIMEIRO_VENCIMENTO')]
		[MVCNameAsAttribute('primeiroVencimento')]
		property PrimeiroVencimento: TDateTime read FPrimeiroVencimento write FPrimeiroVencimento;
    [MVCColumnAttribute('TAXA_COMISSAO')]
		[MVCNameAsAttribute('taxaComissao')]
		property TaxaComissao: Extended read FTaxaComissao write FTaxaComissao;
    [MVCColumnAttribute('VALOR_COMISSAO')]
		[MVCNameAsAttribute('valorComissao')]
		property ValorComissao: Extended read FValorComissao write FValorComissao;
    [MVCColumnAttribute('INTERVALO_ENTRE_PARCELAS')]
		[MVCNameAsAttribute('intervaloEntreParcelas')]
		property IntervaloEntreParcelas: Integer read FIntervaloEntreParcelas write FIntervaloEntreParcelas;
    [MVCColumnAttribute('DIA_FIXO')]
		[MVCNameAsAttribute('diaFixo')]
		property DiaFixo: string read FDiaFixo write FDiaFixo;
      
    [MVCNameAsAttribute('finDocumentoOrigem')]
		property FinDocumentoOrigem: TFinDocumentoOrigem read FFinDocumentoOrigem write FFinDocumentoOrigem;
    [MVCNameAsAttribute('finNaturezaFinanceira')]
		property FinNaturezaFinanceira: TFinNaturezaFinanceira read FFinNaturezaFinanceira write FFinNaturezaFinanceira;
    [MVCNameAsAttribute('cliente')]
		property Cliente: TCliente read FCliente write FCliente;
    [MapperListOf(TFinParcelaReceber)]
	[MVCNameAsAttribute('listaFinParcelaReceber')]
	property ListaFinParcelaReceber: TObjectList<TFinParcelaReceber> read FListaFinParcelaReceber write FListaFinParcelaReceber;
  end;

implementation

{ TFinLancamentoReceber }

constructor TFinLancamentoReceber.Create;
begin
  FListaFinParcelaReceber := TObjectList<TFinParcelaReceber>.Create;
  FFinDocumentoOrigem := TFinDocumentoOrigem.Create;
  FFinNaturezaFinanceira := TFinNaturezaFinanceira.Create;
  FCliente := TCliente.Create;
end;

destructor TFinLancamentoReceber.Destroy;
begin
  FreeAndNil(FListaFinParcelaReceber);
  FreeAndNil(FFinDocumentoOrigem);
  FreeAndNil(FFinNaturezaFinanceira);
  FreeAndNil(FCliente);
  inherited;
end;

procedure TFinLancamentoReceber.ValidarInsercao;
begin
  inherited;

end;

procedure TFinLancamentoReceber.ValidarAlteracao;
begin
  inherited;

end;

procedure TFinLancamentoReceber.ValidarExclusao;
begin
  inherited;

end;

end.