/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [ECF_R01] 
                                                                                
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

@DataClassName("EcfR01")
class EcfR01s extends Table {
  String get tableName => 'ECF_R01';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get serieEcf => text().named('SERIE_ECF').withLength(min: 0, max: 20).nullable()();
  TextColumn get cnpjEmpresa => text().named('CNPJ_EMPRESA').withLength(min: 0, max: 14).nullable()();
  TextColumn get cnpjSh => text().named('CNPJ_SH').withLength(min: 0, max: 14).nullable()();
  TextColumn get inscricaoEstadualSh => text().named('INSCRICAO_ESTADUAL_SH').withLength(min: 0, max: 14).nullable()();
  TextColumn get inscricaoMunicipalSh => text().named('INSCRICAO_MUNICIPAL_SH').withLength(min: 0, max: 14).nullable()();
  TextColumn get denominacaoSh => text().named('DENOMINACAO_SH').withLength(min: 0, max: 40).nullable()();
  TextColumn get nomePafEcf => text().named('NOME_PAF_ECF').withLength(min: 0, max: 40).nullable()();
  TextColumn get versaoPafEcf => text().named('VERSAO_PAF_ECF').withLength(min: 0, max: 10).nullable()();
  TextColumn get md5PafEcf => text().named('MD5_PAF_ECF').withLength(min: 0, max: 32).nullable()();
  DateTimeColumn get dataInicial => dateTime().named('DATA_INICIAL').nullable()();
  DateTimeColumn get dataFinal => dateTime().named('DATA_FINAL').nullable()();
  TextColumn get versaoEr => text().named('VERSAO_ER').withLength(min: 0, max: 4).nullable()();
  TextColumn get numeroLaudoPaf => text().named('NUMERO_LAUDO_PAF').withLength(min: 0, max: 40).nullable()();
  TextColumn get razaoSocialSh => text().named('RAZAO_SOCIAL_SH').withLength(min: 0, max: 40).nullable()();
  TextColumn get enderecoSh => text().named('ENDERECO_SH').withLength(min: 0, max: 40).nullable()();
  TextColumn get numeroSh => text().named('NUMERO_SH').withLength(min: 0, max: 10).nullable()();
  TextColumn get complementoSh => text().named('COMPLEMENTO_SH').withLength(min: 0, max: 40).nullable()();
  TextColumn get bairroSh => text().named('BAIRRO_SH').withLength(min: 0, max: 40).nullable()();
  TextColumn get cidadeSh => text().named('CIDADE_SH').withLength(min: 0, max: 40).nullable()();
  TextColumn get cepSh => text().named('CEP_SH').withLength(min: 0, max: 8).nullable()();
  TextColumn get ufSh => text().named('UF_SH').withLength(min: 0, max: 2).nullable()();
  TextColumn get telefoneSh => text().named('TELEFONE_SH').withLength(min: 0, max: 10).nullable()();
  TextColumn get contatoSh => text().named('CONTATO_SH').withLength(min: 0, max: 20).nullable()();
  TextColumn get principalExecutavel => text().named('PRINCIPAL_EXECUTAVEL').withLength(min: 0, max: 40).nullable()();
  TextColumn get hashRegistro => text().named('HASH_REGISTRO').withLength(min: 0, max: 32).nullable()();
}