{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [PESSOA_ENDERECO] 
                                                                                
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
unit PessoaEndereco;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TPessoaEndereco = class(TModelBase)
  private
    FId: Integer;
    FIdPessoa: Integer;
    FLogradouro: string;
    FNumero: string;
    FBairro: string;
    FMunicipioIbge: Integer;
    FUf: string;
    FCep: string;
    FCidade: string;
    FComplemento: string;
    FPrincipal: string;
    FEntrega: string;
    FCobranca: string;
    FCorrespondencia: string;
      
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    [MVCColumnAttribute('ID', True)]
	[MVCNameAsAttribute('id')]
	property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_PESSOA')]
	[MVCNameAsAttribute('idPessoa')]
	property IdPessoa: Integer read FIdPessoa write FIdPessoa;
    [MVCColumnAttribute('LOGRADOURO')]
	[MVCNameAsAttribute('logradouro')]
	property Logradouro: string read FLogradouro write FLogradouro;
    [MVCColumnAttribute('NUMERO')]
	[MVCNameAsAttribute('numero')]
	property Numero: string read FNumero write FNumero;
    [MVCColumnAttribute('BAIRRO')]
	[MVCNameAsAttribute('bairro')]
	property Bairro: string read FBairro write FBairro;
    [MVCColumnAttribute('MUNICIPIO_IBGE')]
	[MVCNameAsAttribute('municipioIbge')]
	property MunicipioIbge: Integer read FMunicipioIbge write FMunicipioIbge;
    [MVCColumnAttribute('UF')]
	[MVCNameAsAttribute('uf')]
	property Uf: string read FUf write FUf;
    [MVCColumnAttribute('CEP')]
	[MVCNameAsAttribute('cep')]
	property Cep: string read FCep write FCep;
    [MVCColumnAttribute('CIDADE')]
	[MVCNameAsAttribute('cidade')]
	property Cidade: string read FCidade write FCidade;
    [MVCColumnAttribute('COMPLEMENTO')]
	[MVCNameAsAttribute('complemento')]
	property Complemento: string read FComplemento write FComplemento;
    [MVCColumnAttribute('PRINCIPAL')]
	[MVCNameAsAttribute('principal')]
	property Principal: string read FPrincipal write FPrincipal;
    [MVCColumnAttribute('ENTREGA')]
	[MVCNameAsAttribute('entrega')]
	property Entrega: string read FEntrega write FEntrega;
    [MVCColumnAttribute('COBRANCA')]
	[MVCNameAsAttribute('cobranca')]
	property Cobranca: string read FCobranca write FCobranca;
    [MVCColumnAttribute('CORRESPONDENCIA')]
	[MVCNameAsAttribute('correspondencia')]
	property Correspondencia: string read FCorrespondencia write FCorrespondencia;
      
  end;

implementation

{ TPessoaEndereco }



procedure TPessoaEndereco.ValidarInsercao;
begin
  inherited;

end;

procedure TPessoaEndereco.ValidarAlteracao;
begin
  inherited;

end;

procedure TPessoaEndereco.ValidarExclusao;
begin
  inherited;

end;

end.