{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [MUNICIPIO] 
                                                                                
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
unit Municipio;

interface

uses
  Generics.Collections, System.SysUtils,
  Uf, 
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TMunicipio = class(TModelBase)
  private
    FId: Integer;
    FIdUf: Integer;
    FNome: string;
    FCodigoIbge: Integer;
    FCodigoReceitaFederal: Integer;
    FCodigoEstadual: Integer;
      
    FUf: TUf;
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    constructor Create; virtual;
    destructor Destroy; override;

    [MVCColumnAttribute('ID', True)]
	[MVCNameAsAttribute('id')]
	property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_UF')]
	[MVCNameAsAttribute('idUf')]
	property IdUf: Integer read FIdUf write FIdUf;
    [MVCColumnAttribute('NOME')]
	[MVCNameAsAttribute('nome')]
	property Nome: string read FNome write FNome;
    [MVCColumnAttribute('CODIGO_IBGE')]
	[MVCNameAsAttribute('codigoIbge')]
	property CodigoIbge: Integer read FCodigoIbge write FCodigoIbge;
    [MVCColumnAttribute('CODIGO_RECEITA_FEDERAL')]
	[MVCNameAsAttribute('codigoReceitaFederal')]
	property CodigoReceitaFederal: Integer read FCodigoReceitaFederal write FCodigoReceitaFederal;
    [MVCColumnAttribute('CODIGO_ESTADUAL')]
	[MVCNameAsAttribute('codigoEstadual')]
	property CodigoEstadual: Integer read FCodigoEstadual write FCodigoEstadual;
      
    [MVCNameAsAttribute('uf')]
	property Uf: TUf read FUf write FUf;
  end;

implementation

{ TMunicipio }

constructor TMunicipio.Create;
begin
  FUf := TUf.Create;
end;

destructor TMunicipio.Destroy;
begin
  FreeAndNil(FUf);
  inherited;
end;

procedure TMunicipio.ValidarInsercao;
begin
  inherited;

end;

procedure TMunicipio.ValidarAlteracao;
begin
  inherited;

end;

procedure TMunicipio.ValidarExclusao;
begin
  inherited;

end;

end.