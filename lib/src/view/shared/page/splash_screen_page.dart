/*
Title: T2Ti ERP 3.0                                                                
Description: Janela de Splash
                                                                                
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
import 'package:pegasus_pdv/src/infra/infra.dart';

class SplashScreenPage extends StatelessWidget {
  @override  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.blueGrey),
          ),
          FittedBox(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 300,
                  width: 300,
                  child: Image.asset(
                    Constantes.t2tiLogoPegasusPdv,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "T2Ti Pegasus PDV",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
                ),
                SizedBox( 
                  height: 10.0,
                ),
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                Text(
                  "Bem-vindo. Aguarde um momento.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                  ),                   
                ),
                SizedBox( 
                  height: 10.0,
                ),
              ],
            ),
          ),
        ],
       ),   
      
       
      
      
    //    Stack(
    //     fit: StackFit.expand,
    //     children: <Widget>[
    //       Container(
    //         decoration: BoxDecoration(color: Colors.blueGrey),
    //       ),
    //       FittedBox(    

    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: <Widget>[
    //           Expanded(
    //            flex: 2,
    //            child: Container(
    //              child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //                children: <Widget>[
    //                 // FittedBox(    
    //                 //   alignment: Alignment.center,  
    //                 //   fit: BoxFit.cover,               
    //                 Container(
    //                   margin: EdgeInsets.symmetric(horizontal: 20),
    //                   height: 300,
    //                   child: Image.asset(
    //                     Constantes.t2tiLogoPegasusPdv,
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 10.0,
    //                 ),
    //                 Text(
    //                    "T2Ti Pegasus PDV",
    //                    style: TextStyle(
    //                      color: Colors.white,
    //                      fontSize: 25.0,
    //                      fontWeight: FontWeight.bold),
    //                  ),
    //                ],
    //              ),
    //            ),
    //           ),
    //           // Expanded(
    //           //   flex: 1,
    //           //   child: Column(
    //           //     mainAxisAlignment: MainAxisAlignment.center,
    //           //     children: <Widget>[
    //           //       CircularProgressIndicator(),
    //           //       Padding(
    //           //         padding: EdgeInsets.only(top: 20.0),
    //           //       ),
    //           //       Text(
    //           //         "Bem-vindo. Aguarde um momento.",
    //           //         style: TextStyle(
    //           //           color: Colors.white,
    //           //           fontSize: 18.0,
    //           //           fontWeight: FontWeight.bold
    //           //         ),                   
    //           //       )
    //           //     ],
    //           //   ),
    //           // )
    //         ],
    //       ),
    //       ),
    //     ],
    //   ),
    );
  }
}