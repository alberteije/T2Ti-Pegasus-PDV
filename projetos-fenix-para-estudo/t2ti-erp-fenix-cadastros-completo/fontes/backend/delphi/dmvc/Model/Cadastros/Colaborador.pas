{*******************************************************************************
Title: T2Ti ERP Fenix
Description: Model relacionado à tabela [COLABORADOR]

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
unit Colaborador;

interface

uses
  Generics.Collections, System.SysUtils,
  Usuario, Pessoa, Cargo, Setor,
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TColaborador = class(TModelBase)
  private
    FId: Integer;
    FIdPessoa: Integer;
    FIdCargo: Integer;
    FIdSetor: Integer;
    FMatricula: string;
    FDataCadastro: TDateTime;
    FDataAdmissao: TDateTime;
    FDataDemissao: TDateTime;
    FCtpsNumero: string;
    FCtpsSerie: string;
    FCtpsDataExpedicao: TDateTime;
    FCtpsUf: string;
    FObservacao: string;

    FUsuario: TUsuario;
    FPessoa: TPessoa;
    FCargo: TCargo;
    FSetor: TSetor;
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    constructor Create; virtual;
    destructor Destroy; override;

    [MVCColumnAttribute('ID', True)]
	[MVCNameAsAttribute('id')]
	property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_PESSOA')]
	[MVCNameAsAttribute('idPessoa')]
	property IdPessoa: Integer read FIdPessoa write FIdPessoa;
    [MVCColumnAttribute('ID_CARGO')]
	[MVCNameAsAttribute('idCargo')]
	property IdCargo: Integer read FIdCargo write FIdCargo;
    [MVCColumnAttribute('ID_SETOR')]
	[MVCNameAsAttribute('idSetor')]
	property IdSetor: Integer read FIdSetor write FIdSetor;
    [MVCColumnAttribute('MATRICULA')]
	[MVCNameAsAttribute('matricula')]
	property Matricula: string read FMatricula write FMatricula;
    [MVCColumnAttribute('DATA_CADASTRO')]
	[MVCNameAsAttribute('dataCadastro')]
	property DataCadastro: TDateTime read FDataCadastro write FDataCadastro;
    [MVCColumnAttribute('DATA_ADMISSAO')]
	[MVCNameAsAttribute('dataAdmissao')]
	property DataAdmissao: TDateTime read FDataAdmissao write FDataAdmissao;
    [MVCColumnAttribute('DATA_DEMISSAO')]
	[MVCNameAsAttribute('dataDemissao')]
	property DataDemissao: TDateTime read FDataDemissao write FDataDemissao;
    [MVCColumnAttribute('CTPS_NUMERO')]
	[MVCNameAsAttribute('ctpsNumero')]
	property CtpsNumero: string read FCtpsNumero write FCtpsNumero;
    [MVCColumnAttribute('CTPS_SERIE')]
	[MVCNameAsAttribute('ctpsSerie')]
	property CtpsSerie: string read FCtpsSerie write FCtpsSerie;
    [MVCColumnAttribute('CTPS_DATA_EXPEDICAO')]
	[MVCNameAsAttribute('ctpsDataExpedicao')]
	property CtpsDataExpedicao: TDateTime read FCtpsDataExpedicao write FCtpsDataExpedicao;
    [MVCColumnAttribute('CTPS_UF')]
	[MVCNameAsAttribute('ctpsUf')]
	property CtpsUf: string read FCtpsUf write FCtpsUf;
    [MVCColumnAttribute('OBSERVACAO')]
	[MVCNameAsAttribute('observacao')]
	property Observacao: string read FObservacao write FObservacao;

    [MVCNameAsAttribute('usuario')]
	property Usuario: TUsuario read FUsuario write FUsuario;
    [MVCNameAsAttribute('pessoa')]
	property Pessoa: TPessoa read FPessoa write FPessoa;
    [MVCNameAsAttribute('cargo')]
	property Cargo: TCargo read FCargo write FCargo;
    [MVCNameAsAttribute('setor')]
	property Setor: TSetor read FSetor write FSetor;
  end;

implementation

{ TColaborador }

constructor TColaborador.Create;
begin
  FUsuario := TUsuario.Create;
  FPessoa := TPessoa.Create;
  FCargo := TCargo.Create;
  FSetor := TSetor.Create;
end;

destructor TColaborador.Destroy;
begin
  FreeAndNil(FUsuario);
  FreeAndNil(FPessoa);
  FreeAndNil(FCargo);
  FreeAndNil(FSetor);
  inherited;
end;

procedure TColaborador.ValidarInsercao;
begin
  inherited;

end;

procedure TColaborador.ValidarAlteracao;
begin
  inherited;

end;

procedure TColaborador.ValidarExclusao;
begin
  inherited;

end;

end.
