/*
Title: T2Ti ERP 3.0                                                                
Description: PersistePage relacionada à tabela [MESA] 
                                                                                
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

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

class MesaCadastroPage extends StatefulWidget {
  const MesaCadastroPage(this.mesa, {Key? key}) : super(key: key);

  final Mesa mesa;

  @override
  _MesaCadastroPageState createState() => _MesaCadastroPageState();
}

class _MesaCadastroPageState extends State<MesaCadastroPage> {
  Mesa? mesa;

  @override
  void initState() {
    super.initState();
    mesa = widget.mesa;
  }
  
  @override
  Widget build(BuildContext context) {
    final listItems = <Widget>[

      ListTile(
        contentPadding: const EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 2),
        leading: Wrap( 
          spacing: 12,
          children: const [
            SizedBox(width: 1,),
            Icon(
              Icons.chair,
              color: Colors.black54,
            ),
          ]
        ),
        title: Text("Quantidade de Cadeiras para Adultos",
          style: TextStyle(
            color: Colors.white,
            fontSize: Biblioteca.isTelaPequena(context)! ? 14.0 : 16.0,
            fontWeight: FontWeight.bold
          ),
        ),                    
        trailing:
        SizedBox(
          width: Biblioteca.isTelaPequena(context)! ? 120 : 200,
          child: SliderTheme(
            data: ViewUtilLib.sliderThemeData(context),
            child: SpinBox( 
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: Biblioteca.isTelaPequena(context)! ? 14.0 : 16.0
              ),
              max: 20,
              min: 1,
              value: mesa!.quantidadeCadeiras!.toDouble(),
              decimals: 0,
              step: 1,
              onChanged: (value) { 
                mesa = mesa!.copyWith(
                  quantidadeCadeiras: value.toInt(),
                );
                setState(() {
                });
              },
            ),                          
          ),    
        ),
      ),  
      ListTile(
        contentPadding: const EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 2),
        leading: Wrap( 
          spacing: 12,
          children: const [
            SizedBox(width: 1,),
            Icon(
              Icons.chair_sharp,
              color: Colors.black54,
            ),
          ]
        ),
        title: Text("Quantidade de Cadeiras para Crianças",
          style: TextStyle(
            color: Colors.white,
            fontSize: Biblioteca.isTelaPequena(context)! ? 14.0 : 16.0,
            fontWeight: FontWeight.bold
          ),
        ),                    
        trailing:
        SizedBox(
          width: Biblioteca.isTelaPequena(context)! ? 120 : 200,
          child: SliderTheme(
            data: ViewUtilLib.sliderThemeData(context),
            child: SpinBox( 
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: Biblioteca.isTelaPequena(context)! ? 14.0 : 16.0
              ),
              max: 20,
              min: 0,
              value: mesa!.quantidadeCadeirasCrianca?.toDouble() ?? 0,
              decimals: 0,
              step: 1,
              onChanged: (value) { 
                mesa = mesa!.copyWith(
                  quantidadeCadeirasCrianca: value.toInt(),
                );
                setState(() {
                });
              },
            ),                          
          ),    
        ),
      ),  

      Padding(
        padding: const EdgeInsets.all(16),
        child: TextFormField(
          maxLength: 1000,
          maxLines: 3,
          style: const TextStyle(color: Colors.white),
          initialValue: mesa?.observacao ?? '',
          decoration: getInputDecoration(
            'Observação',
            'Observação',
            false,),
          onSaved: (String? value) {
          },
          onChanged: (text) {
            mesa = mesa!.copyWith(
              observacao: text,
            );
            setState(() {
            });
          },
        ),
      ),
      
    ].expand((widget) => [widget, const Divider()]).toList();

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: Color.lerp(Colors.grey[850], Colors.blueGrey, 0.8),
        appBar: AppBar(
          backgroundColor: Color.lerp(Colors.grey[850], Colors.white, 0.4),
          bottom: MesaTileDetalhe(mesa!),
        ),
        body: ListView(padding: const EdgeInsets.only(top: 50.0), children: listItems),
      ),
    );
  }

  Future<bool> _willPopCallback() async {
    await Sessao.db.mesaDao.alterar(mesa!);
    return true;
  }

}

class MesaTileDetalhe extends StatelessWidget implements PreferredSizeWidget {
  const MesaTileDetalhe(this.mesa, {Key? key}) : super(key: key);

  final Mesa mesa;

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {     
    final tileText = <Widget>[         
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${mesa.quantidadeCadeiras}', style: const TextStyle(fontSize: 12.0, color: Colors.white)),
          Text('${mesa.quantidadeCadeirasCrianca ?? '0'}', style: const TextStyle(fontSize: 12.0, color: Colors.white)),
        ],
      ),
      Text(mesa.numero.toString(), style: const TextStyle(fontSize: 50.0, color: Colors.white, fontWeight: FontWeight.bold)),
      Text((mesa.observacao?.isNotEmpty ?? false) ? 'OBS' : '', style: const TextStyle(fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.bold)),
    ];

    final tile = Container(
      margin: const EdgeInsets.all(0.0),
      width: 110,
      height: 110,
      foregroundDecoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.blue, Colors.amberAccent]), backgroundBlendMode: BlendMode.multiply,),
      child: RawMaterialButton(
        fillColor: Colors.grey[800],
        disabledElevation: 10.0,
        padding: const EdgeInsets.all(4.0),
        onPressed: () {  },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          children: tileText
        ),
      ),
    );

    return Hero(
      tag: 'hero-${mesa.numero}',
      flightShuttleBuilder: (_, anim, __, ___, ____) =>
          ScaleTransition(scale: anim.drive(Tween(begin: 1, end: 1.75)), child: tile),
      child: Transform.scale(scale: 1.75, child: tile),
    );     
  }
}
