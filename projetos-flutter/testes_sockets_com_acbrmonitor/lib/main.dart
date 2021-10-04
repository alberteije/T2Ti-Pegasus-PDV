import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_sockets/pdf_page.dart';
import 'package:ini/ini.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title='Demo Sockets com ACBrMonitor';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: MyHomePage(
        title: title,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, @required this.title})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controllercNF = TextEditingController();
  TextEditingController _controllernNF = TextEditingController();
  TextEditingController _controllerResposta = TextEditingController();

  SharedPreferences _prefs;
  Socket _socket;
  String _respostaServidor;
  bool _imprime = false;
  String _ultimaChaveEmitida;

  File arquivoIni = new File("ACBrMonitor.ini");
  Config config;

  @override
  Widget build(BuildContext context) {
    _controllercNF.text = _prefs?.getString('cNF') ?? 'conecte no servidor';
    _controllernNF.text = _prefs?.getString('nNF')?.padLeft(9, '0') ?? 'conecte no servidor';

    config = new Config.fromStrings(arquivoIni.readAsLinesSync());
    print("lendo a partir do arquivo INI: ${config.get("EMPRESA", "Nome")}"); 

    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.connected_tv),
          tooltip: 'Conectar ao Servidor',
          onPressed: () async {            
            print("Conectando ao servidor...");
            _imprime = false;
            var enderecoServidor=new InternetAddress(config.get("ACBrMonitor", "IP_SERVIDOR"));
            int portaServidor = int.tryParse(config.get("ACBrMonitor", "TCP_Porta"));//6001;
            try {
              conectar(enderecoServidor, portaServidor);            
            } catch (e) {
              _controllerResposta.text = e.toString();
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.account_tree_rounded),
          tooltip: 'Consultar Status do Servico',
          onPressed: () async {
            print("Consultando status do servico...");
            _imprime = false;
            try {
              consultarStatusServico();
            } catch (e) {
              _controllerResposta.text = e.toString();
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.add_chart),
          tooltip: 'Emitir NFC-e',
          onPressed: () async {
            print("Emitindo uma nota fiscal [NFC-e]...");
            _imprime = false;
            try {
              emitirNfce();
            } catch (e, stacktrace) {
              _controllerResposta.text = e.toString() + "\n\n" + stacktrace.toString();
            }
          },
        ),
        // IconButton(
        //   icon: Icon(Icons.mail),
        //   tooltip: 'Enviar email com a nota',
        //   onPressed: () async {
        //     print("Enviar email com a nota [NFC-e]...");
        //     _imprime = false;
        //     enviarEmail();
        //   },
        // ),
        IconButton(
          icon: Icon(Icons.print),
          tooltip: 'Imprimir Danfe',
          onPressed: () async {
            print("imprimir danfe [NFC-e]...");
            _imprime = true;
            imprimirDanfe();
          },
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: Column(children: [
                TextFormField(
                  controller: _controllercNF,
                  decoration: InputDecoration(labelText: 'Código Numérico [cNF]'),
                ),
                TextFormField(
                  controller: _controllernNF,
                  decoration: InputDecoration(labelText: 'Número da Nota [nNF]'),
                ),
                TextFormField(
                  controller: _controllerResposta,
                  maxLines: 10,
                  decoration: InputDecoration(labelText: 'Resposta'),
                ),
              ],)
              
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _socket.destroy();
    super.dispose();
  }

  void conectar(InternetAddress enderecoServidor, int portaServidor) async {
    _prefs = await SharedPreferences.getInstance();

    Socket.connect(enderecoServidor, portaServidor).then((socket) {
      _socket = socket;

      print('Connected to: ${_socket.remoteAddress.address}:${_socket.remotePort}');

      //configurando os callbacks: onData e onDone
      _socket.listen((data) {
        _respostaServidor = String.fromCharCodes(data).trim();
        _controllerResposta.text += '\n==========================\n' + _respostaServidor;
        print(_respostaServidor);

        // se emitiu a nota, guarda a chave para impressão
        if (_respostaServidor.contains('ChaveDFe')) {
          var respostaJson = json.decode(_respostaServidor.substring(4, _respostaServidor.length));
          _ultimaChaveEmitida = respostaJson.values.toList()[0]['Retorno']['ChaveDFe'];
        }

        // impressão
        if (_imprime) {
          var decodeB64 = base64.decode(_respostaServidor.substring(4, _respostaServidor.length - 1)); // remove o OK da resposta e um último caractere que é inserido
            Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (BuildContext context) => PdfPage(
                      arquivoPdf: decodeB64, title: 'NFC-e')));          
        }
      },
      onDone: () {
        print("Done");
      });

      _socket.write('ACBr.datahora\r\n.\r\n');
    });

    setState(() {});
  }

  void consultarStatusServico() {
    _socket.write('NFE.StatusServico\r\n.\r\n');
  }  

  void enviarEmail() {
    _socket.write('NFe.EnviarEmail("t2ti.com@gmail.com","C:\\ACBrMonitor\\DFes\\10793118000178\\NFCe\\202104\\NFCe\\53210410793118000178650050000000031990000030-nfe.xml",1)\r\n.\r\n');
  }  

  void imprimirDanfe() {
    // _socket.write('NFE.ImprimirDANFEPDF("C:\\ACBrMonitor\\DFes\\10793118000178\\NFCe\\202104\\NFCe\\53210410793118000178650050000000021990000025-nfe.xml")\r\n.\r\n');
    // _socket.write('NFe.LoadfromFile("C:\\ACBrMonitor\\DFes\\10793118000178\\NFCe\\202104\\NFCe\\53210410793118000178650050000000021990000025-nfe.xml")\r\n.\r\n');
    // _socket.write('ACBr.EncodeBase64("C:\\ACBrMonitor\\PDF\\10793118000178\\NFCe\\202104\\NFCe\\53210410793118000178650050000000021990000025-nfe.pdf")\r\n.\r\n');
    if (_ultimaChaveEmitida != null && _ultimaChaveEmitida.isNotEmpty) {
      // var formatter = DateFormat('yyyyMM');
      // String anoMes = formatter.format(DateTime.now());
      final caminhoPdf = config.get('EMPRESA', 'CAMINHO_PDF');
      _socket.write('ACBr.EncodeBase64("$caminhoPdf'+_ultimaChaveEmitida+'-nfe.pdf")\r\n.\r\n');
      _imprime = true;
    } else {
      _imprime = false;
    }
  }  

