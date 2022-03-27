{*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Model relacionado à tabela [CONTAS_RECEBER] 
                                                                                
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
unit ContasReceber;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TContasReceber = class(TModelBase)
  private
    FId: Integer;
    FIdCliente: Integer;
    FIdPdvVendaCabecalho: Integer;
    FDataLancamento: Integer;
    FDataVencimento: Integer;
    FDataRecebimento: Integer;
    FValorAReceber: Extended;
    FTaxaJuro: Extended;
    FTaxaMulta: Extended;
    FTaxaDesconto: Extended;
    FValorJuro: Extended;
    FValorMulta: Extended;
    FValorDesconto: Extended;
    FValorRecebido: Extended;
    FNumeroDocumento: string;
    FHistorico: string;
    FStatusRecebimento: string;

  public
//    procedure ValidarInsercao; override;
//    procedure ValidarAlteracao; override;
//    procedure ValidarExclusao; override;

    [MVCColumnAttribute('ID', True)]
		[MVCNameAsAttribute('id')]
		property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_CLIENTE')]
		[MVCNameAsAttribute('idCliente')]
		property IdCliente: Integer read FIdCliente write FIdCliente;
    [MVCColumnAttribute('ID_PDV_VENDA_CABECALHO')]
		[MVCNameAsAttribute('idPdvVendaCabecalho')]
		property IdPdvVendaCabecalho: Integer read FIdPdvVendaCabecalho write FIdPdvVendaCabecalho;
    [MVCColumnAttribute('DATA_LANCAMENTO')]
		[MVCNameAsAttribute('dataLancamento')]
		property DataLancamento: Integer read FDataLancamento write FDataLancamento;
    [MVCColumnAttribute('DATA_VENCIMENTO')]
		[MVCNameAsAttribute('dataVencimento')]
		property DataVencimento: Integer read FDataVencimento write FDataVencimento;
    [MVCColumnAttribute('DATA_RECEBIMENTO')]
		[MVCNameAsAttribute('dataRecebimento')]
		property DataRecebimento: Integer read FDataRecebimento write FDataRecebimento;
    [MVCColumnAttribute('VALOR_A_RECEBER')]
		[MVCNameAsAttribute('valorAReceber')]
		property ValorAReceber: Extended read FValorAReceber write FValorAReceber;
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
    [MVCColumnAttribute('VALOR_RECEBIDO')]
		[MVCNameAsAttribute('valorRecebido')]
		property ValorRecebido: Extended read FValorRecebido write FValorRecebido;
    [MVCColumnAttribute('NUMERO_DOCUMENTO')]
		[MVCNameAsAttribute('numeroDocumento')]
		property NumeroDocumento: string read FNumeroDocumento write FNumeroDocumento;
    [MVCColumnAttribute('HISTORICO')]
		[MVCNameAsAttribute('historico')]
		property Historico: string read FHistorico write FHistorico;
    [MVCColumnAttribute('STATUS_RECEBIMENTO')]
		[MVCNameAsAttribute('statusRecebimento')]
		property StatusRecebimento: string read FStatusRecebimento write FStatusRecebimento;
      
  end;

implementation

{ TContasReceber }



end.