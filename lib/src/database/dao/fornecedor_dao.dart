/*
Title: T2Ti ERP Pegasus                                                                
Description: DAO relacionado à tabela [FORNECEDOR] 
                                                                                
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

part 'fornecedor_dao.g.dart';

@UseDao(tables: [
          Fornecedors,
		])
class FornecedorDao extends DatabaseAccessor<AppDatabase> with _$FornecedorDaoMixin {
  final AppDatabase db;

  List<Fornecedor> listaFornecedor; // será usada para popular a grid na janela do fornecedor

  FornecedorDao(this.db) : super(db);

  Future<List<Fornecedor>> consultarLista() async {
    listaFornecedor = await select(fornecedors).get();
    return listaFornecedor;
  }

  Future<List<Fornecedor>> consultarListaFiltro(String campo, String valor) async {
    listaFornecedor = await (customSelect("SELECT * FROM FORNECEDOR WHERE " + campo + " like '%" + valor + "%'", 
                                readsFrom: { fornecedors }).map((row) {
                                  return Fornecedor.fromData(row.data, db);  
                                }).get());
    return listaFornecedor;
  }

  Stream<List<Fornecedor>> observarLista() => select(fornecedors).watch();

  Future<Fornecedor> consultarObjeto(int pId) {
    return (select(fornecedors)..where((t) => t.id.equals(pId))).getSingleOrNull();
  } 

  Future<int> inserir(Insertable<Fornecedor> pObjeto) {
    return transaction(() async {
      final idInserido = await into(fornecedors).insert(pObjeto);
      return idInserido;
    });    
  } 

  Future<bool> alterar(Insertable<Fornecedor> pObjeto) {
    return transaction(() async {
      return update(fornecedors).replace(pObjeto);
    });    
  } 

  Future<int> excluir(Insertable<Fornecedor> pObjeto) {
    return transaction(() async {
      return delete(fornecedors).delete(pObjeto);
    });    
  }

	static List<String> campos = <String>[
		'ID', 
		'NOME', 
		'FANTASIA', 
		'EMAIL', 
		'URL', 
		'CPF_CNPJ', 
		'RG', 
		'ORGAO_RG', 
		'DATA_EMISSAO_RG', 
		'SEXO', 
		'INSCRICAO_ESTADUAL', 
		'INSCRICAO_MUNICIPAL', 
		'TIPO_PESSOA', 
		'DATA_CADASTRO', 
		'LOGRADOURO', 
		'NUMERO', 
		'COMPLEMENTO', 
		'CEP', 
		'BAIRRO', 
		'CIDADE', 
		'UF', 
		'TELEFONE', 
		'CELULAR', 
		'CONTATO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Nome', 
		'Fantasia', 
		'Email', 
		'Url', 
		'Cpf Cnpj', 
		'Rg', 
		'Orgao Rg', 
		'Data Emissao Rg', 
		'Sexo', 
		'Inscricao Estadual', 
		'Inscricao Municipal', 
		'Tipo Pessoa', 
		'Data Cadastro', 
		'Logradouro', 
		'Numero', 
		'Complemento', 
		'Cep', 
		'Bairro', 
		'Cidade', 
		'Uf', 
		'Telefone', 
		'Celular', 
		'Contato', 
	];

  
}