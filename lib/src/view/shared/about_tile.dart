/*
Title: T2Ti ERP 3.0                                                                
Description: Janela About - Sobre
                                                                                
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

Based on: Flutter UIKit by Pawan Kumar - https://github.com/iampawan/Flutter-UI-Kit
*******************************************************************************/
import 'package:flutter/material.dart';
import 'package:pegasus_pdv/src/infra/infra.dart';

class MyAboutTile extends StatelessWidget {
  @override  
  Widget build(BuildContext context) {
    return AboutListTile(
      child: Text("Sobre o " + Constantes.nomeApp),
      dense: true,
      applicationIcon: CircleAvatar(
        minRadius: 30,
        maxRadius: 30,
        backgroundImage: AssetImage(Constantes.profileImage),
      ),
      icon: CircleAvatar(
        minRadius: 15,
        maxRadius: 15,
        backgroundImage: AssetImage(Constantes.t2tiLogo),
      ),
      aboutBoxChildren: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Você está usando o T2Ti Pegasus PDV. \n\n"
          "Esse software é multi-plataforma e pode ser  \n"
          "encontrado nas diversas stores (Google, Apple e Microsoft) \n"
          "e também no site da T2Ti Sistemas no seguinte link: \n\n"
		      "https://t2tisistemas.com/ \n\n"
          "Caminho para o banco de dados: \n" + 
          Sessao.caminhoBancoDados,
        ),
      ],
      applicationName: Constantes.nomeApp,
      applicationVersion: Constantes.versaoApp,
      applicationLegalese: "Licença: MIT",      
    );
  }
}