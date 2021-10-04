{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [USUARIO] 
                                                                                
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
unit Usuario;

interface

uses
  Generics.Collections, System.SysUtils,
  Papel, 
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TUsuario = class(TModelBase)
  private
    FId: Integer;
    FIdColaborador: Integer;
    FIdPapel: Integer;
    FLogin: string;
    FSenha: string;
    FAdministrador: string;
    FDataCadastro: TDateTime;
      
    FPapel: TPapel;
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    constructor Create; virtual;
    destructor Destroy; override;

    [MVCColumnAttribute('ID', True)]
	[MVCNameAsAttribute('id')]
	property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_COLABORADOR')]
	[MVCNameAsAttribute('idColaborador')]
	property IdColaborador: Integer read FIdColaborador write FIdColaborador;
    [MVCColumnAttribute('ID_PAPEL')]
	[MVCNameAsAttribute('idPapel')]
	property IdPapel: Integer read FIdPapel write FIdPapel;
    [MVCColumnAttribute('LOGIN')]
	[MVCNameAsAttribute('login')]
	property Login: string read FLogin write FLogin;
    [MVCColumnAttribute('SENHA')]
	[MVCNameAsAttribute('senha')]
	property Senha: string read FSenha write FSenha;
    [MVCColumnAttribute('ADMINISTRADOR')]
	[MVCNameAsAttribute('administrador')]
	property Administrador: string read FAdministrador write FAdministrador;
    [MVCColumnAttribute('DATA_CADASTRO')]
	[MVCNameAsAttribute('dataCadastro')]
	property DataCadastro: TDateTime read FDataCadastro write FDataCadastro;
      
    [MVCNameAsAttribute('papel')]
	property Papel: TPapel read FPapel write FPapel;
  end;

implementation

{ TUsuario }

constructor TUsuario.Create;
begin
  FPapel := TPapel.Create;
end;

destructor TUsuario.Destroy;
begin
  FreeAndNil(FPapel);
  inherited;
end;

procedure TUsuario.ValidarInsercao;
begin
  inherited;

end;

procedure TUsuario.ValidarAlteracao;
begin
  inherited;

end;

procedure TUsuario.ValidarExclusao;
begin
  inherited;

end;

end.