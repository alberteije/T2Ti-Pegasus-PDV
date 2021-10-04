unit Cargo;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TCargo = class(TModelBase)
  private
    FId: Integer;
    FNome: string;
    FDescricao: string;
    FSalario: decimal(18,6);
    FCbo_1994: string;
    FCbo_2002: string;
      
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    [MVCColumn('ID', True)]
		[MapperJSONSer('id')]
		property Id: Integer read FId write FId;
    [MVCColumn('NOME')]
		[MapperJSONSer('nome')]
		property Nome: string read FNome write FNome;
    [MVCColumn('DESCRICAO')]
		[MapperJSONSer('descricao')]
		property Descricao: string read FDescricao write FDescricao;
    [MVCColumn('SALARIO')]
		[MapperJSONSer('salario')]
		property Salario: decimal(18,6) read FSalario write FSalario;
    [MVCColumn('CBO_1994')]
		[MapperJSONSer('cbo_1994')]
		property Cbo_1994: string read FCbo_1994 write FCbo_1994;
    [MVCColumn('CBO_2002')]
		[MapperJSONSer('cbo_2002')]
		property Cbo_2002: string read FCbo_2002 write FCbo_2002;
      
  end;

implementation

{ TCargo }

procedure TCargo.ValidarInsercao;
begin
  inherited;

end;

procedure TCargo.ValidarAlteracao;
begin
  inherited;

end;

procedure TCargo.ValidarExclusao;
begin
  inherited;

end;

end.