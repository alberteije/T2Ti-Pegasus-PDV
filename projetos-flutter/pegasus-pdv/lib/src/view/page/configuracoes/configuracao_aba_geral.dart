/*
Title: T2Ti ERP 3.0                                                                
Description: Página de configuração - Aba Geral
                                                                                
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/controller/controller.dart';

import 'package:pegasus_pdv/src/view/shared/page/lookup_local_page.dart';
import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

class ConfiguracaoAbaGeral extends StatefulWidget {
  
  @override
  _ConfiguracaoAbaGeralState createState() => _ConfiguracaoAbaGeralState();
}

class _ConfiguracaoAbaGeralState extends State<ConfiguracaoAbaGeral> {
  bool _permiteEstoqueNegativo = Sessao.configuracaoPdv.permiteEstoqueNegativo == 'S' ? true : false;
  String _formatoPagina = Sessao.configuracaoPdv.reciboFormatoPagina;
  double _larguraPagina = Sessao.configuracaoPdv.reciboLarguraPagina ?? 57;
  double _margensPagina = Sessao.configuracaoPdv.reciboMargemPagina ?? 5;
  double _larguraPaginaSlider = 100;
  final _importaTributOperacaoFiscalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _refrescarTela());
  }

  @override
  Widget build(BuildContext context) {
    // carrega o formato de acordo com o que tem no banco de dados
    switch (_formatoPagina) {
      case 'A4' : 
        _formatoPagina = Constantes.impressaoFormularioA4;
        _larguraPaginaSlider = 100;
        _larguraPagina = 100;
        break;
      case '57' : 
        _formatoPagina = Constantes.impressaoBobina57;
        _larguraPaginaSlider = 57;
        _larguraPagina = _larguraPagina > 57 ? 57 : _larguraPagina;
        break;
      case '80' : 
        _formatoPagina = Constantes.impressaoBobina80;
        _larguraPaginaSlider = 80;
        _larguraPagina = _larguraPagina > 80 ? 80 : _larguraPagina;
        break;
      default:
    }    
   
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        body: bodyData(),
      ),
    );
  }

  Widget bodyData() => SingleChildScrollView(
    child: Theme(
      data: ThemeData(fontFamily: Constantes.ralewayFont),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _pegarCabecalho(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _pegarConteudoPagina(),
          ),
        ],
      ),
    ),
  );

  Padding _pegarCabecalho() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                child: Material(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  elevation: 5.0,
                  color: Colors.blueGrey.shade100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Configurações Gerais',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Utilize esse espaço para configurar a aplicação', textAlign: TextAlign.center,),                
                      ),                      
                      Divider(
                        indent: 10,
                        endIndent: 10,
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  List<Widget> _pegarConteudoPagina() {
    List<Widget> listaConteudo = [];
    listaConteudo.add(
      // Recibo
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Recibo",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 18,
              ),
            ),
            Divider(color: Colors.grey),
          ],
        )
      ),
    );
    listaConteudo.add(
      Card(
        color: Colors.white,
        elevation: 2.0,
        child: Column(
          children: <Widget>[
            ExpansionTile(
              leading: Icon(
                Icons.document_scanner,
                color: Colors.blue,
              ),
              key: GlobalKey(),
              title: 
                Biblioteca.isTelaPequena(context) 
                ? Text('Formato Página: ' + _formatoPagina)
                : Text('Formato da Página: ' + _formatoPagina),                             
              backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
              children: <Widget>[
                ListTile(
                  title: const Text(Constantes.impressaoFormularioA4),
                  onTap: () {
                    setState(() {
                      _formatoPagina = Constantes.impressaoFormularioA4;
                      _larguraPaginaSlider = 100;
                    });
                  },              
                ),
                ListTile(
                  title: const Text(Constantes.impressaoBobina57),
                  onTap: () {
                    setState(() {
                      _formatoPagina = Constantes.impressaoBobina57;
                      _larguraPaginaSlider = 57;
                      _larguraPagina = _larguraPagina > 57 ? 57 : _larguraPagina;
                    });
                  },              
                ),
                ListTile(
                  title: const Text(Constantes.impressaoBobina80),
                  onTap: () {
                    setState(() {
                      _formatoPagina = Constantes.impressaoBobina80;
                      _larguraPaginaSlider = 80;
                      _larguraPagina = _larguraPagina > 80 ? 80 : _larguraPagina;
                    });
                  },              
                ),
              ]
            ),                    
            Visibility(
              visible: _formatoPagina != Constantes.impressaoFormularioA4,
              child: ListTile(
                contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 2),
                leading: Wrap( 
                  spacing: 12,
                  children: [
                    SizedBox(width: 1,),
                    Icon(
                      Icons.amp_stories_outlined,
                      color: Colors.grey,
                    ),
                  ]
                ),
                title: 
                  Biblioteca.isTelaPequena(context) 
                  ? Text("Largura [" + _larguraPagina.toString() + "]")
                  : Text("Largura Página [" + _larguraPagina.toString() + "]"),                    
                trailing:
                Container(
                  width: Biblioteca.isTelaPequena(context) ? 200 : 200,
                  child: SliderTheme(
                    data: ViewUtilLib.sliderThemeData(context),
                    child: Slider(
                      value: _larguraPagina,
                      min: 0,
                      max: _larguraPaginaSlider,
                      divisions: _larguraPaginaSlider.toInt(),
                      label: '$_larguraPagina',
                      onChanged: (value) {
                        setState(
                          () {
                            _larguraPagina = value;
                          },
                        );
                      },
                    ),
                  ),    
                ),
              ),
            ),
            Visibility(
              visible: _formatoPagina != Constantes.impressaoFormularioA4,
              child: ListTile(
                contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 2),
                leading: Wrap( 
                  spacing: 12,
                  children: [
                    SizedBox(width: 1,),
                    Icon(
                      Icons.ad_units_outlined,
                      color: Colors.grey,
                    ),
                  ]
                ),
                title: 
                  Biblioteca.isTelaPequena(context) 
                  ? Text("Margens [" + _margensPagina.toString() + "]")
                  : Text("Margens Página [" + _margensPagina.toString() + "]"),                    
                trailing:
                Container(
                  width: Biblioteca.isTelaPequena(context) ? 150 : 200,
                  child: SliderTheme(
                    data: ViewUtilLib.sliderThemeData(context),
                    child: Slider(
                      value: _margensPagina,
                      min: 0,
                      max: 5,
                      divisions: 5,
                      label: '$_margensPagina',
                      onChanged: (value) {
                        setState(
                          () {
                            _margensPagina = value;
                          },
                        );
                      },
                    ),
                  ),    
                ),
              ),
            ),
          ],
        ),
      ),
    );
    listaConteudo.add(
      // Recibo
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Outros",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 18,
              ),
            ),
            Divider(color: Colors.grey),
          ],
        )
      ),
    );
    listaConteudo.add(
      Card(
        color: Colors.white,
        elevation: 2.0,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.now_widgets_sharp,
                color: Colors.red,
              ),
              title: Text("Permite Venda com Estoque Negativo"),
              trailing: CupertinoSwitch(
                value: _permiteEstoqueNegativo,
                onChanged: (val) {
                  _permiteEstoqueNegativo = !_permiteEstoqueNegativo;
                  setState(() {});
                },
              )
            ),
            Visibility(
              visible: Sessao.configuracaoPdv.modulo != 'G',
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: TextFormField(
                          controller: _importaTributOperacaoFiscalController,
                          readOnly: true,
                          decoration: getInputDecoration(
                            'Importe a Operação Fiscal Padrão',
                            'Operação Fiscal Padrão',
                            false),
                          onSaved: (String value) {
                          },
                          validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
                          onChanged: (text) {
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: IconButton(
                        tooltip: 'Importar Operação Fiscal',
                        icon: ViewUtilLib.getIconBotaoLookup(),
                        onPressed: () async {
                          ///chamando o lookup
                          Map<String, dynamic> _objetoJsonRetorno =
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                  LookupLocalPage(
                                    title: 'Importar Operação Fiscal',
                                    colunas: TributOperacaoFiscalDao.colunas,
                                    campos: TributOperacaoFiscalDao.campos,
                                    campoPesquisaPadrao: 'descricao',
                                    valorPesquisaPadrao: '%',
                                    metodoConsultaCallBack: TributOperacaoFiscalController.filtrarOperacaoFiscalLookup,
                                  ),
                                  fullscreenDialog: true,
                                ));
                          if (_objetoJsonRetorno != null) {
                            if (_objetoJsonRetorno['descricao'] != null) {
                              Sessao.configuracaoPdv = 
                              Sessao.configuracaoPdv.copyWith(
                                idTributOperacaoFiscalPadrao: _objetoJsonRetorno['id'],
                              );                                
                              await _refrescarTela();
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),							
              ),
            ),
          ],
        ),
      ),
    );
    return listaConteudo;
  }

  Future<bool> _willPopCallback() async {
    switch (_formatoPagina) {
      case Constantes.impressaoFormularioA4 : 
        _formatoPagina = 'A4';
        break;
      case Constantes.impressaoBobina57 : 
        _formatoPagina = '57';
        break;
      case Constantes.impressaoBobina80 : 
        _formatoPagina = '80';
        break;
      default:
    }    

    Sessao.configuracaoPdv = 
    Sessao.configuracaoPdv.copyWith(
      reciboFormatoPagina: _formatoPagina,
      reciboLarguraPagina: _larguraPagina,
      reciboMargemPagina: _margensPagina,
      permiteEstoqueNegativo: _permiteEstoqueNegativo ? 'S' : 'N',
    );
    await Sessao.db.pdvConfiguracaoDao.alterar(Sessao.configuracaoPdv);
    return true;
  }

  Future _refrescarTela() async {
    if (Sessao.configuracaoPdv.idTributOperacaoFiscalPadrao != null) {
      final operacaoFiscal = await Sessao.db.tributOperacaoFiscalDao.consultarObjeto(Sessao.configuracaoPdv.idTributOperacaoFiscalPadrao);
      _importaTributOperacaoFiscalController.text = operacaoFiscal.descricao;
      setState(() {
      });
    }
  }  
}