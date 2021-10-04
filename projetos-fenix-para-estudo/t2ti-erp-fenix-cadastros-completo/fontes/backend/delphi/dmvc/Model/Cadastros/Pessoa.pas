{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [PESSOA] 
                                                                                
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
unit Pessoa;

interface

uses
  Generics.Collections, System.SysUtils,
  PessoaContato, PessoaEndereco, PessoaFisica, PessoaJuridica, PessoaTelefone, 
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TPessoa = class(TModelBase)
  private
    FId: Integer;
    FNome: string;
    FTipo: string;
    FSite: string;
    FEmail: string;
    FCliente: string;
    FFornecedor: string;
    FTransportadora: string;
    FColaborador: string;
    FContador: string;
      
    FPessoaFisica: TPessoaFisica;
    FPessoaJuridica: TPessoaJuridica;
    FListaPessoaContato: TObjectList<TPessoaContato>;
    FListaPessoaEndereco: TObjectList<TPessoaEndereco>;
    FListaPessoaTelefone: TObjectList<TPessoaTelefone>;
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    constructor Create; virtual;
    destructor Destroy; override;

    [MVCColumnAttribute('ID', True)]
	[MVCNameAsAttribute('id')]
	property Id: Integer read FId write FId;
    [MVCColumnAttribute('NOME')]
	[MVCNameAsAttribute('nome')]
	property Nome: string read FNome write FNome;
    [MVCColumnAttribute('TIPO')]
	[MVCNameAsAttribute('tipo')]
	property Tipo: string read FTipo write FTipo;
    [MVCColumnAttribute('SITE')]
	[MVCNameAsAttribute('site')]
	property Site: string read FSite write FSite;
    [MVCColumnAttribute('EMAIL')]
	[MVCNameAsAttribute('email')]
	property Email: string read FEmail write FEmail;
    [MVCColumnAttribute('CLIENTE')]
	[MVCNameAsAttribute('cliente')]
	property Cliente: string read FCliente write FCliente;
    [MVCColumnAttribute('FORNECEDOR')]
	[MVCNameAsAttribute('fornecedor')]
	property Fornecedor: string read FFornecedor write FFornecedor;
    [MVCColumnAttribute('TRANSPORTADORA')]
	[MVCNameAsAttribute('transportadora')]
	property Transportadora: string read FTransportadora write FTransportadora;
    [MVCColumnAttribute('COLABORADOR')]
	[MVCNameAsAttribute('colaborador')]
	property Colaborador: string read FColaborador write FColaborador;
    [MVCColumnAttribute('CONTADOR')]
	[MVCNameAsAttribute('contador')]
	property Contador: string read FContador write FContador;
      
    [MVCNameAsAttribute('pessoaFisica')]
	property PessoaFisica: TPessoaFisica read FPessoaFisica write FPessoaFisica;
    [MVCNameAsAttribute('pessoaJuridica')]
	property PessoaJuridica: TPessoaJuridica read FPessoaJuridica write FPessoaJuridica;
    [MapperListOf(TPessoaContato)]
	[MVCNameAsAttribute('listaPessoaContato')]
	property ListaPessoaContato: TObjectList<TPessoaContato> read FListaPessoaContato write FListaPessoaContato;
    [MapperListOf(TPessoaEndereco)]
	[MVCNameAsAttribute('listaPessoaEndereco')]
	property ListaPessoaEndereco: TObjectList<TPessoaEndereco> read FListaPessoaEndereco write FListaPessoaEndereco;
    [MapperListOf(TPessoaTelefone)]
	[MVCNameAsAttribute('listaPessoaTelefone')]
	property ListaPessoaTelefone: TObjectList<TPessoaTelefone> read FListaPessoaTelefone write FListaPessoaTelefone;
  end;

implementation

{ TPessoa }

constructor TPessoa.Create;
begin
  FListaPessoaContato := TObjectList<TPessoaContato>.Create;
  FListaPessoaEndereco := TObjectList<TPessoaEndereco>.Create;
  FPessoaFisica := TPessoaFisica.Create;
  FPessoaJuridica := TPessoaJuridica.Create;
  FListaPessoaTelefone := TObjectList<TPessoaTelefone>.Create;
end;

destructor TPessoa.Destroy;
begin
  FreeAndNil(FListaPessoaContato);
  FreeAndNil(FListaPessoaEndereco);
  FreeAndNil(FPessoaFisica);
  FreeAndNil(FPessoaJuridica);
  FreeAndNil(FListaPessoaTelefone);
  inherited;
end;

procedure TPessoa.ValidarInsercao;
begin
  inherited;

end;

procedure TPessoa.ValidarAlteracao;
begin
  inherited;

end;

procedure TPessoa.ValidarExclusao;
begin
  inherited;

end;

end.