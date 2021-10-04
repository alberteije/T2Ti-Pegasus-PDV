/*
Title: T2Ti ERP 3.0                                                                
Description: Contém alguns widgets utilizados nas páginas do caixa (PDV)
                                                                                
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

Container getItemResumoValor({String descricao, String valor, Color corFundo,}) {
  return Container(
    padding: EdgeInsets.only(top: 0.0, left: 10.0, right: 10.0, bottom: 3.0),
    child: Card(
      color: corFundo,
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: <Widget>[
            Text(descricao, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
            SizedBox(
              width: 5,
            ),
            Spacer(),
            Text(valor, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    ),
  );
}

Card getCardValorUnitario({BuildContext context, double valorUnitario}) {
  return Card(
    elevation: 0.5,
    child: Container(
      width: Biblioteca.isTelaPequena(context) ? 60 : 120,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          Constantes.formatoDecimalValor.format(valorUnitario), 
          textAlign: TextAlign.right,
          style: TextStyle(
            fontWeight: FontWeight.w600, 
            fontSize: Biblioteca.isTelaPequena(context) ? 11.0 : 14.0,
          ),
        )
      ),
    ),
  );
}

Card getCardQuantidade({BuildContext context, double quantidade}) {
  return Card(
    child: Container(
      width: Biblioteca.isTelaPequena(context) ? 50 : 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          Constantes.formatoDecimalQuantidade.format(quantidade), 
          textAlign: TextAlign.right,
          style: TextStyle(
            fontWeight: FontWeight.w600, 
            fontSize: Biblioteca.isTelaPequena(context) ? 11.0 : 14.0,
          ),
        )
      ),
    ),
  );
}

Card getCardValorTotal({BuildContext context, double valorTotal}) {
  return Card(
    elevation: 0.5,
    child: Container(
      width: Biblioteca.isTelaPequena(context) ? 80 : 120,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          Constantes.formatoDecimalValor.format(valorTotal), 
          textAlign: TextAlign.right,
          style: TextStyle(
            fontWeight: FontWeight.w800, 
            fontSize: Biblioteca.isTelaPequena(context) ? 13.0 : 16.0,
          ),
        ),
      ),
    ),
  );
}