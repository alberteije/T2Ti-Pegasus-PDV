{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_LANCAMENTO_PAGAR] 
                                                                                
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
unit FinLancamentoPagar;

interface

uses
  Generics.Collections, System.SysUtils,
  FinParcelaPagar, FinDocumentoOrigem, FinNaturezaFinanceira, Fornecedor, 
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TFinLancamentoPagar = class(TModelBase)
  private
    FId: Integer;
    FIdFinDocumentoOrigem: Integer;
    FIdFinNaturezaFinanceira: Integer;
    FIdFornecedor: Integer;
    FQuantidadeParcela: Integer;
    FValorTotal: Extended;
    FValorAPagar: Extended;
    FDataLancamento: TDateTime;
    FNumeroDocumento: string;
    FImagemDocumento: string;
    FPrimeiroVencimento: TDateTime;
    FIntervaloEntreParcelas: Integer;
    FDiaFixo: string;
      
    FFinDocumentoOrigem: TFinDocumentoOrigem;
    FFinNaturezaFinanceira: TFinNaturezaFinanceira;
    FFornecedor: TFornecedor;
    FListaFinParcelaPagar: TObjectList<TFinParcelaPagar>;
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
    [MVCColumnAttribute('ID_FORNECEDOR')]
		[MVCNameAsAttribute('idFornecedor')]
		property IdFornecedor: Integer read FIdFornecedor write FIdFornecedor;
    [MVCColumnAttribute('QUANTIDADE_PARCELA')]
		[MVCNameAsAttribute('quantidadeParcela')]
		property QuantidadeParcela: Integer read FQuantidadeParcela write FQuantidadeParcela;
    [MVCColumnAttribute('VALOR_TOTAL')]
		[MVCNameAsAttribute('valorTotal')]
		property ValorTotal: Extended read FValorTotal write FValorTotal;
    [MVCColumnAttribute('VALOR_A_PAGAR')]
		[MVCNameAsAttribute('valorAPagar')]
		property ValorAPagar: Extended read FValorAPagar write FValorAPagar;
    [MVCColumnAttribute('DATA_LANCAMENTO')]
		[MVCNameAsAttribute('dataLancamento')]
		property DataLancamento: TDateTime read FDataLancamento write FDataLancamento;
    [MVCColumnAttribute('NUMERO_DOCUMENTO')]
		[MVCNameAsAttribute('numeroDocumento')]
		property NumeroDocumento: string read FNumeroDocumento write FNumeroDocumento;
    [MVCColumnAttribute('IMAGEM_DOCUMENTO')]
		[MVCNameAsAttribute('imagemDocumento')]
		property ImagemDocumento: string read FImagemDocumento write FImagemDocumento;
    [MVCColumnAttribute('PRIMEIRO_VENCIMENTO')]
		[MVCNameAsAttribute('primeiroVencimento')]
		property PrimeiroVencimento: TDateTime read FPrimeiroVencimento write FPrimeiroVencimento;
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
    [MVCNameAsAttribute('fornecedor')]
		property Fornecedor: TFornecedor read FFornecedor write FFornecedor;
    [MapperListOf(TFinParcelaPagar)]
	[MVCNameAsAttribute('listaFinParcelaPagar')]
	property ListaFinParcelaPagar: TObjectList<TFinParcelaPagar> read FListaFinParcelaPagar write FListaFinParcelaPagar;
  end;

implementation

{ TFinLancamentoPagar }

constructor TFinLancamentoPagar.Create;
begin
  FListaFinParcelaPagar := TObjectList<TFinParcelaPagar>.Create;
  FFinDocumentoOrigem := TFinDocumentoOrigem.Create;
  FFinNaturezaFinanceira := TFinNaturezaFinanceira.Create;
  FFornecedor := TFornecedor.Create;
end;

destructor TFinLancamentoPagar.Destroy;
begin
  FreeAndNil(FListaFinParcelaPagar);
  FreeAndNil(FFinDocumentoOrigem);
  FreeAndNil(FFinNaturezaFinanceira);
  FreeAndNil(FFornecedor);
  inherited;
end;

procedure TFinLancamentoPagar.ValidarInsercao;
begin
  inherited;

end;

procedure TFinLancamentoPagar.ValidarAlteracao;
begin
  inherited;

end;

procedure TFinLancamentoPagar.ValidarExclusao;
begin
  inherited;

end;

end.