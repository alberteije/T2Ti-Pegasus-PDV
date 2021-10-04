/*
Title: T2Ti ERP 3.0                                                              
Description: Model Transiente para o cliente - Tipo do Plano do PDV
tabela existe apenas na retaguarda da SH
                                                                                
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
import 'dart:convert';

class PdvTipoPlanoModel {
	int id;
	String modulo; //G=GRATIS - F=FISCAL - P=PREMIUM 
	String plano; //M=MENSAL - S=SEMESTRAL - A=ANUAL 
	String moduloFiscal; // NFC - SAT - MFE
  double valor;

	PdvTipoPlanoModel({
			this.id,
			this.modulo,
			this.plano,
			this.moduloFiscal,
			this.valor = 0.0,
		});

	PdvTipoPlanoModel.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		modulo = jsonDados['modulo'];
		plano = getPlano(jsonDados['plano']);
		moduloFiscal = jsonDados['moduloFiscal'];
		valor = jsonDados['valor'] != null ? jsonDados['valor'].toDouble() : null;
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['modulo'] = this.modulo;
		jsonDados['plano'] = this.plano;
		jsonDados['moduloFiscal'] = this.moduloFiscal;
		jsonDados['valor'] = this.valor;
	
		return jsonDados;
	}
	
  getPlano(String plano) {
    switch (plano) {
      case 'M':
        return 'Mensal';
        break;
      case 'S':
        return 'Semestral';
        break;
      case 'A':
        return 'Anual';
        break;
      default:
        return null;
      }
    }

	String objetoEncodeJson(PdvTipoPlanoModel objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}