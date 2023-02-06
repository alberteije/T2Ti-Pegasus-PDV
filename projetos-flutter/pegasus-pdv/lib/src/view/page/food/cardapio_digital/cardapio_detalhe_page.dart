/*
Title: T2Ti ERP 3.0                                                                
Description: página de detalhe do cardápio
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2022 T2Ti.COM                                          
                                                                                
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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pegasus_pdv/src/controller/controller.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';
import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/infra/infra.dart';

class CardapioDetalhePage extends StatefulWidget {
  final ProdutoMontado produtoMontado;

  const CardapioDetalhePage(this.produtoMontado, {Key? key}) : super(key: key);

  @override
  CardapioDetalhePageState createState() => CardapioDetalhePageState();
}

class CardapioDetalhePageState extends State<CardapioDetalhePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.lerp(Colors.grey[850], Colors.blueGrey, 0.8),
      body: _getCorpo(),
    );
  }

  Widget _getCorpo() {
    return ListView(
      padding: const EdgeInsets.only(top: 0.0), 
      children: [

        Stack(
          children: [
            Container(
              color: Color.lerp(Colors.grey[850], Colors.white, 0.4),
              height: 60,
            ),
            const SizedBox(
              height: 10,
            ),
            Positioned(
              top: 20,
              left: 60,
              child: Text("Detalhes: ${widget.produtoMontado.produto!.nome!}",
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: Biblioteca.isTelaPequena(context)! ? 14.0 : 16.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                tooltip: 'Voltar',
                icon: const Icon(Icons.arrow_back_outlined),
                onPressed: () { Navigator.pop(context); }, 
              ),
            ),
          ],
        ),
       
        CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            gridComImagens(),
          ],
        ),        

        ListTile(
          contentPadding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 15),
          leading: Wrap( 
            spacing: 12,
            children: const [
              SizedBox(width: 1,),
              Icon(
                FontAwesomeIcons.dochub,
                color: Colors.black54,
              ),
            ]
          ),
          title: Text("Descrição do Produto",
            style: TextStyle(
              color: Colors.grey.shade300,
              fontSize: Biblioteca.isTelaPequena(context)! ? 14.0 : 16.0,
              fontWeight: FontWeight.bold
            ),
          ),                    
        ),  
        
        Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 5, left: 20, right: 5),
          child: Text(widget.produtoMontado.produto!.descricao ?? "Cadastre a descrição do produto",
            style: TextStyle(
              color: Colors.yellow.shade300,
              fontSize: Biblioteca.isTelaPequena(context)! ? 14.0 : 16.0,
              fontWeight: FontWeight.bold
            ),
          ),        
        ),
      ],
    );
  } 

  // TODO: o código abaixo se repete (no todo ou em parte) em produto_persiste_page
  /// ==================================================================================================================
  /// o código abaixo monta a grid com as imagens do produto
  /// ==================================================================================================================
  Widget gridComImagens() {
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
          return imagemStack(index);
        }, childCount: ProdutoController.listaProdutoImagem.length),
      )
    );
  }

  int definirQuantidadeDeCartoesPorLinha(BuildContext context) {
    double larguraDaTela = MediaQuery.of(context).size.width;
    int larguraDoCartao = 150;
    int quantidadePorLinha = larguraDaTela ~/ larguraDoCartao;
    return quantidadePorLinha;
  }

  Widget imagemStack(int index) {
    return InkWell(
      canRequestFocus: false,
      hoverColor: Colors.grey,
      onTap: () {
      },
      splashColor: Colors.black,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2.0,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            imagemImage(ProdutoController.listaProdutoImagem[index]),
            imagemColor(ProdutoController.listaProdutoImagem[index]),
          ],
        ),
      ),
    );
  }

  //stack 1/3 - primeira porção da pilha - a imagem - fica na parte de baixo do Stack
  Widget imagemImage(ProdutoImagem produtoImagem) {
    return Image.memory(produtoImagem.imagem!);
  } 

  //stack 2/3 - segunda porção da pilha - a cor com a opacidade
  Widget imagemColor(ProdutoImagem produtoImagem) => Container(
    decoration: BoxDecoration(boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.green.withOpacity(0.2),
        blurRadius: 50.0, // efeito de fumaça
      ),
    ]),
  );
}