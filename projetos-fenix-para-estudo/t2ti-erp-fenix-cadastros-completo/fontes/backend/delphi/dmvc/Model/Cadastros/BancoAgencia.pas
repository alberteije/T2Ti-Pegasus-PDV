{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [BANCO_AGENCIA] 
                                                                                
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
unit BancoAgencia;

interface

uses
  Generics.Collections, System.SysUtils,
  Banco, 
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TBancoAgencia = class(TModelBase)
  private
    FId: Integer;
    FIdBanco: Integer;
    FNumero: string;
    FDigito: string;
    FNome: string;
    FTelefone: string;
    FContato: string;
    FObservacao: string;
    FGerente: string;
      
    FBanco: TBanco;
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    constructor Create; virtual;
    destructor Destroy; override;

    [MVCColumnAttribute('ID', True)]
	[MVCNameAsAttribute('id')]
	property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_BANCO')]
	[MVCNameAsAttribute('idBanco')]
	property IdBanco: Integer read FIdBanco write FIdBanco;
    [MVCColumnAttribute('NUMERO')]
	[MVCNameAsAttribute('numero')]
	property Numero: string read FNumero write FNumero;
    [MVCColumnAttribute('DIGITO')]
	[MVCNameAsAttribute('digito')]
	property Digito: string read FDigito write FDigito;
    [MVCColumnAttribute('NOME')]
	[MVCNameAsAttribute('nome')]
	property Nome: string read FNome write FNome;
    [MVCColumnAttribute('TELEFONE')]
	[MVCNameAsAttribute('telefone')]
	property Telefone: string read FTelefone write FTelefone;
    [MVCColumnAttribute('CONTATO')]
	[MVCNameAsAttribute('contato')]
	property Contato: string read FContato write FContato;
    [MVCColumnAttribute('OBSERVACAO')]
	[MVCNameAsAttribute('observacao')]
	property Observacao: string read FObservacao write FObservacao;
    [MVCColumnAttribute('GERENTE')]
	[MVCNameAsAttribute('gerente')]
	property Gerente: string read FGerente write FGerente;
      
    [MVCNameAsAttribute('banco')]
	property Banco: TBanco read FBanco write FBanco;
  end;

implementation

{ TBancoAgencia }

constructor TBancoAgencia.Create;
begin
  FBanco := TBanco.Create;
end;

destructor TBancoAgencia.Destroy;
begin
  FreeAndNil(FBanco);
  inherited;
end;

procedure TBancoAgencia.ValidarInsercao;
begin
  inherited;

end;

procedure TBancoAgencia.ValidarAlteracao;
begin
  inherited;

end;

procedure TBancoAgencia.ValidarExclusao;
begin
  inherited;

end;

end.