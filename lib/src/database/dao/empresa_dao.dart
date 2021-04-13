/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [EMPRESA] 
                                                                                
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

import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

part 'empresa_dao.g.dart';

@UseDao(tables: [
          Empresas,
		])
class EmpresaDao extends DatabaseAccessor<AppDatabase> with _$EmpresaDaoMixin {
  final AppDatabase db;

  List<Empresa> listaEmpresa; // será usada para popular a grid na janela do empresa

  EmpresaDao(this.db) : super(db);

  Future<List<Empresa>> consultarLista() async {
    listaEmpresa = await select(empresas).get();
    return listaEmpresa;
  }

  Future<List<Empresa>> consultarListaFiltro(String campo, String valor) async {
    listaEmpresa = await (customSelect("SELECT * FROM EMPRESA WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { empresas }).map((row) {
                                  return Empresa.fromData(row.data, db);  
                                }).get());
    return listaEmpresa;
  }

  Stream<List<Empresa>> observarLista() => select(empresas).watch();

  Future<Empresa> consultarObjeto(int pId) {
    return (select(empresas)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<Empresa> pObjeto) {
    return transaction(() async {
      final idInserido = await into(empresas).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<Empresa> pObjeto) {
    return transaction(() async {
      return update(empresas).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<Empresa> pObjeto) {
    return transaction(() async {
      return delete(empresas).delete(pObjeto);
    });    
  }

	static List<String> campos = <String>[
		'ID', 
		'RAZAO_SOCIAL', 
		'NOME_FANTASIA', 
		'CNPJ', 
		'INSCRICAO_ESTADUAL', 
		'INSCRICAO_MUNICIPAL', 
		'DATA_CONSTITUICAO', 
		'TIPO', 
		'EMAIL', 
		'LOGRADOURO', 
		'NUMERO', 
		'COMPLEMENTO', 
		'CEP', 
		'BAIRRO', 
		'CIDADE', 
		'UF', 
		'FONE', 
		'CONTATO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Razao Social', 
		'Nome Fantasia', 
		'Cnpj', 
		'Inscricao Estadual', 
		'Inscricao Municipal', 
		'Data Constituicao', 
		'Tipo', 
		'Email', 
		'Logradouro', 
		'Numero', 
		'Complemento', 
		'Cep', 
		'Bairro', 
		'Cidade', 
		'Uf', 
		'Fone', 
		'Contato', 
	];
  
}