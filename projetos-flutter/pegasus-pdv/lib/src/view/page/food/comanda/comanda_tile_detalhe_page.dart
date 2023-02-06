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
import 'package:flutter/material.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';
import 'package:pegasus_pdv/src/infra/infra.dart';


class ComandaTileDetalhePage extends StatelessWidget  {
  final ComandaMontado comandaMontado;
  final double altura;
  final double largura;
  final double tamanhoFonteLabelComanda;
  final double tamanhoFonteNumeroComanda;
  final double tamanhoFonteQuantidadeItens;
  final double tamanhoFonteQuantidadePessoas;
  final double tamanhoFonteValorTotal;
  final double tamanhoFontevalorPorPessoa;
  final EdgeInsetsGeometry paddingComandaData;

  const ComandaTileDetalhePage(
    this.comandaMontado, 
    {
    required this.altura,
    required this.largura,
    required this.tamanhoFonteLabelComanda,
    required this.tamanhoFonteNumeroComanda,
    required this.tamanhoFonteQuantidadeItens,
    required this.tamanhoFonteQuantidadePessoas,
    required this.tamanhoFonteValorTotal,
    required this.tamanhoFontevalorPorPessoa,
    required this.paddingComandaData,
    Key? key
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {  
    final comandaWidget = SizedBox(
      height: altura,
      width: largura,
      child: Card(
        color: Color.lerp(Colors.white, Colors.blueGrey, 0.8),
        clipBehavior: Clip.antiAlias,
        elevation: 2.0,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            comandaImage(),
            comandaColor(),
            comandaData(comandaMontado),
          ],
        ),
      ),
    );

    return comandaWidget;
  }

  //stack 1/3 - primeira porção da pilha - a imagem - fica na parte de baixo do Stack
  Widget comandaImage() => Image.asset(
    Constantes.fundoComandaImage,
    fit: BoxFit.cover,
  );

  //stack 2/3 - segunda porção da pilha - a cor com a opacidade
  Widget comandaColor() => Container(
    decoration: BoxDecoration(boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.amber.withOpacity(0.5),
        blurRadius: 100.0, // efeito de fumaça
      ),
    ]),
  );

  //stack 3/3 - terceira porção da pilha - ícone e texto
  Widget comandaData(ComandaMontado comandaMontado) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // parte de cima
        Padding(
          padding: paddingComandaData,
          child: Column(
            children: [
              Text('Comanda Nº', style: TextStyle(fontSize: tamanhoFonteLabelComanda, color: Colors.black54, fontWeight: FontWeight.bold)),
              Text(comandaMontado.comanda!.id.toString().padLeft(8, '0'), style: TextStyle(fontSize: tamanhoFonteNumeroComanda, color: Colors.black, fontWeight: FontWeight.bold)),
              Text(Biblioteca.formatarData(comandaMontado.comanda!.dataChegada), style: const TextStyle(fontSize: 10.0, color: Colors.black54, fontWeight: FontWeight.bold)),
              Text(comandaMontado.comanda!.horaChegada ?? '', style: const TextStyle(fontSize: 10.0, color: Colors.black54, fontWeight: FontWeight.bold)),
            ],
          ),                 
        ),

        // parte de baixo
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Column(
            children: [
              Text('Quantidade de Itens: ${comandaMontado.listaComandaDetalheMontado!.length}', style: TextStyle(fontSize: tamanhoFonteQuantidadeItens, color: Colors.black54, fontWeight: FontWeight.bold)),
              Text('Quantidade de Pessoas: ${comandaMontado.comanda!.quantidadePessoas?.toString() ?? '0'}', style: TextStyle(fontSize: tamanhoFonteQuantidadePessoas, color: Colors.black54, fontWeight: FontWeight.bold)),
              Text('Valor Subtotal: ${Biblioteca.formatarValorDecimal(comandaMontado.comanda!.valorSubtotal)}', style: TextStyle(fontSize: tamanhoFonteValorTotal, color: Colors.black, fontWeight: FontWeight.bold)),
              Text('Valor Desconto: ${Biblioteca.formatarValorDecimal(comandaMontado.comanda!.valorDesconto)}', style: TextStyle(fontSize: tamanhoFonteValorTotal, color: Colors.black, fontWeight: FontWeight.bold)),
              Text('Valor Total: ${Biblioteca.formatarValorDecimal(comandaMontado.comanda!.valorTotal)}', style: TextStyle(fontSize: tamanhoFonteValorTotal, color: Colors.black, fontWeight: FontWeight.bold)),
              Text('Valor por Pessoa: ${Biblioteca.formatarValorDecimal(comandaMontado.comanda!.valorPorPessoa)}', style: TextStyle(fontSize: tamanhoFontevalorPorPessoa, color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

}