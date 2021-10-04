{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [PRODUTO_SUBGRUPO] 
                                                                                
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
unit ProdutoSubgrupo;

interface

uses
  Generics.Collections, System.SysUtils,
  ProdutoGrupo, 
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TProdutoSubgrupo = class(TModelBase)
  private
    FId: Integer;
    FIdProdutoGrupo: Integer;
    FNome: string;
    FDescricao: string;
      
    FProdutoGrupo: TProdutoGrupo;
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    constructor Create; virtual;
    destructor Destroy; override;

    [MVCColumnAttribute('ID', True)]
	[MVCNameAsAttribute('id')]
	property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_PRODUTO_GRUPO')]
	[MVCNameAsAttribute('idProdutoGrupo')]
	property IdProdutoGrupo: Integer read FIdProdutoGrupo write FIdProdutoGrupo;
    [MVCColumnAttribute('NOME')]
	[MVCNameAsAttribute('nome')]
	property Nome: string read FNome write FNome;
    [MVCColumnAttribute('DESCRICAO')]
	[MVCNameAsAttribute('descricao')]
	property Descricao: string read FDescricao write FDescricao;
      
    [MVCNameAsAttribute('produtoGrupo')]
	property ProdutoGrupo: TProdutoGrupo read FProdutoGrupo write FProdutoGrupo;
  end;

implementation

{ TProdutoSubgrupo }

constructor TProdutoSubgrupo.Create;
begin
  FProdutoGrupo := TProdutoGrupo.Create;
end;

destructor TProdutoSubgrupo.Destroy;
begin
  FreeAndNil(FProdutoGrupo);
  inherited;
end;

procedure TProdutoSubgrupo.ValidarInsercao;
begin
  inherited;

end;

procedure TProdutoSubgrupo.ValidarAlteracao;
begin
  inherited;

end;

procedure TProdutoSubgrupo.ValidarExclusao;
begin
  inherited;

end;

end.