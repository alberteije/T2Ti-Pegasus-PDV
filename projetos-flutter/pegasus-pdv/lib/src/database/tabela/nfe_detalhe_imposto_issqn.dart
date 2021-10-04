/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_DETALHE_IMPOSTO_ISSQN] 
                                                                                
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

@DataClassName("NfeDetalheImpostoIssqn")
class NfeDetalheImpostoIssqns extends Table {
  String get tableName => 'NFE_DETALHE_IMPOSTO_ISSQN';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeDetalhe => integer().named('ID_NFE_DETALHE').nullable().customConstraint('NULLABLE REFERENCES NFE_DETALHE(ID)')();
  RealColumn get baseCalculoIssqn => real().named('BASE_CALCULO_ISSQN').nullable()();
  RealColumn get aliquotaIssqn => real().named('ALIQUOTA_ISSQN').nullable()();
  RealColumn get valorIssqn => real().named('VALOR_ISSQN').nullable()();
  IntColumn get municipioIssqn => integer().named('MUNICIPIO_ISSQN').nullable()();
  IntColumn get itemListaServicos => integer().named('ITEM_LISTA_SERVICOS').nullable()();
  RealColumn get valorDeducao => real().named('VALOR_DEDUCAO').nullable()();
  RealColumn get valorOutrasRetencoes => real().named('VALOR_OUTRAS_RETENCOES').nullable()();
  RealColumn get valorDescontoIncondicionado => real().named('VALOR_DESCONTO_INCONDICIONADO').nullable()();
  RealColumn get valorDescontoCondicionado => real().named('VALOR_DESCONTO_CONDICIONADO').nullable()();
  RealColumn get valorRetencaoIss => real().named('VALOR_RETENCAO_ISS').nullable()();
  TextColumn get indicadorExigibilidadeIss => text().named('INDICADOR_EXIGIBILIDADE_ISS').withLength(min: 0, max: 1).nullable()();
  TextColumn get codigoServico => text().named('CODIGO_SERVICO').withLength(min: 0, max: 20).nullable()();
  IntColumn get municipioIncidencia => integer().named('MUNICIPIO_INCIDENCIA').nullable()();
  IntColumn get paisSevicoPrestado => integer().named('PAIS_SEVICO_PRESTADO').nullable()();
  TextColumn get numeroProcesso => text().named('NUMERO_PROCESSO').withLength(min: 0, max: 30).nullable()();
  TextColumn get indicadorIncentivoFiscal => text().named('INDICADOR_INCENTIVO_FISCAL').withLength(min: 0, max: 1).nullable()();
}