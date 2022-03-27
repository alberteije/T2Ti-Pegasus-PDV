{*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Model relacionado à tabela [PRODUTO] 
                                                                                
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
unit Produto;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TProduto = class(TModelBase)
  private
    FId: Integer;
    FIdProdutoUnidade: Integer;
    FIdTributGrupoTributario: Integer;
    FIdProdutoTipo: Integer;
    FIdProdutoSubgrupo: Integer;
    FGtin: string;
    FCodigoInterno: string;
    FNome: string;
    FDescricao: string;
    FDescricaoPdv: string;
    FValorCompra: Extended;
    FValorVenda: Extended;
    FQuantidadeEstoque: Extended;
    FEstoqueMinimo: Extended;
    FEstoqueMaximo: Extended;
    FCodigoNcm: string;
    FIat: string;
    FIppt: string;
    FTipoItemSped: string;
    FTaxaIpi: Extended;
    FTaxaIssqn: Extended;
    FTaxaPis: Extended;
    FTaxaCofins: Extended;
    FTaxaIcms: Extended;
    FCst: string;
    FCsosn: string;
    FTotalizadorParcial: string;
    FEcfIcmsSt: string;
    FCodigoBalanca: Integer;
    FPafPSt: string;
    FHashRegistro: string;
    FValorCusto: Extended;
    FSituacao: string;
    FCodigoCest: string;

  public
//    procedure ValidarInsercao; override;
//    procedure ValidarAlteracao; override;
//    procedure ValidarExclusao; override;

    [MVCColumnAttribute('ID', True)]
		[MVCNameAsAttribute('id')]
		property Id: Integer read FId write FId;
    [MVCColumnAttribute('ID_PRODUTO_UNIDADE')]
		[MVCNameAsAttribute('idProdutoUnidade')]
		property IdProdutoUnidade: Integer read FIdProdutoUnidade write FIdProdutoUnidade;
    [MVCColumnAttribute('ID_TRIBUT_GRUPO_TRIBUTARIO')]
		[MVCNameAsAttribute('idTributGrupoTributario')]
		property IdTributGrupoTributario: Integer read FIdTributGrupoTributario write FIdTributGrupoTributario;
    [MVCColumnAttribute('ID_PRODUTO_TIPO')]
		[MVCNameAsAttribute('idProdutoTipo')]
		property IdProdutoTipo: Integer read FIdProdutoTipo write FIdProdutoTipo;
    [MVCColumnAttribute('ID_PRODUTO_SUBGRUPO')]
		[MVCNameAsAttribute('idProdutoSubgrupo')]
		property IdProdutoSubgrupo: Integer read FIdProdutoSubgrupo write FIdProdutoSubgrupo;
    [MVCColumnAttribute('GTIN')]
		[MVCNameAsAttribute('gtin')]
		property Gtin: string read FGtin write FGtin;
    [MVCColumnAttribute('CODIGO_INTERNO')]
		[MVCNameAsAttribute('codigoInterno')]
		property CodigoInterno: string read FCodigoInterno write FCodigoInterno;
    [MVCColumnAttribute('NOME')]
		[MVCNameAsAttribute('nome')]
		property Nome: string read FNome write FNome;
    [MVCColumnAttribute('DESCRICAO')]
		[MVCNameAsAttribute('descricao')]
		property Descricao: string read FDescricao write FDescricao;
    [MVCColumnAttribute('DESCRICAO_PDV')]
		[MVCNameAsAttribute('descricaoPdv')]
		property DescricaoPdv: string read FDescricaoPdv write FDescricaoPdv;
    [MVCColumnAttribute('VALOR_COMPRA')]
		[MVCNameAsAttribute('valorCompra')]
		property ValorCompra: Extended read FValorCompra write FValorCompra;
    [MVCColumnAttribute('VALOR_VENDA')]
		[MVCNameAsAttribute('valorVenda')]
		property ValorVenda: Extended read FValorVenda write FValorVenda;
    [MVCColumnAttribute('QUANTIDADE_ESTOQUE')]
		[MVCNameAsAttribute('quantidadeEstoque')]
		property QuantidadeEstoque: Extended read FQuantidadeEstoque write FQuantidadeEstoque;
    [MVCColumnAttribute('ESTOQUE_MINIMO')]
		[MVCNameAsAttribute('estoqueMinimo')]
		property EstoqueMinimo: Extended read FEstoqueMinimo write FEstoqueMinimo;
    [MVCColumnAttribute('ESTOQUE_MAXIMO')]
		[MVCNameAsAttribute('estoqueMaximo')]
		property EstoqueMaximo: Extended read FEstoqueMaximo write FEstoqueMaximo;
    [MVCColumnAttribute('CODIGO_NCM')]
		[MVCNameAsAttribute('codigoNcm')]
		property CodigoNcm: string read FCodigoNcm write FCodigoNcm;
    [MVCColumnAttribute('IAT')]
		[MVCNameAsAttribute('iat')]
		property Iat: string read FIat write FIat;
    [MVCColumnAttribute('IPPT')]
		[MVCNameAsAttribute('ippt')]
		property Ippt: string read FIppt write FIppt;
    [MVCColumnAttribute('TIPO_ITEM_SPED')]
		[MVCNameAsAttribute('tipoItemSped')]
		property TipoItemSped: string read FTipoItemSped write FTipoItemSped;
    [MVCColumnAttribute('TAXA_IPI')]
		[MVCNameAsAttribute('taxaIpi')]
		property TaxaIpi: Extended read FTaxaIpi write FTaxaIpi;
    [MVCColumnAttribute('TAXA_ISSQN')]
		[MVCNameAsAttribute('taxaIssqn')]
		property TaxaIssqn: Extended read FTaxaIssqn write FTaxaIssqn;
    [MVCColumnAttribute('TAXA_PIS')]
		[MVCNameAsAttribute('taxaPis')]
		property TaxaPis: Extended read FTaxaPis write FTaxaPis;
    [MVCColumnAttribute('TAXA_COFINS')]
		[MVCNameAsAttribute('taxaCofins')]
		property TaxaCofins: Extended read FTaxaCofins write FTaxaCofins;
    [MVCColumnAttribute('TAXA_ICMS')]
		[MVCNameAsAttribute('taxaIcms')]
		property TaxaIcms: Extended read FTaxaIcms write FTaxaIcms;
    [MVCColumnAttribute('CST')]
		[MVCNameAsAttribute('cst')]
		property Cst: string read FCst write FCst;
    [MVCColumnAttribute('CSOSN')]
		[MVCNameAsAttribute('csosn')]
		property Csosn: string read FCsosn write FCsosn;
    [MVCColumnAttribute('TOTALIZADOR_PARCIAL')]
		[MVCNameAsAttribute('totalizadorParcial')]
		property TotalizadorParcial: string read FTotalizadorParcial write FTotalizadorParcial;
    [MVCColumnAttribute('ECF_ICMS_ST')]
		[MVCNameAsAttribute('ecfIcmsSt')]
		property EcfIcmsSt: string read FEcfIcmsSt write FEcfIcmsSt;
    [MVCColumnAttribute('CODIGO_BALANCA')]
		[MVCNameAsAttribute('codigoBalanca')]
		property CodigoBalanca: Integer read FCodigoBalanca write FCodigoBalanca;
    [MVCColumnAttribute('PAF_P_ST')]
		[MVCNameAsAttribute('pafPSt')]
		property PafPSt: string read FPafPSt write FPafPSt;
    [MVCColumnAttribute('HASH_REGISTRO')]
		[MVCNameAsAttribute('hashRegistro')]
		property HashRegistro: string read FHashRegistro write FHashRegistro;
    [MVCColumnAttribute('VALOR_CUSTO')]
		[MVCNameAsAttribute('valorCusto')]
		property ValorCusto: Extended read FValorCusto write FValorCusto;
    [MVCColumnAttribute('SITUACAO')]
		[MVCNameAsAttribute('situacao')]
		property Situacao: string read FSituacao write FSituacao;
    [MVCColumnAttribute('CODIGO_CEST')]
		[MVCNameAsAttribute('codigoCest')]
		property CodigoCest: string read FCodigoCest write FCodigoCest;
      
  end;

implementation

{ TProduto }



end.