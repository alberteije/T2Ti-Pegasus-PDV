/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Service relacionado à sincronização de dados
                                                                                
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
package com.t2ti.retaguarda_sh.service.sincroniza;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.apache.commons.text.CaseUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.t2ti.retaguarda_sh.model.cadastros.Empresa;
import com.t2ti.retaguarda_sh.model.sincroniza.ObjetoSincroniza;
import com.t2ti.retaguarda_sh.service.cadastros.EmpresaService;

@Service
public class SincronizaService {
	
	@Autowired
	private EmpresaService empresaService;
	
	@PersistenceContext
    private EntityManager entityManager;	

	List<String> listaTabelaCentral = Arrays.asList(
		"TRIBUT_ICMS_CUSTOM_CAB",
		"TRIBUT_ICMS_CUSTOM_DET",
		"TRIBUT_OPERACAO_FISCAL",
		"TRIBUT_GRUPO_TRIBUTARIO",
		"TRIBUT_CONFIGURA_OF_GT",
		"TRIBUT_COFINS",
		"TRIBUT_ICMS_UF",
		"TRIBUT_IPI",
		"TRIBUT_ISS",
		"TRIBUT_PIS",
		"CLIENTE",
		"COLABORADOR",
		"FORNECEDOR",
		"PRODUTO_GRUPO",
		"PRODUTO_SUBGRUPO",
		"PRODUTO_TIPO",
		"PRODUTO_UNIDADE",
		"PRODUTO",
		"PRODUTO_FICHA_TECNICA",
		"PRODUTO_IMAGEM",
		"PDV_TIPO_PAGAMENTO",
		"PRODUTO_PROMOCAO",
		"COMPRA_PEDIDO_CABECALHO",
		"COMPRA_PEDIDO_DETALHE",
		"CONTAS_PAGAR",
		"CONTAS_RECEBER"
	); 

	List<String> listaTabelaCentralDelete = Arrays.asList(
		"TRIBUT_ICMS_CUSTOM_DET",
		"TRIBUT_ICMS_CUSTOM_CAB",
		"TRIBUT_COFINS",
		"TRIBUT_ICMS_UF",
		"TRIBUT_IPI",
		"TRIBUT_PIS",
		"TRIBUT_CONFIGURA_OF_GT",
		"TRIBUT_OPERACAO_FISCAL",
		"PRODUTO_IMAGEM",
		"PRODUTO_FICHA_TECNICA",
		"PRODUTO_PROMOCAO",
		"PDV_TIPO_PAGAMENTO",
		"COMPRA_PEDIDO_DETALHE",
		"COMPRA_PEDIDO_CABECALHO",
		"CONTAS_PAGAR",
		"CONTAS_RECEBER",
		"PRODUTO",
		"TRIBUT_GRUPO_TRIBUTARIO",
		"PRODUTO_SUBGRUPO",
		"PRODUTO_GRUPO",
		"PRODUTO_TIPO",
		"PRODUTO_UNIDADE",
		"CLIENTE",
		"COLABORADOR",
		"FORNECEDOR"
	); 
	
	List<String> listaTabelaLocal = Arrays.asList(
		"PDV_MOVIMENTO",
		"PDV_FECHAMENTO",
		"PDV_SANGRIA",
		"PDV_SUPRIMENTO",
		"PDV_VENDA_CABECALHO",
		"PDV_VENDA_DETALHE",
		"PDV_TOTAL_TIPO_PAGAMENTO",
		"NFE_CABECALHO",
		"NFE_DESTINATARIO",
		"NFE_DETALHE",
		"NFE_DETALHE_IMPOSTO_COFINS",
		"NFE_DETALHE_IMPOSTO_ICMS",
		"NFE_DETALHE_IMPOSTO_PIS",
		"NFE_INFORMACAO_PAGAMENTO",
		"NFE_NUMERO",
		"NFE_NUMERO_INUTILIZADO"
	);	
	
