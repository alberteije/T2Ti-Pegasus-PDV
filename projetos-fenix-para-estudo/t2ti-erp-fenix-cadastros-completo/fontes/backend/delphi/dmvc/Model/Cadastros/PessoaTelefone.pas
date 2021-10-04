{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [PESSOA_TELEFONE] 
                                                                                
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
unit PessoaTelefone;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TPessoaTelefone = class(TModelBase)
  private
    FId: Integer;
    FIdPessoa: Integer;
    FTipo: string;
    FNumero: string;
      
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
    [MVCColumnAttribute('TIPO')]
	[MVCNameAsAttribute('tipo')]
	property Tipo: string read FTipo write FTipo;
    [MVCColumnAttribute('NUMERO')]
	[MVCNameAsAttribute('numero')]
	property Numero: string read FNumero write FNumero;
      
  end;

implementation

{ TPessoaTelefone }



procedure TPessoaTelefone.ValidarInsercao;
begin
  inherited;

end;

procedure TPessoaTelefone.ValidarAlteracao;
begin
  inherited;

end;

procedure TPessoaTelefone.ValidarExclusao;
begin
  inherited;

end;

end.