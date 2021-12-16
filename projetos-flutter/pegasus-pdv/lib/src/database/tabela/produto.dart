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

import '../database_classes.dart';

@DataClassName("Produto")
@UseRowClass(Produto)
class Produtos extends Table {
  @override
  String get tableName => 'PRODUTO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idProdutoUnidade => integer().named('ID_PRODUTO_UNIDADE').nullable().customConstraint('NULLABLE REFERENCES PRODUTO_UNIDADE(ID)')();
  IntColumn get idTributGrupoTributario => integer().named('ID_TRIBUT_GRUPO_TRIBUTARIO').nullable().customConstraint('NULLABLE REFERENCES TRIBUT_GRUPO_TRIBUTARIO(ID)')();
  IntColumn get idProdutoTipo => integer().named('ID_PRODUTO_TIPO').nullable().customConstraint('NULLABLE REFERENCES PRODUTO_TIPO(ID)')();
  IntColumn get idProdutoSubgrupo => integer().named('ID_PRODUTO_SUBGRUPO').nullable().customConstraint('NULLABLE REFERENCES PRODUTO_SUBGRUPO(ID)')();
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
  RealColumn get valorCusto => real().named('VALOR_CUSTO').nullable()();
  TextColumn get situacao => text().named('SITUACAO').withLength(min: 0, max: 1).nullable()();
  TextColumn get codigoCest => text().named('CODIGO_CEST').withLength(min: 0, max: 7).nullable()();
}

class ProdutoMontado {
  ProdutoUnidade? produtoUnidade;
  Produto? produto;
  TributGrupoTributario? tributGrupoTributario;
  ProdutoTipo? produtoTipo;
  ProdutoSubgrupo? produtoSubgrupo;
  Cardapio? cardapio;

  ProdutoMontado({
    this.produtoUnidade,
    this.produto,
    this.tributGrupoTributario,
    this.produtoTipo,
    this.produtoSubgrupo,
    this.cardapio,
  });
}

class Produto extends DataClass implements Insertable<Produto> {
  final int? id;
  final int? idProdutoUnidade;
  final int? idTributGrupoTributario;
  final int? idProdutoTipo;
  final int? idProdutoSubgrupo;
  final String? gtin;
  final String? codigoInterno;
  final String? nome;
  final String? descricao;
  final String? descricaoPdv;
  final double? valorCompra;
  final double? valorVenda;
  final double? quantidadeEstoque;
  final double? estoqueMinimo;
  final double? estoqueMaximo;
  final String? codigoNcm;
  final String? iat;
  final String? ippt;
  final String? tipoItemSped;
  final double? taxaIpi;
  final double? taxaIssqn;
  final double? taxaPis;
  final double? taxaCofins;
  final double? taxaIcms;
  final String? cst;
  final String? csosn;
  final String? totalizadorParcial;
  final String? ecfIcmsSt;
  final int? codigoBalanca;
  final String? pafPSt;
  final String? hashRegistro;
  final double? valorCusto;
  final String? situacao;
  final String? codigoCest;

  Produto(
    {
      required this.id,
      this.idProdutoUnidade,
      this.idTributGrupoTributario,
      this.idProdutoTipo,
      this.idProdutoSubgrupo,
      this.gtin,
      this.codigoInterno,
      this.nome,
      this.descricao,
      this.descricaoPdv,
      this.valorCompra,
      this.valorVenda,
      this.quantidadeEstoque,
      this.estoqueMinimo,
      this.estoqueMaximo,
      this.codigoNcm,
      this.iat,
      this.ippt,
      this.tipoItemSped,
      this.taxaIpi,
      this.taxaIssqn,
      this.taxaPis,
      this.taxaCofins,
      this.taxaIcms,
      this.cst,
      this.csosn,
      this.totalizadorParcial,
      this.ecfIcmsSt,
      this.codigoBalanca,
      this.pafPSt,
      this.hashRegistro,
      this.valorCusto,
      this.situacao,
      this.codigoCest,
    }
  );

