unit ModelBase;

interface

uses
  MVCFramework.Serializer.Commons;

type
  TModelBase = class
  private
  public
    procedure ValidarInsercao; virtual;
    procedure ValidarAlteracao; virtual;
    procedure ValidarExclusao; virtual;
  end;

implementation

{ TModelBase }

procedure TModelBase.ValidarInsercao;
begin

end;

procedure TModelBase.ValidarAlteracao;
begin

end;

procedure TModelBase.ValidarExclusao;
begin

end;

end.
