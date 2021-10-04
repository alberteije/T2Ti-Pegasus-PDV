unit ObjetoPagSeguro;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TObjetoPagSeguro = class(TModelBase)
  private
    FCodigoTransacao: string;
    FStatusTransacao: string;
    FCodigoStatusTransacao: string;
    FEmailCliente: string;
    FMetodoPagamento: string;
    FCodigoTipoPagamento: string;
    FCodigoProduto: string;
    FDescricaoProduto: string;
    FValorUnitario: Extended;

  public
		[MVCNameAsAttribute('codigoTransacao')]
		property CodigoTransacao: string read FCodigoTransacao write FCodigoTransacao;
		[MVCNameAsAttribute('statusTransacao')]
		property StatusTransacao: string read FStatusTransacao write FStatusTransacao;
		[MVCNameAsAttribute('codigoStatusTransacao')]
		property CodigoStatusTransacao: string read FCodigoStatusTransacao write FCodigoStatusTransacao;
		[MVCNameAsAttribute('emailCliente')]
		property EmailCliente: string read FEmailCliente write FEmailCliente;
		[MVCNameAsAttribute('metodoPagamento')]
		property MetodoPagamento: string read FMetodoPagamento write FMetodoPagamento;
		[MVCNameAsAttribute('codigoTipoPagamento')]
		property CodigoTipoPagamento: string read FCodigoTipoPagamento write FCodigoTipoPagamento;
		[MVCNameAsAttribute('codigoProduto')]
		property CodigoProduto: string read FCodigoProduto write FCodigoProduto;
		[MVCNameAsAttribute('descricaoProduto')]
		property DescricaoProduto: string read FDescricaoProduto write FDescricaoProduto;
		[MVCNameAsAttribute('valorUnitario')]
		property ValorUnitario: Extended read FValorUnitario write FValorUnitario;

  end;

implementation

{ TEmpresa }



end.