  factory Produto.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Produto(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idProdutoUnidade: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PRODUTO_UNIDADE']),
      idTributGrupoTributario: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_TRIBUT_GRUPO_TRIBUTARIO']),
      idProdutoTipo: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PRODUTO_TIPO']),
      idProdutoSubgrupo: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PRODUTO_SUBGRUPO']),
      gtin: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}GTIN']),
      codigoInterno: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_INTERNO']),
      nome: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NOME']),
      descricao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DESCRICAO']),
      descricaoPdv: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DESCRICAO_PDV']),
      valorCompra: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_COMPRA']),
      valorVenda: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_VENDA']),
      quantidadeEstoque: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE_ESTOQUE']),
      estoqueMinimo: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ESTOQUE_MINIMO']),
      estoqueMaximo: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ESTOQUE_MAXIMO']),
      codigoNcm: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_NCM']),
      iat: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}IAT']),
      ippt: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}IPPT']),
      tipoItemSped: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TIPO_ITEM_SPED']),
      taxaIpi: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}TAXA_IPI']),
      taxaIssqn: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}TAXA_ISSQN']),
      taxaPis: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}TAXA_PIS']),
      taxaCofins: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}TAXA_COFINS']),
      taxaIcms: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}TAXA_ICMS']),
      cst: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CST']),
      csosn: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CSOSN']),
      totalizadorParcial: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TOTALIZADOR_PARCIAL']),
      ecfIcmsSt: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}ECF_ICMS_ST']),
      codigoBalanca: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_BALANCA']),
      pafPSt: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}PAF_P_ST']),
      hashRegistro: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}HASH_REGISTRO']),
      valorCusto: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_CUSTO']),
      situacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}SITUACAO']),
      codigoCest: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_CEST']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idProdutoUnidade != null) {
      map['ID_PRODUTO_UNIDADE'] = Variable<int?>(idProdutoUnidade);
    }
    if (!nullToAbsent || idTributGrupoTributario != null) {
      map['ID_TRIBUT_GRUPO_TRIBUTARIO'] = Variable<int?>(idTributGrupoTributario);
    }
    if (!nullToAbsent || idProdutoTipo != null) {
      map['ID_PRODUTO_TIPO'] = Variable<int?>(idProdutoTipo);
    }
    if (!nullToAbsent || idProdutoSubgrupo != null) {
      map['ID_PRODUTO_SUBGRUPO'] = Variable<int?>(idProdutoSubgrupo);
    }
    if (!nullToAbsent || gtin != null) {
      map['GTIN'] = Variable<String?>(gtin);
    }
    if (!nullToAbsent || codigoInterno != null) {
      map['CODIGO_INTERNO'] = Variable<String?>(codigoInterno);
    }
    if (!nullToAbsent || nome != null) {
      map['NOME'] = Variable<String?>(nome);
    }
    if (!nullToAbsent || descricao != null) {
      map['DESCRICAO'] = Variable<String?>(descricao);
    }
    if (!nullToAbsent || descricaoPdv != null) {
      map['DESCRICAO_PDV'] = Variable<String?>(descricaoPdv);
    }
    if (!nullToAbsent || valorCompra != null) {
      map['VALOR_COMPRA'] = Variable<double?>(valorCompra);
    }
    if (!nullToAbsent || valorVenda != null) {
      map['VALOR_VENDA'] = Variable<double?>(valorVenda);
    }
    if (!nullToAbsent || quantidadeEstoque != null) {
      map['QUANTIDADE_ESTOQUE'] = Variable<double?>(quantidadeEstoque);
    }
    if (!nullToAbsent || estoqueMinimo != null) {
      map['ESTOQUE_MINIMO'] = Variable<double?>(estoqueMinimo);
    }
    if (!nullToAbsent || estoqueMaximo != null) {
      map['ESTOQUE_MAXIMO'] = Variable<double?>(estoqueMaximo);
    }
    if (!nullToAbsent || codigoNcm != null) {
      map['CODIGO_NCM'] = Variable<String?>(codigoNcm);
    }
    if (!nullToAbsent || iat != null) {
      map['IAT'] = Variable<String?>(iat);
    }
    if (!nullToAbsent || ippt != null) {
      map['IPPT'] = Variable<String?>(ippt);
    }
    if (!nullToAbsent || tipoItemSped != null) {
      map['TIPO_ITEM_SPED'] = Variable<String?>(tipoItemSped);
    }
    if (!nullToAbsent || taxaIpi != null) {
      map['TAXA_IPI'] = Variable<double?>(taxaIpi);
    }
    if (!nullToAbsent || taxaIssqn != null) {
      map['TAXA_ISSQN'] = Variable<double?>(taxaIssqn);
    }
    if (!nullToAbsent || taxaPis != null) {
      map['TAXA_PIS'] = Variable<double?>(taxaPis);
    }
    if (!nullToAbsent || taxaCofins != null) {
      map['TAXA_COFINS'] = Variable<double?>(taxaCofins);
    }
    if (!nullToAbsent || taxaIcms != null) {
      map['TAXA_ICMS'] = Variable<double?>(taxaIcms);
    }
    if (!nullToAbsent || cst != null) {
      map['CST'] = Variable<String?>(cst);
    }
    if (!nullToAbsent || csosn != null) {
      map['CSOSN'] = Variable<String?>(csosn);
    }
    if (!nullToAbsent || totalizadorParcial != null) {
      map['TOTALIZADOR_PARCIAL'] = Variable<String?>(totalizadorParcial);
    }
    if (!nullToAbsent || ecfIcmsSt != null) {
      map['ECF_ICMS_ST'] = Variable<String?>(ecfIcmsSt);
    }
    if (!nullToAbsent || codigoBalanca != null) {
      map['CODIGO_BALANCA'] = Variable<int?>(codigoBalanca);
    }
    if (!nullToAbsent || pafPSt != null) {
      map['PAF_P_ST'] = Variable<String?>(pafPSt);
    }
    if (!nullToAbsent || hashRegistro != null) {
      map['HASH_REGISTRO'] = Variable<String?>(hashRegistro);
    }
    if (!nullToAbsent || valorCusto != null) {
      map['VALOR_CUSTO'] = Variable<double?>(valorCusto);
    }
    if (!nullToAbsent || situacao != null) {
      map['SITUACAO'] = Variable<String?>(situacao);
    }
    if (!nullToAbsent || codigoCest != null) {
      map['CODIGO_CEST'] = Variable<String?>(codigoCest);
    }
    return map;
  }

  ProdutosCompanion toCompanion(bool nullToAbsent) {
    return ProdutosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idProdutoUnidade: idProdutoUnidade == null && nullToAbsent
        ? const Value.absent()
        : Value(idProdutoUnidade),
      idTributGrupoTributario: idTributGrupoTributario == null && nullToAbsent
        ? const Value.absent()
        : Value(idTributGrupoTributario),
      idProdutoTipo: idProdutoTipo == null && nullToAbsent
        ? const Value.absent()
        : Value(idProdutoTipo),
      idProdutoSubgrupo: idProdutoSubgrupo == null && nullToAbsent
        ? const Value.absent()
        : Value(idProdutoSubgrupo),
      gtin: gtin == null && nullToAbsent
        ? const Value.absent()
        : Value(gtin),
      codigoInterno: codigoInterno == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoInterno),
      nome: nome == null && nullToAbsent
        ? const Value.absent()
        : Value(nome),
      descricao: descricao == null && nullToAbsent
        ? const Value.absent()
        : Value(descricao),
      descricaoPdv: descricaoPdv == null && nullToAbsent
        ? const Value.absent()
        : Value(descricaoPdv),
      valorCompra: valorCompra == null && nullToAbsent
        ? const Value.absent()
        : Value(valorCompra),
      valorVenda: valorVenda == null && nullToAbsent
        ? const Value.absent()
        : Value(valorVenda),
      quantidadeEstoque: quantidadeEstoque == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidadeEstoque),
      estoqueMinimo: estoqueMinimo == null && nullToAbsent
        ? const Value.absent()
        : Value(estoqueMinimo),
      estoqueMaximo: estoqueMaximo == null && nullToAbsent
        ? const Value.absent()
        : Value(estoqueMaximo),
      codigoNcm: codigoNcm == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoNcm),
      iat: iat == null && nullToAbsent
        ? const Value.absent()
        : Value(iat),
      ippt: ippt == null && nullToAbsent
        ? const Value.absent()
        : Value(ippt),
      tipoItemSped: tipoItemSped == null && nullToAbsent
        ? const Value.absent()
        : Value(tipoItemSped),
      taxaIpi: taxaIpi == null && nullToAbsent
        ? const Value.absent()
        : Value(taxaIpi),
      taxaIssqn: taxaIssqn == null && nullToAbsent
        ? const Value.absent()
        : Value(taxaIssqn),
      taxaPis: taxaPis == null && nullToAbsent
        ? const Value.absent()
        : Value(taxaPis),
      taxaCofins: taxaCofins == null && nullToAbsent
        ? const Value.absent()
        : Value(taxaCofins),
      taxaIcms: taxaIcms == null && nullToAbsent
        ? const Value.absent()
        : Value(taxaIcms),
      cst: cst == null && nullToAbsent
        ? const Value.absent()
        : Value(cst),
      csosn: csosn == null && nullToAbsent
        ? const Value.absent()
        : Value(csosn),
      totalizadorParcial: totalizadorParcial == null && nullToAbsent
        ? const Value.absent()
        : Value(totalizadorParcial),
      ecfIcmsSt: ecfIcmsSt == null && nullToAbsent
        ? const Value.absent()
        : Value(ecfIcmsSt),
      codigoBalanca: codigoBalanca == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoBalanca),
      pafPSt: pafPSt == null && nullToAbsent
        ? const Value.absent()
        : Value(pafPSt),
      hashRegistro: hashRegistro == null && nullToAbsent
        ? const Value.absent()
        : Value(hashRegistro),
      valorCusto: valorCusto == null && nullToAbsent
        ? const Value.absent()
        : Value(valorCusto),
      situacao: situacao == null && nullToAbsent
        ? const Value.absent()
        : Value(situacao),
      codigoCest: codigoCest == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoCest),
    );
  }

  factory Produto.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Produto(
      id: serializer.fromJson<int>(json['id']),
      idProdutoUnidade: serializer.fromJson<int>(json['idProdutoUnidade']),
      idTributGrupoTributario: serializer.fromJson<int>(json['idTributGrupoTributario']),
      idProdutoTipo: serializer.fromJson<int>(json['idProdutoTipo']),
      idProdutoSubgrupo: serializer.fromJson<int>(json['idProdutoSubgrupo']),
      gtin: serializer.fromJson<String>(json['gtin']),
      codigoInterno: serializer.fromJson<String>(json['codigoInterno']),
      nome: serializer.fromJson<String>(json['nome']),
      descricao: serializer.fromJson<String>(json['descricao']),
      descricaoPdv: serializer.fromJson<String>(json['descricaoPdv']),
      valorCompra: serializer.fromJson<double>(json['valorCompra']),
      valorVenda: serializer.fromJson<double>(json['valorVenda']),
      quantidadeEstoque: serializer.fromJson<double>(json['quantidadeEstoque']),
      estoqueMinimo: serializer.fromJson<double>(json['estoqueMinimo']),
      estoqueMaximo: serializer.fromJson<double>(json['estoqueMaximo']),
      codigoNcm: serializer.fromJson<String>(json['codigoNcm']),
      iat: serializer.fromJson<String>(json['iat']),
      ippt: serializer.fromJson<String>(json['ippt']),
      tipoItemSped: serializer.fromJson<String>(json['tipoItemSped']),
      taxaIpi: serializer.fromJson<double>(json['taxaIpi']),
      taxaIssqn: serializer.fromJson<double>(json['taxaIssqn']),
      taxaPis: serializer.fromJson<double>(json['taxaPis']),
      taxaCofins: serializer.fromJson<double>(json['taxaCofins']),
      taxaIcms: serializer.fromJson<double>(json['taxaIcms']),
      cst: serializer.fromJson<String>(json['cst']),
      csosn: serializer.fromJson<String>(json['csosn']),
      totalizadorParcial: serializer.fromJson<String>(json['totalizadorParcial']),
      ecfIcmsSt: serializer.fromJson<String>(json['ecfIcmsSt']),
      codigoBalanca: serializer.fromJson<int>(json['codigoBalanca']),
      pafPSt: serializer.fromJson<String>(json['pafPSt']),
      hashRegistro: serializer.fromJson<String>(json['hashRegistro']),
      valorCusto: serializer.fromJson<double>(json['valorCusto']),
      situacao: serializer.fromJson<String>(json['situacao']),
      codigoCest: serializer.fromJson<String>(json['codigoCest']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idProdutoUnidade': serializer.toJson<int?>(idProdutoUnidade),
      'idTributGrupoTributario': serializer.toJson<int?>(idTributGrupoTributario),
      'idProdutoTipo': serializer.toJson<int?>(idProdutoTipo),
      'idProdutoSubgrupo': serializer.toJson<int?>(idProdutoSubgrupo),
      'gtin': serializer.toJson<String?>(gtin),
      'codigoInterno': serializer.toJson<String?>(codigoInterno),
      'nome': serializer.toJson<String?>(nome),
      'descricao': serializer.toJson<String?>(descricao),
      'descricaoPdv': serializer.toJson<String?>(descricaoPdv),
      'valorCompra': serializer.toJson<double?>(valorCompra),
      'valorVenda': serializer.toJson<double?>(valorVenda),
      'quantidadeEstoque': serializer.toJson<double?>(quantidadeEstoque),
      'estoqueMinimo': serializer.toJson<double?>(estoqueMinimo),
      'estoqueMaximo': serializer.toJson<double?>(estoqueMaximo),
      'codigoNcm': serializer.toJson<String?>(codigoNcm),
      'iat': serializer.toJson<String?>(iat),
      'ippt': serializer.toJson<String?>(ippt),
      'tipoItemSped': serializer.toJson<String?>(tipoItemSped),
      'taxaIpi': serializer.toJson<double?>(taxaIpi),
      'taxaIssqn': serializer.toJson<double?>(taxaIssqn),
      'taxaPis': serializer.toJson<double?>(taxaPis),
      'taxaCofins': serializer.toJson<double?>(taxaCofins),
      'taxaIcms': serializer.toJson<double?>(taxaIcms),
      'cst': serializer.toJson<String?>(cst),
      'csosn': serializer.toJson<String?>(csosn),
      'totalizadorParcial': serializer.toJson<String?>(totalizadorParcial),
      'ecfIcmsSt': serializer.toJson<String?>(ecfIcmsSt),
      'codigoBalanca': serializer.toJson<int?>(codigoBalanca),
      'pafPSt': serializer.toJson<String?>(pafPSt),
      'hashRegistro': serializer.toJson<String?>(hashRegistro),
      'valorCusto': serializer.toJson<double?>(valorCusto),
      'situacao': serializer.toJson<String?>(situacao),
      'codigoCest': serializer.toJson<String?>(codigoCest),
    };
  }

  Produto copyWith(
        {
		  int? id,
          int? idProdutoUnidade,
          int? idTributGrupoTributario,
          int? idProdutoTipo,
          int? idProdutoSubgrupo,
          String? gtin,
          String? codigoInterno,
          String? nome,
          String? descricao,
          String? descricaoPdv,
          double? valorCompra,
          double? valorVenda,
          double? quantidadeEstoque,
          double? estoqueMinimo,
          double? estoqueMaximo,
          String? codigoNcm,
          String? iat,
          String? ippt,
          String? tipoItemSped,
          double? taxaIpi,
          double? taxaIssqn,
          double? taxaPis,
          double? taxaCofins,
          double? taxaIcms,
          String? cst,
          String? csosn,
          String? totalizadorParcial,
          String? ecfIcmsSt,
          int? codigoBalanca,
          String? pafPSt,
          String? hashRegistro,
          double? valorCusto,
          String? situacao,
          String? codigoCest,
		}) =>
      Produto(
        id: id ?? this.id,
        idProdutoUnidade: idProdutoUnidade ?? this.idProdutoUnidade,
        idTributGrupoTributario: idTributGrupoTributario ?? this.idTributGrupoTributario,
        idProdutoTipo: idProdutoTipo ?? this.idProdutoTipo,
        idProdutoSubgrupo: idProdutoSubgrupo ?? this.idProdutoSubgrupo,
        gtin: gtin ?? this.gtin,
        codigoInterno: codigoInterno ?? this.codigoInterno,
        nome: nome ?? this.nome,
        descricao: descricao ?? this.descricao,
        descricaoPdv: descricaoPdv ?? this.descricaoPdv,
        valorCompra: valorCompra ?? this.valorCompra,
        valorVenda: valorVenda ?? this.valorVenda,
        quantidadeEstoque: quantidadeEstoque ?? this.quantidadeEstoque,
        estoqueMinimo: estoqueMinimo ?? this.estoqueMinimo,
        estoqueMaximo: estoqueMaximo ?? this.estoqueMaximo,
        codigoNcm: codigoNcm ?? this.codigoNcm,
        iat: iat ?? this.iat,
        ippt: ippt ?? this.ippt,
        tipoItemSped: tipoItemSped ?? this.tipoItemSped,
        taxaIpi: taxaIpi ?? this.taxaIpi,
        taxaIssqn: taxaIssqn ?? this.taxaIssqn,
        taxaPis: taxaPis ?? this.taxaPis,
        taxaCofins: taxaCofins ?? this.taxaCofins,
        taxaIcms: taxaIcms ?? this.taxaIcms,
        cst: cst ?? this.cst,
        csosn: csosn ?? this.csosn,
        totalizadorParcial: totalizadorParcial ?? this.totalizadorParcial,
        ecfIcmsSt: ecfIcmsSt ?? this.ecfIcmsSt,
        codigoBalanca: codigoBalanca ?? this.codigoBalanca,
        pafPSt: pafPSt ?? this.pafPSt,
        hashRegistro: hashRegistro ?? this.hashRegistro,
        valorCusto: valorCusto ?? this.valorCusto,
        situacao: situacao ?? this.situacao,
        codigoCest: codigoCest ?? this.codigoCest,
      );
  
  @override
  String toString() {
    return (StringBuffer('Produto(')
          ..write('id: $id, ')
          ..write('idProdutoUnidade: $idProdutoUnidade, ')
          ..write('idTributGrupoTributario: $idTributGrupoTributario, ')
          ..write('idProdutoTipo: $idProdutoTipo, ')
          ..write('idProdutoSubgrupo: $idProdutoSubgrupo, ')
          ..write('gtin: $gtin, ')
          ..write('codigoInterno: $codigoInterno, ')
          ..write('nome: $nome, ')
          ..write('descricao: $descricao, ')
          ..write('descricaoPdv: $descricaoPdv, ')
          ..write('valorCompra: $valorCompra, ')
          ..write('valorVenda: $valorVenda, ')
          ..write('quantidadeEstoque: $quantidadeEstoque, ')
          ..write('estoqueMinimo: $estoqueMinimo, ')
          ..write('estoqueMaximo: $estoqueMaximo, ')
          ..write('codigoNcm: $codigoNcm, ')
          ..write('iat: $iat, ')
          ..write('ippt: $ippt, ')
          ..write('tipoItemSped: $tipoItemSped, ')
          ..write('taxaIpi: $taxaIpi, ')
          ..write('taxaIssqn: $taxaIssqn, ')
          ..write('taxaPis: $taxaPis, ')
          ..write('taxaCofins: $taxaCofins, ')
          ..write('taxaIcms: $taxaIcms, ')
          ..write('cst: $cst, ')
          ..write('csosn: $csosn, ')
          ..write('totalizadorParcial: $totalizadorParcial, ')
          ..write('ecfIcmsSt: $ecfIcmsSt, ')
          ..write('codigoBalanca: $codigoBalanca, ')
          ..write('pafPSt: $pafPSt, ')
          ..write('hashRegistro: $hashRegistro, ')
          ..write('valorCusto: $valorCusto, ')
          ..write('situacao: $situacao, ')
          ..write('codigoCest: $codigoCest, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idProdutoUnidade,
      idTributGrupoTributario,
      idProdutoTipo,
      idProdutoSubgrupo,
      gtin,
      codigoInterno,
      nome,
      descricao,
      descricaoPdv,
      valorCompra,
      valorVenda,
      quantidadeEstoque,
      estoqueMinimo,
      estoqueMaximo,
      codigoNcm,
      iat,
      ippt,
      tipoItemSped,
      taxaIpi,
      taxaIssqn,
      taxaPis,
      taxaCofins,
      taxaIcms,
      cst,
      csosn,
      totalizadorParcial,
      ecfIcmsSt,
      codigoBalanca,
      pafPSt,
      hashRegistro,
      valorCusto,
      situacao,
      codigoCest,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Produto &&
          other.id == id &&
          other.idProdutoUnidade == idProdutoUnidade &&
          other.idTributGrupoTributario == idTributGrupoTributario &&
          other.idProdutoTipo == idProdutoTipo &&
          other.idProdutoSubgrupo == idProdutoSubgrupo &&
          other.gtin == gtin &&
          other.codigoInterno == codigoInterno &&
          other.nome == nome &&
          other.descricao == descricao &&
          other.descricaoPdv == descricaoPdv &&
          other.valorCompra == valorCompra &&
          other.valorVenda == valorVenda &&
          other.quantidadeEstoque == quantidadeEstoque &&
          other.estoqueMinimo == estoqueMinimo &&
          other.estoqueMaximo == estoqueMaximo &&
          other.codigoNcm == codigoNcm &&
          other.iat == iat &&
          other.ippt == ippt &&
          other.tipoItemSped == tipoItemSped &&
          other.taxaIpi == taxaIpi &&
          other.taxaIssqn == taxaIssqn &&
          other.taxaPis == taxaPis &&
          other.taxaCofins == taxaCofins &&
          other.taxaIcms == taxaIcms &&
          other.cst == cst &&
          other.csosn == csosn &&
          other.totalizadorParcial == totalizadorParcial &&
          other.ecfIcmsSt == ecfIcmsSt &&
          other.codigoBalanca == codigoBalanca &&
          other.pafPSt == pafPSt &&
          other.hashRegistro == hashRegistro &&
          other.valorCusto == valorCusto &&
          other.situacao == situacao &&
          other.codigoCest == codigoCest 
	   );
}

class ProdutosCompanion extends UpdateCompanion<Produto> {

  final Value<int?> id;
  final Value<int?> idProdutoUnidade;
  final Value<int?> idTributGrupoTributario;
  final Value<int?> idProdutoTipo;
  final Value<int?> idProdutoSubgrupo;
  final Value<String?> gtin;
  final Value<String?> codigoInterno;
  final Value<String?> nome;
  final Value<String?> descricao;
  final Value<String?> descricaoPdv;
  final Value<double?> valorCompra;
  final Value<double?> valorVenda;
  final Value<double?> quantidadeEstoque;
  final Value<double?> estoqueMinimo;
  final Value<double?> estoqueMaximo;
  final Value<String?> codigoNcm;
  final Value<String?> iat;
  final Value<String?> ippt;
  final Value<String?> tipoItemSped;
  final Value<double?> taxaIpi;
  final Value<double?> taxaIssqn;
  final Value<double?> taxaPis;
  final Value<double?> taxaCofins;
  final Value<double?> taxaIcms;
  final Value<String?> cst;
  final Value<String?> csosn;
  final Value<String?> totalizadorParcial;
  final Value<String?> ecfIcmsSt;
  final Value<int?> codigoBalanca;
  final Value<String?> pafPSt;
  final Value<String?> hashRegistro;
  final Value<double?> valorCusto;
  final Value<String?> situacao;
  final Value<String?> codigoCest;

  const ProdutosCompanion({
    this.id = const Value.absent(),
    this.idProdutoUnidade = const Value.absent(),
    this.idTributGrupoTributario = const Value.absent(),
    this.idProdutoTipo = const Value.absent(),
    this.idProdutoSubgrupo = const Value.absent(),
    this.gtin = const Value.absent(),
    this.codigoInterno = const Value.absent(),
    this.nome = const Value.absent(),
    this.descricao = const Value.absent(),
    this.descricaoPdv = const Value.absent(),
    this.valorCompra = const Value.absent(),
    this.valorVenda = const Value.absent(),
    this.quantidadeEstoque = const Value.absent(),
    this.estoqueMinimo = const Value.absent(),
    this.estoqueMaximo = const Value.absent(),
    this.codigoNcm = const Value.absent(),
    this.iat = const Value.absent(),
    this.ippt = const Value.absent(),
    this.tipoItemSped = const Value.absent(),
    this.taxaIpi = const Value.absent(),
    this.taxaIssqn = const Value.absent(),
    this.taxaPis = const Value.absent(),
    this.taxaCofins = const Value.absent(),
    this.taxaIcms = const Value.absent(),
    this.cst = const Value.absent(),
    this.csosn = const Value.absent(),
    this.totalizadorParcial = const Value.absent(),
    this.ecfIcmsSt = const Value.absent(),
    this.codigoBalanca = const Value.absent(),
    this.pafPSt = const Value.absent(),
    this.hashRegistro = const Value.absent(),
    this.valorCusto = const Value.absent(),
    this.situacao = const Value.absent(),
    this.codigoCest = const Value.absent(),
  });

  ProdutosCompanion.insert({
    this.id = const Value.absent(),
    this.idProdutoUnidade = const Value.absent(),
    this.idTributGrupoTributario = const Value.absent(),
    this.idProdutoTipo = const Value.absent(),
    this.idProdutoSubgrupo = const Value.absent(),
    this.gtin = const Value.absent(),
    this.codigoInterno = const Value.absent(),
    this.nome = const Value.absent(),
    this.descricao = const Value.absent(),
    this.descricaoPdv = const Value.absent(),
    this.valorCompra = const Value.absent(),
    this.valorVenda = const Value.absent(),
    this.quantidadeEstoque = const Value.absent(),
    this.estoqueMinimo = const Value.absent(),
    this.estoqueMaximo = const Value.absent(),
    this.codigoNcm = const Value.absent(),
    this.iat = const Value.absent(),
    this.ippt = const Value.absent(),
    this.tipoItemSped = const Value.absent(),
    this.taxaIpi = const Value.absent(),
    this.taxaIssqn = const Value.absent(),
    this.taxaPis = const Value.absent(),
    this.taxaCofins = const Value.absent(),
    this.taxaIcms = const Value.absent(),
    this.cst = const Value.absent(),
    this.csosn = const Value.absent(),
    this.totalizadorParcial = const Value.absent(),
    this.ecfIcmsSt = const Value.absent(),
    this.codigoBalanca = const Value.absent(),
    this.pafPSt = const Value.absent(),
    this.hashRegistro = const Value.absent(),
    this.valorCusto = const Value.absent(),
    this.situacao = const Value.absent(),
    this.codigoCest = const Value.absent(),
  });

  static Insertable<Produto> custom({
    Expression<int>? id,
    Expression<int>? idProdutoUnidade,
    Expression<int>? idTributGrupoTributario,
    Expression<int>? idProdutoTipo,
    Expression<int>? idProdutoSubgrupo,
    Expression<String>? gtin,
    Expression<String>? codigoInterno,
    Expression<String>? nome,
    Expression<String>? descricao,
    Expression<String>? descricaoPdv,
    Expression<double>? valorCompra,
    Expression<double>? valorVenda,
    Expression<double>? quantidadeEstoque,
    Expression<double>? estoqueMinimo,
    Expression<double>? estoqueMaximo,
    Expression<String>? codigoNcm,
    Expression<String>? iat,
    Expression<String>? ippt,
    Expression<String>? tipoItemSped,
    Expression<double>? taxaIpi,
    Expression<double>? taxaIssqn,
    Expression<double>? taxaPis,
    Expression<double>? taxaCofins,
    Expression<double>? taxaIcms,
    Expression<String>? cst,
    Expression<String>? csosn,
    Expression<String>? totalizadorParcial,
    Expression<String>? ecfIcmsSt,
    Expression<int>? codigoBalanca,
    Expression<String>? pafPSt,
    Expression<String>? hashRegistro,
    Expression<double>? valorCusto,
    Expression<String>? situacao,
    Expression<String>? codigoCest,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idProdutoUnidade != null) 'ID_PRODUTO_UNIDADE': idProdutoUnidade,
      if (idTributGrupoTributario != null) 'ID_TRIBUT_GRUPO_TRIBUTARIO': idTributGrupoTributario,
      if (idProdutoTipo != null) 'ID_PRODUTO_TIPO': idProdutoTipo,
      if (idProdutoSubgrupo != null) 'ID_PRODUTO_SUBGRUPO': idProdutoSubgrupo,
      if (gtin != null) 'GTIN': gtin,
      if (codigoInterno != null) 'CODIGO_INTERNO': codigoInterno,
      if (nome != null) 'NOME': nome,
      if (descricao != null) 'DESCRICAO': descricao,
      if (descricaoPdv != null) 'DESCRICAO_PDV': descricaoPdv,
      if (valorCompra != null) 'VALOR_COMPRA': valorCompra,
      if (valorVenda != null) 'VALOR_VENDA': valorVenda,
      if (quantidadeEstoque != null) 'QUANTIDADE_ESTOQUE': quantidadeEstoque,
      if (estoqueMinimo != null) 'ESTOQUE_MINIMO': estoqueMinimo,
      if (estoqueMaximo != null) 'ESTOQUE_MAXIMO': estoqueMaximo,
      if (codigoNcm != null) 'CODIGO_NCM': codigoNcm,
      if (iat != null) 'IAT': iat,
      if (ippt != null) 'IPPT': ippt,
      if (tipoItemSped != null) 'TIPO_ITEM_SPED': tipoItemSped,
      if (taxaIpi != null) 'TAXA_IPI': taxaIpi,
      if (taxaIssqn != null) 'TAXA_ISSQN': taxaIssqn,
      if (taxaPis != null) 'TAXA_PIS': taxaPis,
      if (taxaCofins != null) 'TAXA_COFINS': taxaCofins,
      if (taxaIcms != null) 'TAXA_ICMS': taxaIcms,
      if (cst != null) 'CST': cst,
      if (csosn != null) 'CSOSN': csosn,
      if (totalizadorParcial != null) 'TOTALIZADOR_PARCIAL': totalizadorParcial,
      if (ecfIcmsSt != null) 'ECF_ICMS_ST': ecfIcmsSt,
      if (codigoBalanca != null) 'CODIGO_BALANCA': codigoBalanca,
      if (pafPSt != null) 'PAF_P_ST': pafPSt,
      if (hashRegistro != null) 'HASH_REGISTRO': hashRegistro,
      if (valorCusto != null) 'VALOR_CUSTO': valorCusto,
      if (situacao != null) 'SITUACAO': situacao,
      if (codigoCest != null) 'CODIGO_CEST': codigoCest,
    });
  }

  ProdutosCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idProdutoUnidade,
      Value<int>? idTributGrupoTributario,
      Value<int>? idProdutoTipo,
      Value<int>? idProdutoSubgrupo,
      Value<String>? gtin,
      Value<String>? codigoInterno,
      Value<String>? nome,
      Value<String>? descricao,
      Value<String>? descricaoPdv,
      Value<double>? valorCompra,
      Value<double>? valorVenda,
      Value<double>? quantidadeEstoque,
      Value<double>? estoqueMinimo,
      Value<double>? estoqueMaximo,
      Value<String>? codigoNcm,
      Value<String>? iat,
      Value<String>? ippt,
      Value<String>? tipoItemSped,
      Value<double>? taxaIpi,
      Value<double>? taxaIssqn,
      Value<double>? taxaPis,
      Value<double>? taxaCofins,
      Value<double>? taxaIcms,
      Value<String>? cst,
      Value<String>? csosn,
      Value<String>? totalizadorParcial,
      Value<String>? ecfIcmsSt,
      Value<int>? codigoBalanca,
      Value<String>? pafPSt,
      Value<String>? hashRegistro,
      Value<double>? valorCusto,
      Value<String>? situacao,
      Value<String>? codigoCest,
	  }) {
    return ProdutosCompanion(
      id: id ?? this.id,
      idProdutoUnidade: idProdutoUnidade ?? this.idProdutoUnidade,
      idTributGrupoTributario: idTributGrupoTributario ?? this.idTributGrupoTributario,
      idProdutoTipo: idProdutoTipo ?? this.idProdutoTipo,
      idProdutoSubgrupo: idProdutoSubgrupo ?? this.idProdutoSubgrupo,
      gtin: gtin ?? this.gtin,
      codigoInterno: codigoInterno ?? this.codigoInterno,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      descricaoPdv: descricaoPdv ?? this.descricaoPdv,
      valorCompra: valorCompra ?? this.valorCompra,
      valorVenda: valorVenda ?? this.valorVenda,
      quantidadeEstoque: quantidadeEstoque ?? this.quantidadeEstoque,
      estoqueMinimo: estoqueMinimo ?? this.estoqueMinimo,
      estoqueMaximo: estoqueMaximo ?? this.estoqueMaximo,
      codigoNcm: codigoNcm ?? this.codigoNcm,
      iat: iat ?? this.iat,
      ippt: ippt ?? this.ippt,
      tipoItemSped: tipoItemSped ?? this.tipoItemSped,
      taxaIpi: taxaIpi ?? this.taxaIpi,
      taxaIssqn: taxaIssqn ?? this.taxaIssqn,
      taxaPis: taxaPis ?? this.taxaPis,
      taxaCofins: taxaCofins ?? this.taxaCofins,
      taxaIcms: taxaIcms ?? this.taxaIcms,
      cst: cst ?? this.cst,
      csosn: csosn ?? this.csosn,
      totalizadorParcial: totalizadorParcial ?? this.totalizadorParcial,
      ecfIcmsSt: ecfIcmsSt ?? this.ecfIcmsSt,
      codigoBalanca: codigoBalanca ?? this.codigoBalanca,
      pafPSt: pafPSt ?? this.pafPSt,
      hashRegistro: hashRegistro ?? this.hashRegistro,
      valorCusto: valorCusto ?? this.valorCusto,
      situacao: situacao ?? this.situacao,
      codigoCest: codigoCest ?? this.codigoCest,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idProdutoUnidade.present) {
      map['ID_PRODUTO_UNIDADE'] = Variable<int?>(idProdutoUnidade.value);
    }
    if (idTributGrupoTributario.present) {
      map['ID_TRIBUT_GRUPO_TRIBUTARIO'] = Variable<int?>(idTributGrupoTributario.value);
    }
    if (idProdutoTipo.present) {
      map['ID_PRODUTO_TIPO'] = Variable<int?>(idProdutoTipo.value);
    }
    if (idProdutoSubgrupo.present) {
      map['ID_PRODUTO_SUBGRUPO'] = Variable<int?>(idProdutoSubgrupo.value);
    }
    if (gtin.present) {
      map['GTIN'] = Variable<String?>(gtin.value);
    }
    if (codigoInterno.present) {
      map['CODIGO_INTERNO'] = Variable<String?>(codigoInterno.value);
    }
    if (nome.present) {
      map['NOME'] = Variable<String?>(nome.value);
    }
    if (descricao.present) {
      map['DESCRICAO'] = Variable<String?>(descricao.value);
    }
    if (descricaoPdv.present) {
      map['DESCRICAO_PDV'] = Variable<String?>(descricaoPdv.value);
    }
    if (valorCompra.present) {
      map['VALOR_COMPRA'] = Variable<double?>(valorCompra.value);
    }
    if (valorVenda.present) {
      map['VALOR_VENDA'] = Variable<double?>(valorVenda.value);
    }
    if (quantidadeEstoque.present) {
      map['QUANTIDADE_ESTOQUE'] = Variable<double?>(quantidadeEstoque.value);
    }
    if (estoqueMinimo.present) {
      map['ESTOQUE_MINIMO'] = Variable<double?>(estoqueMinimo.value);
    }
    if (estoqueMaximo.present) {
      map['ESTOQUE_MAXIMO'] = Variable<double?>(estoqueMaximo.value);
    }
    if (codigoNcm.present) {
      map['CODIGO_NCM'] = Variable<String?>(codigoNcm.value);
    }
    if (iat.present) {
      map['IAT'] = Variable<String?>(iat.value);
    }
    if (ippt.present) {
      map['IPPT'] = Variable<String?>(ippt.value);
    }
    if (tipoItemSped.present) {
      map['TIPO_ITEM_SPED'] = Variable<String?>(tipoItemSped.value);
    }
    if (taxaIpi.present) {
      map['TAXA_IPI'] = Variable<double?>(taxaIpi.value);
    }
    if (taxaIssqn.present) {
      map['TAXA_ISSQN'] = Variable<double?>(taxaIssqn.value);
    }
    if (taxaPis.present) {
      map['TAXA_PIS'] = Variable<double?>(taxaPis.value);
    }
    if (taxaCofins.present) {
      map['TAXA_COFINS'] = Variable<double?>(taxaCofins.value);
    }
    if (taxaIcms.present) {
      map['TAXA_ICMS'] = Variable<double?>(taxaIcms.value);
    }
    if (cst.present) {
      map['CST'] = Variable<String?>(cst.value);
    }
    if (csosn.present) {
      map['CSOSN'] = Variable<String?>(csosn.value);
    }
    if (totalizadorParcial.present) {
      map['TOTALIZADOR_PARCIAL'] = Variable<String?>(totalizadorParcial.value);
    }
    if (ecfIcmsSt.present) {
      map['ECF_ICMS_ST'] = Variable<String?>(ecfIcmsSt.value);
    }
    if (codigoBalanca.present) {
      map['CODIGO_BALANCA'] = Variable<int?>(codigoBalanca.value);
    }
    if (pafPSt.present) {
      map['PAF_P_ST'] = Variable<String?>(pafPSt.value);
    }
    if (hashRegistro.present) {
      map['HASH_REGISTRO'] = Variable<String?>(hashRegistro.value);
    }
    if (valorCusto.present) {
      map['VALOR_CUSTO'] = Variable<double?>(valorCusto.value);
    }
    if (situacao.present) {
      map['SITUACAO'] = Variable<String?>(situacao.value);
    }
    if (codigoCest.present) {
      map['CODIGO_CEST'] = Variable<String?>(codigoCest.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProdutosCompanion(')
          ..write('id: $id, ')
          ..write('idProdutoUnidade: $idProdutoUnidade, ')
          ..write('idTributGrupoTributario: $idTributGrupoTributario, ')
          ..write('idProdutoTipo: $idProdutoTipo, ')
          ..write('idProdutoSubgrupo: $idProdutoSubgrupo, ')
          ..write('gtin: $gtin, ')
          ..write('codigoInterno: $codigoInterno, ')
          ..write('nome: $nome, ')
          ..write('descricao: $descricao, ')
          ..write('descricaoPdv: $descricaoPdv, ')
          ..write('valorCompra: $valorCompra, ')
          ..write('valorVenda: $valorVenda, ')
          ..write('quantidadeEstoque: $quantidadeEstoque, ')
          ..write('estoqueMinimo: $estoqueMinimo, ')
          ..write('estoqueMaximo: $estoqueMaximo, ')
          ..write('codigoNcm: $codigoNcm, ')
          ..write('iat: $iat, ')
          ..write('ippt: $ippt, ')
          ..write('tipoItemSped: $tipoItemSped, ')
          ..write('taxaIpi: $taxaIpi, ')
          ..write('taxaIssqn: $taxaIssqn, ')
          ..write('taxaPis: $taxaPis, ')
          ..write('taxaCofins: $taxaCofins, ')
          ..write('taxaIcms: $taxaIcms, ')
          ..write('cst: $cst, ')
          ..write('csosn: $csosn, ')
          ..write('totalizadorParcial: $totalizadorParcial, ')
          ..write('ecfIcmsSt: $ecfIcmsSt, ')
          ..write('codigoBalanca: $codigoBalanca, ')
          ..write('pafPSt: $pafPSt, ')
          ..write('hashRegistro: $hashRegistro, ')
          ..write('valorCusto: $valorCusto, ')
          ..write('situacao: $situacao, ')
          ..write('codigoCest: $codigoCest, ')
          ..write(')'))
        .toString();
  }
}

class $ProdutosTable extends Produtos
    with TableInfo<$ProdutosTable, Produto> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ProdutosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idProdutoUnidadeMeta =
      const VerificationMeta('idProdutoUnidade');
  GeneratedColumn<int>? _idProdutoUnidade;
  @override
  GeneratedColumn<int> get idProdutoUnidade =>
      _idProdutoUnidade ??= GeneratedColumn<int>('ID_PRODUTO_UNIDADE', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES PRODUTO_UNIDADE(ID)');
  final VerificationMeta _idTributGrupoTributarioMeta =
      const VerificationMeta('idTributGrupoTributario');
  GeneratedColumn<int>? _idTributGrupoTributario;
  @override
  GeneratedColumn<int> get idTributGrupoTributario =>
      _idTributGrupoTributario ??= GeneratedColumn<int>('ID_TRIBUT_GRUPO_TRIBUTARIO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES TRIBUT_GRUPO_TRIBUTARIO(ID)');
  final VerificationMeta _idProdutoTipoMeta =
      const VerificationMeta('idProdutoTipo');
  GeneratedColumn<int>? _idProdutoTipo;
  @override
  GeneratedColumn<int> get idProdutoTipo =>
      _idProdutoTipo ??= GeneratedColumn<int>('ID_PRODUTO_TIPO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES PRODUTO_TIPO(ID)');
  final VerificationMeta _idProdutoSubgrupoMeta =
      const VerificationMeta('idProdutoSubgrupo');
  GeneratedColumn<int>? _idProdutoSubgrupo;
  @override
  GeneratedColumn<int> get idProdutoSubgrupo =>
      _idProdutoSubgrupo ??= GeneratedColumn<int>('ID_PRODUTO_SUBGRUPO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES PRODUTO_SUBGRUPO(ID)');
  final VerificationMeta _gtinMeta =
      const VerificationMeta('gtin');
  GeneratedColumn<String>? _gtin;
  @override
  GeneratedColumn<String> get gtin => _gtin ??=
      GeneratedColumn<String>('GTIN', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _codigoInternoMeta =
      const VerificationMeta('codigoInterno');
  GeneratedColumn<String>? _codigoInterno;
  @override
  GeneratedColumn<String> get codigoInterno => _codigoInterno ??=
      GeneratedColumn<String>('CODIGO_INTERNO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _nomeMeta =
      const VerificationMeta('nome');
  GeneratedColumn<String>? _nome;
  @override
  GeneratedColumn<String> get nome => _nome ??=
      GeneratedColumn<String>('NOME', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  GeneratedColumn<String>? _descricao;
  @override
  GeneratedColumn<String> get descricao => _descricao ??=
      GeneratedColumn<String>('DESCRICAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _descricaoPdvMeta =
      const VerificationMeta('descricaoPdv');
  GeneratedColumn<String>? _descricaoPdv;
  @override
  GeneratedColumn<String> get descricaoPdv => _descricaoPdv ??=
      GeneratedColumn<String>('DESCRICAO_PDV', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorCompraMeta =
      const VerificationMeta('valorCompra');
  GeneratedColumn<double>? _valorCompra;
  @override
  GeneratedColumn<double> get valorCompra => _valorCompra ??=
      GeneratedColumn<double>('VALOR_COMPRA', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorVendaMeta =
      const VerificationMeta('valorVenda');
  GeneratedColumn<double>? _valorVenda;
  @override
  GeneratedColumn<double> get valorVenda => _valorVenda ??=
      GeneratedColumn<double>('VALOR_VENDA', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _quantidadeEstoqueMeta =
      const VerificationMeta('quantidadeEstoque');
  GeneratedColumn<double>? _quantidadeEstoque;
  @override
  GeneratedColumn<double> get quantidadeEstoque => _quantidadeEstoque ??=
      GeneratedColumn<double>('QUANTIDADE_ESTOQUE', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _estoqueMinimoMeta =
      const VerificationMeta('estoqueMinimo');
  GeneratedColumn<double>? _estoqueMinimo;
  @override
  GeneratedColumn<double> get estoqueMinimo => _estoqueMinimo ??=
      GeneratedColumn<double>('ESTOQUE_MINIMO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _estoqueMaximoMeta =
      const VerificationMeta('estoqueMaximo');
  GeneratedColumn<double>? _estoqueMaximo;
  @override
  GeneratedColumn<double> get estoqueMaximo => _estoqueMaximo ??=
      GeneratedColumn<double>('ESTOQUE_MAXIMO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _codigoNcmMeta =
      const VerificationMeta('codigoNcm');
  GeneratedColumn<String>? _codigoNcm;
  @override
  GeneratedColumn<String> get codigoNcm => _codigoNcm ??=
      GeneratedColumn<String>('CODIGO_NCM', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _iatMeta =
      const VerificationMeta('iat');
  GeneratedColumn<String>? _iat;
  @override
  GeneratedColumn<String> get iat => _iat ??=
      GeneratedColumn<String>('IAT', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _ipptMeta =
      const VerificationMeta('ippt');
  GeneratedColumn<String>? _ippt;
  @override
  GeneratedColumn<String> get ippt => _ippt ??=
      GeneratedColumn<String>('IPPT', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _tipoItemSpedMeta =
      const VerificationMeta('tipoItemSped');
  GeneratedColumn<String>? _tipoItemSped;
  @override
  GeneratedColumn<String> get tipoItemSped => _tipoItemSped ??=
      GeneratedColumn<String>('TIPO_ITEM_SPED', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _taxaIpiMeta =
      const VerificationMeta('taxaIpi');
  GeneratedColumn<double>? _taxaIpi;
  @override
  GeneratedColumn<double> get taxaIpi => _taxaIpi ??=
      GeneratedColumn<double>('TAXA_IPI', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _taxaIssqnMeta =
      const VerificationMeta('taxaIssqn');
  GeneratedColumn<double>? _taxaIssqn;
  @override
  GeneratedColumn<double> get taxaIssqn => _taxaIssqn ??=
      GeneratedColumn<double>('TAXA_ISSQN', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _taxaPisMeta =
      const VerificationMeta('taxaPis');
  GeneratedColumn<double>? _taxaPis;
  @override
  GeneratedColumn<double> get taxaPis => _taxaPis ??=
      GeneratedColumn<double>('TAXA_PIS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _taxaCofinsMeta =
      const VerificationMeta('taxaCofins');
  GeneratedColumn<double>? _taxaCofins;
  @override
  GeneratedColumn<double> get taxaCofins => _taxaCofins ??=
      GeneratedColumn<double>('TAXA_COFINS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _taxaIcmsMeta =
      const VerificationMeta('taxaIcms');
  GeneratedColumn<double>? _taxaIcms;
  @override
  GeneratedColumn<double> get taxaIcms => _taxaIcms ??=
      GeneratedColumn<double>('TAXA_ICMS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _cstMeta =
      const VerificationMeta('cst');
  GeneratedColumn<String>? _cst;
  @override
  GeneratedColumn<String> get cst => _cst ??=
      GeneratedColumn<String>('CST', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _csosnMeta =
      const VerificationMeta('csosn');
  GeneratedColumn<String>? _csosn;
  @override
  GeneratedColumn<String> get csosn => _csosn ??=
      GeneratedColumn<String>('CSOSN', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _totalizadorParcialMeta =
      const VerificationMeta('totalizadorParcial');
  GeneratedColumn<String>? _totalizadorParcial;
  @override
  GeneratedColumn<String> get totalizadorParcial => _totalizadorParcial ??=
      GeneratedColumn<String>('TOTALIZADOR_PARCIAL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _ecfIcmsStMeta =
      const VerificationMeta('ecfIcmsSt');
  GeneratedColumn<String>? _ecfIcmsSt;
  @override
  GeneratedColumn<String> get ecfIcmsSt => _ecfIcmsSt ??=
      GeneratedColumn<String>('ECF_ICMS_ST', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _codigoBalancaMeta =
      const VerificationMeta('codigoBalanca');
  GeneratedColumn<int>? _codigoBalanca;
  @override
  GeneratedColumn<int> get codigoBalanca => _codigoBalanca ??=
      GeneratedColumn<int>('CODIGO_BALANCA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _pafPStMeta =
      const VerificationMeta('pafPSt');
  GeneratedColumn<String>? _pafPSt;
  @override
  GeneratedColumn<String> get pafPSt => _pafPSt ??=
      GeneratedColumn<String>('PAF_P_ST', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _hashRegistroMeta =
      const VerificationMeta('hashRegistro');
  GeneratedColumn<String>? _hashRegistro;
  @override
  GeneratedColumn<String> get hashRegistro => _hashRegistro ??=
      GeneratedColumn<String>('HASH_REGISTRO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorCustoMeta =
      const VerificationMeta('valorCusto');
  GeneratedColumn<double>? _valorCusto;
  @override
  GeneratedColumn<double> get valorCusto => _valorCusto ??=
      GeneratedColumn<double>('VALOR_CUSTO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _situacaoMeta =
      const VerificationMeta('situacao');
  GeneratedColumn<String>? _situacao;
  @override
  GeneratedColumn<String> get situacao => _situacao ??=
      GeneratedColumn<String>('SITUACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _codigoCestMeta =
      const VerificationMeta('codigoCest');
  GeneratedColumn<String>? _codigoCest;
  @override
  GeneratedColumn<String> get codigoCest => _codigoCest ??=
      GeneratedColumn<String>('CODIGO_CEST', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idProdutoUnidade,
        idTributGrupoTributario,
        idProdutoTipo,
        idProdutoSubgrupo,
        gtin,
        codigoInterno,
        nome,
        descricao,
        descricaoPdv,
        valorCompra,
        valorVenda,
        quantidadeEstoque,
        estoqueMinimo,
        estoqueMaximo,
        codigoNcm,
        iat,
        ippt,
        tipoItemSped,
        taxaIpi,
        taxaIssqn,
        taxaPis,
        taxaCofins,
        taxaIcms,
        cst,
        csosn,
        totalizadorParcial,
        ecfIcmsSt,
        codigoBalanca,
        pafPSt,
        hashRegistro,
        valorCusto,
        situacao,
        codigoCest,
      ];

  @override
  String get aliasedName => _alias ?? 'PRODUTO';
  
  @override
  String get actualTableName => 'PRODUTO';
  
  @override
  VerificationContext validateIntegrity(Insertable<Produto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_PRODUTO_UNIDADE')) {
        context.handle(_idProdutoUnidadeMeta,
            idProdutoUnidade.isAcceptableOrUnknown(data['ID_PRODUTO_UNIDADE']!, _idProdutoUnidadeMeta));
    }
    if (data.containsKey('ID_TRIBUT_GRUPO_TRIBUTARIO')) {
        context.handle(_idTributGrupoTributarioMeta,
            idTributGrupoTributario.isAcceptableOrUnknown(data['ID_TRIBUT_GRUPO_TRIBUTARIO']!, _idTributGrupoTributarioMeta));
    }
    if (data.containsKey('ID_PRODUTO_TIPO')) {
        context.handle(_idProdutoTipoMeta,
            idProdutoTipo.isAcceptableOrUnknown(data['ID_PRODUTO_TIPO']!, _idProdutoTipoMeta));
    }
    if (data.containsKey('ID_PRODUTO_SUBGRUPO')) {
        context.handle(_idProdutoSubgrupoMeta,
            idProdutoSubgrupo.isAcceptableOrUnknown(data['ID_PRODUTO_SUBGRUPO']!, _idProdutoSubgrupoMeta));
    }
    if (data.containsKey('GTIN')) {
        context.handle(_gtinMeta,
            gtin.isAcceptableOrUnknown(data['GTIN']!, _gtinMeta));
    }
    if (data.containsKey('CODIGO_INTERNO')) {
        context.handle(_codigoInternoMeta,
            codigoInterno.isAcceptableOrUnknown(data['CODIGO_INTERNO']!, _codigoInternoMeta));
    }
    if (data.containsKey('NOME')) {
        context.handle(_nomeMeta,
            nome.isAcceptableOrUnknown(data['NOME']!, _nomeMeta));
    }
    if (data.containsKey('DESCRICAO')) {
        context.handle(_descricaoMeta,
            descricao.isAcceptableOrUnknown(data['DESCRICAO']!, _descricaoMeta));
    }
    if (data.containsKey('DESCRICAO_PDV')) {
        context.handle(_descricaoPdvMeta,
            descricaoPdv.isAcceptableOrUnknown(data['DESCRICAO_PDV']!, _descricaoPdvMeta));
    }
    if (data.containsKey('VALOR_COMPRA')) {
        context.handle(_valorCompraMeta,
            valorCompra.isAcceptableOrUnknown(data['VALOR_COMPRA']!, _valorCompraMeta));
    }
    if (data.containsKey('VALOR_VENDA')) {
        context.handle(_valorVendaMeta,
            valorVenda.isAcceptableOrUnknown(data['VALOR_VENDA']!, _valorVendaMeta));
    }
    if (data.containsKey('QUANTIDADE_ESTOQUE')) {
        context.handle(_quantidadeEstoqueMeta,
            quantidadeEstoque.isAcceptableOrUnknown(data['QUANTIDADE_ESTOQUE']!, _quantidadeEstoqueMeta));
    }
    if (data.containsKey('ESTOQUE_MINIMO')) {
        context.handle(_estoqueMinimoMeta,
            estoqueMinimo.isAcceptableOrUnknown(data['ESTOQUE_MINIMO']!, _estoqueMinimoMeta));
    }
    if (data.containsKey('ESTOQUE_MAXIMO')) {
        context.handle(_estoqueMaximoMeta,
            estoqueMaximo.isAcceptableOrUnknown(data['ESTOQUE_MAXIMO']!, _estoqueMaximoMeta));
    }
    if (data.containsKey('CODIGO_NCM')) {
        context.handle(_codigoNcmMeta,
            codigoNcm.isAcceptableOrUnknown(data['CODIGO_NCM']!, _codigoNcmMeta));
    }
    if (data.containsKey('IAT')) {
        context.handle(_iatMeta,
            iat.isAcceptableOrUnknown(data['IAT']!, _iatMeta));
    }
    if (data.containsKey('IPPT')) {
        context.handle(_ipptMeta,
            ippt.isAcceptableOrUnknown(data['IPPT']!, _ipptMeta));
    }
    if (data.containsKey('TIPO_ITEM_SPED')) {
        context.handle(_tipoItemSpedMeta,
            tipoItemSped.isAcceptableOrUnknown(data['TIPO_ITEM_SPED']!, _tipoItemSpedMeta));
    }
    if (data.containsKey('TAXA_IPI')) {
        context.handle(_taxaIpiMeta,
            taxaIpi.isAcceptableOrUnknown(data['TAXA_IPI']!, _taxaIpiMeta));
    }
    if (data.containsKey('TAXA_ISSQN')) {
        context.handle(_taxaIssqnMeta,
            taxaIssqn.isAcceptableOrUnknown(data['TAXA_ISSQN']!, _taxaIssqnMeta));
    }
    if (data.containsKey('TAXA_PIS')) {
        context.handle(_taxaPisMeta,
            taxaPis.isAcceptableOrUnknown(data['TAXA_PIS']!, _taxaPisMeta));
    }
    if (data.containsKey('TAXA_COFINS')) {
        context.handle(_taxaCofinsMeta,
            taxaCofins.isAcceptableOrUnknown(data['TAXA_COFINS']!, _taxaCofinsMeta));
    }
    if (data.containsKey('TAXA_ICMS')) {
        context.handle(_taxaIcmsMeta,
            taxaIcms.isAcceptableOrUnknown(data['TAXA_ICMS']!, _taxaIcmsMeta));
    }
    if (data.containsKey('CST')) {
        context.handle(_cstMeta,
            cst.isAcceptableOrUnknown(data['CST']!, _cstMeta));
    }
    if (data.containsKey('CSOSN')) {
        context.handle(_csosnMeta,
            csosn.isAcceptableOrUnknown(data['CSOSN']!, _csosnMeta));
    }
    if (data.containsKey('TOTALIZADOR_PARCIAL')) {
        context.handle(_totalizadorParcialMeta,
            totalizadorParcial.isAcceptableOrUnknown(data['TOTALIZADOR_PARCIAL']!, _totalizadorParcialMeta));
    }
    if (data.containsKey('ECF_ICMS_ST')) {
        context.handle(_ecfIcmsStMeta,
            ecfIcmsSt.isAcceptableOrUnknown(data['ECF_ICMS_ST']!, _ecfIcmsStMeta));
    }
    if (data.containsKey('CODIGO_BALANCA')) {
        context.handle(_codigoBalancaMeta,
            codigoBalanca.isAcceptableOrUnknown(data['CODIGO_BALANCA']!, _codigoBalancaMeta));
    }
    if (data.containsKey('PAF_P_ST')) {
        context.handle(_pafPStMeta,
            pafPSt.isAcceptableOrUnknown(data['PAF_P_ST']!, _pafPStMeta));
    }
    if (data.containsKey('HASH_REGISTRO')) {
        context.handle(_hashRegistroMeta,
            hashRegistro.isAcceptableOrUnknown(data['HASH_REGISTRO']!, _hashRegistroMeta));
    }
    if (data.containsKey('VALOR_CUSTO')) {
        context.handle(_valorCustoMeta,
            valorCusto.isAcceptableOrUnknown(data['VALOR_CUSTO']!, _valorCustoMeta));
    }
    if (data.containsKey('SITUACAO')) {
        context.handle(_situacaoMeta,
            situacao.isAcceptableOrUnknown(data['SITUACAO']!, _situacaoMeta));
    }
    if (data.containsKey('CODIGO_CEST')) {
        context.handle(_codigoCestMeta,
            codigoCest.isAcceptableOrUnknown(data['CODIGO_CEST']!, _codigoCestMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Produto map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Produto.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProdutosTable createAlias(String alias) {
    return $ProdutosTable(_db, alias);
  }
}