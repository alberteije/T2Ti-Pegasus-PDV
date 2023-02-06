/*
Title: T2Ti ERP 3.0                                                                
Description: Model que exporta os demais Models
                                                                                
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

// módulo cadastros
export 'package:pegasus_pdv/src/model/cadastros/usuario_model.dart';
export 'package:pegasus_pdv/src/model/cadastros/empresa_model.dart';
export 'package:pegasus_pdv/src/model/cadastros/empresa_consulta_publica.dart';
export 'package:pegasus_pdv/src/model/cadastros/pdv_tipo_plano_model.dart';

// nfce
export 'package:pegasus_pdv/src/model/nfce/nfce_plano_pagamento_model.dart';
export 'package:pegasus_pdv/src/model/nfce/nfe_configuracao_model.dart';

// transiente
export 'package:pegasus_pdv/src/model/transiente/filtro.dart';
export 'package:pegasus_pdv/src/model/transiente/objeto_nfe.dart';
export 'package:pegasus_pdv/src/model/transiente/objeto_sincroniza.dart';
export 'package:pegasus_pdv/src/model/transiente/retorno_json_erro.dart';

// ifood
export 'package:pegasus_pdv/src/model/ifood/schedule_model.dart';
export 'package:pegasus_pdv/src/model/ifood/coordinates_model.dart';
export 'package:pegasus_pdv/src/model/ifood/delivery_model.dart';
export 'package:pegasus_pdv/src/model/ifood/delivery_address_model.dart';
export 'package:pegasus_pdv/src/model/ifood/takeout_model.dart';
export 'package:pegasus_pdv/src/model/ifood/indoor_model.dart';
export 'package:pegasus_pdv/src/model/ifood/merchant_model.dart';
export 'package:pegasus_pdv/src/model/ifood/phone_model.dart';
export 'package:pegasus_pdv/src/model/ifood/customer_model.dart';
export 'package:pegasus_pdv/src/model/ifood/option_model.dart';
export 'package:pegasus_pdv/src/model/ifood/item_model.dart';
export 'package:pegasus_pdv/src/model/ifood/sponsorship_value_model.dart';
export 'package:pegasus_pdv/src/model/ifood/benefit_model.dart';
export 'package:pegasus_pdv/src/model/ifood/additional_fee_model.dart';
export 'package:pegasus_pdv/src/model/ifood/total_model.dart';
export 'package:pegasus_pdv/src/model/ifood/method_model.dart';
export 'package:pegasus_pdv/src/model/ifood/payments_model.dart';
export 'package:pegasus_pdv/src/model/ifood/picking_model.dart';
export 'package:pegasus_pdv/src/model/ifood/metadata_model.dart';
export 'package:pegasus_pdv/src/model/ifood/additional_info_model.dart';
export 'package:pegasus_pdv/src/model/ifood/root_model.dart';