// cNF=99000004
// nNF=000000004
// dhEmi=29/04/2021 11:02:00
  void emitirNfce() {
    var formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
    String dataFormatada = formatter.format(DateTime.now());

    var stringResponsavelTecnico = 
      ' [INFRESPTEC]\n' +
      ' CNPJ='+config.get('INFRESPTEC', 'CNPJ') + '\n' +
      ' xContato='+config.get('INFRESPTEC', 'xContato') + '\n' +
      ' email='+config.get('INFRESPTEC', 'email') + '\n' +
      ' fone='+config.get('INFRESPTEC', 'fone') + '\n' +
      ' idcsrt='+config.get('INFRESPTEC', 'idcsrt') + '\n' +
      ' csrt='+config.get('INFRESPTEC', 'csrt') + '\n\n';

    var stringProduto = '';
    if (config.get('ACBrMonitor', 'CRT') == '3') {
      stringProduto = 
      ' [Produto001]\n'
      ' CFOP=5102\n'
      ' cProd=7896019606226\n'
      ' cEAN=7896019606226\n'
      ' xProd=PRODUTO PARA TESTES COM A NFCE\n'
      ' ncm=17049010\n'
      ' uCom=UN\n'
      ' qCom=1\n'
      ' vUnCom=6\n'
      ' vProd=6\n'
      ' cEANTrib=7896019606226\n'
      ' uTrib=UN\n'
      ' qTrib=1\n'
      ' vUnTrib=6\n'
      ' vFrete=0\n'
      ' vSeg=0\n'
      ' vDesc=0\n'
      ' vOutro=0\n'
      ' indTot=1\n'
      ' \n'
      ' [ICMS001]\n'
      ' CST=00\n'
      ' orig=0\n'
      ' modBC=3\n'
      ' vBC=0\n'
      ' pICMS=17\n'
      ' vICMS=0\n'
      ' \n'
      ' [IPI001]\n'
      ' CST=53\n'
      ' vBC=0\n'
      ' pIPI=0\n'
      ' vIPI=0\n'
      ' \n'
      ' [PIS001]\n'
      ' CST=01\n'
      ' vBC=0\n'
      ' pPIS=0.65\n'
      ' vPIS=0\n'
      ' \n'
      ' [COFINS001]\n'
      ' CST=01\n'
      ' vBC=0\n'
      ' pCOFINS=3\n'
      ' vCOFINS=0\n'
      ' \n';
    } else {
      stringProduto = 
        ' [Produto001]\n'
        ' CFOP=5102\n'
        ' cProd=7896019606226\n'
        ' cEAN=7896019606226\n'
        ' xProd=PRODUTO PARA TESTES COM A NFCE\n'
        ' ncm=17049010\n'
        ' uCom=UN\n'
        ' qCom=1\n'
        ' vUnCom=6\n'
        ' vProd=6\n'
        ' cEANTrib=7896019606226\n'
        ' uTrib=UN\n'
        ' qTrib=1\n'
        ' vUnTrib=6\n'
        ' vFrete=0\n'
        ' vSeg=0\n'
        ' vDesc=0\n'
        ' vOutro=0\n'
        ' indTot=1\n'
        ' \n'
        ' [ICMS001]\n'
        ' CSOSN=102\n'
        ' orig=0\n'
        ' modBC=\n'
        ' vBC=0\n'
        ' pICMS=0\n'
        ' vICMS=0\n'
        ' \n'
        ' [IPI001]\n'
        ' CST=99\n'
        ' vBC=0\n'
        ' pIPI=0\n'
        ' vIPI=0\n'
        ' \n'
        ' [PIS001]\n'
        ' CST=99\n'
        ' vBC=0\n'
        ' pPIS=0\n'
        ' vPIS=0\n'
        ' \n'
        ' [COFINS001]\n'
        ' CST=99\n'
        ' vBC=0\n'
        ' pCOFINS=3\n'
        ' vCOFINS=0\n'
        ' \n';
    }

    String conteudoNfce=
      '[infNFe]\n'
      ' versao=4.00\n'
      ' \n'
      ' [Identificacao]\n'
      ' cNF='+_controllercNF.text+'\n'
      ' natOp=VENDA\n'
      ' mod=65\n'
      ' serie='+ config.get('ACBrMonitor', 'SERIE') +'\n'
      ' nNF='+_controllernNF.text+'\n'
      ' dhEmi='+dataFormatada+'\n'
      ' tpNF=1\n'
      ' indFinal=1\n'
      ' idDest=1\n'
      ' indPres=1\n'
      ' tpimp=4\n'
      ' tpAmb=2\n'
      ' \n'
      ' [Emitente]\n'
      ' CNPJCPF=' + config.get('EMPRESA', 'CNPJCPF') + '\n'
      ' xNome='+ config.get('EMPRESA', 'Nome') +'\n'
      ' xFant='+ config.get('EMPRESA', 'FANTASIA') +'\n'
      ' IE='+ config.get('EMPRESA', 'IE') +'\n'
      ' IEST=\n'
      ' IM=\n'
      ' CNAE=8599604\n'
      ' CRT='+ config.get('ACBrMonitor', 'CRT') +'\n'
      ' xLgr='+ config.get('EMPRESA', 'Logradouro') +'\n'
      ' nro='+ config.get('EMPRESA', 'Numero') +'\n'
      ' xCpl='+ config.get('EMPRESA', 'Complemento') +'\n'
      ' xBairro='+ config.get('EMPRESA', 'Bairro') +'\n'
      ' cMun='+ config.get('EMPRESA', 'CodCidade') +'\n'
      ' xMun='+ config.get('EMPRESA', 'Cidade') +'\n'
      ' UF='+ config.get('EMPRESA', 'UF') +'\n'
      ' CEP='+ config.get('EMPRESA', 'CEP') +'\n'
      ' cPais=1058\n'
      ' xPais=BRASIL\n'
      ' Fone=\n'
      ' cUF='+ config.get('EMPRESA', 'cUF') +'\n'
      ' cMunFG=\n'
      ' \n'
      ' [Destinatario]\n'
      ' CNPJCPF=11832478000790\n'
      ' xNome=TESTE PESSOA JURIDICA\n'
      ' indIEDest=9\n'
      ' email=pj@gmail.com\n'
      ' xLgr=LOGRADOURO PESSOA juridica\n'
      ' nro=2\n'
      ' xCpl=COMPLEMENTO\n'
      ' xBairro=BAIRRO\n'
      ' cMun=5300108\n'
      ' xMun=BRASILIA\n'
      ' UF=DF\n'
      ' CEP=71000000\n'
      ' cPais=1058\n'
      ' xPais=Brazil\n'
      ' Fone=\n'
      ' \n'
      +stringProduto+
      ' [Total]\n'
      ' vNF=6\n'
      ' vBC=0\n'
      ' vICMS=0\n'
      ' vBCST=0\n'
      ' vST=0\n'
      ' vProd=6\n'
      ' vFrete=0\n'
      ' vSeg=0\n'
      ' vDesc=0\n'
      ' vII=0\n'
      ' vIPI=0\n'
      ' vPIS=0\n'
      ' vCOFINS=0\n'
      ' vOutro=0\n'
      ' \n'
      ' [Transportador]\n'
      ' modFrete=9\n'
      ' \n'
      ' [PAG001]\n'
      ' tpag=01\n'
      ' vPag=6\n'
      ' indPag=0\n'
      ' vTroco=0\n'
      ' \n'
      + stringResponsavelTecnico +
      ' [DadosAdicionais]\n'
      ' infAdFisco=\n'
      ' infCpl =';  
    _socket.write('NFe.CriarEnviarNFe("' + conteudoNfce + '", "001", , , , , , "1")\r\n.\r\n');

    _prefs.setString('cNF', (int.parse(_controllercNF.text) + 1).toString());
    _prefs.setString('nNF', (int.parse(_controllernNF.text) + 1).toString());
    setState(() {});
  }  

}

