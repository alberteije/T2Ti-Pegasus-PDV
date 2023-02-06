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

import 'package:pegasus_pdv/src/model/model.dart';
import 'package:pegasus_pdv/src/infra/infra.dart';

class RootModel {
	String? id;
	String? orderTiming;
	String? orderType;
	String? salesChannel;
	ScheduleModel? schedule;
	DeliveryModel? delivery;
	TakeoutModel? takeout;
	IndoorModel? indoor;
	String? displayId;
	DateTime? createdAt;
	DateTime? preparationStartDateTime;
	MerchantModel? merchant;
	CustomerModel? customer;
	TotalModel? total;
	PaymentsModel? payments;
	PickingModel? picking;
	bool? test;
	AdditionalInfoModel? additionalInfo;	
	List<ItemModel>? items = [];
	List<BenefitModel>? benefits = [];
	List<AdditionalFeeModel>? additionalFees = [];

	RootModel({
		id,
		orderTiming,
    orderType,
		salesChannel,
		schedule,
		delivery,
		takeout,
		indoor,
		displayId,
		createdAt,
		preparationStartDateTime,
		merchant,
		customer,
		total,
		payments,
		picking,
		test,
		additionalInfo,
		items,
		benefits,
		additionalFees,
	});

	RootModel.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		orderTiming = jsonDados['orderTiming'];
		orderType = jsonDados['orderType'];
		salesChannel = jsonDados['salesChannel'];
		schedule = jsonDados['schedule'] == null ? null : ScheduleModel.fromJson(jsonDados['schedule']);
		delivery = jsonDados['delivery'] == null ? null : DeliveryModel.fromJson(jsonDados['delivery']);
		takeout = jsonDados['takeout'] == null ? null : TakeoutModel.fromJson(jsonDados['takeout']);
		indoor = jsonDados['indoor'] == null ? null : IndoorModel.fromJson(jsonDados['indoor']);
		displayId = jsonDados['displayId'];
		createdAt = Biblioteca.tratarDataJson(jsonDados['createdAt']);
		preparationStartDateTime = Biblioteca.tratarDataJson(jsonDados['preparationStartDateTime']);
		merchant = jsonDados['merchant'] == null ? null : MerchantModel.fromJson(jsonDados['merchant']);
		customer = jsonDados['customer'] == null ? null : CustomerModel.fromJson(jsonDados['customer']);
		total = jsonDados['total'] == null ? null : TotalModel.fromJson(jsonDados['total']);
		payments = jsonDados['payments'] == null ? null : PaymentsModel.fromJson(jsonDados['payments']);
		picking = jsonDados['picking'] == null ? null : PickingModel.fromJson(jsonDados['picking']);
		test = jsonDados['test'] = jsonDados['test'];
		additionalInfo == null ? null : AdditionalInfoModel.fromJson(jsonDados['additionalInfo']);
		items = (jsonDados['items'] as Iterable?)?.map((m) => ItemModel.fromJson(m)).toList() ?? [];
		benefits = (jsonDados['benefits'] as Iterable?)?.map((m) => BenefitModel.fromJson(m)).toList() ?? [];
		additionalFees = (jsonDados['additionalFees'] as Iterable?)?.map((m) => AdditionalFeeModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = <String, dynamic>{};

		jsonDados['id'] = id;
		jsonDados['orderTiming'] = orderTiming;
		jsonDados['orderType'] = orderType;
		jsonDados['salesChannel'] = salesChannel;
		jsonDados['schedule'] = schedule == null ? null : schedule!.toJson;
		jsonDados['delivery'] = delivery == null ? null : delivery!.toJson;
		jsonDados['takeout'] = takeout == null ? null : takeout!.toJson;
		jsonDados['indoor'] = indoor == null ? null : indoor!.toJson;
		jsonDados['displayId'] = displayId;
		jsonDados['createdAt'] = createdAt;
		jsonDados['preparationStartDateTime'] = preparationStartDateTime;
		jsonDados['merchant'] = merchant == null ? null : merchant!.toJson;
		jsonDados['customer'] = customer == null ? null : customer!.toJson;
		jsonDados['total'] = total == null ? null : total!.toJson;
		jsonDados['payments'] = payments == null ? null : payments!.toJson;
		jsonDados['picking'] = picking == null ? null : picking!.toJson;
		jsonDados['test'] = test;
		jsonDados['additionalInfo'] = additionalInfo == null ? null : additionalInfo!.toJson;
		

		var listaItems = [];
		for (ItemModel objeto in items ?? []) {
			listaItems.add(objeto.toJson);
		}
		jsonDados['items'] = listaItems;

		var listaBenefits = [];
		for (BenefitModel objeto in benefits ?? []) {
			listaBenefits.add(objeto.toJson);
		}
		jsonDados['benefits'] = listaBenefits;
		

		var listaFees = [];
		for (AdditionalFeeModel objeto in additionalFees ?? []) {
			listaFees.add(objeto.toJson);
		}
		jsonDados['additionalFees'] = listaFees;
		
		return jsonDados;
	}
 
	String objetoEncodeJson() {
	  final jsonDados = toJson;
	  return json.encode(jsonDados);
	}
	
}