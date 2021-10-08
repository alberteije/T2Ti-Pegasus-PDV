/*
Title: T2Ti ERP 3.0                                                                
Description: Página de configuração - Aba NFC-e
                                                                                
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
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/model/model.dart';
import 'package:pegasus_pdv/src/service/service.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

class ConfiguracaoAbaNfce extends StatefulWidget {
  
  @override
  _ConfiguracaoAbaNfceState createState() => _ConfiguracaoAbaNfceState();
}

class _ConfiguracaoAbaNfceState extends State<ConfiguracaoAbaNfce> {
  String _arquivoCertificadoBase64;
  String  _textoInformativo = '';
  String _ambiente = Sessao.configuracaoNfce.webserviceAmbiente?.toString() ?? '2';
  String _formatoImpressaoDanfe = Sessao.configuracaoNfce.formatoImpressaoDanfe?.toString() ?? '4';
  bool _imprimirItensUmaLinha = Sessao.configuracaoNfce.nfceImprimirItensUmaLinha == 'S' ? true : false;
  bool _imprimirDescontoPorItem = Sessao.configuracaoNfce.nfceImprimirDescontoPorItem == 'S' ? true : false;
  bool _imprimirQRCodeNaLateral = Sessao.configuracaoNfce.nfceImprimirQrcodeLateral == 'S' ? true : false;
  bool _imprimirGtin = Sessao.configuracaoNfce.nfceImprimirGtin == 'S' ? true : false;
  bool _imprimirNomeFantasia = Sessao.configuracaoNfce.nfceImprimirNomeFantasia == 'S' ? true : false;
  final _numeroController = MaskedTextController(
    mask: '000000000',
    text: Sessao.numeroNfce.numero?.toString() ?? '1',
  );
  final _serieController = MaskedTextController(
    mask: '000',
    text: Sessao.numeroNfce.serie ?? '1',
  );
  final _idCscController = MaskedTextController(
    mask: '0000000000',
    text: Sessao.configuracaoNfce.nfceIdCsc ?? '0',
  );
  final _cnpjController = MaskedTextController(
    mask: Constantes.mascaraCNPJ,
    text: Sessao.configuracaoNfce.respTecCnpj ?? '',
  );
  final _telefoneController = MaskedTextController(
    mask: Constantes.mascaraTELEFONE,
    text: Sessao.configuracaoNfce.respTecFone ?? '',
  );
  final _idCsrtController = MaskedTextController(
    mask: '00',
    text: Sessao.configuracaoNfce.respTecIdCsrt ?? '0',
  );
  final _hashCsrtController = MaskedTextController(
    mask: '0000000000000000000000000000', // 28 caracteres
    text: Sessao.configuracaoNfce.respTecHashCsrt ?? '0',
  );
  final _cscController = TextEditingController(text: Sessao.configuracaoNfce.nfceCsc ?? '');
  final _emailRespTecController = TextEditingController(text: Sessao.configuracaoNfce.respTecEmail ?? '');
  final _contatoRespTecController = TextEditingController(text: Sessao.configuracaoNfce.respTecContato ?? '');
  final _nomeCertificadoController = TextEditingController(text: Sessao.configuracaoNfce.certificadoDigitalCaminho ?? '');
  final _senhaCertificadoController = TextEditingController(
    text: Sessao.configuracaoNfce.certificadoDigitalSenha != null ? Constantes.encrypter.decrypt64(Sessao.configuracaoNfce.certificadoDigitalSenha, iv: Constantes.iv) : ''
  );

  String _formatoPagina = Sessao.configuracaoNfce.nfceModeloImpressao ?? Constantes.impressaoFormularioA4;
  int _resolucaoPagina = Sessao.configuracaoNfce.nfceResolucaoImpressao ?? 302; // no ACBrMonitor existe a propriedade Width (largura), mas sua unidade é em DPI
  double _margemSuperior = Sessao.configuracaoNfce.nfceMargemSuperior ?? 0.8;
  double _margemInferior = Sessao.configuracaoNfce.nfceMargemInferior ?? 0.8;  
  double _margemEsquerda = Sessao.configuracaoNfce.nfceMargemEsquerda ?? 0.7;
  double _margemDireita = Sessao.configuracaoNfce.nfceMargemDireita ?? 0.7;
  int _tamanhoFonteItem = Sessao.configuracaoNfce.nfceTamanhoFonteItem ?? 7;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (_formatoPagina) {
      case 'A4' : 
        _formatoPagina = Constantes.impressaoFormularioA4;
        break;
      case '57' : 
        _formatoPagina = Constantes.impressaoBobina57;
        break;
      case '80' : 
        _formatoPagina = Constantes.impressaoBobina80;
        break;
      default:
    }    

    if (Sessao.configuracaoPdv.moduloFiscalPrincipal != 'NFC') {
      _textoInformativo = 'Após a contratação do plano NFC-e, você poderá configurar os dados da NFC-e aqui';
    } else {
      _textoInformativo = 'Utilize esse espaço para configurar a Nota Fiscal de Consumidor Eletrônica - NFC-e';        
    }

    return Scaffold(
      body: bodyData(),
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
                        'Configurações da NFC-e',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(_textoInformativo, textAlign: TextAlign.center,),                
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
    if (Sessao.configuracaoPdv.moduloFiscalPrincipal == 'NFC') {      
      listaConteudo.add(
        // Certificado Digital
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Certificado Digital",
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
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: TextFormField(
                          controller: _nomeCertificadoController,
                          readOnly: true,
                          decoration: getInputDecoration(
                            'Importe o arquivo do Certificado Digital A1',
                            'Certificado Digital A1',
                            false),
                          onSaved: (String value) {
                          },
                          // validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
                          onChanged: (text) {
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: IconButton(
                        tooltip: 'Importar arquivo do Certificado Digital A1',
                        icon: Icon(Icons.file_copy),
                        onPressed: () async {
                          // Documentação: https://github.com/miguelpruivo/flutter_file_picker/wiki
                          FilePickerResult arquivoSelecionado = 
                            await FilePicker.platform.pickFiles(
                              type: FileType.custom, 
                              allowedExtensions: ['pfx'],
                              dialogTitle: 'Selecione o Certificado Digital PFX'
                            );
                            if(arquivoSelecionado != null) {
                              File file = File(arquivoSelecionado.files.first.path);
                              _arquivoCertificadoBase64 = base64.encode(file.readAsBytesSync());
                              _nomeCertificadoController.text = arquivoSelecionado.files[0].name;
                            }                          
                        },
                      ),
                    ),
                  ],
                ),							
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  controller: _senhaCertificadoController,
                  obscureText: true,
                  decoration: getInputDecoration(
                    'Senha do Certificado Digital',
                    'Senha Certificado',
                    false),
                  onSaved: (String value) {
                  },
                  onChanged: (text) {
                  },
                ),                
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _getBotaoEnviarCertificadoDigital(),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      );
      listaConteudo.add(
        // Impressão DANFE
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Impressão DANFE",
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
                      });
                    },              
                  ),
                  ListTile(
                    title: const Text(Constantes.impressaoBobina57),
                    onTap: () {
                      setState(() {
                        _formatoPagina = Constantes.impressaoBobina57;
                      });
                    },              
                  ),
                  ListTile(
                    title: const Text(Constantes.impressaoBobina80),
                    onTap: () {
                      setState(() {
                        _formatoPagina = Constantes.impressaoBobina80;
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
                  title: Text("Resolução Impressão",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Biblioteca.isTelaPequena(context) ? 14.0 : 16.0
                          ),
                        ),                    
                  trailing:
                  Container(
                    width: Biblioteca.isTelaPequena(context) ? 140 : 200,
                    child: SliderTheme(
                      data: ViewUtilLib.sliderThemeData(context),
                      child: SpinBox( 
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: Biblioteca.isTelaPequena(context) ? 14.0 : 16.0
                        ),
                        max: 310.0,
                        min: 1,
                        value: _resolucaoPagina.toDouble(),
                        decimals: 1,
                        step: 1,
                        onChanged: (value) { _resolucaoPagina = value.toInt(); },
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
                        Icons.amp_stories_outlined,
                        color: Colors.grey,
                      ),
                    ]
                  ),
                  title: Text("Margem Esquerda",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Biblioteca.isTelaPequena(context) ? 14.0 : 16.0
                          ),
                        ),                    
                  trailing:
                  Container(
                    width: Biblioteca.isTelaPequena(context) ? 120 : 200,
                    child: SliderTheme(
                      data: ViewUtilLib.sliderThemeData(context),
                      child: SpinBox( 
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: Biblioteca.isTelaPequena(context) ? 14.0 : 16.0
                        ),
                        max: 5.0,
                        min: 0.1,
                        value: _margemEsquerda,
                        decimals: 1,
                        step: 0.1,
                        onChanged: (value) { _margemEsquerda = value; },
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
                        Icons.amp_stories_outlined,
                        color: Colors.grey,
                      ),
                    ]
                  ),
                  title: Text("Margem Direita",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Biblioteca.isTelaPequena(context) ? 14.0 : 16.0
                          ),
                        ),                    
                  trailing:
                  Container(
                    width: Biblioteca.isTelaPequena(context) ? 120 : 200,
                    child: SliderTheme(
                      data: ViewUtilLib.sliderThemeData(context),
                      child: SpinBox( 
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: Biblioteca.isTelaPequena(context) ? 14.0 : 16.0
                        ),
                        max: 5.0,
                        min: 0.1,
                        value: _margemDireita,
                        decimals: 1,
                        step: 0.1,
                        onChanged: (value) { _margemDireita = value; },
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
                        Icons.amp_stories_outlined,
                        color: Colors.grey,
                      ),
                    ]
                  ),
                  title: Text("Margem Superior",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Biblioteca.isTelaPequena(context) ? 14.0 : 16.0
                          ),
                        ),                    
                  trailing:
                  Container(
                    width: Biblioteca.isTelaPequena(context) ? 120 : 200,
                    child: SliderTheme(
                      data: ViewUtilLib.sliderThemeData(context),
                      child: SpinBox( 
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: Biblioteca.isTelaPequena(context) ? 14.0 : 16.0
                        ),
                        max: 5.0,
                        min: 0.1,
                        value: _margemSuperior,
                        decimals: 1,
                        step: 0.1,
                        onChanged: (value) { _margemSuperior = value; },
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
                        Icons.amp_stories_outlined,
                        color: Colors.grey,
                      ),
                    ]
                  ),
                  title: Text("Margem Inferior",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Biblioteca.isTelaPequena(context) ? 14.0 : 16.0
                          ),
                        ),                    
                  trailing:
                  Container(
                    width: Biblioteca.isTelaPequena(context) ? 120 : 200,
                    child: SliderTheme(
                      data: ViewUtilLib.sliderThemeData(context),
                      child: SpinBox( 
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: Biblioteca.isTelaPequena(context) ? 14.0 : 16.0
                        ),
                        max: 5.0,
                        min: 0.1,
                        value: _margemInferior,
                        decimals: 1,
                        step: 0.1,
                        onChanged: (value) { _margemInferior = value; },
                      ),                          
                    ),    
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 2),
                leading: Wrap( 
                  spacing: 12,
                  children: [
                    SizedBox(width: 1,),
                    Icon(
                      Icons.font_download,
                      color: Colors.grey,
                    ),
                  ]
                ),
                title: Text("Tamanho da Fonte do Item",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Biblioteca.isTelaPequena(context) ? 14.0 : 16.0
                        ),
                      ),                    
                trailing:
                Container(
                  width: Biblioteca.isTelaPequena(context) ? 120 : 200,
                  child: SliderTheme(
                    data: ViewUtilLib.sliderThemeData(context),
                    child: SpinBox( 
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: Biblioteca.isTelaPequena(context) ? 14.0 : 16.0
                      ),
                      max: 10,
                      min: 5,
                      value: _tamanhoFonteItem.toDouble(),
                      decimals: 0,
                      step: 1,
                      onChanged: (value) { _tamanhoFonteItem = value.toInt(); },
                    ),                          
                  ),    
                ),
              ),                                                       
              ListTile(
                leading: Icon(
                  Icons.ad_units,
                  color: Colors.blueGrey,
                ),
                title: Text("Imprimir Itens Somente em Uma Linha",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Biblioteca.isTelaPequena(context) ? 14.0 : 16.0
                        ),
                      ),                    
                trailing: CupertinoSwitch(
                  value: _imprimirItensUmaLinha,
                  onChanged: (val) {
                    _imprimirItensUmaLinha = !_imprimirItensUmaLinha;
                    setState(() {});
                  },
                )
              ),
              ListTile(
                leading: Icon(
                  Icons.ad_units_outlined,
                  color: Colors.blueGrey,
                ),
                title: Text("Imprimir Desconto por Item",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Biblioteca.isTelaPequena(context) ? 14.0 : 16.0
                        ),
                      ),                    
                trailing: CupertinoSwitch(
                  value: _imprimirDescontoPorItem,
                  onChanged: (val) {
                    _imprimirDescontoPorItem = !_imprimirDescontoPorItem;
                    setState(() {});
                  },
                )
              ),
              ListTile(
                leading: Icon(
                  Icons.qr_code_2,
                  color: Colors.blueGrey,
                ),
                title: Text("Imprimir QRCode na Lateral",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Biblioteca.isTelaPequena(context) ? 14.0 : 16.0
                        ),
                      ),                    
                trailing: CupertinoSwitch(
                  value: _imprimirQRCodeNaLateral,
                  onChanged: (val) {
                    _imprimirQRCodeNaLateral = !_imprimirQRCodeNaLateral;
                    setState(() {});
                  },
                )
              ),
              ListTile(
                leading: Icon(
                  Icons.read_more,
                  color: Colors.blueGrey,
                ),
                title: Text("Imprimir GTIN",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Biblioteca.isTelaPequena(context) ? 14.0 : 16.0
                        ),
                      ),                    
                trailing: CupertinoSwitch(
                  value: _imprimirGtin,
                  onChanged: (val) {
                    _imprimirGtin = !_imprimirGtin;
                    setState(() {});
                  },
                )
              ),
              ListTile(
                leading: Icon(
                  Icons.receipt_long_outlined,
                  color: Colors.blueGrey,
                ),
                title: Text("Imprimir Nome Fantasia",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Biblioteca.isTelaPequena(context) ? 14.0 : 16.0
                        ),
                      ),                    
                trailing: CupertinoSwitch(
                  value: _imprimirNomeFantasia,
                  onChanged: (val) {
                    _imprimirNomeFantasia = !_imprimirNomeFantasia;
                    setState(() {});
                  },
                )
              ),
              ListTile(                  
                leading: Icon(
                  Icons.receipt_long_outlined,
                  color: Colors.blueGrey,
                ),
                title: Text("Formato DANFE",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Biblioteca.isTelaPequena(context) ? 14.0 : 16.0
                  ),
                ),                   
                trailing: Container(
                  width: Biblioteca.isTelaPequena(context) ? 180 : 300,
                  padding: EdgeInsets.all(0),
                  child: CustomRadioButton(
                    buttonLables: [
                      'Impresso',
                      'Mensagem',
                    ],
                    buttonValues: [
                      "4",
                      "5",
                    ],
                    buttonTextStyle: ButtonTextStyle(
                      selectedColor: Colors.white,
                      unSelectedColor: Colors.black,
                      textStyle: TextStyle(fontSize: Biblioteca.isTelaPequena(context) ? 10 : 16)),
                    radioButtonValue: (value) {
                      _formatoImpressaoDanfe = value;
                    },
                    enableShape: true,
                    defaultSelected: _formatoImpressaoDanfe,
                    elevation: 2,
                    absoluteZeroSpacing: Biblioteca.isTelaPequena(context) ? true : false,
                    unSelectedColor: Theme.of(context).canvasColor,
                    selectedColor: Theme.of(context).accentColor,
                    enableButtonWrap: false,
                    width: Biblioteca.isTelaPequena(context) ? 85 : 140,
                  ),
                ),
              ),
              ListTile(                  
                leading: Icon(
                  Icons.computer,
                  color: Colors.blueGrey,
                ),
                title: Text("Ambiente",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Biblioteca.isTelaPequena(context) ? 14.0 : 16.0
                  ),
                ),                   
                trailing: Container(
                  width: Biblioteca.isTelaPequena(context) ? 175 : 300,
                  padding: EdgeInsets.all(0),
                  child: CustomRadioButton(
                    buttonLables: [
                      'Produção',
                      'Homologação',
                    ],
                    buttonValues: [
                      "1",
                      "2",
                    ],
                    buttonTextStyle: ButtonTextStyle(
                      selectedColor: Colors.white,
                      unSelectedColor: Colors.black,
                      textStyle: TextStyle(fontSize: Biblioteca.isTelaPequena(context) ? 10 : 16)),
                    radioButtonValue: (value) {
                      _ambiente = value;
                    },
                    enableShape: true,
                    defaultSelected: _ambiente,
                    elevation: 2,
                    absoluteZeroSpacing: Biblioteca.isTelaPequena(context) ? true : false,
                    unSelectedColor: Theme.of(context).canvasColor,
                    selectedColor: Theme.of(context).accentColor,
                    enableButtonWrap: false,
                    width: Biblioteca.isTelaPequena(context) ? 85 : 140,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      listaConteudo.add(
        // Numeração e Série
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Numeração e Série",
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
              Padding(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  controller: _numeroController,
                  decoration: getInputDecoration(
                    'Conteúdo para o campo Número',
                    'Número NFC-e',
                    false),
                  onSaved: (String value) {
                  },
                  onChanged: (text) {
                  },
                ),                
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  controller: _serieController,
                  decoration: getInputDecoration(
                    'Conteúdo para o campo Série',
                    'Série NFC-e',
                    false),
                  onSaved: (String value) {
                  },
                  onChanged: (text) {
                  },
                ),                
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _getBotaoAtualizarNumeroSerie(context: context),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      );
      listaConteudo.add(
        // CSC
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "CSC",
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
              Padding(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  controller: _idCscController,
                  decoration: getInputDecoration(
                    'Conteúdo para o campo ID CSC',
                    'ID CSC',
                    false),
                  onSaved: (String value) {
                  },
                  onChanged: (text) {
                  },
                ),                
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  controller: _cscController,
                  decoration: getInputDecoration(
                    'Conteúdo para o campo CSC',
                    'CSC',
                    false),
                  onSaved: (String value) {
                  },
                  onChanged: (text) {
                  },
                ),                
              ),
            ],
          ),
        ),
      );
      listaConteudo.add(
        // Responsável Técnico
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Responsável Técnico",
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
              Padding(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  maxLength: 18,
                  keyboardType: TextInputType.number,
                  controller: _cnpjController,
                  validator: ValidaCampoFormulario.validarCNPJ,
                  decoration: getInputDecoration(
                    'Conteúdo para o campo Cnpj',
                    'Cnpj',
                    true,
                    paddingVertical: 15),
                  onSaved: (String value) {
                  },
                  onChanged: (text) {
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  maxLength: 60,
                  maxLines: 1,
                  controller: _contatoRespTecController,
                  decoration: getInputDecoration(
                    'Conteúdo para o campo Contato',
                    'Contato',
                    false),
                  onSaved: (String value) {
                  },
                  onChanged: (text) {
                  },
                ),                
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  validator: ValidaCampoFormulario.validarEmail,
                  maxLength: 250,
                  maxLines: 1,
                  controller: _emailRespTecController,
                  decoration: getInputDecoration(
                    'Conteúdo para o campo Email',
                    'Email',
                    false),
                  onSaved: (String value) {
                  },
                  onChanged: (text) {
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  maxLength: 14,
                  keyboardType: TextInputType.number,
                  controller: _telefoneController,
                  decoration: getInputDecoration(
                    'Conteúdo para o campo Telefone',
                    'Telefone',
                    false),
                  onSaved: (String value) {
                  },
                  onChanged: (text) {
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  controller: _idCsrtController,
                  decoration: getInputDecoration(
                    'Conteúdo para o campo ID CSRT',
                    'ID CSRT',
                    false),
                  onSaved: (String value) {
                  },
                  onChanged: (text) {
                  },
                ),                
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  controller: _hashCsrtController,
                  decoration: getInputDecoration(
                    'Conteúdo para o campo HASH CSRT',
                    'HASH CSRT',
                    false),
                  onSaved: (String value) {
                  },
                  onChanged: (text) {
                  },
                ),                
              ),
            ],
          ),
        ),
      );			  
      listaConteudo.add(
        // Botões de rodapé
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _getBotoesRodape(context: context),
              ),
              const SizedBox(height: 10.0),
            ],
          )
        ),
      );	      	        
    }
    return listaConteudo;
  }

  List<Widget> _getBotaoAtualizarNumeroSerie({BuildContext context}) {
    List<Widget> listaBotoes = [];
    listaBotoes.add(
       Container(
        width: 220,
        child: getBotaoGenericoPdv(
          descricao: 'Atualizar Número e Série',
          cor: Colors.green, 
          onPressed: () async {
            await _atualizarNumero();
          }
        ),
      ),
    );
    return listaBotoes;
  }
  
 List<Widget> _getBotoesRodape({BuildContext context}) {
    List<Widget> listaBotoes = [];
    listaBotoes.add(
      Container(
        width: Biblioteca.isTelaPequena(context) ? 130 : 150,
        child: getBotaoGenericoPdv(
          descricao: Biblioteca.isMobile() ? 'Cancelar' : 'Cancelar [F11]',
          cor: Colors.red, 
          onPressed: () {
            Navigator.pop(context, false);
          }
        ),        
      ),
    );
    listaBotoes.add(
      SizedBox(width: 10.0),
    );
    listaBotoes.add(
      Container(
        width: Biblioteca.isTelaPequena(context) ? 130 : 150,
        child: getBotaoGenericoPdv(
          descricao: Biblioteca.isMobile() ? 'Confirmar' : 'Confirmar [F12]',
          cor: Colors.green, 
          onPressed: () async {
            gerarDialogBoxEspera(context);
            await _salvar();
            Sessao.fecharDialogBoxEspera(context);
          }
        ),
      ),
    );
    return listaBotoes;
  }

  List<Widget> _getBotaoEnviarCertificadoDigital() {
    List<Widget> listaBotoes = [];
    listaBotoes.add(
       Container(
        width: 220,
        child: getBotaoGenericoPdv(
          descricao: 'Enviar Certificado Digital',
          cor: Colors.green, 
          onPressed: () async {
            if (_arquivoCertificadoBase64 == null || _arquivoCertificadoBase64 == '') {
              gerarDialogBoxInformacao(context, 'Selecione o arquivo do Certificado Digital - tipo A1 (arquivo PFX).');
            } else if (_senhaCertificadoController.text == null || _senhaCertificadoController.text == '') {
              gerarDialogBoxInformacao(context, 'Informe a senha do Certificado Digital.');
            } else {
              gerarDialogBoxEspera(context);
              await _enviarCertificado();
              Sessao.fecharDialogBoxEspera(context);
            }
          }
        ),
      ),
    );
    return listaBotoes;
  }

  Future _atualizarNumero() async {
    Sessao.numeroNfce = 
    Sessao.numeroNfce.copyWith(
      numero: int.tryParse(_numeroController.text),
      serie: _serieController.text,
    );
    final retorno = await Sessao.db.nfeNumeroDao.alterar(Sessao.numeroNfce);
    if (retorno) {
      Sessao.numeroNfce = await Sessao.db.nfeNumeroDao.consultarObjeto(1);
      showInSnackBar('Dados atualizados com sucesso!', context, corFundo: Colors.blue);
    }
  }

  Future<bool> _salvar() async {
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
    Sessao.configuracaoNfce = 
    Sessao.configuracaoNfce.copyWith(
      caminhoSalvarPdf: 'C:\\ACBrMonitor\\'+Sessao.empresa.cnpj+'\\PDF\\',
      caminhoSalvarXml: 'C:\\ACBrMonitor\\'+Sessao.empresa.cnpj+'\\DFes\\',
      webserviceAmbiente: int.tryParse(_ambiente),
      formatoImpressaoDanfe: int.tryParse(_formatoImpressaoDanfe),
      nfceModeloImpressao: _formatoPagina,
      nfceResolucaoImpressao: _resolucaoPagina,
      nfceMargemEsquerda: _margemEsquerda,
      nfceMargemDireita: _margemDireita,
      nfceMargemSuperior: _margemSuperior,
      nfceMargemInferior: _margemInferior,
      nfceImprimirItensUmaLinha: _imprimirItensUmaLinha ? 'S' : 'N',
      nfceImprimirDescontoPorItem: _imprimirDescontoPorItem ? 'S' : 'N',
      nfceImprimirQrcodeLateral: _imprimirQRCodeNaLateral ? 'S' : 'N',
      nfceImprimirGtin: _imprimirGtin ? 'S' : 'N',
      nfceImprimirNomeFantasia: _imprimirNomeFantasia ? 'S' : 'N',
      nfceIdCsc: _idCscController.text,
      nfceCsc: _cscController.text,
      nfceTamanhoFonteItem: _tamanhoFonteItem,
      respTecCnpj: Biblioteca.removerMascara(_cnpjController.text),
      respTecContato: _contatoRespTecController.text,
      respTecEmail: _emailRespTecController.text,
      respTecFone: Biblioteca.removerMascara(_telefoneController.text),
      respTecIdCsrt: _idCsrtController.text,
      respTecHashCsrt: _hashCsrtController.text,
    );

    NfeConfiguracaoModel nfeConfiguracao = NfeConfiguracaoModel.fromDB(Sessao.configuracaoNfce);
    NfceService nfceService = NfceService();
    nfeConfiguracao = await nfceService.atualizarConfiguracoesMonitor(nfeConfiguracao, Sessao.empresa.cnpj);        
    if (nfeConfiguracao != null) {
      await Sessao.db.nfeConfiguracaoDao.alterar(Sessao.configuracaoNfce);
      Navigator.pop(context, true); // fecha janela de configuração
      Navigator.pop(context, true); // fecha menu lateral
      showInSnackBar('Dados salvos com sucesso.', context, corFundo: Colors.blue);
      return true;
    } else {
      showInSnackBar('Ocorreu um problema ao tentar salvar os dados no Servidor.', context, corFundo: Colors.red);
      return false;
    }
  }

  Future _enviarCertificado() async {
    // use para uma release de testes
    // showInSnackBar('Essa é uma versão de Testes para desenvolvedores. Configure o ACBrMonitor manualmente.', context, corFundo: Colors.blue);
    NfceService nfceService = NfceService();
    final retorno = await nfceService.atualizarCertificadoDigital(_arquivoCertificadoBase64, _senhaCertificadoController.text);        
    if (retorno) {
      Sessao.configuracaoNfce = 
      Sessao.configuracaoNfce.copyWith(
        certificadoDigitalSerie: _nomeCertificadoController.text,
        certificadoDigitalSenha: Constantes.encrypter.encrypt(_senhaCertificadoController.text, iv: Constantes.iv).base64,
      );
      await Sessao.db.nfeConfiguracaoDao.alterar(Sessao.configuracaoNfce);
      showInSnackBar('Certificado enviado com sucesso.', context, corFundo: Colors.blue);
    } else {
      showInSnackBar('Ocorreu um problema ao tentar enviar o certificado para o Servidor.', context, corFundo: Colors.red);
    }
  }

}