/*
Title: T2Ti ERP 3.0                                                                
Description: Página de lookup específica as perguntas e respostas do cardápio
                                                                                
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
import 'package:flutter/material.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';
import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';

class ComandaCardapioPerguntaLookupPage extends StatefulWidget {
  final Cardapio cardapio;
  const ComandaCardapioPerguntaLookupPage(this.cardapio, {Key? key}) : super(key: key);
  
  @override
  _ComandaCardapioPerguntaLookupPageState createState() => _ComandaCardapioPerguntaLookupPageState();
}

class _ComandaCardapioPerguntaLookupPageState extends State<ComandaCardapioPerguntaLookupPage> {
  List<CardapioPerguntaPadraoMontado> listaCardapioPerguntaPadraoMontado = [];
  List<RespostasSelecionadas> listaRespostasSelecionadas = [];

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance!.addPostFrameCallback((_) => _refrescarTela());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyData(),
      bottomNavigationBar: BottomAppBar(
        color: ViewUtilLib.getBottomAppBarColor(),          
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _getBotoesRodape(context: context),
        ),
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
      child: SizedBox(
        child: Stack(
          children: <Widget>[
            SizedBox(
              child: Material(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                elevation: 5.0,
                color: Colors.blueGrey.shade100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Perguntas Padrões',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Faça as seguintes perguntas ao cliente bom base no produto que ele escolheu.', textAlign: TextAlign.center,),                
                    ),                      
                    const Divider(
                      indent: 10,
                      endIndent: 10,
                      thickness: 2,
                    ),
                    const SizedBox(
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

    for (var perguntaMontado in listaCardapioPerguntaPadraoMontado) {   
      listaConteudo.add(
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                perguntaMontado.cardapioPerguntaPadrao!.pergunta ?? '',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 18,
                ),
              ),
              const Divider(color: Colors.grey),
            ],
          )
        ),
      );

      final respostaFiltro = listaRespostasSelecionadas.where( ((pergunta) => pergunta.idPergunta == perguntaMontado.id )).toList();    

      listaConteudo.add(
        Card(
          color: Colors.white,
          elevation: 2.0,
          child: Column(
            children: <Widget>[
              ExpansionTile(
                leading: const Icon(
                  Icons.question_answer,
                  color: Colors.blue,
                ),
                key: GlobalKey(),
                title: Text(respostaFiltro[0].resposta),                             
                backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.025),
                children: _pegarRespostas(perguntaMontado),  
              ),                  
            ],
          ),
        ),
      );        
    }
    return listaConteudo;
  }

  List<Widget> _pegarRespostas(CardapioPerguntaPadraoMontado perguntaMontado) {
    List<Widget> listaConteudo = [];
    for (var resposta in perguntaMontado.listaCardapioRespostaPadrao) {
      listaConteudo.add(
        ListTile(
          title: Text(resposta.resposta!),
          onTap: () {
            final perguntaFiltro = listaRespostasSelecionadas.where( ((pergunta) => pergunta.idPergunta == perguntaMontado.id )).toList();    
            perguntaFiltro[0].resposta = resposta.resposta!;
            setState(() {
            });
          },              
        ),
      );
    }
    return listaConteudo;
  }

  Future _refrescarTela() async {
    listaCardapioPerguntaPadraoMontado = await Sessao.db.cardapioPerguntaPadraoDao.consultarListaPerguntaMontado(widget.cardapio.id!);

    if (listaRespostasSelecionadas.isEmpty) {
      for (var perguntaMontado in listaCardapioPerguntaPadraoMontado) {   
        RespostasSelecionadas respostasSelecionadas = RespostasSelecionadas(
          idPergunta: perguntaMontado.id,
          pergunta: perguntaMontado.cardapioPerguntaPadrao!.pergunta!,
          resposta: '',
        );
        listaRespostasSelecionadas.add(respostasSelecionadas);
      }
    } 
    
    setState(() {
    });
  } 

  List<Widget> _getBotoesRodape({required BuildContext context}) {
    List<Widget> listaBotoes = [];    
    listaBotoes.add(
      SizedBox(
        width: Biblioteca.isTelaPequena(context)! ? 130 : 150,
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
      const SizedBox(width: 10.0, height: 50,),
    );
    listaBotoes.add(
      SizedBox(
        width: Biblioteca.isTelaPequena(context)! ? 130 : 150,
        child: getBotaoGenericoPdv(
          descricao: Biblioteca.isMobile() ? 'Confirmar' : 'Confirmar [F12]',
          cor: Colors.green.shade900, 
          onPressed: () {
            Navigator.pop(context, listaRespostasSelecionadas);
          }
        ),
      ),
    );
    return listaBotoes;
  }

}