/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [PRODUTO] 
                                                                                
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

@DataClassName("Produto")
class Produtos extends Table {
  String get tableName => 'PRODUTO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idProdutoUnidade => integer().named('ID_PRODUTO_UNIDADE').nullable().customConstraint('NULLABLE REFERENCES PRODUTO_UNIDADE(ID)')();
  IntColumn get idTributGrupoTributario => integer().named('ID_TRIBUT_GRUPO_TRIBUTARIO').nullable().customConstraint('NULLABLE REFERENCES TRIBUT_GRUPO_TRIBUTARIO(ID)')();
  TextColumn get gtin => text().named('GTIN').withLength(min: 0, max: 14).nullable()();
  TextColumn get codigoInterno => text().named('CODIGO_INTERNO').withLength(min: 0, max: 50).nullable()();
  TextColumn get nome => text().named('NOME').withLength(min: 0, max: 100).nullable()();
  TextColumn get descricao => text().named('DESCRICAO').withLength(min: 0, max: 250).nullable()();
  TextColumn get descricaoPdv => text().named('DESCRICAO_PDV').withLength(min: 0, max: 30).nullable()();
  RealColumn get valorCompra => real().named('VALOR_COMPRA').nullable()();
  RealColumn get valorVenda => real().named('VALOR_VENDA').nullable()();
  RealColumn get quantidadeEstoque => real().named('QUANTIDADE_ESTOQUE').nullable()();
  RealColumn get estoqueMinimo => real().named('ESTOQUE_MINIMO').nullable()();
  RealColumn get estoqueMaximo => real().named('ESTOQUE_MAXIMO').nullable()();
  TextColumn get codigoNcm => text().named('CODIGO_NCM').withLength(min: 0, max: 8).nullable()();
  TextColumn get iat => text().named('IAT').withLength(min: 0, max: 1).nullable()();
  TextColumn get ippt => text().named('IPPT').withLength(min: 0, max: 1).nullable()();
  TextColumn get tipoItemSped => text().named('TIPO_ITEM_SPED').withLength(min: 0, max: 2).nullable()();
  RealColumn get taxaIpi => real().named('TAXA_IPI').nullable()();
  RealColumn get taxaIssqn => real().named('TAXA_ISSQN').nullable()();
  RealColumn get taxaPis => real().named('TAXA_PIS').nullable()();
  RealColumn get taxaCofins => real().named('TAXA_COFINS').nullable()();
  RealColumn get taxaIcms => real().named('TAXA_ICMS').nullable()();
  TextColumn get cst => text().named('CST').withLength(min: 0, max: 3).nullable()();
  TextColumn get csosn => text().named('CSOSN').withLength(min: 0, max: 4).nullable()();
  TextColumn get totalizadorParcial => text().named('TOTALIZADOR_PARCIAL').withLength(min: 0, max: 10).nullable()();
  TextColumn get ecfIcmsSt => text().named('ECF_ICMS_ST').withLength(min: 0, max: 4).nullable()();
  IntColumn get codigoBalanca => integer().named('CODIGO_BALANCA').nullable()();
  TextColumn get pafPSt => text().named('PAF_P_ST').withLength(min: 0, max: 1).nullable()();
  TextColumn get hashRegistro => text().named('HASH_REGISTRO').withLength(min: 0, max: 32).nullable()();
}

class ProdutoMontado {
  ProdutoUnidade produtoUnidade;
  Produto produto;
  TributGrupoTributario tributGrupoTributario;

  ProdutoMontado({
    this.produtoUnidade,
    this.produto,
    this.tributGrupoTributario,
  });
}