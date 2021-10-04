{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [VIEW_PESSOA_COLABORADOR] 
                                                                                
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
unit ViewPessoaColaborador;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TViewPessoaColaborador = class(TModelBase)
  private
    FId: Integer;
    FNome: string;
    FTipo: string;
    FEmail: string;
    FSite: string;
    FCpfCnpj: string;
    FRgIe: string;
    FMatricula: string;
    FDataCadastro: TDateTime;
    FDataAdmissao: TDateTime;
    FDataDemissao: TDateTime;
    FCtpsNumero: string;
    FCtpsSerie: string;
    FCtpsDataExpedicao: TDateTime;
    FCtpsUf: string;
    FObservacao: string;
    FLogradouro: string;
    FNumero: string;
    FComplemento: string;
    FBairro: string;
    FCidade: string;
    FCep: string;
    FMunicipioIbge: Integer;
    FUf: string;
    FIdPessoa: Integer;
    FIdCargo: Integer;
    FIdSetor: Integer;
      
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    [MVCColumnAttribute('ID', True)]
		[MVCNameAsAttribute('id')]
		property Id: Integer read FId write FId;
    [MVCColumnAttribute('NOME')]
		[MVCNameAsAttribute('nome')]
		property Nome: string read FNome write FNome;
    [MVCColumnAttribute('TIPO')]
		[MVCNameAsAttribute('tipo')]
		property Tipo: string read FTipo write FTipo;
    [MVCColumnAttribute('EMAIL')]
		[MVCNameAsAttribute('email')]
		property Email: string read FEmail write FEmail;
    [MVCColumnAttribute('SITE')]
		[MVCNameAsAttribute('site')]
		property Site: string read FSite write FSite;
    [MVCColumnAttribute('CPF_CNPJ')]
		[MVCNameAsAttribute('cpfCnpj')]
		property CpfCnpj: string read FCpfCnpj write FCpfCnpj;
    [MVCColumnAttribute('RG_IE')]
		[MVCNameAsAttribute('rgIe')]
		property RgIe: string read FRgIe write FRgIe;
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
    [MVCColumnAttribute('LOGRADOURO')]
		[MVCNameAsAttribute('logradouro')]
		property Logradouro: string read FLogradouro write FLogradouro;
    [MVCColumnAttribute('NUMERO')]
		[MVCNameAsAttribute('numero')]
		property Numero: string read FNumero write FNumero;
    [MVCColumnAttribute('COMPLEMENTO')]
		[MVCNameAsAttribute('complemento')]
		property Complemento: string read FComplemento write FComplemento;
    [MVCColumnAttribute('BAIRRO')]
		[MVCNameAsAttribute('bairro')]
		property Bairro: string read FBairro write FBairro;
    [MVCColumnAttribute('CIDADE')]
		[MVCNameAsAttribute('cidade')]
		property Cidade: string read FCidade write FCidade;
    [MVCColumnAttribute('CEP')]
		[MVCNameAsAttribute('cep')]
		property Cep: string read FCep write FCep;
    [MVCColumnAttribute('MUNICIPIO_IBGE')]
		[MVCNameAsAttribute('municipioIbge')]
		property MunicipioIbge: Integer read FMunicipioIbge write FMunicipioIbge;
    [MVCColumnAttribute('UF')]
		[MVCNameAsAttribute('uf')]
		property Uf: string read FUf write FUf;
    [MVCColumnAttribute('ID_PESSOA')]
		[MVCNameAsAttribute('idPessoa')]
		property IdPessoa: Integer read FIdPessoa write FIdPessoa;
    [MVCColumnAttribute('ID_CARGO')]
		[MVCNameAsAttribute('idCargo')]
		property IdCargo: Integer read FIdCargo write FIdCargo;
    [MVCColumnAttribute('ID_SETOR')]
		[MVCNameAsAttribute('idSetor')]
		property IdSetor: Integer read FIdSetor write FIdSetor;
      
  end;

implementation

{ TViewPessoaColaborador }



procedure TViewPessoaColaborador.ValidarInsercao;
begin
  inherited;

end;

procedure TViewPessoaColaborador.ValidarAlteracao;
begin
  inherited;

end;

procedure TViewPessoaColaborador.ValidarExclusao;
begin
  inherited;

end;

end.