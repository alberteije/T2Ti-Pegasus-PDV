{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [CEP] 
                                                                                
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
unit Cep;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TCep = class(TModelBase)
  private
    FId: Integer;
    FNumero: string;
    FLogradouro: string;
    FComplemento: string;
    FBairro: string;
    FMunicipio: string;
    FUf: string;
    FCodigoIbgeMunicipio: Integer;
      
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    [MVCColumnAttribute('ID', True)]
	[MVCNameAsAttribute('id')]
	property Id: Integer read FId write FId;
    [MVCColumnAttribute('NUMERO')]
	[MVCNameAsAttribute('numero')]
	property Numero: string read FNumero write FNumero;
    [MVCColumnAttribute('LOGRADOURO')]
	[MVCNameAsAttribute('logradouro')]
	property Logradouro: string read FLogradouro write FLogradouro;
    [MVCColumnAttribute('COMPLEMENTO')]
	[MVCNameAsAttribute('complemento')]
	property Complemento: string read FComplemento write FComplemento;
    [MVCColumnAttribute('BAIRRO')]
	[MVCNameAsAttribute('bairro')]
	property Bairro: string read FBairro write FBairro;
    [MVCColumnAttribute('MUNICIPIO')]
	[MVCNameAsAttribute('municipio')]
	property Municipio: string read FMunicipio write FMunicipio;
    [MVCColumnAttribute('UF')]
	[MVCNameAsAttribute('uf')]
	property Uf: string read FUf write FUf;
    [MVCColumnAttribute('CODIGO_IBGE_MUNICIPIO')]
	[MVCNameAsAttribute('codigoIbgeMunicipio')]
	property CodigoIbgeMunicipio: Integer read FCodigoIbgeMunicipio write FCodigoIbgeMunicipio;
      
  end;

implementation

{ TCep }



procedure TCep.ValidarInsercao;
begin
  inherited;

end;

procedure TCep.ValidarAlteracao;
begin
  inherited;

end;

procedure TCep.ValidarExclusao;
begin
  inherited;

end;

end.