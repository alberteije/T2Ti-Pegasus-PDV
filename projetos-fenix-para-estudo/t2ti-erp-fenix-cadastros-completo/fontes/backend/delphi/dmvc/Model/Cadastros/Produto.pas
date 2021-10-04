{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [PRODUTO] 
                                                                                
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
unit Produto;

interface

uses
  Generics.Collections, System.SysUtils,
  ProdutoSubgrupo, ProdutoMarca, ProdutoUnidade, 
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TProduto = class(TModelBase)
  private
    FId: Integer;
    FIdProdutoSubgrupo: Integer;
    FIdProdutoMarca: Integer;
    FIdProdutoUnidade: Integer;
    FNome: string;
    FDescricao: string;
    FGtin: string;
    FCodigoInterno: string;
    FValorCompra: Extended;
    FValorVenda: Extended;
    FNcm: string;
    FEstoqueMinimo: Extended;
    FEstoqueMaximo: Extended;
    FQuantidadeEstoque: Extended;
    FDataCadastro: TDateTime;
      
    FProdutoSubgrupo: TProdutoSubgrupo;
    FProdutoMarca: TProdutoMarca;
    FProdutoUnidade: TProdutoUnidade;
  public
    procedure ValidarInsercao; override;
    procedure ValidarAlteracao; override;
    procedure ValidarExclusao; override;

    constructor Create; virtual;
    destructor Destroy; override;

    [MVCColumnAttribute('ID', True)]
	[MVCNameAsAttribute('id')]
	property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_PRODUTO_SUBGRUPO')]
	[MVCNameAsAttribute('idProdutoSubgrupo')]
	property IdProdutoSubgrupo: Integer read FIdProdutoSubgrupo write FIdProdutoSubgrupo;
    [MVCColumnAttribute('ID_PRODUTO_MARCA')]
	[MVCNameAsAttribute('idProdutoMarca')]
	property IdProdutoMarca: Integer read FIdProdutoMarca write FIdProdutoMarca;
    [MVCColumnAttribute('ID_PRODUTO_UNIDADE')]
	[MVCNameAsAttribute('idProdutoUnidade')]
	property IdProdutoUnidade: Integer read FIdProdutoUnidade write FIdProdutoUnidade;
    [MVCColumnAttribute('NOME')]
	[MVCNameAsAttribute('nome')]
	property Nome: string read FNome write FNome;
    [MVCColumnAttribute('DESCRICAO')]
	[MVCNameAsAttribute('descricao')]
	property Descricao: string read FDescricao write FDescricao;
    [MVCColumnAttribute('GTIN')]
	[MVCNameAsAttribute('gtin')]
	property Gtin: string read FGtin write FGtin;
    [MVCColumnAttribute('CODIGO_INTERNO')]
	[MVCNameAsAttribute('codigoInterno')]
	property CodigoInterno: string read FCodigoInterno write FCodigoInterno;
    [MVCColumnAttribute('VALOR_COMPRA')]
	[MVCNameAsAttribute('valorCompra')]
	property ValorCompra: Extended read FValorCompra write FValorCompra;
    [MVCColumnAttribute('VALOR_VENDA')]
	[MVCNameAsAttribute('valorVenda')]
	property ValorVenda: Extended read FValorVenda write FValorVenda;
    [MVCColumnAttribute('NCM')]
	[MVCNameAsAttribute('ncm')]
	property Ncm: string read FNcm write FNcm;
    [MVCColumnAttribute('ESTOQUE_MINIMO')]
	[MVCNameAsAttribute('estoqueMinimo')]
	property EstoqueMinimo: Extended read FEstoqueMinimo write FEstoqueMinimo;
    [MVCColumnAttribute('ESTOQUE_MAXIMO')]
	[MVCNameAsAttribute('estoqueMaximo')]
	property EstoqueMaximo: Extended read FEstoqueMaximo write FEstoqueMaximo;
    [MVCColumnAttribute('QUANTIDADE_ESTOQUE')]
	[MVCNameAsAttribute('quantidadeEstoque')]
	property QuantidadeEstoque: Extended read FQuantidadeEstoque write FQuantidadeEstoque;
    [MVCColumnAttribute('DATA_CADASTRO')]
	[MVCNameAsAttribute('dataCadastro')]
	property DataCadastro: TDateTime read FDataCadastro write FDataCadastro;
      
    [MVCNameAsAttribute('produtoSubgrupo')]
	property ProdutoSubgrupo: TProdutoSubgrupo read FProdutoSubgrupo write FProdutoSubgrupo;
    [MVCNameAsAttribute('produtoMarca')]
	property ProdutoMarca: TProdutoMarca read FProdutoMarca write FProdutoMarca;
    [MVCNameAsAttribute('produtoUnidade')]
	property ProdutoUnidade: TProdutoUnidade read FProdutoUnidade write FProdutoUnidade;
  end;

implementation

{ TProduto }

constructor TProduto.Create;
begin
  FProdutoSubgrupo := TProdutoSubgrupo.Create;
  FProdutoMarca := TProdutoMarca.Create;
  FProdutoUnidade := TProdutoUnidade.Create;
end;

destructor TProduto.Destroy;
begin
  FreeAndNil(FProdutoSubgrupo);
  FreeAndNil(FProdutoMarca);
  FreeAndNil(FProdutoUnidade);
  inherited;
end;

procedure TProduto.ValidarInsercao;
begin
  inherited;

end;

procedure TProduto.ValidarAlteracao;
begin
  inherited;

end;

procedure TProduto.ValidarExclusao;
begin
  inherited;

end;

end.