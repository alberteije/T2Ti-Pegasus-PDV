unit ObjetoSincroniza;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TObjetoSincroniza = class(TModelBase)
  private
    FTabela: string;
    FRegistros: string;

  public
		[MVCNameAsAttribute('tabela')]
		property Tabela: string read FTabela write FTabela;
		[MVCNameAsAttribute('registros')]
		property Registros: string read FRegistros write FRegistros;

  end;

implementation

{ TEmpresa }



end.
