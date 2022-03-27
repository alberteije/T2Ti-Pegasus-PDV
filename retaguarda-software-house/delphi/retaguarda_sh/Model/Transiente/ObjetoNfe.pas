unit ObjetoNfe;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TObjetoNfe = class(TModelBase)
  private
    FCnpj: string;
    FJustificativa: string;
    FAno: string;
    FModelo: string;
    FSerie: string;
    FNumeroInicial: string;
    FNumeroFinal: string;
    FChaveAcesso: string;

  public
		[MVCNameAsAttribute('cnpj')]
		property Cnpj: string read FCnpj write FCnpj;
		[MVCNameAsAttribute('justificativa')]
		property Justificativa: string read FJustificativa write FJustificativa;
		[MVCNameAsAttribute('ano')]
		property Ano: string read FAno write FAno;
		[MVCNameAsAttribute('modelo')]
		property Modelo: string read FModelo write FModelo;
		[MVCNameAsAttribute('serie')]
		property Serie: string read FSerie write FSerie;
		[MVCNameAsAttribute('numeroInicial')]
		property NumeroInicial: string read FNumeroInicial write FNumeroInicial;
		[MVCNameAsAttribute('numeroFinal')]
		property NumeroFinal: string read FNumeroFinal write FNumeroFinal;
		[MVCNameAsAttribute('chaveAcesso')]
		property ChaveAcesso: string read FChaveAcesso write FChaveAcesso;

  end;

implementation

{ TEmpresa }



end.
