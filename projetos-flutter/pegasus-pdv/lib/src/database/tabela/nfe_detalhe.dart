/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_DETALHE] 
                                                                                
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
*******************************************************************************/
import 'package:moor/moor.dart';

import '../database.dart';

@DataClassName("NfeDetalhe")
class NfeDetalhes extends Table {
  @override
  String get tableName => 'NFE_DETALHE';

  IntColumn? get id => integer().named('ID').autoIncrement()();
  IntColumn? get idNfeCabecalho => integer().named('ID_NFE_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES NFE_CABECALHO(ID)')();
  IntColumn? get numeroItem => integer().named('NUMERO_ITEM').nullable()() as Column<int>?;
  TextColumn? get codigoProduto => text().named('CODIGO_PRODUTO').withLength(min: 0, max: 60).nullable()() as Column<String>?;
  TextColumn? get gtin => text().named('GTIN').withLength(min: 0, max: 14).nullable()() as Column<String>?;
  TextColumn? get nomeProduto => text().named('NOME_PRODUTO').withLength(min: 0, max: 120).nullable()() as Column<String>?;
  TextColumn? get ncm => text().named('NCM').withLength(min: 0, max: 8).nullable()() as Column<String>?;
  TextColumn? get nve => text().named('NVE').withLength(min: 0, max: 6).nullable()() as Column<String>?;
  TextColumn? get cest => text().named('CEST').withLength(min: 0, max: 7).nullable()() as Column<String>?;
  TextColumn? get indicadorEscalaRelevante => text().named('INDICADOR_ESCALA_RELEVANTE').withLength(min: 0, max: 1).nullable()() as Column<String>?;
  TextColumn? get cnpjFabricante => text().named('CNPJ_FABRICANTE').withLength(min: 0, max: 14).nullable()() as Column<String>?;
  TextColumn? get codigoBeneficioFiscal => text().named('CODIGO_BENEFICIO_FISCAL').withLength(min: 0, max: 10).nullable()() as Column<String>?;
  IntColumn? get exTipi => integer().named('EX_TIPI').nullable()() as Column<int>?;
  IntColumn? get cfop => integer().named('CFOP').nullable()() as Column<int>?;
  TextColumn? get unidadeComercial => text().named('UNIDADE_COMERCIAL').withLength(min: 0, max: 6).nullable()() as Column<String>?;
  RealColumn? get quantidadeComercial => real().named('QUANTIDADE_COMERCIAL').nullable()() as Column<double>?;
  TextColumn? get numeroPedidoCompra => text().named('NUMERO_PEDIDO_COMPRA').withLength(min: 0, max: 15).nullable()() as Column<String>?;
  IntColumn? get itemPedidoCompra => integer().named('ITEM_PEDIDO_COMPRA').nullable()() as Column<int>?;
  TextColumn? get numeroFci => text().named('NUMERO_FCI').withLength(min: 0, max: 36).nullable()() as Column<String>?;
  TextColumn? get numeroRecopi => text().named('NUMERO_RECOPI').withLength(min: 0, max: 20).nullable()() as Column<String>?;
  RealColumn? get valorUnitarioComercial => real().named('VALOR_UNITARIO_COMERCIAL').nullable()() as Column<double>?; // valor unitário do produto que está sendo vendido
  RealColumn? get valorBrutoProduto => real().named('VALOR_BRUTO_PRODUTO').nullable()() as Column<double>?; // quantidade * valor unitário
  TextColumn? get gtinUnidadeTributavel => text().named('GTIN_UNIDADE_TRIBUTAVEL').withLength(min: 0, max: 14).nullable()() as Column<String>?;
  TextColumn? get unidadeTributavel => text().named('UNIDADE_TRIBUTAVEL').withLength(min: 0, max: 6).nullable()() as Column<String>?;
  RealColumn? get quantidadeTributavel => real().named('QUANTIDADE_TRIBUTAVEL').nullable()() as Column<double>?;
  RealColumn? get valorUnitarioTributavel => real().named('VALOR_UNITARIO_TRIBUTAVEL').nullable()() as Column<double>?; // valor unitário do produto que está sendo vendido
  RealColumn? get valorFrete => real().named('VALOR_FRETE').nullable()() as Column<double>?;
  RealColumn? get valorSeguro => real().named('VALOR_SEGURO').nullable()() as Column<double>?;
  RealColumn? get valorDesconto => real().named('VALOR_DESCONTO').nullable()() as Column<double>?; // valor do desconto no item
  RealColumn? get valorOutrasDespesas => real().named('VALOR_OUTRAS_DESPESAS').nullable()() as Column<double>?;
  TextColumn? get entraTotal => text().named('ENTRA_TOTAL').withLength(min: 0, max: 1).nullable()() as Column<String>?;
  RealColumn? get valorTotalTributos => real().named('VALOR_TOTAL_TRIBUTOS').nullable()() as Column<double>?; // IBPT = estadual+municipal+federal para o item
  RealColumn? get percentualDevolvido => real().named('PERCENTUAL_DEVOLVIDO').nullable()() as Column<double>?;
  RealColumn? get valorIpiDevolvido => real().named('VALOR_IPI_DEVOLVIDO').nullable()() as Column<double>?;
  TextColumn? get informacoesAdicionais => text().named('INFORMACOES_ADICIONAIS').withLength(min: 0, max: 250).nullable()() as Column<String>?;
  RealColumn? get valorSubtotal => real().named('VALOR_SUBTOTAL').nullable()() as Column<double>?; // quantidade * valor unitário
  RealColumn? get valorTotal => real().named('VALOR_TOTAL').nullable()() as Column<double>?; // (quantidade * valor unitário) - valor do desconto
}

class NfeDetalheMontado {
  NfeDetalhe? nfeDetalhe;
  NfeDetalheImpostoIcms? nfeDetalheImpostoIcms;
  NfeDetalheImpostoPis? nfeDetalheImpostoPis;
  NfeDetalheImpostoCofins? nfeDetalheImpostoCofins;

  NfeDetalheMontado({
    this.nfeDetalhe,
    this.nfeDetalheImpostoIcms,
    this.nfeDetalheImpostoPis,
    this.nfeDetalheImpostoCofins,
  });
}