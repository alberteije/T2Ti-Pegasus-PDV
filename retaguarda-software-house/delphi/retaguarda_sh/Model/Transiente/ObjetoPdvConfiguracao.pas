unit ObjetoPdvConfiguracao;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TObjetoPdvConfiguracao = class(TModelBase)
  private
    FDecimaisQuantidade: Integer;
    FDecimaisValor: Integer;

  public
		[MVCNameAsAttribute('decimaisQuantidade')]
		property DecimaisQuantidade: Integer read FDecimaisQuantidade write FDecimaisQuantidade;
		[MVCNameAsAttribute('decimaisValor')]
		property DecimaisValor: Integer read FDecimaisValor write FDecimaisValor;

  end;

implementation

{ TEmpresa }



end.