	@Transactional
	public void sincronizarServidor(String bancoSQLite64, String cnpj) throws FileNotFoundException, IOException, SQLException, NoSuchFieldException, SecurityException {
		String filtro = "CNPJ = '" + cnpj + "'";
		Empresa empresa = empresaService.consultarObjetoFiltro(filtro);
		if (empresa != null) {
            String caminhoComCnpj = "C:\\ACBrMonitor\\" + empresa.getCnpj() + "\\";
    	    String caminhoArquivoSQLite = caminhoComCnpj + "sqlite\\" + empresa.getCnpj() + ".sqlite";

		    // converte e salva o arquivo do banco em disco
			byte[] bancoSQLiteBytes = Base64.getDecoder().decode(bancoSQLite64);
			FileOutputStream fileOutputStream = new FileOutputStream(caminhoArquivoSQLite);
			fileOutputStream.write(bancoSQLiteBytes);
			fileOutputStream.close();
    	    
			Connection conexaoSQLite = null;
            String urlSQLite = "jdbc:sqlite:" + caminhoArquivoSQLite;

			Connection conexaoMySQL = null;
            String urlMySQL = "jdbc:mysql://localhost/pegasus_" + cnpj;
            String usuarioMySQL = "root";
            String senhaMySQL = "root";	            

            ResultSet resultSetMeta = null;
            ResultSet resultSetQuery = null;
            PreparedStatement stmt = null;

            List<String> listaColunas = new ArrayList<String>();
            List<String> listaInserts = new ArrayList<String>();
            List<String> listaDeletes = new ArrayList<String>();
            
			try {
	            conexaoSQLite = DriverManager.getConnection(urlSQLite);	            
	            DatabaseMetaData metadata = conexaoSQLite.getMetaData();	            
	            
	            for (String tabela : listaTabelaCentralDelete) {
	            	String sqlDelete = "DELETE FROM " + tabela;
	            	listaDeletes.add(sqlDelete);
	            }
	            
	            for (String tabela : listaTabelaCentral) {	            		            
		            listaColunas.clear();
	
	            	// insere o nome das colunas no array
	            	resultSetMeta = metadata.getColumns(null, null, tabela, null);
		            while (resultSetMeta.next()) {
		            	listaColunas.add(resultSetMeta.getString("COLUMN_NAME"));
		            }
		            
		            // consulta os dados no SQLite
		            stmt = conexaoSQLite.prepareStatement("select * from " + tabela);
		            resultSetQuery = stmt.executeQuery();		            

		            while (resultSetQuery.next()) {		            	
			            String sqlInsert = "";
			            String colunas = "";
			            String valores = "";
		            	
		            	// primeiro campo do insert - insere ele primeiro para evitar problemas com a vírgula
			            colunas += listaColunas.get(0);
			            valores += "'" + resultSetQuery.getString(1) + "'";
			            
			            // completa o insert com o restante dos campos
			            for(int i = 1; i < listaColunas.size(); i++){
			                colunas += ", " + listaColunas.get(i);
			                if (resultSetQuery.getString(i+1) == null) {
			                	valores += ", " +  null;			                	
			                } else {
				                valores += ", " + (resultSetQuery.getString(i+1).equals("") ? null : "'" + resultSetQuery.getString(i+1) + "'");
			                }
			            }
			            
			            sqlInsert = "INSERT INTO " + tabela + " (" + colunas + ") VALUES (" + valores + ")";
			            listaInserts.add(sqlInsert);
		            }		            	            	
	            }

	            // insere/atualiza os dados no MySQL - banco espelhado do Pegasus na retaguarda
	            conexaoMySQL = DriverManager.getConnection(urlMySQL, usuarioMySQL, senhaMySQL);
	            Statement statement = conexaoMySQL.createStatement();
	            for (int i = 0; i < listaDeletes.size(); i++) {
	        		statement.executeUpdate(listaDeletes.get(i));
				}
	            for (int i = 0; i < listaInserts.size(); i++) {
	        		statement.executeUpdate(listaInserts.get(i));
				}
	            	            
            } finally {
                if (conexaoSQLite != null) {
                	conexaoSQLite.close();
                }
                if (conexaoMySQL != null) {
                	conexaoMySQL.close();
                }
            }			
		}		
	}

