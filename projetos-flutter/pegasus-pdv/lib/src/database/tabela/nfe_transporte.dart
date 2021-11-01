/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_TRANSPORTE] 
                                                                                
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

@DataClassName("NfeTransporte")
class NfeTransportes extends Table {
  @override
  String get tableName => 'NFE_TRANSPORTE';

  IntColumn? get id => integer().named('ID').autoIncrement()();
  IntColumn? get idNfeCabecalho => integer().named('ID_NFE_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES NFE_CABECALHO(ID)')() as Column<int>?;
  TextColumn? get modalidadeFrete => text().named('MODALIDADE_FRETE').withLength(min: 0, max: 1).nullable()() as Column<String>?;
  TextColumn? get cnpj => text().named('CNPJ').withLength(min: 0, max: 14).nullable()() as Column<String>?;
  TextColumn? get cpf => text().named('CPF').withLength(min: 0, max: 11).nullable()() as Column<String>?;
  TextColumn? get nome => text().named('NOME').withLength(min: 0, max: 60).nullable()() as Column<String>?;
  TextColumn? get inscricaoEstadual => text().named('INSCRICAO_ESTADUAL').withLength(min: 0, max: 14).nullable()() as Column<String>?;
  TextColumn? get endereco => text().named('ENDERECO').withLength(min: 0, max: 60).nullable()() as Column<String>?;
  TextColumn? get nomeMunicipio => text().named('NOME_MUNICIPIO').withLength(min: 0, max: 60).nullable()() as Column<String>?;
  TextColumn? get uf => text().named('UF').withLength(min: 0, max: 2).nullable()() as Column<String>?;
  RealColumn? get valorServico => real().named('VALOR_SERVICO').nullable()() as Column<double>?;
  RealColumn? get valorBcRetencaoIcms => real().named('VALOR_BC_RETENCAO_ICMS').nullable()() as Column<double>?;
  RealColumn? get aliquotaRetencaoIcms => real().named('ALIQUOTA_RETENCAO_ICMS').nullable()() as Column<double>?;
  RealColumn? get valorIcmsRetido => real().named('VALOR_ICMS_RETIDO').nullable()() as Column<double>?;
  IntColumn? get cfop => integer().named('CFOP').nullable()() as Column<int>?;
  IntColumn? get municipio => integer().named('MUNICIPIO').nullable()() as Column<int>?;
  TextColumn? get placaVeiculo => text().named('PLACA_VEICULO').withLength(min: 0, max: 7).nullable()() as Column<String>?;
  TextColumn? get ufVeiculo => text().named('UF_VEICULO').withLength(min: 0, max: 2).nullable()() as Column<String>?;
  TextColumn? get rntcVeiculo => text().named('RNTC_VEICULO').withLength(min: 0, max: 20).nullable()() as Column<String>?;
}