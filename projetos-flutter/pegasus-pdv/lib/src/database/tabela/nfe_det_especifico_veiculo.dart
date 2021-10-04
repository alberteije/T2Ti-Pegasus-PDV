/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_DET_ESPECIFICO_VEICULO] 
                                                                                
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

@DataClassName("NfeDetEspecificoVeiculo")
class NfeDetEspecificoVeiculos extends Table {
  String get tableName => 'NFE_DET_ESPECIFICO_VEICULO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeDetalhe => integer().named('ID_NFE_DETALHE').nullable().customConstraint('NULLABLE REFERENCES NFE_DETALHE(ID)')();
  TextColumn get tipoOperacao => text().named('TIPO_OPERACAO').withLength(min: 0, max: 1).nullable()();
  TextColumn get chassi => text().named('CHASSI').withLength(min: 0, max: 17).nullable()();
  TextColumn get cor => text().named('COR').withLength(min: 0, max: 4).nullable()();
  TextColumn get descricaoCor => text().named('DESCRICAO_COR').withLength(min: 0, max: 40).nullable()();
  TextColumn get potenciaMotor => text().named('POTENCIA_MOTOR').withLength(min: 0, max: 4).nullable()();
  TextColumn get cilindradas => text().named('CILINDRADAS').withLength(min: 0, max: 4).nullable()();
  TextColumn get pesoLiquido => text().named('PESO_LIQUIDO').withLength(min: 0, max: 9).nullable()();
  TextColumn get pesoBruto => text().named('PESO_BRUTO').withLength(min: 0, max: 9).nullable()();
  TextColumn get numeroSerie => text().named('NUMERO_SERIE').withLength(min: 0, max: 9).nullable()();
  TextColumn get tipoCombustivel => text().named('TIPO_COMBUSTIVEL').withLength(min: 0, max: 2).nullable()();
  TextColumn get numeroMotor => text().named('NUMERO_MOTOR').withLength(min: 0, max: 21).nullable()();
  TextColumn get capacidadeMaximaTracao => text().named('CAPACIDADE_MAXIMA_TRACAO').withLength(min: 0, max: 9).nullable()();
  TextColumn get distanciaEixos => text().named('DISTANCIA_EIXOS').withLength(min: 0, max: 4).nullable()();
  TextColumn get anoModelo => text().named('ANO_MODELO').withLength(min: 0, max: 4).nullable()();
  TextColumn get anoFabricacao => text().named('ANO_FABRICACAO').withLength(min: 0, max: 4).nullable()();
  TextColumn get tipoPintura => text().named('TIPO_PINTURA').withLength(min: 0, max: 1).nullable()();
  TextColumn get tipoVeiculo => text().named('TIPO_VEICULO').withLength(min: 0, max: 2).nullable()();
  TextColumn get especieVeiculo => text().named('ESPECIE_VEICULO').withLength(min: 0, max: 1).nullable()();
  TextColumn get condicaoVin => text().named('CONDICAO_VIN').withLength(min: 0, max: 1).nullable()();
  TextColumn get condicaoVeiculo => text().named('CONDICAO_VEICULO').withLength(min: 0, max: 1).nullable()();
  TextColumn get codigoMarcaModelo => text().named('CODIGO_MARCA_MODELO').withLength(min: 0, max: 6).nullable()();
  TextColumn get codigoCorDenatran => text().named('CODIGO_COR_DENATRAN').withLength(min: 0, max: 2).nullable()();
  IntColumn get lotacaoMaxima => integer().named('LOTACAO_MAXIMA').nullable()();
  TextColumn get restricao => text().named('RESTRICAO').withLength(min: 0, max: 1).nullable()();
}