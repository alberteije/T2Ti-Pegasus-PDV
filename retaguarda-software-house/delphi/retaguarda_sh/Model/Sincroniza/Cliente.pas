{*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Model relacionado à tabela [CLIENTE] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
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
unit Cliente;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TCliente = class(TModelBase)
  private
    FId: Integer;
    FNome: string;
    FFantasia: string;
    FEmail: string;
    FUrl: string;
    FCpfCnpj: string;
    FRg: string;
    FOrgaoRg: string;
    FDataEmissaoRg: Integer;
    FSexo: string;
    FInscricaoEstadual: string;
    FInscricaoMunicipal: string;
    FTipoPessoa: string;
    FDataCadastro: Integer;
    FLogradouro: string;
    FNumero: string;
    FComplemento: string;
    FCep: string;
    FBairro: string;
    FCidade: string;
    FUf: string;
    FTelefone: string;
    FCelular: string;
    FContato: string;
    FCodigoIbgeCidade: Integer;
    FCodigoIbgeUf: Integer;
    FFidelidadeAviso: string;
    FFidelidadeQuantidade: Integer;
    FFidelidadeValor: Extended;

  public
//    procedure ValidarInsercao; override;
//    procedure ValidarAlteracao; override;
//    procedure ValidarExclusao; override;

    [MVCColumnAttribute('ID', True)]
		[MVCNameAsAttribute('id')]
		property Id: Integer read FId write FId;
    [MVCColumnAttribute('NOME')]
		[MVCNameAsAttribute('nome')]
		property Nome: string read FNome write FNome;
    [MVCColumnAttribute('FANTASIA')]
		[MVCNameAsAttribute('fantasia')]
		property Fantasia: string read FFantasia write FFantasia;
    [MVCColumnAttribute('EMAIL')]
		[MVCNameAsAttribute('email')]
		property Email: string read FEmail write FEmail;
    [MVCColumnAttribute('URL')]
		[MVCNameAsAttribute('url')]
		property Url: string read FUrl write FUrl;
    [MVCColumnAttribute('CPF_CNPJ')]
		[MVCNameAsAttribute('cpfCnpj')]
		property CpfCnpj: string read FCpfCnpj write FCpfCnpj;
    [MVCColumnAttribute('RG')]
		[MVCNameAsAttribute('rg')]
		property Rg: string read FRg write FRg;
    [MVCColumnAttribute('ORGAO_RG')]
		[MVCNameAsAttribute('orgaoRg')]
		property OrgaoRg: string read FOrgaoRg write FOrgaoRg;
    [MVCColumnAttribute('DATA_EMISSAO_RG')]
		[MVCNameAsAttribute('dataEmissaoRg')]
		property DataEmissaoRg: Integer read FDataEmissaoRg write FDataEmissaoRg;
    [MVCColumnAttribute('SEXO')]
		[MVCNameAsAttribute('sexo')]
		property Sexo: string read FSexo write FSexo;
    [MVCColumnAttribute('INSCRICAO_ESTADUAL')]
		[MVCNameAsAttribute('inscricaoEstadual')]
		property InscricaoEstadual: string read FInscricaoEstadual write FInscricaoEstadual;
    [MVCColumnAttribute('INSCRICAO_MUNICIPAL')]
		[MVCNameAsAttribute('inscricaoMunicipal')]
		property InscricaoMunicipal: string read FInscricaoMunicipal write FInscricaoMunicipal;
    [MVCColumnAttribute('TIPO_PESSOA')]
		[MVCNameAsAttribute('tipoPessoa')]
		property TipoPessoa: string read FTipoPessoa write FTipoPessoa;
    [MVCColumnAttribute('DATA_CADASTRO')]
		[MVCNameAsAttribute('dataCadastro')]
		property DataCadastro: Integer read FDataCadastro write FDataCadastro;
    [MVCColumnAttribute('LOGRADOURO')]
		[MVCNameAsAttribute('logradouro')]
		property Logradouro: string read FLogradouro write FLogradouro;
    [MVCColumnAttribute('NUMERO')]
		[MVCNameAsAttribute('numero')]
		property Numero: string read FNumero write FNumero;
    [MVCColumnAttribute('COMPLEMENTO')]
		[MVCNameAsAttribute('complemento')]
		property Complemento: string read FComplemento write FComplemento;
    [MVCColumnAttribute('CEP')]
		[MVCNameAsAttribute('cep')]
		property Cep: string read FCep write FCep;
    [MVCColumnAttribute('BAIRRO')]
		[MVCNameAsAttribute('bairro')]
		property Bairro: string read FBairro write FBairro;
    [MVCColumnAttribute('CIDADE')]
		[MVCNameAsAttribute('cidade')]
		property Cidade: string read FCidade write FCidade;
    [MVCColumnAttribute('UF')]
		[MVCNameAsAttribute('uf')]
		property Uf: string read FUf write FUf;
    [MVCColumnAttribute('TELEFONE')]
		[MVCNameAsAttribute('telefone')]
		property Telefone: string read FTelefone write FTelefone;
    [MVCColumnAttribute('CELULAR')]
		[MVCNameAsAttribute('celular')]
		property Celular: string read FCelular write FCelular;
    [MVCColumnAttribute('CONTATO')]
		[MVCNameAsAttribute('contato')]
		property Contato: string read FContato write FContato;
    [MVCColumnAttribute('CODIGO_IBGE_CIDADE')]
		[MVCNameAsAttribute('codigoIbgeCidade')]
		property CodigoIbgeCidade: Integer read FCodigoIbgeCidade write FCodigoIbgeCidade;
    [MVCColumnAttribute('CODIGO_IBGE_UF')]
		[MVCNameAsAttribute('codigoIbgeUf')]
		property CodigoIbgeUf: Integer read FCodigoIbgeUf write FCodigoIbgeUf;
    [MVCColumnAttribute('FIDELIDADE_AVISO')]
		[MVCNameAsAttribute('fidelidadeAviso')]
		property FidelidadeAviso: string read FFidelidadeAviso write FFidelidadeAviso;
    [MVCColumnAttribute('FIDELIDADE_QUANTIDADE')]
		[MVCNameAsAttribute('fidelidadeQuantidade')]
		property FidelidadeQuantidade: Integer read FFidelidadeQuantidade write FFidelidadeQuantidade;
    [MVCColumnAttribute('FIDELIDADE_VALOR')]
		[MVCNameAsAttribute('fidelidadeValor')]
		property FidelidadeValor: Extended read FFidelidadeValor write FFidelidadeValor;
      
  end;

implementation

{ TCliente }



end.