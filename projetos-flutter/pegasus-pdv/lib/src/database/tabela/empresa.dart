/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [EMPRESA] 
                                                                                
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

@DataClassName("Empresa")
class Empresas extends Table {
  String get tableName => 'EMPRESA';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get razaoSocial => text().named('RAZAO_SOCIAL').withLength(min: 0, max: 150).nullable()();
  TextColumn get nomeFantasia => text().named('NOME_FANTASIA').withLength(min: 0, max: 150).nullable()();
  TextColumn get cnpj => text().named('CNPJ').withLength(min: 0, max: 14).nullable()();
  TextColumn get inscricaoEstadual => text().named('INSCRICAO_ESTADUAL').withLength(min: 0, max: 30).nullable()();
  TextColumn get inscricaoMunicipal => text().named('INSCRICAO_MUNICIPAL').withLength(min: 0, max: 30).nullable()();
  TextColumn get tipoRegime => text().named('TIPO_REGIME').withLength(min: 0, max: 1).nullable()(); //"1-Lucro REAL" - "2-Lucro presumido" - "3-Simples nacional"
  TextColumn get crt => text().named('CRT').withLength(min: 0, max: 1).nullable()(); // "1-Simples Nacional" - "2-Simples Nacional - excesso de sublimite da receita bruta" - "3-Regime Normal"
  DateTimeColumn get dataConstituicao => dateTime().named('DATA_CONSTITUICAO').nullable()();
  TextColumn get tipo => text().named('TIPO').withLength(min: 0, max: 1).nullable()(); // "M=Matriz" - "F=Filial"
  TextColumn get email => text().named('EMAIL').withLength(min: 0, max: 250).nullable()();
  RealColumn get aliquotaPis => real().named('ALIQUOTA_PIS').nullable()();
  RealColumn get aliquotaCofins => real().named('ALIQUOTA_COFINS').nullable()();
  TextColumn get logradouro => text().named('LOGRADOURO').withLength(min: 0, max: 250).nullable()();
  TextColumn get numero => text().named('NUMERO').withLength(min: 0, max: 10).nullable()();
  TextColumn get complemento => text().named('COMPLEMENTO').withLength(min: 0, max: 100).nullable()();
  TextColumn get cep => text().named('CEP').withLength(min: 0, max: 9).nullable()();
  TextColumn get bairro => text().named('BAIRRO').withLength(min: 0, max: 100).nullable()();
  TextColumn get cidade => text().named('CIDADE').withLength(min: 0, max: 100).nullable()();
  TextColumn get uf => text().named('UF').withLength(min: 0, max: 2).nullable()();
  TextColumn get fone => text().named('FONE').withLength(min: 0, max: 15).nullable()();
  TextColumn get contato => text().named('CONTATO').withLength(min: 0, max: 30).nullable()();
  IntColumn get codigoIbgeCidade => integer().named('CODIGO_IBGE_CIDADE').nullable()();
  IntColumn get codigoIbgeUf => integer().named('CODIGO_IBGE_UF').nullable()();
  BlobColumn get logotipo => blob().named('LOGOTIPO').nullable()();
  BoolColumn get registrado => boolean().named('REGISTRADO').nullable()();
  TextColumn get naturezaJuridica => text().named('NATUREZA_JURIDICA').withLength(min: 0, max: 200).nullable()();
  TextColumn get emailPagamento => text().named('EMAIL_PAGAMENTO').withLength(min: 0, max: 250).nullable()();
  BoolColumn get simei => boolean().named('SIMEI').nullable()();
  DateTimeColumn get dataRegistro => dateTime().named('DATA_REGISTRO').nullable()();
  TextColumn get horaRegistro => text().named('HORA_REGISTRO').withLength(min: 0, max: 8).nullable()();
}