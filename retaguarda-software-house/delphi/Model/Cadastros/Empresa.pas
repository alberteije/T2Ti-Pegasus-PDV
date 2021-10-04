{*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Model relacionado à tabela [EMPRESA] 
                                                                                
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
unit Empresa;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TEmpresa = class(TModelBase)
  private
    FId: Integer;
    FRazaoSocial: string;
    FNomeFantasia: string;
    FCnpj: string;
    FInscricaoEstadual: string;
    FInscricaoMunicipal: string;
    FTipoRegime: string;
    FCrt: string;
    FDataConstituicao: TDateTime;
    FTipo: string;
    FEmail: string;
    FEmailPagamento: string;
    FLogradouro: string;
    FNumero: string;
    FComplemento: string;
    FCep: string;
    FBairro: string;
    FCidade: string;
    FUf: string;
    FFone: string;
    FContato: string;
    FCodigoIbgeCidade: Integer;
    FCodigoIbgeUf: Integer;
    FLogotipo: string;
    FRegistrado: string;
    FNaturezaJuridica: string;
    FSimei: string;
    FDataRegistro: TDateTime;
    FHoraRegistro: string;

  public
//    procedure ValidarInsercao; override;
//    procedure ValidarAlteracao; override;
//    procedure ValidarExclusao; override;

    [MVCColumnAttribute('ID', True)]
		[MVCNameAsAttribute('id')]
		property Id: Integer read FId write FId;
    [MVCColumnAttribute('RAZAO_SOCIAL')]
		[MVCNameAsAttribute('razaoSocial')]
		property RazaoSocial: string read FRazaoSocial write FRazaoSocial;
    [MVCColumnAttribute('NOME_FANTASIA')]
		[MVCNameAsAttribute('nomeFantasia')]
		property NomeFantasia: string read FNomeFantasia write FNomeFantasia;
    [MVCColumnAttribute('CNPJ')]
		[MVCNameAsAttribute('cnpj')]
		property Cnpj: string read FCnpj write FCnpj;
    [MVCColumnAttribute('INSCRICAO_ESTADUAL')]
		[MVCNameAsAttribute('inscricaoEstadual')]
		property InscricaoEstadual: string read FInscricaoEstadual write FInscricaoEstadual;
    [MVCColumnAttribute('INSCRICAO_MUNICIPAL')]
		[MVCNameAsAttribute('inscricaoMunicipal')]
		property InscricaoMunicipal: string read FInscricaoMunicipal write FInscricaoMunicipal;
    [MVCColumnAttribute('TIPO_REGIME')]
		[MVCNameAsAttribute('tipoRegime')]
		property TipoRegime: string read FTipoRegime write FTipoRegime;
    [MVCColumnAttribute('CRT')]
		[MVCNameAsAttribute('crt')]
		property Crt: string read FCrt write FCrt;
    [MVCColumnAttribute('DATA_CONSTITUICAO')]
		[MVCNameAsAttribute('dataConstituicao')]
		property DataConstituicao: TDateTime read FDataConstituicao write FDataConstituicao;
    [MVCColumnAttribute('TIPO')]
		[MVCNameAsAttribute('tipo')]
		property Tipo: string read FTipo write FTipo;
    [MVCColumnAttribute('EMAIL')]
		[MVCNameAsAttribute('email')]
		property Email: string read FEmail write FEmail;
    [MVCColumnAttribute('EMAIL_PAGAMENTO')]
		[MVCNameAsAttribute('emailPagamento')]
		property EmailPagamento: string read FEmailPagamento write FEmailPagamento;
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
    [MVCColumnAttribute('FONE')]
		[MVCNameAsAttribute('fone')]
		property Fone: string read FFone write FFone;
    [MVCColumnAttribute('CONTATO')]
		[MVCNameAsAttribute('contato')]
		property Contato: string read FContato write FContato;
    [MVCColumnAttribute('CODIGO_IBGE_CIDADE')]
		[MVCNameAsAttribute('codigoIbgeCidade')]
		property CodigoIbgeCidade: Integer read FCodigoIbgeCidade write FCodigoIbgeCidade;
    [MVCColumnAttribute('CODIGO_IBGE_UF')]
		[MVCNameAsAttribute('codigoIbgeUf')]
		property CodigoIbgeUf: Integer read FCodigoIbgeUf write FCodigoIbgeUf;
    [MVCColumnAttribute('LOGOTIPO')]
		[MVCNameAsAttribute('logotipo')]
		property Logotipo: string read FLogotipo write FLogotipo;
    [MVCColumnAttribute('REGISTRADO')]
		[MVCNameAsAttribute('registrado')]
		property Registrado: string read FRegistrado write FRegistrado;
    [MVCColumnAttribute('NATUREZA_JURIDICA')]
		[MVCNameAsAttribute('naturezaJuridica')]
		property NaturezaJuridica: string read FNaturezaJuridica write FNaturezaJuridica;
    [MVCColumnAttribute('SIMEI')]
		[MVCNameAsAttribute('simei')]
		property Simei: string read FSimei write FSimei;
    [MVCColumnAttribute('DATA_REGISTRO')]
		[MVCNameAsAttribute('dataRegistro')]
		property DataRegistro: TDateTime read FDataRegistro write FDataRegistro;
    [MVCColumnAttribute('HORA_REGISTRO')]
		[MVCNameAsAttribute('horaRegistro')]
		property HoraRegistro: string read FHoraRegistro write FHoraRegistro;

  end;

implementation

{ TEmpresa }



end.