	public void armazenarMovimento(String bancoSQLite64, String cnpj, String idMovimento, String idDispositivo) throws FileNotFoundException, IOException, SQLException {
		String filtro = "CNPJ = '" + cnpj + "'";
		Empresa empresa = empresaService.consultarObjetoFiltro(filtro);
		if (empresa != null) {
            String caminhoComCnpj = "C:\\ACBrMonitor\\" + empresa.getCnpj() + "\\";
    	    String caminhoArquivoSQLite = caminhoComCnpj + "sqlite\\" + idDispositivo + ".sqlite";

		    // converte e salva o arquivo do banco em disco
			byte[] bancoSQLiteBytes = Base64.getDecoder().decode(bancoSQLite64);
			FileOutputStream fileOutputStream = new FileOutputStream(caminhoArquivoSQLite);
			fileOutputStream.write(bancoSQLiteBytes);
			fileOutputStream.close();
    	    
			Connection conexaoSQLite = null;
            String urlSQLite = "jdbc:sqlite:" + caminhoArquivoSQLite;

			Connection conexaoMySQL = null;
            String urlMySQL = "jdbc:mysql://localhost/pegasus_" + cnpj;
            String usuarioMySQL = "root";
            String senhaMySQL = "root";	            

            ResultSet resultSetMeta = null;
            ResultSet resultSetQuery = null;
            PreparedStatement stmt = null;

            List<String> listaColunas = new ArrayList<String>();
            List<String> listaInserts = new ArrayList<String>();
            List<String> listaDeletes = new ArrayList<String>();
            
			try {
	            conexaoSQLite = DriverManager.getConnection(urlSQLite);	            
	            DatabaseMetaData metadata = conexaoSQLite.getMetaData();	            
	            
	            for (String tabela : listaTabelaLocal) {	            		            
		            listaColunas.clear();
	
	            	String sqlDelete = "DELETE FROM " + tabela + " WHERE ID_DISPOSITIVO = '" + idDispositivo + "'"; ;
	            	listaDeletes.add(sqlDelete);

		            // insere o nome das colunas no array
	            	resultSetMeta = metadata.getColumns(null, null, tabela, null);
		            while (resultSetMeta.next()) {
		            	listaColunas.add(resultSetMeta.getString("COLUMN_NAME"));
		            }
		            
		            // consulta os dados no SQLite
		            stmt = conexaoSQLite.prepareStatement("select * from " + tabela);
		            resultSetQuery = stmt.executeQuery();		            

		            while (resultSetQuery.next()) {		            	
			            String sqlInsert = "";
			            String colunas = "";
			            String valores = "";
			            
			            // completa o insert com o restante dos campos
			            for(int i = 1; i < listaColunas.size(); i++){
			                colunas += ", " + listaColunas.get(i);
			                if (resultSetQuery.getString(i+1) == null) {
			                	valores += ", " +  null;			                	
			                } else {
				                valores += ", " + (resultSetQuery.getString(i+1).equals("") ? null : "'" + resultSetQuery.getString(i+1) + "'");
			                }
			            }
			            
			            colunas = colunas.substring(2); // tira a primeira vírgula
			            valores = valores.substring(2); // tira a primeira vírgula
			            colunas += ", ID_GERADO_DISPOSITIVO, ID_DISPOSITIVO";
			            valores += ", '" + resultSetQuery.getString(1) + "' , '" + idDispositivo + "'";
			            sqlInsert = "INSERT INTO " + tabela + " (" + colunas + ") VALUES (" + valores + ")";
			            listaInserts.add(sqlInsert);
		            }		            	            	
	            }

	            // insere/atualiza os dados no MySQL - banco espelhado do Pegasus na retaguarda
	            conexaoMySQL = DriverManager.getConnection(urlMySQL, usuarioMySQL, senhaMySQL);
	            Statement statement = conexaoMySQL.createStatement();
	            for (int i = 0; i < listaDeletes.size(); i++) {
	        		statement.executeUpdate(listaDeletes.get(i));
				}
	            for (int i = 0; i < listaInserts.size(); i++) {
	        		statement.executeUpdate(listaInserts.get(i));
				}
	            	            
            } finally {
                if (conexaoSQLite != null) {
                	conexaoSQLite.close();
                }
                if (conexaoMySQL != null) {
                	conexaoMySQL.close();
                }
            }			
		}		
	}

	public String sincronizarCliente(String cnpj) throws FileNotFoundException, IOException, SQLException {
		String filtro = "CNPJ = '" + cnpj + "'";
		Empresa empresa = empresaService.consultarObjetoFiltro(filtro);
		if (empresa != null) {

			Connection conexaoMySQL = null;
            String urlMySQL = "jdbc:mysql://localhost/pegasus_" + cnpj;
            String usuarioMySQL = "root";
            String senhaMySQL = "root";	            

            ResultSet resultSetQuery = null;
            PreparedStatement stmt = null;

            List<ObjetoSincroniza> listaRetorno = new ArrayList<ObjetoSincroniza>();
            ObjectMapper mapper = new ObjectMapper();
            
			try {
	            conexaoMySQL = DriverManager.getConnection(urlMySQL, usuarioMySQL, senhaMySQL);
	            
	            for (String tabela : listaTabelaCentral) {
	            	ObjetoSincroniza objetoSincroniza = new ObjetoSincroniza();
	            	objetoSincroniza.setTabela(tabela);
	                
		            // consulta os dados no MySQL
		            stmt = conexaoMySQL.prepareStatement("select * from " + tabela);
		            resultSetQuery = stmt.executeQuery();		            
            		
		            List<Map<String, Object>> registros = getEntitiesFromResultSet(resultSetQuery);
            		objetoSincroniza.setRegistros(mapper.writeValueAsString(registros));
		            		            
	                listaRetorno.add(objetoSincroniza);
	            }
	            	            
            } finally {
                if (conexaoMySQL != null) {
                	conexaoMySQL.close();
                }
            }			
			return mapper.writeValueAsString(listaRetorno);			
		} else {
			return "";
		}
	}


    protected List<Map<String, Object>> getEntitiesFromResultSet(ResultSet resultSet) throws SQLException {
        ArrayList<Map<String, Object>> entities = new ArrayList<>();
        while (resultSet.next()) {
            entities.add(getEntityFromResultSet(resultSet));
        }
        return entities;
    }

    protected Map<String, Object> getEntityFromResultSet(ResultSet resultSet) throws SQLException {
        ResultSetMetaData metaData = resultSet.getMetaData();
        int columnCount = metaData.getColumnCount();
        Map<String, Object> resultsMap = new HashMap<>();
        for (int i = 1; i <= columnCount; ++i) {
            //String columnName = metaData.getColumnName(i).toLowerCase();
        	String columnName = CaseUtils.toCamelCase(metaData.getColumnName(i), false, '_'); 
            Object object = resultSet.getObject(i);
            resultsMap.put(columnName, object);
        }
        return resultsMap;
    }	
}