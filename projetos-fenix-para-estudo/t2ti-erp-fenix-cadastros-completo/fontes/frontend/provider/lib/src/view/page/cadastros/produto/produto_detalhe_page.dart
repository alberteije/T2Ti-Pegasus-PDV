/*
Title: T2Ti ERP Fenix                                                                
Description: DetalhePage relacionada à tabela [PRODUTO] 
                                                                                
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
*******************************************************************************/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view_model/view_model.dart';
import 'package:fenix/src/view/shared/erro_page.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'package:intl/intl.dart';
import 'produto_persiste_page.dart';

class ProdutoDetalhePage extends StatelessWidget {
  final Produto produto;

  const ProdutoDetalhePage({Key key, this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var produtoProvider = Provider.of<ProdutoViewModel>(context);

    if (produtoProvider.objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Produto'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<ProdutoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Theme(
          data: ViewUtilLib.getThemeDataDetalhePage(context),
          child: Scaffold(
            appBar: AppBar(title: Text('Produto'), actions: <Widget>[
              IconButton(
                icon: ViewUtilLib.getIconBotaoExcluir(),
                onPressed: () {
                  return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                    produtoProvider.excluir(produto.id);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                },
              ),
              IconButton(
                icon: ViewUtilLib.getIconBotaoAlterar(),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ProdutoPersistePage(
                          produto: produto,
                          title: 'Produto - Editando',
                          operacao: 'A')));
                },
              ),
            ]),
            body: SingleChildScrollView(
              child: Theme(
                data: ThemeData(fontFamily: 'Raleway'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ViewUtilLib.getPaddingDetalhePage('Detalhes de Produto'),
                    Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                        ViewUtilLib.getListTileDataDetalhePageId(
                            produto.id?.toString() ?? '', 'Id'),
						ViewUtilLib.getListTileDataDetalhePage(
							produto.produtoSubgrupo?.nome?.toString() ?? '', 'Subgrupo'),
						ViewUtilLib.getListTileDataDetalhePage(
							produto.produtoMarca?.nome?.toString() ?? '', 'Marca'),
						ViewUtilLib.getListTileDataDetalhePage(
							produto.produtoUnidade?.sigla?.toString() ?? '', 'Unidade'),
						ViewUtilLib.getListTileDataDetalhePage(
							produto.nome ?? '', 'Nome'),
						ViewUtilLib.getListTileDataDetalhePage(
							produto.descricao ?? '', 'Descrição'),
						ViewUtilLib.getListTileDataDetalhePage(
							produto.gtin ?? '', 'GTIN'),
						ViewUtilLib.getListTileDataDetalhePage(
							produto.codigoInterno ?? '', 'Código Interno'),
						ViewUtilLib.getListTileDataDetalhePage(
							produto.valorCompra != null ? Constantes.formatoDecimalValor.format(produto.valorCompra) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Compra'),
						ViewUtilLib.getListTileDataDetalhePage(
							produto.valorVenda != null ? Constantes.formatoDecimalValor.format(produto.valorVenda) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Venda'),
						ViewUtilLib.getListTileDataDetalhePage(
							produto.ncm ?? '', 'NCM'),
						ViewUtilLib.getListTileDataDetalhePage(
							produto.estoqueMinimo != null ? Constantes.formatoDecimalQuantidade.format(produto.estoqueMinimo) : 0.toStringAsFixed(Constantes.decimaisQuantidade), 'Estoque Mínimo'),
						ViewUtilLib.getListTileDataDetalhePage(
							produto.estoqueMaximo != null ? Constantes.formatoDecimalQuantidade.format(produto.estoqueMaximo) : 0.toStringAsFixed(Constantes.decimaisQuantidade), 'Estoque Máximo'),
						ViewUtilLib.getListTileDataDetalhePage(
							produto.quantidadeEstoque != null ? Constantes.formatoDecimalQuantidade.format(produto.quantidadeEstoque) : 0.toStringAsFixed(Constantes.decimaisQuantidade), 'Quantidade em Estoque'),
						ViewUtilLib.getListTileDataDetalhePage(
							produto.dataCadastro != null ? DateFormat('dd/MM/yyyy').format(produto.dataCadastro) : '', 'Data de Cadastro'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
    }
  }
}