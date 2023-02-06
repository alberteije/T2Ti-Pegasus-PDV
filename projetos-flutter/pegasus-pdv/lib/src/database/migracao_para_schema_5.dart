import 'package:drift/drift.dart';

import 'package:pegasus_pdv/src/database/database.dart';

class MigracaoParaSchema5 extends DatabaseAccessor<AppDatabase> {

  final AppDatabase db;
  MigracaoParaSchema5(this.db) : super(db);

  // pega referencia das tabelas existentes
  $ProdutosTable get produtos => attachedDatabase.produtos;
  $ProdutoFichaTecnicasTable get produtoFichaTecnicas => attachedDatabase.produtoFichaTecnicas;
  $ColaboradorsTable get colaboradors => attachedDatabase.colaboradors;
  $ClientesTable get clientes => attachedDatabase.clientes;
  
  // pega referencia das novas tabelas
  $CardapiosTable get	cardapios => attachedDatabase.cardapios;
  $CardapioPerguntaPadraosTable get	cardapioPerguntaPadraos => attachedDatabase.cardapioPerguntaPadraos;
  $CardapioRespostaPadraosTable get	cardapioRespostaPadraos => attachedDatabase.cardapioRespostaPadraos;
  $ComandasTable get	comandas => attachedDatabase.comandas;
  $ComandaDetalhesTable get	comandaDetalhes => attachedDatabase.comandaDetalhes;
  $ComandaPedidosTable get	comandaPedidos => attachedDatabase.comandaPedidos;
  $ComandaObservacaoPadraosTable get	comandaObservacaoPadraos => attachedDatabase.comandaObservacaoPadraos;
  $ComandaDetalheComplementosTable get	comandaDetalheComplementos => attachedDatabase.comandaDetalheComplementos;
  $CozinhasTable get	cozinhas => attachedDatabase.cozinhas;
  $DeliverysTable get	deliverys => attachedDatabase.deliverys;
  $DeliveryAcertosTable get	deliveryAcertos => attachedDatabase.deliveryAcertos;
  $DeliveryAcertoComandasTable get	deliveryAcertoComandas => attachedDatabase.deliveryAcertoComandas;
  $EmpresaSegmentosTable get	empresaSegmentos => attachedDatabase.empresaSegmentos;
  $EmpresaDeliveryPedidosTable get	empresaDeliveryPedidos => attachedDatabase.empresaDeliveryPedidos;
  $EntregadorRotasTable get	entregadorRotas => attachedDatabase.entregadorRotas;
  $EntregadorRotaDetalhesTable get	entregadorRotaDetalhes => attachedDatabase.entregadorRotaDetalhes;
  $FidelidadeHistoricosTable get	fidelidadeHistoricos => attachedDatabase.fidelidadeHistoricos;
  $FidelidadeUtilizadosTable get	fidelidadeUtilizados => attachedDatabase.fidelidadeUtilizados;
  $ProdutoGruposTable get	produtoGrupos => attachedDatabase.produtoGrupos;
  $ProdutoSubgruposTable get	produtoSubgrupos => attachedDatabase.produtoSubgrupos;
  $ProdutoTiposTable get	produtoTipos => attachedDatabase.produtoTipos;
  $MesasTable get	mesas => attachedDatabase.mesas;
  $ReservasTable get	reservas => attachedDatabase.reservas;
  $ReservaMesasTable get	reservaMesas => attachedDatabase.reservaMesas;
  $TaxaEntregasTable get	taxaEntregas => attachedDatabase.taxaEntregas;
  $EmpresaCnaesTable get	empresaCnaes => attachedDatabase.empresaCnaes;
  $ProdutoImagemsTable get	produtoImagems => attachedDatabase.produtoImagems;
  $ClienteFiadosTable get	clienteFiados => attachedDatabase.clienteFiados;

  Future<void> migrarParaSchema5(Migrator m, int from, int to) async {
    // adicionando novas colunas em tabelas existentes
    await m.addColumn(produtos, produtos.codigoCest);        
    await m.addColumn(produtos, produtos.situacao);        
    await m.addColumn(produtos, produtos.valorCusto);        
    await m.addColumn(produtos, produtos.idProdutoSubgrupo);        
    await m.addColumn(produtos, produtos.idProdutoTipo);        
    await m.addColumn(produtoFichaTecnicas, produtoFichaTecnicas.valorCusto);        
    await m.addColumn(produtoFichaTecnicas, produtoFichaTecnicas.percentualCusto);        
    await m.addColumn(colaboradors, colaboradors.entregadorVeiculo);        
    await m.addColumn(clientes, clientes.fidelidadeAviso);        
    await m.addColumn(clientes, clientes.fidelidadeQuantidade);        
    await m.addColumn(clientes, clientes.fidelidadeValor);        
    await m.addColumn(clientes, clientes.fiadoValorTeto);        
    
        // criando novas tabelas
    await m.createTable(cardapios);
    await m.createTable(cardapioPerguntaPadraos);
    await m.createTable(cardapioRespostaPadraos);
    await m.createTable(comandas);
    await m.createTable(comandaDetalhes);
    await m.createTable(comandaPedidos);
    await m.createTable(comandaObservacaoPadraos);
    await m.createTable(comandaDetalheComplementos);
    await m.createTable(cozinhas);
    await m.createTable(deliverys);
    await m.createTable(deliveryAcertos);
    await m.createTable(deliveryAcertoComandas);
    await m.createTable(empresaSegmentos);
    await m.createTable(empresaDeliveryPedidos);
    await m.createTable(entregadorRotas);
    await m.createTable(entregadorRotaDetalhes);
    await m.createTable(fidelidadeHistoricos);
    await m.createTable(fidelidadeUtilizados);
    await m.createTable(produtoGrupos);
    await m.createTable(produtoSubgrupos);
    await m.createTable(produtoTipos);
    await m.createTable(mesas);
    await m.createTable(reservas);
    await m.createTable(reservaMesas);
    await m.createTable(taxaEntregas);
    await m.createTable(empresaCnaes);
    await m.createTable(produtoImagems);
    await m.createTable(clienteFiados);
  }
}