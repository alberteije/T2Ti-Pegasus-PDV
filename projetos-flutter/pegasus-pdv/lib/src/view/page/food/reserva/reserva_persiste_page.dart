/*
Title: T2Ti ERP 3.0                                                                
Description: PersistePage relacionada à tabela [RESERVA] 
                                                                                
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
import 'package:flutter/gestures.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';
import 'package:pegasus_pdv/src/view/page/page.dart';
import 'package:pegasus_pdv/src/view/shared/page/lookup_local_page.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

import 'package:extended_masked_text/extended_masked_text.dart';

class ReservaPersistePage extends StatefulWidget {
  final ReservaMontado? reservaMontado;
  final String? title;
  final String? operacao;

  const ReservaPersistePage({Key? key, this.reservaMontado, this.title, this.operacao})
      : super(key: key);

  @override
  _ReservaPersistePageState createState() => _ReservaPersistePageState();
}

class _ReservaPersistePageState extends State<ReservaPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _formFoiAlterado = false;

  Map<LogicalKeySet, Intent>? _shortcutMap; 
  Map<Type, Action<Intent>>? _actionMap;
  final _foco = FocusNode();

  Reserva? _reserva;
  List<Mesa> listaMesa = [];

  @override
  void initState() {
    super.initState();
    bootstrapGridParameters(
      gutterSize: Constantes.flutterBootstrapGutterSize,
    );

    _shortcutMap = getAtalhosPersistePage();

    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };
    _reserva = widget.reservaMontado!.reserva;
    _foco.requestFocus();
    listaMesa = widget.reservaMontado?.listaMesa ?? [];
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.excluir:
        _excluir();
        break;
      case AtalhoTelaType.salvar:
        _salvar();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {	
    final _importaClienteController = TextEditingController();
    _importaClienteController.text =  widget.reservaMontado?.cliente?.nome ?? ''; 
    final _horaReservaController = MaskedTextController(
      mask: Constantes.mascaraHORA,
      text: _reserva?.horaReserva ?? '',
    );
    final _telefoneContatoController = MaskedTextController(
      mask: Constantes.mascaraTELEFONE,
      text: _reserva?.telefoneContato ?? '',
    );
	  final _contatoController = TextEditingController(
      text: _reserva?.nomeContato ?? ''
    );
    final _quantidadePessoasController = MoneyMaskedTextController(
      decimalSeparator: '',
      thousandSeparator: '',    
      precision: 0, 
      initialValue: _reserva?.quantidadePessoas?.toDouble() ?? 0,
    );

    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        autofocus: true,
        child: Scaffold(drawerDragStartBehavior: DragStartBehavior.down,
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(widget.title!), 
            actions: widget.operacao == 'I'
              ? getBotoesAppBarPersistePage(context: context, salvar: _salvar,)
              : getBotoesAppBarPersistePageComExclusao(context: context, salvar: _salvar, excluir: _excluir),
          ),      
          body: SafeArea(
            top: false,
            bottom: false,
            child: Form(
              key: _formKey,
              autovalidateMode: _autoValidate,
              onWillPop: _avisarUsuarioFormAlterado,
              child: Scrollbar(
                child: SingleChildScrollView(
                  dragStartBehavior: DragStartBehavior.down,
                  child: Column(
                    children: [
                      BootstrapContainer(
                        fluid: true,
                        decoration: const BoxDecoration(color: Colors.white),
                        padding: Biblioteca.isTelaPequena(context) == true ? ViewUtilLib.paddingBootstrapContainerTelaPequena : ViewUtilLib.paddingBootstrapContainerTelaGrande,
                        children: <Widget>[
                          const Divider(color: Colors.white,),
                          BootstrapRow(
                            height: 60,
                            children: <BootstrapCol>[
                              BootstrapCol(
                                sizes: 'col-12',
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        child: TextFormField(
                                          // validator: ValidaCampoFormulario.validarObrigatorio,
                                          controller: _importaClienteController,
                                          readOnly: true,
                                          decoration: getInputDecoration(
                                            'Conteúdo para o campo Cliente',
                                            'Cliente *',
                                            false),
                                          onSaved: (String? value) {
                                          },
                                          onChanged: (text) {
                                            _formFoiAlterado = true;
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 0,
                                      child: IconButton(
                                        tooltip: 'Importar Cliente',
                                        icon: ViewUtilLib.getIconBotaoLookup(),
                                        onPressed: () async {
                                          ///chamando o lookup
                                          Map<String, dynamic>? _objetoJsonRetorno =
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                LookupLocalPage(
                                                  title: 'Importar Cliente',
                                                  colunas: ClienteDao.colunas,
                                                  campos: ClienteDao.campos,
                                                  campoPesquisaPadrao: 'Nome',
                                                  valorPesquisaPadrao: '%',
                                                  metodoConsultaCallBack: _filtrarClienteLookup,                                             
                                                  permiteCadastro: true,
                                                  metodoCadastroCallBack: () { Navigator.pushNamed(context, '/clienteLista',); },
                                                ),
                                                fullscreenDialog: true,
                                              ));
                                          if (_objetoJsonRetorno != null) {
                                            if (_objetoJsonRetorno['nome'] != null) {
                                              _importaClienteController.text = _objetoJsonRetorno['nome'];
                                              _contatoController.text = _objetoJsonRetorno['nome'];
                                              _reserva = _reserva!.copyWith(idCliente: _objetoJsonRetorno['id']);
                                              widget.reservaMontado!.cliente = widget.reservaMontado!.cliente!.copyWith(
                                                nome: _objetoJsonRetorno['nome'],
                                              );          
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(color: Colors.white,),
                          BootstrapRow(
                            height: 60,
                            children: <BootstrapCol>[
                              BootstrapCol(
                                sizes: 'col-12 col-md-6',
                                child: Padding(
                                  padding: Biblioteca.distanciaEntreColunasQuebraLinha(context)!,
                                  child: InputDecorator(
                                    decoration: getInputDecoration(
                                      'Informe a Data Reserva',
                                      'Data Reserva',
                                      true,
                                      erroSeVazio: _reserva!.dataReserva == null),
                                    isEmpty: _reserva!.dataReserva == null,
                                    child: DatePickerItem(
                                      mascara: 'dd/MM/yyyy',
                                      dateTime: _reserva!.dataReserva,
                                      firstDate: DateTime.parse('1900-01-01'),
                                      lastDate:DateTime.parse('2100-01-01'),
                                      onChanged: (DateTime? value) {
                                          _formFoiAlterado = true;
                                          setState(() {
                                            _reserva = _reserva!.copyWith(dataReserva: Biblioteca.removerTempoDaData(value));
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              BootstrapCol(
                                sizes: 'col-12 col-md-6',
                                child: Padding(
                                  padding: Biblioteca.distanciaEntreColunasQuebraLinha(context)!,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: _horaReservaController,
                                    decoration: getInputDecoration(
                                      'Informe a Hora Reserva',
                                      'Hora Reserva',
                                      true,
                                      paddingVertical: 15),
                                      onSaved: (String? value) {
                                    },
                                    validator: ValidaCampoFormulario.validarHORA,
                                    onChanged: (text) {
                                      _reserva = _reserva!.copyWith(horaReserva: text);
                                      _formFoiAlterado = true;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(color: Colors.white,),
                          BootstrapRow(
                            height: 60,
                            children: <BootstrapCol>[
                              BootstrapCol(
                                sizes: 'col-12',
                                child: TextFormField(
                                  validator: ValidaCampoFormulario.validarObrigatorio,
                                  maxLength: 100,
                                  maxLines: 1,
                                  controller: _contatoController,
                                  decoration: getInputDecoration(
                                    'Informe o Contato',
                                    'Contato',
                                    false),
                                  onSaved: (String? value) {
                                  },
                                  onChanged: (text) {
                                    _reserva = _reserva!.copyWith(nomeContato: text);
                                    _formFoiAlterado = true;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Divider(color: Colors.white,),
                          BootstrapRow(
                            height: 60,
                            children: <BootstrapCol>[
                              BootstrapCol(
                                sizes: 'col-12 col-md-6',
                                child: Padding(
                                  padding: Biblioteca.distanciaEntreColunasQuebraLinha(context)!,
                                  child: TextFormField(
                                    validator: ValidaCampoFormulario.validarNumericoMaiorQueZero,
                                    keyboardType: TextInputType.number,
                                    controller: _quantidadePessoasController,
                                    decoration: getInputDecoration(
                                      'Informe a Quantidade de Pessoas',
                                      'Quantidade de Pessoas',
                                      false),
                                    onSaved: (String? value) {
                                    },
                                    onChanged: (text) {
                                      _reserva = _reserva!.copyWith(quantidadePessoas: _quantidadePessoasController.numberValue.toInt());
                                      _formFoiAlterado = true;
                                    },
                                  ),
                                ),
                              ),
                              BootstrapCol(
                                sizes: 'col-12 col-md-6',
                                child: Padding(
                                  padding: Biblioteca.distanciaEntreColunasQuebraLinha(context)!,
                                  child: TextFormField(
                                    validator: ValidaCampoFormulario.validarObrigatorio,
                                    keyboardType: TextInputType.number,
                                    controller: _telefoneContatoController,
                                    decoration: getInputDecoration(
                                      'Informe o Telefone',
                                      'Telefone',
                                      false),
                                    onSaved: (String? value) {
                                    },
                                    onChanged: (text) {
                                      _reserva = _reserva!.copyWith(telefoneContato: text);
                                      _formFoiAlterado = true;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(color: Colors.white,),
                          BootstrapRow(
                            height: 60,
                            children: <BootstrapCol>[
                              BootstrapCol(
                                sizes: 'col-12',
                                child: 
                                  Text(
                                    '* indica que o campo é obrigatório',
                                    style: Theme.of(context).textTheme.caption,
                                  ),								
                              ),
                            ],
                          ),
                          // const Divider(color: Colors.white,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200,
                                child: getBotaoGenericoPdv(
                                  descricao: 'Selecionar Mesas',
                                  cor: Colors.green, 
                                  onPressed: _selecionarMesas,
                                ),
                              ), 
                              const SizedBox(
                                width: 10,
                              ), 
                              SizedBox(
                                width: 200,
                                child: getBotaoGenericoPdv(
                                  descricao: 'Cancelar Reserva',
                                  cor: Colors.red, 
                                  onPressed: () async {
                                    _reserva = _reserva!.copyWith(situacao: 'C');
                                    await _salvar();
                                  }
                                ),
                              ), 
                            ],
                          ),
                          const SizedBox(height: 50.0),
                        ],        
                      ),
                      Visibility(
                        visible: listaMesa.isNotEmpty,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 0),
                              child: Text(
                                "Mesas selecionadas para a reserva", 
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                            const Divider(
                              indent: 10,
                              endIndent: 10,
                              thickness: 2,
                            ),                            
                            Card(
                              color: Colors.blueGrey[900],
                              margin: const EdgeInsets.all(16),
                              elevation: 4,
                              child: CustomScrollView(
                                shrinkWrap: true,
                                slivers: <Widget>[
                                  gridComMesas(),
                                ],
                              ),
                            ),
                          ],
                        ) 
                      ),
                    ],
                  ),
                ),
              ),			  
            ),
          ),
        ),
      ),
    );
  }

  void _filtrarClienteLookup(String campo, String valor) async {
    final listaFiltrada = await Sessao.db.clienteDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }
  
  Future _selecionarMesas() async {
    if (_reserva!.dataReserva == null) {
      showInSnackBar('Por favor, informe a data da reserva.', context);
    } else {
      final retorno = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => MesaPage(
            title: 'Reserva de Mesa',
            reserva: _reserva,
            operacao: 'RES',
          ),
          fullscreenDialog: true,
        )
      );   
      if (retorno != null) {
        listaMesa = retorno;
        setState(() {
        });
      }                             
    }
  }  

  Future _salvar() async {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      _autoValidate = AutovalidateMode.always;
      showInSnackBar(Constantes.mensagemCorrijaErrosFormSalvar, context);
    } else {
      gerarDialogBoxConfirmacao(context, Constantes.perguntaSalvarAlteracoes, () async {
        form.save();
        if (listaMesa.isEmpty) {
          showInSnackBar("Selecione a(s) mesa(s) para confirmar a reserva!", context, corFundo: Colors.red);
        } else {
          if (widget.operacao == 'A') {
            await Sessao.db.reservaDao.alterar(_reserva!, listaMesa);
          } else {
            _reserva = _reserva!.copyWith(situacao: 'A');
            await Sessao.db.reservaDao.inserir(_reserva!, listaMesa);
          }
          Navigator.of(context).pop();
          showInSnackBar("Registro salvo com sucesso!", context, corFundo: Colors.green);
        }
      });
    }
  }

  Future<bool> _avisarUsuarioFormAlterado() async {
    final FormState? form = _formKey.currentState;
    if (form == null || !_formFoiAlterado) {
      return true;
    } else {
      await (gerarDialogBoxFormAlterado(context));
      return false;
    }
  }
  
  void _excluir() {
    gerarDialogBoxExclusao(context, () async {
	  await Sessao.db.reservaDao.excluir(_reserva!);
      Navigator.of(context).pop();
      showInSnackBar("Registro excluído com sucesso!", context, corFundo: Colors.green);
    });
  }  

  /// ==================================================================================================================
  /// o código abaixo monta a grid com as mesas de forma estática para o usuário visualizar as mesas da reserva
  /// ==================================================================================================================
  Widget gridComMesas() {
    return SliverPadding(
      padding: const EdgeInsets.all(5.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: definirQuantidadeDeCartoesPorLinha(context),
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 1.0,
        ),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return mesaStack(index);
        }, childCount: listaMesa.length),
      )
    );
  }

  int definirQuantidadeDeCartoesPorLinha(BuildContext context) {
    double larguraDaTela = MediaQuery.of(context).size.width;
    int larguraDoCartao = 100;
    int quantidadePorLinha = larguraDaTela ~/ larguraDoCartao;
    return quantidadePorLinha;
  }

  Widget mesaStack(int index) {
    return InkWell(
      canRequestFocus: false,
      hoverColor: Colors.black38,
      onTap: () {
      },
      splashColor: Colors.black,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2.0,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            mesaImage(listaMesa[index]),
            mesaColor(listaMesa[index]),
            mesaData(listaMesa[index]),
          ],
        ),
      ),
    );
  }

  //stack 1/3 - primeira porção da pilha - a imagem - fica na parte de baixo do Stack
  Widget mesaImage(Mesa mesa) => Image.asset(
    int.tryParse(mesa.numero!)!.isEven ? Constantes.mesaImage02 : Constantes.mesaImage02,
    fit: BoxFit.cover,
  );

  //stack 2/3 - segunda porção da pilha - a cor com a opacidade
  Widget mesaColor(Mesa mesa) => Container(
    decoration: BoxDecoration(boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.yellow.withOpacity(0.6),
        blurRadius: 50.0, // efeito de fumaça
      ),
    ]),
  );

  //stack 3/3 - terceira porção da pilha - ícone e texto
  Widget mesaData(Mesa mesa) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 20,
          foregroundDecoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xff536dfe), Color(0xff8e99f3)]), backgroundBlendMode: BlendMode.multiply,),      
          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${mesa.quantidadeCadeiras}', style: const TextStyle(fontSize: 14.0, color: Colors.white)),
              Text('${mesa.quantidadeCadeirasCrianca ?? '0'}', style: const TextStyle(fontSize: 14.0, color: Colors.white)),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[      
            Text(mesa.numero.toString(), style: const TextStyle(fontSize: 40.0, color: Colors.black54, fontWeight: FontWeight.bold)),
          ],
        ),
        Container(
          height: 15,
          foregroundDecoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xff536dfe), Color(0xff8e99f3)]), backgroundBlendMode: BlendMode.multiply,),      
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text((mesa.observacao?.isNotEmpty ?? false) ? 'OBS' : '', style: const TextStyle(fontSize: 10.0, color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
  
}