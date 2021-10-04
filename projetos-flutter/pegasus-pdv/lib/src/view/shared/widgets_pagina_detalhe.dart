/*
Title: T2Ti ERP 3.0                                                                
Description: Contém alguns widgets utilizados na página de detalhe
                                                                                
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
import 'package:flutter/services.dart';

/// Retorna o Padding para a página de detalhe - cabeçalho da página
Padding getPaddingDetalhePage(String titulo) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Text(
      titulo,
      style: TextStyle(color: Colors.grey.shade700),
    ),
  );
}

/// Retorna o Theme para a página de detalhe
ThemeData getThemeDataDetalhePage(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    platform: Theme.of(context).platform,
  );
}

/// Retorna o ListTile para a página de detalhe
ListTile getListTileDataDetalhePage(String title, String subtitle) {
  return ListTile(
    leading: Icon(
      Icons.arrow_right,
      color: Colors.grey,
    ),
    title: Text(title),
    subtitle: Text(subtitle),
  );
}

/// Retorna o ListTile para a página de detalhe - campos do tipo Id
ListTile getListTileDataDetalhePageId(String title, String subtitle) {
  return ListTile(
    leading: Icon(
      Icons.vpn_key,
      color: Colors.blue,
    ),
    title: Text(title),
    subtitle: Text(subtitle),
  );
}