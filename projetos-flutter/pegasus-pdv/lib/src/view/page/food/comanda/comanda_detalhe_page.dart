/*
Title: T2Ti ERP 3.0                                                                
Description: PersistePage relacionada à tabela [COMANDA] 
                                                                                
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
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pegasus_pdv/src/controller/controller.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';
import 'package:pegasus_pdv/src/database/database.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/view/page/page.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/page/lookup_local_page.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_caixa.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

class ComandaDetalhePage extends StatefulWidget {
  final ComandaMontado comandaMontado;

  const ComandaDetalhePage(this.comandaMontado, {Key? key}) : super(key: key);

  @override
  ComandaDetalhePageState createState() => ComandaDetalhePageState();
}

class ComandaDetalhePageState extends State<ComandaDetalhePage> {
  final _pesquisaProdutoController = TextEditingController();
  final _focusNode = FocusNode();
  double? _quantidadeInformada = 1;
  double valorDesconto = 0;
  ProdutoMontado? _produtoMontado = ProdutoMontado(produto: Produto(id: null),);

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    valorDesconto = widget.comandaMontado.comanda!.valorDesconto ?? 0;
    return Scaffold(
      backgroundColor: Color.lerp(Colors.grey[850], Colors.blueGrey, 0.8),
      body: _getCorpo(),
    );
  }

  Widget _getCorpo() {
    return Column(
      children: <Widget>[
        Stack(
          children: [
            Container(
              color: Color.lerp(Colors.grey[850], Colors.white, 0.4),
              height: 100,
            ),
            const SizedBox(
              height: 200,
            ),
            Positioned(
              top: 10,
              right: 10, 
              child: _getPopupMenuGeral(_executarFuncaoMenuButtonGeral),
            ),
            Positioned(
              top: 10,
              left: 10, 
              child: ComandaTileDetalhePage(
                widget.comandaMontado,
                altura: 182,
                largura: 133,
                tamanhoFonteLabelComanda: 10,
                tamanhoFonteNumeroComanda: 10,
                tamanhoFonteQuantidadeItens: 9,
                tamanhoFonteQuantidadePessoas: 9,
                tamanhoFonteValorTotal: 9,
                tamanhoFontevalorPorPessoa: 9,
                paddingComandaData: const EdgeInsets.fromLTRB(50, 3, 0, 0),
              ),
            ),
            Positioned(
              top: 50,
              right: 10,
              child: SizedBox(
                height: 182,
                width: MediaQuery.of(context).size.width - 163,
                  child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        child: TextField(
                          style: TextStyle(
                            decorationColor: Colors.white,
                            color: Colors.grey.shade300,
                            fontWeight: FontWeight.bold
                          ),                    
                          focusNode: _focusNode,
                          autofocus: true,
                          controller: _pesquisaProdutoController,
                          onSubmitted: (value) { 
                            _localizarProduto(value); 
                            _pesquisaProdutoController.text = ''; 
                          },
                          decoration: getInputDecoration(
                            'Pesquise Nome ou Código de Barras',
                            'Pesquisar Produto',
                            false,),
                          onChanged: (text) {
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: IconButton(
                        tooltip: 'Pesquisar Produto',
                        icon: ViewUtilLib.getIconBotaoLookup(),
                        onPressed: () {
                          _localizarProduto(_pesquisaProdutoController.text); 
                          _pesquisaProdutoController.text = '';
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.comandaMontado.listaComandaDetalheMontado!.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  _excluirProduto(index: index, perguntaAntes: true);
                },
                background: Container(color: Colors.red),
                child: _itensDaComanda(context, index),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _itensDaComanda(BuildContext context, int index) {
    var item = index + 1;
    return Card(      
      color: Color.lerp(Colors.grey[550], Colors.white, 0.6),
      child: ListTile(
        minLeadingWidth: Biblioteca.isTelaPequena(context)! ? 0 : 20,
        leading: Text(
          item.toString(),
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13.0),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getDescricaoItem(index),
            _getBotoesItem(index),
          ],
        ),        
        subtitle: _getRodape(index),            
        trailing: _getPopupMenuItem(_executarFuncaoMenuButtonItem, index),
      ),
    );
  }

  Widget _getDescricaoItem(int index) {
    return Flexible(    
      child: Text(
        widget.comandaMontado.listaComandaDetalheMontado![index].produtoMontado?.produto?.nome ?? '',
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
      ),
    );
  }

  Widget _getBotoesItem(int index) {
    return Row(          
      mainAxisAlignment: Biblioteca.isTelaPequena(context)! ? MainAxisAlignment.center : MainAxisAlignment.end,
      children: <Widget>[
        // valor unitário
        getCardValorUnitario(context: context, valorUnitario: widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe!.valorUnitario),
        const SizedBox(
          width: 8,
        ),
        getBotaoDecrementaCaixa(corIcone: Colors.red.shade900, decrementar: () {_decrementarItem(index);} ),
        // quantidade e unidade
        getCardQuantidade(context: context, quantidade: widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe!.quantidade),
        getBotaoIncrementaCaixa(corIcone: Colors.green.shade900, incrementar: () {_incrementarItem(index);} ),
        const SizedBox(
          width: 8,
        ),
        // valor total
        getCardValorTotal(context: context, valorTotal: widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe!.valorTotal),
      ],
    );
  }

  Widget _getRodape(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          indent: 0,
          endIndent: 0,
          thickness: 2,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.cancel, color: Colors.red,),
                onPressed: () {
                  setState(() {
                    widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe = 
                    widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe!.copyWith(
                      observacao: '',
                    );
                  });                 
                }, 
              ),
              const Text(
                "Observações", 
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 0),
          child: Text(
            widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe!.observacao ?? '',
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13.0),
          ),
        ),
        const Divider(
          indent: 0,
          endIndent: 0,
          thickness: 2,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 0),
          child: Text(
            "Complementos", 
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black
            ),
          ),
        ),
        SizedBox(
          height: (35.0 * (widget.comandaMontado.listaComandaDetalheMontado?.length ?? 0)) + 50,
          child: Scrollbar(
            child: ListView(
              padding: const EdgeInsets.all(2.0),
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Card(
                    color: Colors.grey,
                    elevation: 2.0,
                    child: DataTable(
                      headingTextStyle: const TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold),
                      dataTextStyle: const TextStyle(color: Colors.black, fontSize: 12.0,),
                      headingRowHeight: 35,
                      dataRowHeight: 35,
                      columns: _getColumnsComplemento(),
                      rows: _getRowsComplemento(index),
                    ),
                  ),
                ),
              ],
            ),
          ),                          
        ),
        const Divider(
          indent: 0,
          endIndent: 0,
          thickness: 2,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [            
              Text(
                "Total do Item ${Biblioteca.formatarValorDecimal(
                  widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe!.valorTotal! + 
                  widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe!.valorTotalComplemento!
                )}", 
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }

  List<DataColumn> _getColumnsComplemento() {
    List<DataColumn> lista = [];
    lista.add(
      const DataColumn(
        label: Text(''),
        tooltip: '',      
    ));
    lista.add(const DataColumn(
      label: Text(
        "Nome",        
      ),
    ));
    lista.add(const DataColumn(
      numeric: true,
      label: Text(
        "Valor",
      ),
    ));
    return lista;
  }

  List<DataRow> _getRowsComplemento(int index) {
    List<DataRow> lista = [];
    for (var comandaDetalheComplemento in widget.comandaMontado.listaComandaDetalheMontado![index].listaComandaDetalheComplemento!) {
      List<DataCell> celulas = [];

      celulas = [
        DataCell(
          getBotaoGenericoPdv(
            descricao: 'Excluir',
            cor: Colors.red.shade400, 
            padding: const EdgeInsets.all(2),
            textStyle: const TextStyle(color: Colors.white, fontSize: 12.0,),
            onPressed: () {
              _excluirComplemento(comandaDetalheComplemento, index);
            }
          ),
        ),
        DataCell(
          Text(comandaDetalheComplemento.nomeProduto ?? '',),
        ),
        DataCell(
          Text(Biblioteca.formatarValorDecimal(comandaDetalheComplemento.valorTotal),),
        ),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

  PopupMenuButton<String> _getPopupMenuItem(Function(String) onSelectedPopupMenuButton, int index) {
    return PopupMenuButton<String> (
      onSelected: onSelectedPopupMenuButton,
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
        PopupMenuItem<String>(
          value: 'excluir:$index',
          child: Row(
            children: const [
              Icon(
                Icons.delete, 
                color: Colors.red,
              ),
              Text(
                ' Excluir',
                style: TextStyle(
                  decorationColor: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold
                ),                                    
              ),
            ],
          ),          
        ),
        PopupMenuItem<String>(
          value: 'complemento:$index',
          child: Row(
            children: const [
              Icon(
                Icons.add_box, 
                color: Colors.blue
              ),
              Text(
                ' Complemento',
                style: TextStyle(
                  decorationColor: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold
                ),                                    
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'observacao:$index',
          child: Row(
            children: const [
              Icon(
                Icons.add_box, 
                color: Colors.green
              ),
              Text(
                ' Observação',
                style: TextStyle(
                  decorationColor: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold
                ),                                    
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'perguntas:$index',
          child: Row(
            children: const [
              Icon(
                Icons.question_answer, 
                color: Colors.purple
              ),
              Text(
                ' Perguntas',
                style: TextStyle(
                  decorationColor: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold
                ),                                    
              ),
            ],
          ),
        ),
      ],
    );
  }

  PopupMenuButton<String> _getPopupMenuGeral(Function(String) onSelectedPopupMenuButton) {
    return PopupMenuButton<String> (
      onSelected: onSelectedPopupMenuButton,
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
        PopupMenuItem<String>(
          value: 'salvar_dados',
          child: Row(
            children: const [
              Icon(
                Icons.save, 
                color: Colors.purple,
              ),
              Text(
                ' Salvar Dados',
                style: TextStyle(
                  decorationColor: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold
                ),                                    
              ),
            ],
          ),          
        ),
        PopupMenuItem<String>(
          value: 'desconto',
          child: Row(
            children: const [
              Icon(
                Icons.monetization_on, 
                color: Colors.pink,
              ),
              Text(
                ' Conceder Desconto',
                style: TextStyle(
                  decorationColor: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold
                ),                                    
              ),
            ],
          ),          
        ),
        PopupMenuItem<String>(
          value: 'imprimir_comanda',
          child: Row(
            children: const [
              Icon(
                Icons.print, 
                color: Colors.green,
              ),
              Text(
                ' Imprimir Comanda',
                style: TextStyle(
                  decorationColor: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold
                ),                                    
              ),
            ],
          ),          
        ),
        // PopupMenuItem<String>(
        //   value: 'mesa',
        //   child: Row(
        //     children: const [
        //       Icon(
        //         Icons.chair_sharp,
        //         color: Colors.indigo,
        //       ),
        //       Text(
        //         ' Mesa',
        //         style: TextStyle(
        //           decorationColor: Colors.white,
        //           fontSize: 10,
        //           fontWeight: FontWeight.bold
        //         ),                                    
        //       ),
        //     ],
        //   ),          
        // ),
        // PopupMenuItem<String>(
        //   value: 'delivery',
        //   child: Row(
        //     children: const [
        //       Icon(
        //         Icons.motorcycle, 
        //         color: Colors.blueGrey,
        //       ),
        //       Text(
        //         ' delivery',
        //         style: TextStyle(
        //           decorationColor: Colors.white,
        //           fontSize: 10,
        //           fontWeight: FontWeight.bold
        //         ),                                    
        //       ),
        //     ],
        //   ),          
        // ),
        PopupMenuItem<String>(
          value: 'emitir_nota',
          child: Row(
            children: const [
              Icon(
                Icons.document_scanner, 
                color: Colors.blue
              ),
              Text(
                ' Emitir Nota',
                style: TextStyle(
                  decorationColor: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold
                ),                                    
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'sair',
          child: Row(
            children: const [
              Icon(
                Icons.door_back_door_outlined, 
                color: Colors.red
              ),
              Text(
                ' Sair',
                style: TextStyle(
                  decorationColor: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold
                ),                                    
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _localizarProduto(String? dadoInformado) async {
    // TODO: mover esse código daqui e da CaixaPage para um local central, talvez para a Sessao
    bool podeRealizarVenda = false;
    if (Sessao.configuracaoPdv!.modulo != 'G') {
      if (Sessao.configuracaoPdv!.moduloFiscalPrincipal == 'NFC') {
        String mensagemRetorno = await NfceController.verificarSeAptoParaEmitirNfce();
        if (mensagemRetorno.isNotEmpty) {
          if (!mounted) return;
          gerarDialogBoxInformacao(context, mensagemRetorno);
        } else {
          podeRealizarVenda = true;
        }
      } else if (Sessao.configuracaoPdv!.moduloFiscalPrincipal == 'SAT') {
        String mensagemRetorno = await SatController.verificarSeAptoParaEmitirCfe();
        if (mensagemRetorno.isNotEmpty) {
          if (!mounted) return;
          gerarDialogBoxInformacao(context, mensagemRetorno);
        } else {
          podeRealizarVenda = true;
        }
      }
    } else {
      if (EmpresaController.podeUsarSistemaGratuito()) {
        podeRealizarVenda = true;
      } else {
        gerarDialogBoxInformacao(context, 'Apenas empresas MEI podem usar o sistema gratuito com emissão de recibo. Utilize o módulo NFC-e.');
      }
    }

    if (podeRealizarVenda) {
      _quantidadeInformada = 1;
      final digitouQuantidade = dadoInformado!.split('*');
      if (digitouQuantidade.length > 1) {
        _quantidadeInformada = double.tryParse(digitouQuantidade[0].replaceAll(',', '.'));
        dadoInformado = digitouQuantidade[1];
      }

      var campoParaConsulta = '';
      int? dadoNumerico = int.tryParse(dadoInformado);
      if (dadoNumerico != null) {
        if (dadoInformado.length == 13 || dadoInformado.length == 14) {
          campoParaConsulta = 'GTIN';
        } else {
          campoParaConsulta = 'CODIGO_INTERNO';
        }
      } else {
        campoParaConsulta = 'NOME';
      }
      _produtoMontado = await Sessao.db.produtoDao.consultarObjetoMontado(campo: campoParaConsulta, valor: dadoInformado);   

      if (_produtoMontado != null) {
        // TODO: mover esse código e da CaixaPage para um local central, talvez ProdutoController
        bool podeComporItemParaComanda = true;
        if (Sessao.configuracaoPdv!.moduloFiscalPrincipal == 'NFC') {
          // verifica se a tributação para o produto está OK antes mesmo de incluí-lo na comanda
          final tributacao = await Sessao.db.tributConfiguraOfGtDao.consultarObjetoMontado(
            Sessao.configuracaoPdv!.idTributOperacaoFiscalPadrao!, _produtoMontado!.tributGrupoTributario!.id!); 
          if (tributacao == null) {
            podeComporItemParaComanda = false;
            if (!mounted) return;
            gerarDialogBoxErro(context, 'Existe um problema com a tributação deste produto. Informe o Grupo Tributário para o Produto e vincule a Operação Fiscal para o mesmo na tela "Configura Tributação"');
          } else {
            podeComporItemParaComanda = true;
          }
        }
        if (podeComporItemParaComanda) {
          _comporItemParaComanda();
        }
      } else {
        _importarProduto(criterioPesquisa: dadoInformado);
      }
    }
    _focusNode.requestFocus();
  }

  Future _comporItemParaComanda() async {
    final quantidadeFutura = (_produtoMontado!.produto!.quantidadeEstoque ?? 0) - _quantidadeInformada!;

    if(Sessao.configuracaoPdv!.modulo != 'G' && _produtoMontado!.produto!.idTributGrupoTributario == null) {
      gerarDialogBoxInformacao(context, 'Produto sem Grupo Tributário vinculado.');
    } else if ((Sessao.configuracaoPdv!.permiteEstoqueNegativo ?? 'S') == 'N' && quantidadeFutura < 0) {
      gerarDialogBoxInformacao(context, 'Não é permitido vender um item com estoque negativo.');
    } else {
      ComandaDetalheMontado comandaDetalheMontado = 
      ComandaDetalheMontado(
        comandaDetalhe: ComandaDetalhe(
          id: null,
          idProduto: _produtoMontado!.produto!.id,
          idComanda: widget.comandaMontado.comanda!.id,
          quantidade: _quantidadeInformada,
          valorUnitario: _produtoMontado!.produto!.valorVenda,
          valorTotalComplemento: 0,
          valorTotal: _quantidadeInformada! * _produtoMontado!.produto!.valorVenda!,
          gerouPedidoCozinha: _produtoMontado!.produto!.ippt == 'P' ? 'S' : 'N', 
        ),
        produtoMontado: _produtoMontado,
        listaComandaDetalheComplemento: [],
      );

      // se tiver perguntas, chama a tela com perguntas e respostas
      if (comandaDetalheMontado.produtoMontado!.produto!.ippt == 'P') {
        await _tratarPerguntas(comandaDetalheMontado);
      }

      widget.comandaMontado.listaComandaDetalheMontado!.add(comandaDetalheMontado);

      setState(() {
        _atualizarTotais();
      });      
    }
  }

  void _importarProduto({String? criterioPesquisa}) async {
    Map<String, dynamic>? objetoJsonRetorno = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LookupLocalPage(
            title: 'Importar Produto',
            colunas: ProdutoDao.colunas,
            campos: ProdutoDao.campos,
            campoPesquisaPadrao: 'nome',
            valorPesquisaPadrao: (criterioPesquisa == null || criterioPesquisa == '') ? '%' : criterioPesquisa,
            metodoConsultaCallBack: _filtrarProdutoLookup,
            permiteCadastro: true,
            metodoCadastroCallBack: () { Navigator.pushNamed(context, '/produtoLista',); },
          ),
          fullscreenDialog: true,
        ));
    if (objetoJsonRetorno != null) {
      _localizarProduto(objetoJsonRetorno['gtin']);
    }    
  }  

  void _filtrarProdutoLookup(String campo, String valor) async {
    var listaFiltrada = await Sessao.db.produtoDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  void _excluirProduto({int? index, required bool perguntaAntes}) {
    if (perguntaAntes) {
      gerarDialogBoxExclusao(context, () async {
        setState(() {
          widget.comandaMontado.listaComandaDetalheMontado = List.from(widget.comandaMontado.listaComandaDetalheMontado!)..removeAt(index!);
          _atualizarTotais();
        });
      });
    } else {
      setState(() {
        widget.comandaMontado.listaComandaDetalheMontado = List.from(widget.comandaMontado.listaComandaDetalheMontado!)..removeAt(index!);
        _atualizarTotais();
      });
    }
    _focusNode.requestFocus();
  }
  
  Future _salvar() async {
    _atualizarTotais();
    await Sessao.db.comandaDao.alterar(widget.comandaMontado);
  }

  void _excluirComplemento(ComandaDetalheComplemento comandaDetalheComplemento, int index) {
    gerarDialogBoxExclusao(context, () {
      widget.comandaMontado.listaComandaDetalheMontado![index].listaComandaDetalheComplemento!
      .removeWhere((item) => item.idProduto == comandaDetalheComplemento.idProduto);
      // atualiza o valor total dos complementos no item
      widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe = 
      widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe!.copyWith(
        valorTotalComplemento: _atualizarValorComplemento(widget.comandaMontado.listaComandaDetalheMontado![index]),
      );
      setState(() {
        _atualizarTotais();
      });      
    });
  } 

  double _atualizarValorComplemento(ComandaDetalheMontado comandaDetalheMontado) {
    double valorTotalComplemento = 0;
    for (var complemento in comandaDetalheMontado.listaComandaDetalheComplemento!) {
      valorTotalComplemento += complemento.valorTotal!;
    }
    return valorTotalComplemento;
  }

  void _incrementarItem(int index) {
    setState(() {
      widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe = 
      widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe!.copyWith(
        quantidade: widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe!.quantidade! + 1,
        valorTotal: (widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe!.quantidade! + 1) 
          * widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe!.valorUnitario!,
      );
      _atualizarTotais();
    });
  }

  void _decrementarItem(int index) {
    if (widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe!.quantidade! > 1) {
      setState(() {
        widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe = 
        widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe!.copyWith(
          quantidade: widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe!.quantidade! - 1,
          valorTotal: (widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe!.quantidade! - 1) 
            * widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe!.valorUnitario!,
        );
        _atualizarTotais();
      });
    }
  }

  void _atualizarTotais() {
    double totalComplementos = 0;
    double totalItens = 0;
    for (var item in widget.comandaMontado.listaComandaDetalheMontado!) {
      totalItens = totalItens + item.comandaDetalhe!.valorTotal!;
      totalComplementos = totalComplementos + item.comandaDetalhe!.valorTotalComplemento!;
    }
    double totalGeral = totalItens + totalComplementos;
    final quantidadePessoas = widget.comandaMontado.comanda!.quantidadePessoas ?? 1;
    widget.comandaMontado.comanda = 
    widget.comandaMontado.comanda!.copyWith(
      valorSubtotal: totalGeral,
      valorDesconto: valorDesconto,
      valorTotal: totalGeral - valorDesconto,
      valorPorPessoa: Biblioteca.dividirMonetario(totalGeral - valorDesconto, quantidadePessoas),
    );
  }

  Future _tratarPerguntas(ComandaDetalheMontado comandaDetalheMontado) async {
    List<RespostasSelecionadas> listaRespostasSelecionadas = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ComandaCardapioPerguntaLookupPage(comandaDetalheMontado.produtoMontado!.cardapio!),
        fullscreenDialog: true,
      )
    );        

    var perguntaResposta = '';
    for (var i = 0; i < listaRespostasSelecionadas.length; i++) {
      perguntaResposta += '${listaRespostasSelecionadas[i].pergunta} [${listaRespostasSelecionadas[i].resposta}]\n'; 
    }

    final obsGravada = comandaDetalheMontado.comandaDetalhe!.observacao;

    if (obsGravada != null && obsGravada != '') {
      comandaDetalheMontado.comandaDetalhe = 
        comandaDetalheMontado.comandaDetalhe!.copyWith(observacao: '$obsGravada\n$perguntaResposta',);
    } else {
      comandaDetalheMontado.comandaDetalhe = 
        comandaDetalheMontado.comandaDetalhe!.copyWith(observacao: perguntaResposta,);
    }
    setState(() {
    }); 
  }

  Future _executarFuncaoMenuButtonItem(String operacaoValor) async {  
    final operacaoValorArray = operacaoValor.split(':'); 
    final operacao = operacaoValorArray[0];
    final valor = operacaoValorArray[1];
    final index = int.tryParse(valor)!;
    if (operacao == 'excluir') {
      _excluirProduto(index: index, perguntaAntes: true);
    } else if (operacao == 'observacao') {
      final retorno = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const ComandaObservacaoPadraoLookupPage(),
          fullscreenDialog: true,
        )
      );
      if (retorno is List<dynamic>) {
        var observacao = '';
        final obsGravada = widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe!.observacao;
        if (obsGravada != null && obsGravada != '') {
          observacao = obsGravada;
        }
        for (var i = 0; i < retorno.length; i++) {
          if (observacao == '') {
            observacao += retorno[i]; 
          } else {
            // ignore: prefer_interpolation_to_compose_strings
            observacao += '\n' + retorno[i]; 
          }
        }
        setState(() {
          widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe = 
          widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe!.copyWith(
            observacao: observacao,
          );
        });        
      }
    } else if (operacao == 'complemento') {
      Map<String, dynamic>? objetoJsonRetorno =
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
            LookupLocalPage(
              title: 'Importar Complemento',
              colunas: ProdutoDao.colunas,
              campos: ProdutoDao.campos,
              campoPesquisaPadrao: 'Nome',
              valorPesquisaPadrao: '%',
              metodoConsultaCallBack: _filtrarComplementoLookup,                                             
              permiteCadastro: false,
            ),
            fullscreenDialog: true,
          )
        );
      if (objetoJsonRetorno != null) {

        _produtoMontado = await Sessao.db.produtoDao.consultarObjetoMontado(campo: 'GTIN', valor: objetoJsonRetorno['gtin']);   

        if (_produtoMontado != null) {
          // TODO: mover esse código e da CaixaPage para um local central, talvez ProdutoController
          bool podeComporItemParaComanda = true;
          if (Sessao.configuracaoPdv!.moduloFiscalPrincipal == 'NFC') {
            // verifica se a tributação para o produto está OK antes mesmo de incluí-lo na comanda
            final tributacao = await Sessao.db.tributConfiguraOfGtDao.consultarObjetoMontado(
              Sessao.configuracaoPdv!.idTributOperacaoFiscalPadrao!, _produtoMontado!.tributGrupoTributario!.id!); 
            if (tributacao == null) {
              podeComporItemParaComanda = false;
              if (!mounted) return;
              gerarDialogBoxErro(context, 'Existe um problema com a tributação deste produto. Informe o Grupo Tributário para o Produto e vincule a Operação Fiscal para o mesmo na tela "Configura Tributação"');
            } else {
              podeComporItemParaComanda = true;
            }
          }
          if (podeComporItemParaComanda) {
            widget.comandaMontado.listaComandaDetalheMontado![index].listaComandaDetalheComplemento!.add(
              ComandaDetalheComplemento(
                id: null,
                idProduto: _produtoMontado!.produto!.id,
                nomeProduto: _produtoMontado!.produto!.nome,
                quantidade: 1,
                valorUnitario: _produtoMontado!.produto!.valorVenda,
                valorTotal: _produtoMontado!.produto!.valorVenda,                
              )
            );
            // atualiza o valor total dos complementos no item
            widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe = 
            widget.comandaMontado.listaComandaDetalheMontado![index].comandaDetalhe!.copyWith(
              valorTotalComplemento: _atualizarValorComplemento(widget.comandaMontado.listaComandaDetalheMontado![index]),
            );
            setState(() {
              _atualizarTotais();
            });      
          }
        }
      }    
    } else if (operacao == 'perguntas') {
      if (widget.comandaMontado.listaComandaDetalheMontado![index].produtoMontado!.produto!.ippt == 'P') {
        await _tratarPerguntas(widget.comandaMontado.listaComandaDetalheMontado![index] );
      } else {
        showInSnackBar('Produto não possui cardápio definido com perguntas e respostas', context);
      }

    }
  }

  Future _executarFuncaoMenuButtonGeral(String operacao) async {  
    if (operacao == 'salvar_dados') {
      await _salvar();
      if (!mounted) return;
      Navigator.pop(context);
    } else if (operacao == 'desconto') {
      final retorno = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const InformaValorPage(title: 'Desconto na Comanda', operacao: 'DESCONTO_COMANDA', ),
          fullscreenDialog: true,
        )
      ); 
      if (retorno != false) {
        valorDesconto = Biblioteca.calcularDesconto(widget.comandaMontado.comanda!.valorSubtotal!, retorno);
      }
      setState(() {
        _atualizarTotais();
      });
    } else if (operacao == 'imprimir_comanda') {
      await _salvar();
      if (!mounted) return;
      Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (BuildContext context) { 
            Sessao.comandaMontadoAtual = widget.comandaMontado;
            if (Sessao.configuracaoPdv!.reciboFormatoPagina == '80') {
              return const ComandaRelatorio80();
            } else {
              return const ComandaRelatorio80(); // TODO: implementar o relatório 57 
            }
          }))
        .then((_) {
        });     
    } else if (operacao == 'emitir_nota') {
      await _salvar();
      await _emitirNota();
    } else if (operacao == 'sair') {
      await _salvar();
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  void _filtrarComplementoLookup(String campo, String valor) async {
    var listaFiltrada = await Sessao.db.produtoDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  Future _emitirNota() async {
    Sessao.listaVendaAtualDetalhe = [];
    final taxaDesconto = Biblioteca.dividirMonetario(
      ((widget.comandaMontado.comanda!.valorDesconto ?? 0) * 100),
      (widget.comandaMontado.comanda!.valorSubtotal ?? 0)
    );

    Sessao.vendaAtual = 
      PdvVendaCabecalho(
        id: null, 
        idPdvMovimento: Sessao.movimento!.id, 
        idCliente: widget.comandaMontado.cliente?.id,
        idColaborador: widget.comandaMontado.colaborador?.id,
        statusVenda: 'A',
        dataVenda: DateTime.now(),
        horaVenda: Biblioteca.formatarHora(DateTime.now()),
        tipoOperacao: Sessao.configuracaoPdv!.moduloFiscalPrincipal ?? 'REC',
        taxaDesconto: taxaDesconto,
      );
    int idInserido = await Sessao.db.pdvVendaCabecalhoDao.inserir(Sessao.vendaAtual!);
    Sessao.vendaAtual = await Sessao.db.pdvVendaCabecalhoDao.consultarObjeto(idInserido);

    // monta a lista da venda
    for (var item in widget.comandaMontado.listaComandaDetalheMontado!) {
      VendaDetalhe vendaDetalheItem = VendaDetalhe(
        pdvVendaDetalhe: PdvVendaDetalhe(
          id: null, 
          idProduto: item.produtoMontado!.produto!.id,
          gtin: item.produtoMontado!.produto!.gtin == '' ? item.produtoMontado!.produto!.id.toString() : item.produtoMontado!.produto!.gtin,
          cst: item.produtoMontado!.produto!.cst,
          movimentaEstoque: item.produtoMontado!.produto!.ippt == 'T' ? 'S' : 'N', 
          quantidade: item.comandaDetalhe!.quantidade!,
          valorUnitario: item.comandaDetalhe!.valorUnitario,
          valorTotalItem: item.comandaDetalhe!.valorTotal,
          valorTotal: item.comandaDetalhe!.valorTotal,            
        ),
        produto: item.produtoMontado!.produto,
      );
      Sessao.listaVendaAtualDetalhe.add(vendaDetalheItem);
      for (var complemento in item.listaComandaDetalheComplemento!) {
        final produto = await Sessao.db.produtoDao.consultarObjeto(complemento.idProduto!);
        VendaDetalhe vendaDetalheComplemento = VendaDetalhe(
          pdvVendaDetalhe: PdvVendaDetalhe(
            id: null, 
            idProduto: produto!.id,
            gtin: produto.gtin == '' ? produto.id.toString() : produto.gtin,
            cst: produto.cst,
            movimentaEstoque: produto.ippt == 'T' ? 'S' : 'N', 
            quantidade: complemento.quantidade!,
            valorUnitario: complemento.valorUnitario,
            valorTotalItem: complemento.valorTotal,
            valorTotal: complemento.valorTotal,            
          ),
          produto: produto,
        );
        Sessao.listaVendaAtualDetalhe.add(vendaDetalheComplemento);
      }
    }
    if (!mounted) return;
    Sessao.emitirNotaDaComanda(context);
  }

}