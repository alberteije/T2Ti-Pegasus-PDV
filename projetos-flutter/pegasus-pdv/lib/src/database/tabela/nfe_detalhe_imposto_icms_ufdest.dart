/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_DETALHE_IMPOSTO_ICMS_UFDEST] 
                                                                                
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
import 'package:moor/moor.dart';

@DataClassName("NfeDetalheImpostoIcmsUfdest")
class NfeDetalheImpostoIcmsUfdests extends Table {
  String get tableName => 'NFE_DETALHE_IMPOSTO_ICMS_UFDEST';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeDetalhe => integer().named('ID_NFE_DETALHE').nullable().customConstraint('NULLABLE REFERENCES NFE_DETALHE(ID)')();
  RealColumn get valorBcIcmsUfDestino => real().named('VALOR_BC_ICMS_UF_DESTINO').nullable()();
  RealColumn get valorBcFcpUfDestino => real().named('VALOR_BC_FCP_UF_DESTINO').nullable()();
  RealColumn get percentualFcpUfDestino => real().named('PERCENTUAL_FCP_UF_DESTINO').nullable()();
  RealColumn get aliquotaInternaUfDestino => real().named('ALIQUOTA_INTERNA_UF_DESTINO').nullable()();
  RealColumn get aliquotaInteresdatualUfEnvolvidas => real().named('ALIQUOTA_INTERESDATUAL_UF_ENVOLVIDAS').nullable()();
  RealColumn get percentualProvisorioPartilhaIcms => real().named('PERCENTUAL_PROVISORIO_PARTILHA_ICMS').nullable()();
  RealColumn get valorIcmsFcpUfDestino => real().named('VALOR_ICMS_FCP_UF_DESTINO').nullable()();
  RealColumn get valorInterestadualUfDestino => real().named('VALOR_INTERESTADUAL_UF_DESTINO').nullable()();
  RealColumn get valorInterestadualUfRemetente => real().named('VALOR_INTERESTADUAL_UF_REMETENTE').nullable()();
}