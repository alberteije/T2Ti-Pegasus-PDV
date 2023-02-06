/*
Title: T2Ti ERP 3.0
Description: Controller utilizado para gerar comandas a partir do iFood
                                                                                
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
import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';
import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/service/service.dart';

class IfoodController {

  static CompraPedidoCabecalho? compraPedidoCabecalho;
  static List<CompraDetalhe> listaCompraDetalhe = [];

  static Future<void> gerarComanda() async {

    IfoodService ifoodService = IfoodService();
    final pedidoIfood = await ifoodService.consultarPedido();

    // armazena os dados em EMPRESA_DELIVERY_PEDIDO
    EmpresaDeliveryPedido empresaDeliveryPedido = EmpresaDeliveryPedido(
      id: null,
      codigoPedidoEmpresa: pedidoIfood!.id!,
      conteudoJson: pedidoIfood.toJson.toString(),
      observacao: pedidoIfood.salesChannel,
      dataSolicitacao: Biblioteca.tratarDataJson(pedidoIfood.createdAt),
    );
    final idEmpresaDevliveryPedido = await Sessao.db.empresaDeliveryPedidoDao.inserir(empresaDeliveryPedido);

    // armazena os dados da comanda
    var tipoComanda = '';
    switch (pedidoIfood.orderType!) {
      case 'INDOOR' :
        tipoComanda = 'I';
        break;
      case 'TAKEOUT' :
        tipoComanda = 'T';
        break;
      case 'DELIVERY' :
        tipoComanda = 'D';
        break;
    }        

    Comanda comanda = Comanda(
      id: null,
      idEmpresaDeliveryPedido: idEmpresaDevliveryPedido,
      dataChegada: Biblioteca.tratarDataJson(pedidoIfood.createdAt),
      tipo: tipoComanda,
      valorSubtotal: pedidoIfood.total!.subTotal!,
      valorTotal: pedidoIfood.total!.orderAmount!,
      situacao: 'A',
    );

    // define o cliente
    var cliente = await Sessao.db.clienteDao.consultarObjetoFiltro('CONTATO', pedidoIfood.customer!.id!);
    if (cliente == null) {
      Cliente c = Cliente(
        id: null,
        nome: pedidoIfood.customer!.name,
        telefone: pedidoIfood.customer!.phone?.number ?? '',
        contato: pedidoIfood.customer!.id!,
      );
      final idInserido = await Sessao.db.clienteDao.inserir(c);
      cliente = await Sessao.db.clienteDao.consultarObjeto(idInserido);
    }

    // define os itens e complementos
    List<ComandaDetalheMontado> listaComandaDetalheMontado = [];
    for (var item in pedidoIfood.items!) {
      var produto = await Sessao.db.produtoDao.consultarObjetoFiltro('GTIN', item.ean!);
      if (produto == null) {
        Produto p = Produto(
          id: null,
          idProdutoSubgrupo: 1,
          idProdutoTipo: 1,
          idProdutoUnidade: 1,
          idTributGrupoTributario: 1,
          nome: item.name,
          gtin: item.ean,
          valorVenda: item.unitPrice,
          situacao: 'A',
        );
        final idInserido = await Sessao.db.produtoDao.inserirProdutoSimples(p);
        produto = await Sessao.db.produtoDao.consultarObjeto(idInserido);
      }

      // complementos
      List<ComandaDetalheComplemento> listaComandaDetalheComplemento = [];
      for (var complemento in item.options!) {
        var produtoComplemento = await Sessao.db.produtoDao.consultarObjetoFiltro('GTIN', complemento.ean!);
        if (produtoComplemento == null) {
          Produto pComplemento = Produto(
            id: null,
            idProdutoSubgrupo: 1,
            idProdutoTipo: 1,
            idProdutoUnidade: 1,
            idTributGrupoTributario: 1,
            nome: complemento.name,
            gtin: complemento.ean,
            valorVenda: complemento.unitPrice,
            situacao: 'A',
          );
          final idInserido = await Sessao.db.produtoDao.inserirProdutoSimples(pComplemento);
          produtoComplemento = await Sessao.db.produtoDao.consultarObjeto(idInserido);
        }        
        ComandaDetalheComplemento comandaDetalheComplemento = ComandaDetalheComplemento(
          id: null,
          idProduto: produtoComplemento!.id,
          nomeProduto: produtoComplemento.nome,
          quantidade: complemento.quantity,
          valorUnitario: complemento.unitPrice,
          valorTotal: complemento.price,
        );
        listaComandaDetalheComplemento.add(comandaDetalheComplemento);
      }

      ProdutoMontado produtoMontado = ProdutoMontado(
        produto: produto,
        cardapio: null,
        produtoSubgrupo: null,
        produtoTipo: null,
        produtoUnidade: null,
        tributGrupoTributario: null,
      );

      ComandaDetalhe comandaDetalhe = ComandaDetalhe(
        id: null,
        idProduto: produto!.id,
        quantidade: item.quantity,
        valorUnitario: item.unitPrice,
        valorTotalComplemento: item.optionsPrice,
        valorTotal: item.totalPrice
      );

      ComandaDetalheMontado comandaDetalheMontado = ComandaDetalheMontado(
        comandaDetalhe: comandaDetalhe,
        produtoMontado: produtoMontado,
        listaComandaDetalheComplemento: listaComandaDetalheComplemento,
      );
      listaComandaDetalheMontado.add(comandaDetalheMontado);
    }

    // insere a comanda
    ComandaMontado comandaMontado = ComandaMontado(
      cliente: cliente,
      colaborador: null,
      comanda: comanda,
      listaComandaDetalheMontado: listaComandaDetalheMontado,
    );

    comandaMontado.comanda = await Sessao.db.comandaDao.inserir(comandaMontado);

    // insere os dados de delivery: DELIVERY - apenas para consulta, pois o pedido neste caso é entregue pelo iFood
    Delivery delivery = Delivery(
      id: null,
      idComanda: comandaMontado.comanda!.id,
      nomeCliente: 'iFood - ${cliente!.nome!}',
      telefonePrincipal: cliente.telefone,
      celular: cliente.celular,
      logradouro: pedidoIfood.delivery!.deliveryAddress!.streetName,
      numero: pedidoIfood.delivery!.deliveryAddress!.streetNumber,
      complemento: pedidoIfood.delivery!.deliveryAddress!.complement,
      cep: pedidoIfood.delivery!.deliveryAddress!.postalCode,
      bairro: pedidoIfood.delivery!.deliveryAddress!.neighborhood,
      cidade: pedidoIfood.delivery!.deliveryAddress!.city,
      uf: pedidoIfood.delivery!.deliveryAddress!.state,
      valorFrete: pedidoIfood.total!.deliveryFee,
      valorAReceber: pedidoIfood.total!.orderAmount,
    );
    await Sessao.db.deliveryDao.inserir(delivery);

 }

}