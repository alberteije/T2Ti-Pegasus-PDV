/*
Title: T2Ti ERP 3.0                                                                
Description: Contém alguns widgets de input, onde o usuário preenche dados
                                                                                
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


/// InputDecoration utilizada nas páginas de Persistência
///
/// Os argumentos passados são os mesmos utilizados pela InputDecoration.
/// Temos no entanto uma novidade:
/// [aplicaPadding] deve ser true para controles que o necessitem, tais como DropDownButton e DatePickerItem.
/// Os demais controles devem aplicar o padding padrão.
InputDecoration getInputDecoration(
    String hintText, String labelText, bool aplicaPadding, 
    {double paddingVertical, double paddingHorizontal, Color cor}
    ) {
  return InputDecoration(
    fillColor: cor,
    border: UnderlineInputBorder(),
    hintText: hintText,
    labelText: labelText,
    filled: true,
    contentPadding: aplicaPadding
        ? EdgeInsets.symmetric(
          vertical: paddingVertical == null ? 5 : paddingVertical, 
          horizontal: paddingHorizontal == null ? 10: paddingHorizontal, 
        )
        : null,
  );
}

/// Retorna um DropdownButton
DropdownButtonFormField<String> getDropDownButton(
    String value, Function(String) onChanged, List<String> items, {Function(String) validator}) {
  return DropdownButtonFormField<String>(    
    isExpanded: true,
    value: value,
    onChanged: onChanged,
    validator: validator,
    items: items.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}