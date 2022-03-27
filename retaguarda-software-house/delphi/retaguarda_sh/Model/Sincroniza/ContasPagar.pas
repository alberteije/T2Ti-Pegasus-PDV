{*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Model relacionado à tabela [CONTAS_PAGAR] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
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
unit ContasPagar;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TContasPagar = class(TModelBase)
  private
    FId: Integer;
    FIdFornecedor: Integer;
    FIdCompraPedidoCabecalho: Integer;
    FDataLancamento: Integer;
    FDataVencimento: Integer;
    FDataPagamento: Integer;
    FValorAPagar: Extended;
    FTaxaJuro: Extended;
    FTaxaMulta: Extended;
    FTaxaDesconto: Extended;
    FValorJuro: Extended;
    FValorMulta: Extended;
    FValorDesconto: Extended;
    FValorPago: Extended;
    FNumeroDocumento: string;
    FHistorico: string;
    FStatusPagamento: string;

  public
//    procedure ValidarInsercao; override;
//    procedure ValidarAlteracao; override;
//    procedure ValidarExclusao; override;

    [MVCColumnAttribute('ID', True)]
		[MVCNameAsAttribute('id')]
		property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_FORNECEDOR')]
		[MVCNameAsAttribute('idFornecedor')]
		property IdFornecedor: Integer read FIdFornecedor write FIdFornecedor;
    [MVCColumnAttribute('ID_COMPRA_PEDIDO_CABECALHO')]
		[MVCNameAsAttribute('idCompraPedidoCabecalho')]
		property IdCompraPedidoCabecalho: Integer read FIdCompraPedidoCabecalho write FIdCompraPedidoCabecalho;
    [MVCColumnAttribute('DATA_LANCAMENTO')]
		[MVCNameAsAttribute('dataLancamento')]
		property DataLancamento: Integer read FDataLancamento write FDataLancamento;
    [MVCColumnAttribute('DATA_VENCIMENTO')]
		[MVCNameAsAttribute('dataVencimento')]
		property DataVencimento: Integer read FDataVencimento write FDataVencimento;
    [MVCColumnAttribute('DATA_PAGAMENTO')]
		[MVCNameAsAttribute('dataPagamento')]
		property DataPagamento: Integer read FDataPagamento write FDataPagamento;
    [MVCColumnAttribute('VALOR_A_PAGAR')]
		[MVCNameAsAttribute('valorAPagar')]
		property ValorAPagar: Extended read FValorAPagar write FValorAPagar;
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
    [MVCColumnAttribute('NUMERO_DOCUMENTO')]
		[MVCNameAsAttribute('numeroDocumento')]
		property NumeroDocumento: string read FNumeroDocumento write FNumeroDocumento;
    [MVCColumnAttribute('HISTORICO')]
		[MVCNameAsAttribute('historico')]
		property Historico: string read FHistorico write FHistorico;
    [MVCColumnAttribute('STATUS_PAGAMENTO')]
		[MVCNameAsAttribute('statusPagamento')]
		property StatusPagamento: string read FStatusPagamento write FStatusPagamento;
      
  end;

implementation

{ TContasPagar }



end.