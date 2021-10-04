{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_NATUREZA_FINANCEIRA] 
                                                                                
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
unit FinNaturezaFinanceira;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TFinNaturezaFinanceira = class(TModelBase)
  private
    FId: Integer;
    FCodigo: string;
    FDescricao: string;
    FTipo: string;
    FAplicacao: string;
      
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    [MVCColumnAttribute('ID', True)]
	[MVCNameAsAttribute('id')]
	property Id: Integer read FId write FId;
    [MVCColumnAttribute('CODIGO')]
	[MVCNameAsAttribute('codigo')]
	property Codigo: string read FCodigo write FCodigo;
    [MVCColumnAttribute('DESCRICAO')]
	[MVCNameAsAttribute('descricao')]
	property Descricao: string read FDescricao write FDescricao;
    [MVCColumnAttribute('TIPO')]
	[MVCNameAsAttribute('tipo')]
	property Tipo: string read FTipo write FTipo;
    [MVCColumnAttribute('APLICACAO')]
	[MVCNameAsAttribute('aplicacao')]
	property Aplicacao: string read FAplicacao write FAplicacao;
      
  end;

implementation

{ TFinNaturezaFinanceira }



procedure TFinNaturezaFinanceira.ValidarInsercao;
begin
  inherited;

end;

procedure TFinNaturezaFinanceira.ValidarAlteracao;
begin
  inherited;

end;

procedure TFinNaturezaFinanceira.ValidarExclusao;
begin
  inherited;

end;

end.