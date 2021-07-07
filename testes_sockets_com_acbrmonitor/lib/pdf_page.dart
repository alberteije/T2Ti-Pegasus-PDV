/*
Title: T2Ti ERP Fenix                                                                
Description: Página para exibição de um PDF
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2020 T2Ti.COM                                          
                                                                                
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
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
// import 'package:path_provider/path_provider.dart';

class PdfPage extends StatefulWidget {
  final String title;
  final Uint8List arquivoPdf;

  const PdfPage({Key key, this.title, this.arquivoPdf}) : super(key: key);

  @override
  PdfPageState createState() => PdfPageState();
}

class PdfPageState extends State<PdfPage> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) => prepararArquivo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[],
      ),
      body:PdfPreview(          
        maxPageWidth: 800,
        canChangePageFormat: false,
        build: (format) => widget.arquivoPdf,
      ),      
    );
  }

  // Future prepararArquivo() async {
  //   final diretorioTemporario = await getTemporaryDirectory();
  //   final arquivoPDF = await new File('${diretorioTemporario.path}/arquivo.pdf').create();
  //   await arquivoPDF.writeAsBytes(widget.arquivoPdf);
  //   setState(() {});
  // }

}
