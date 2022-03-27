{*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Model relacionado à tabela [COMPRA_PEDIDO_CABECALHO] 
                                                                                
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
unit CompraPedidoCabecalho;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TCompraPedidoCabecalho = class(TModelBase)
  private
    FId: Integer;
    FIdColaborador: Integer;
    FIdFornecedor: Integer;
    FDataPedido: Integer;
    FDataPrevisaoEntrega: Integer;
    FDataPrevisaoPagamento: Integer;
    FLocalEntrega: string;
    FLocalCobranca: string;
    FContato: string;
    FValorSubtotal: Extended;
    FTaxaDesconto: Extended;
    FValorDesconto: Extended;
    FValorTotal: Extended;
    FFormaPagamento: string;
    FGeraFinanceiro: string;
    FQuantidadeParcelas: Integer;
    FDiaPrimeiroVencimento: Integer;
    FIntervaloEntreParcelas: Integer;
    FDiaFixoParcela: string;
    FDataRecebimentoItens: Integer;
    FHoraRecebimentoItens: string;
    FAtualizouEstoque: string;
    FNumeroDocumentoEntrada: string;
      
  public
//    procedure ValidarInsercao; override;
//    procedure ValidarAlteracao; override;
//    procedure ValidarExclusao; override;

    [MVCColumnAttribute('ID', True)]
		[MVCNameAsAttribute('id')]
		property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_COLABORADOR')]
		[MVCNameAsAttribute('idColaborador')]
		property IdColaborador: Integer read FIdColaborador write FIdColaborador;
    [MVCColumnAttribute('ID_FORNECEDOR')]
		[MVCNameAsAttribute('idFornecedor')]
		property IdFornecedor: Integer read FIdFornecedor write FIdFornecedor;
    [MVCColumnAttribute('DATA_PEDIDO')]
		[MVCNameAsAttribute('dataPedido')]
		property DataPedido: Integer read FDataPedido write FDataPedido;
    [MVCColumnAttribute('DATA_PREVISAO_ENTREGA')]
		[MVCNameAsAttribute('dataPrevisaoEntrega')]
		property DataPrevisaoEntrega: Integer read FDataPrevisaoEntrega write FDataPrevisaoEntrega;
    [MVCColumnAttribute('DATA_PREVISAO_PAGAMENTO')]
		[MVCNameAsAttribute('dataPrevisaoPagamento')]
		property DataPrevisaoPagamento: Integer read FDataPrevisaoPagamento write FDataPrevisaoPagamento;
    [MVCColumnAttribute('LOCAL_ENTREGA')]
		[MVCNameAsAttribute('localEntrega')]
		property LocalEntrega: string read FLocalEntrega write FLocalEntrega;
    [MVCColumnAttribute('LOCAL_COBRANCA')]
		[MVCNameAsAttribute('localCobranca')]
		property LocalCobranca: string read FLocalCobranca write FLocalCobranca;
    [MVCColumnAttribute('CONTATO')]
		[MVCNameAsAttribute('contato')]
		property Contato: string read FContato write FContato;
    [MVCColumnAttribute('VALOR_SUBTOTAL')]
		[MVCNameAsAttribute('valorSubtotal')]
		property ValorSubtotal: Extended read FValorSubtotal write FValorSubtotal;
    [MVCColumnAttribute('TAXA_DESCONTO')]
		[MVCNameAsAttribute('taxaDesconto')]
		property TaxaDesconto: Extended read FTaxaDesconto write FTaxaDesconto;
    [MVCColumnAttribute('VALOR_DESCONTO')]
		[MVCNameAsAttribute('valorDesconto')]
		property ValorDesconto: Extended read FValorDesconto write FValorDesconto;
    [MVCColumnAttribute('VALOR_TOTAL')]
		[MVCNameAsAttribute('valorTotal')]
		property ValorTotal: Extended read FValorTotal write FValorTotal;
    [MVCColumnAttribute('FORMA_PAGAMENTO')]
		[MVCNameAsAttribute('formaPagamento')]
		property FormaPagamento: string read FFormaPagamento write FFormaPagamento;
    [MVCColumnAttribute('GERA_FINANCEIRO')]
		[MVCNameAsAttribute('geraFinanceiro')]
		property GeraFinanceiro: string read FGeraFinanceiro write FGeraFinanceiro;
    [MVCColumnAttribute('QUANTIDADE_PARCELAS')]
		[MVCNameAsAttribute('quantidadeParcelas')]
		property QuantidadeParcelas: Integer read FQuantidadeParcelas write FQuantidadeParcelas;
    [MVCColumnAttribute('DIA_PRIMEIRO_VENCIMENTO')]
		[MVCNameAsAttribute('diaPrimeiroVencimento')]
		property DiaPrimeiroVencimento: Integer read FDiaPrimeiroVencimento write FDiaPrimeiroVencimento;
    [MVCColumnAttribute('INTERVALO_ENTRE_PARCELAS')]
		[MVCNameAsAttribute('intervaloEntreParcelas')]
		property IntervaloEntreParcelas: Integer read FIntervaloEntreParcelas write FIntervaloEntreParcelas;
    [MVCColumnAttribute('DIA_FIXO_PARCELA')]
		[MVCNameAsAttribute('diaFixoParcela')]
		property DiaFixoParcela: string read FDiaFixoParcela write FDiaFixoParcela;
    [MVCColumnAttribute('DATA_RECEBIMENTO_ITENS')]
		[MVCNameAsAttribute('dataRecebimentoItens')]
		property DataRecebimentoItens: Integer read FDataRecebimentoItens write FDataRecebimentoItens;
    [MVCColumnAttribute('HORA_RECEBIMENTO_ITENS')]
		[MVCNameAsAttribute('horaRecebimentoItens')]
		property HoraRecebimentoItens: string read FHoraRecebimentoItens write FHoraRecebimentoItens;
    [MVCColumnAttribute('ATUALIZOU_ESTOQUE')]
		[MVCNameAsAttribute('atualizouEstoque')]
		property AtualizouEstoque: string read FAtualizouEstoque write FAtualizouEstoque;
    [MVCColumnAttribute('NUMERO_DOCUMENTO_ENTRADA')]
		[MVCNameAsAttribute('numeroDocumentoEntrada')]
		property NumeroDocumentoEntrada: string read FNumeroDocumentoEntrada write FNumeroDocumentoEntrada;
      
  end;

implementation

{ TCompraPedidoCabecalho }



end.