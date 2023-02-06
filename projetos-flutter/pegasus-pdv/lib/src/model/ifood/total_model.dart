/*
Title: T2Ti ERP 3.0                                                                
Description: Classe para tratar entidade iFood
                                                                                
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
import 'dart:convert';

class TotalModel {
  double? subTotal;
  double? deliveryFee;
  double? additionalFees;
  double? benefits;
  double? orderAmount;

	TotalModel({
		this.subTotal,
		this.deliveryFee,
		this.additionalFees,
		this.benefits,
		this.orderAmount,
	});

	TotalModel.fromJson(Map<String, dynamic> jsonDados) {
		subTotal = jsonDados['subTotal']?.toDouble();
		deliveryFee = jsonDados['deliveryFee']?.toDouble();
		additionalFees = jsonDados['additionalFees']?.toDouble();
		benefits = jsonDados['benefits']?.toDouble();
		orderAmount = jsonDados['orderAmount']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = <String, dynamic>{};

		jsonDados['subTotal'] = subTotal;
		jsonDados['deliveryFee'] = deliveryFee;
		jsonDados['additionalFees'] = additionalFees;
		jsonDados['benefits'] = benefits;
		jsonDados['orderAmount'] = orderAmount;

		return jsonDados;
	}
 
	String objetoEncodeJson() {
	  final jsonDados = toJson;
	  return json.encode(jsonDados);
	}
	
}