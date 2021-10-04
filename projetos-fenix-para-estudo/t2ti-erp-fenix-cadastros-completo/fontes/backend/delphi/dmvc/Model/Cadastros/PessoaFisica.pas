{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [PESSOA_FISICA] 
                                                                                
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
unit PessoaFisica;

interface

uses
  Generics.Collections, System.SysUtils,
  NivelFormacao, EstadoCivil, 
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TPessoaFisica = class(TModelBase)
  private
    FId: Integer;
    FIdPessoa: Integer;
    FIdNivelFormacao: Integer;
    FIdEstadoCivil: Integer;
    FCpf: string;
    FRg: string;
    FOrgaoRg: string;
    FDataEmissaoRg: TDateTime;
    FDataNascimento: TDateTime;
    FSexo: string;
    FRaca: string;
    FNacionalidade: string;
    FNaturalidade: string;
    FNomePai: string;
    FNomeMae: string;
      
    FNivelFormacao: TNivelFormacao;
    FEstadoCivil: TEstadoCivil;
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
    [MVCColumnAttribute('ID_NIVEL_FORMACAO')]
	[MVCNameAsAttribute('idNivelFormacao')]
	property IdNivelFormacao: Integer read FIdNivelFormacao write FIdNivelFormacao;
    [MVCColumnAttribute('ID_ESTADO_CIVIL')]
	[MVCNameAsAttribute('idEstadoCivil')]
	property IdEstadoCivil: Integer read FIdEstadoCivil write FIdEstadoCivil;
    [MVCColumnAttribute('CPF')]
	[MVCNameAsAttribute('cpf')]
	property Cpf: string read FCpf write FCpf;
    [MVCColumnAttribute('RG')]
	[MVCNameAsAttribute('rg')]
	property Rg: string read FRg write FRg;
    [MVCColumnAttribute('ORGAO_RG')]
	[MVCNameAsAttribute('orgaoRg')]
	property OrgaoRg: string read FOrgaoRg write FOrgaoRg;
    [MVCColumnAttribute('DATA_EMISSAO_RG')]
	[MVCNameAsAttribute('dataEmissaoRg')]
	property DataEmissaoRg: TDateTime read FDataEmissaoRg write FDataEmissaoRg;
    [MVCColumnAttribute('DATA_NASCIMENTO')]
	[MVCNameAsAttribute('dataNascimento')]
	property DataNascimento: TDateTime read FDataNascimento write FDataNascimento;
    [MVCColumnAttribute('SEXO')]
	[MVCNameAsAttribute('sexo')]
	property Sexo: string read FSexo write FSexo;
    [MVCColumnAttribute('RACA')]
	[MVCNameAsAttribute('raca')]
	property Raca: string read FRaca write FRaca;
    [MVCColumnAttribute('NACIONALIDADE')]
	[MVCNameAsAttribute('nacionalidade')]
	property Nacionalidade: string read FNacionalidade write FNacionalidade;
    [MVCColumnAttribute('NATURALIDADE')]
	[MVCNameAsAttribute('naturalidade')]
	property Naturalidade: string read FNaturalidade write FNaturalidade;
    [MVCColumnAttribute('NOME_PAI')]
	[MVCNameAsAttribute('nomePai')]
	property NomePai: string read FNomePai write FNomePai;
    [MVCColumnAttribute('NOME_MAE')]
	[MVCNameAsAttribute('nomeMae')]
	property NomeMae: string read FNomeMae write FNomeMae;
      
    [MVCNameAsAttribute('nivelFormacao')]
	property NivelFormacao: TNivelFormacao read FNivelFormacao write FNivelFormacao;
    [MVCNameAsAttribute('estadoCivil')]
	property EstadoCivil: TEstadoCivil read FEstadoCivil write FEstadoCivil;
  end;

implementation

{ TPessoaFisica }

constructor TPessoaFisica.Create;
begin
  FNivelFormacao := TNivelFormacao.Create;
  FEstadoCivil := TEstadoCivil.Create;
end;

destructor TPessoaFisica.Destroy;
begin
  FreeAndNil(FNivelFormacao);
  FreeAndNil(FEstadoCivil);
  inherited;
end;

procedure TPessoaFisica.ValidarInsercao;
begin
  inherited;

end;

procedure TPessoaFisica.ValidarAlteracao;
begin
  inherited;

end;

procedure TPessoaFisica.ValidarExclusao;
begin
  inherited;

end;

end.