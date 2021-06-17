import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pegasus_pdv/src/infra/constantes.dart';
import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';

class ConfiguracaoAbaGeral extends StatefulWidget {
  
  @override
  _ConfiguracaoAbaGeralState createState() => _ConfiguracaoAbaGeralState();
}

class _ConfiguracaoAbaGeralState extends State<ConfiguracaoAbaGeral> {
  bool _permiteEstoqueNegativo = Sessao.configuracaoPdv.permiteEstoqueNegativo == 'S' ? true : false;
  String _formatoPagina = Sessao.configuracaoPdv.reciboFormatoPagina;
  double _larguraPagina = Sessao.configuracaoPdv.reciboLarguraPagina ?? 57;
  double _margensPagina = 5;
  double _larguraPaginaSlider = 100;

  @override
  Widget build(BuildContext context) {
    // carrega o formato de acordo com o que tem no banco de dados
    switch (_formatoPagina) {
      case 'A4' : 
        _formatoPagina = Constantes.reciboFormularioA4;
        _larguraPaginaSlider = 100;
        _larguraPagina = 100;
        break;
      case '57' : 
        _formatoPagina = Constantes.reciboBobina57;
        _larguraPaginaSlider = 57;
        _larguraPagina = _larguraPagina > 57 ? 57 : _larguraPagina;
        break;
      case '80' : 
        _formatoPagina = Constantes.reciboBobina80;
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
        children: <Widget>[

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
                  title: Text('Formato da Página: ' + _formatoPagina),
                  backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
                  children: <Widget>[
                    ListTile(
                      title: const Text(Constantes.reciboFormularioA4),
                      onTap: () {
                        setState(() {
                          _formatoPagina = Constantes.reciboFormularioA4;
                          _larguraPaginaSlider = 100;
                        });
                      },              
                    ),
                    ListTile(
                      title: const Text(Constantes.reciboBobina57),
                      onTap: () {
                        setState(() {
                          _formatoPagina = Constantes.reciboBobina57;
                          _larguraPaginaSlider = 57;
                          _larguraPagina = _larguraPagina > 57 ? 57 : _larguraPagina;
                        });
                      },              
                    ),
                    ListTile(
                      title: const Text(Constantes.reciboBobina80),
                      onTap: () {
                        setState(() {
                          _formatoPagina = Constantes.reciboBobina80;
                          _larguraPaginaSlider = 80;
                          _larguraPagina = _larguraPagina > 80 ? 80 : _larguraPagina;
                        });
                      },              
                    ),
                  ]
                ),                    
                Visibility(
                  visible: _formatoPagina != Constantes.reciboFormularioA4,
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
                  visible: _formatoPagina != Constantes.reciboFormularioA4,
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
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Future<bool> _willPopCallback() async {
    switch (_formatoPagina) {
      case Constantes.reciboFormularioA4 : 
        _formatoPagina = 'A4';
        break;
      case Constantes.reciboBobina57 : 
        _formatoPagina = '57';
        break;
      case Constantes.reciboBobina80 : 
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
}