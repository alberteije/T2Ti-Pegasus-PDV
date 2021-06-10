/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_DET_ESPECIFICO_COMBUSTIVEL] 
                                                                                
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

@DataClassName("NfeDetEspecificoCombustivel")
class NfeDetEspecificoCombustivels extends Table {
  String get tableName => 'NFE_DET_ESPECIFICO_COMBUSTIVEL';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeDetalhe => integer().named('ID_NFE_DETALHE').nullable().customConstraint('NULLABLE REFERENCES NFE_DETALHE(ID)')();
  IntColumn get codigoAnp => integer().named('CODIGO_ANP').nullable()();
  TextColumn get descricaoAnp => text().named('DESCRICAO_ANP').withLength(min: 0, max: 95).nullable()();
  RealColumn get percentualGlp => real().named('PERCENTUAL_GLP').nullable()();
  RealColumn get percentualGasNacional => real().named('PERCENTUAL_GAS_NACIONAL').nullable()();
  RealColumn get percentualGasImportado => real().named('PERCENTUAL_GAS_IMPORTADO').nullable()();
  RealColumn get valorPartida => real().named('VALOR_PARTIDA').nullable()();
  TextColumn get codif => text().named('CODIF').withLength(min: 0, max: 21).nullable()();
  RealColumn get quantidadeTempAmbiente => real().named('QUANTIDADE_TEMP_AMBIENTE').nullable()();
  TextColumn get ufConsumo => text().named('UF_CONSUMO').withLength(min: 0, max: 2).nullable()();
  RealColumn get cideBaseCalculo => real().named('CIDE_BASE_CALCULO').nullable()();
  RealColumn get cideAliquota => real().named('CIDE_ALIQUOTA').nullable()();
  RealColumn get cideValor => real().named('CIDE_VALOR').nullable()();
  IntColumn get encerranteBico => integer().named('ENCERRANTE_BICO').nullable()();
  IntColumn get encerranteBomba => integer().named('ENCERRANTE_BOMBA').nullable()();
  IntColumn get encerranteTanque => integer().named('ENCERRANTE_TANQUE').nullable()();
  RealColumn get encerranteValorInicio => real().named('ENCERRANTE_VALOR_INICIO').nullable()();
  RealColumn get encerranteValorFim => real().named('ENCERRANTE_VALOR_FIM').nullable()();
}