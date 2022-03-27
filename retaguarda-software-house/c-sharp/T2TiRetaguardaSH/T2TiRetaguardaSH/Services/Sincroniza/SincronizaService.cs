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
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using NHibernate;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SQLite;
using System.IO;
using System.Linq;
using T2TiRetaguardaSH.Models;
using T2TiRetaguardaSH.NHibernate;

namespace T2TiRetaguardaSH.Services
{
	public class SincronizaService
	{
		readonly List<string> listaTabelaCentral = new List<string> {
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
		};

		readonly List<string> listaTabelaCentralDelete = new List<string> {
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
		};

		readonly List<string> listaTabelaLocal = new List<string> {
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
		};

		public void SincronizarServidor(string bancoSQLite64, string cnpj)
		{
			using ISession Session = NHibernateHelper.GetSessionFactory().OpenSession();
			string filtro = "CNPJ = '" + cnpj + "'";
			Empresa empresa = new EmpresaService().ConsultarObjetoFiltro(filtro);
			if (empresa != null)
			{
				// configura os caminhos
				string caminhoComCnpj = "C:\\ACBrMonitor\\" + empresa.Cnpj + '\\';
				string caminhoArquivoSQLite = caminhoComCnpj + "sqlite\\" + empresa.Cnpj + ".sqlite";

				// converte e salva o arquivo do banco SQLIte em disco
				byte[] bancoSQLiteBytes = Convert.FromBase64String(bancoSQLite64);
				File.WriteAllBytes(caminhoArquivoSQLite, bancoSQLiteBytes);

				SQLiteConnection sqliteConnection = null;
				SQLiteDataAdapter sqliteDataAdapter;
				DataTable sqliteTable;
				SQLiteCommand sqliteCommand;
				SQLiteDataReader sqliteDataReader;

				string connectionstring = @"server=localhost;userid=root;password=root;SSL Mode=None;database=pegasus_" + cnpj;
				MySqlConnection mysqlConnection = null;

				List<string> listaColunas = new List<string>();
				List<string> listaInserts = new List<string>();
				List<string> listaDeletes = new List<string>();

				try
				{
					sqliteConnection = new SQLiteConnection("Data Source=" + caminhoArquivoSQLite + "; Version=3;");
					sqliteConnection.Open();

					foreach (string tabela in listaTabelaCentralDelete)
					{
						string sqlDelete = "DELETE FROM " + tabela;
						listaDeletes.Add(sqlDelete);
					}

					foreach (string tabela in listaTabelaCentral)
					{
						listaColunas.Clear();

						// insere o nome das colunas no array
						sqliteCommand = new SQLiteCommand($"PRAGMA table_info({tabela})", sqliteConnection);
						sqliteDataReader = sqliteCommand.ExecuteReader();
						while (sqliteDataReader.Read())
						{
							listaColunas.Add(sqliteDataReader.GetValue(1).ToString());
						}

						// consulta os dados no SQLite
						sqliteTable = new DataTable();
						sqliteCommand = sqliteConnection.CreateCommand();
						sqliteCommand.CommandText = "SELECT * FROM " + tabela;
						sqliteDataAdapter = new SQLiteDataAdapter(sqliteCommand.CommandText, sqliteConnection);
						sqliteDataAdapter.Fill(sqliteTable);

						for (int h = 0; h < sqliteTable.Rows.Count; h++)
						{
							string sqlInsert;
							string colunas = "";
							string valores = "";

							// primeiro campo do insert - insere ele primeiro para evitar problemas com a vírgula
							colunas += listaColunas[0];
							valores += "'" + sqliteTable.Rows[h][0].ToString() + "'";

							// completa o insert com o restante dos campos
							for (int i = 1; i < listaColunas.Count; i++)
							{
								colunas += ", " + listaColunas[i];
								if (sqliteTable.Rows[h][i].GetType().Name == "Double")
								{
									valores += ", '" + sqliteTable.Rows[h][i].ToString().Replace(',', '.') + "'";
								}
								else
								{
									valores += ", " + (sqliteTable.Rows[h][i].ToString().Equals("") ? "null" : "'" + sqliteTable.Rows[h][i].ToString() + "'");
								}
							}

							sqlInsert = "INSERT INTO " + tabela + " (" + colunas + ") VALUES (" + valores + ")";
							listaInserts.Add(sqlInsert);
						}
					}

					// insere/atualiza os dados no MySQL - banco espelhado do Pegasus na retaguarda
					mysqlConnection = new MySqlConnection(connectionstring);
					mysqlConnection.Open();
					for (int i = 0; i < listaDeletes.Count; i++)
					{
						new MySqlCommand(listaDeletes[i], mysqlConnection).ExecuteNonQuery();
					}					
					for (int i = 0; i < listaInserts.Count; i++)
					{
						new MySqlCommand(listaInserts[i], mysqlConnection).ExecuteNonQuery();
					}
				}
				finally
				{
					if (sqliteConnection != null)
					{
						sqliteConnection.Close();
					}
					if (mysqlConnection != null)
					{
						mysqlConnection.Close();
					}
				}
			}

		}


		public void ArmazenarMovimento(string bancoSQLite64, string cnpj, string idMovimento, string idDispositivo)
		{
			using ISession Session = NHibernateHelper.GetSessionFactory().OpenSession();
			string filtro = "CNPJ = '" + cnpj + "'";
			Empresa empresa = new EmpresaService().ConsultarObjetoFiltro(filtro);
			if (empresa != null)
			{
				// configura os caminhos
				string caminhoComCnpj = "C:\\ACBrMonitor\\" + empresa.Cnpj + '\\';
				string caminhoArquivoSQLite = caminhoComCnpj + "sqlite\\" + idDispositivo + ".sqlite";

				// converte e salva o arquivo do banco SQLIte em disco
				byte[] bancoSQLiteBytes = Convert.FromBase64String(bancoSQLite64);
				File.WriteAllBytes(caminhoArquivoSQLite, bancoSQLiteBytes);

				SQLiteConnection sqliteConnection = null;
				SQLiteDataAdapter sqliteDataAdapter;
				DataTable sqliteTable;
				SQLiteCommand sqliteCommand;
				SQLiteDataReader sqliteDataReader;

				string connectionstring = @"server=localhost;userid=root;password=root;SSL Mode=None;database=pegasus_" + cnpj;
				MySqlConnection mysqlConnection = null;

				List<string> listaColunas = new List<string>();
				List<string> listaInserts = new List<string>();
				List<string> listaDeletes = new List<string>();

				try
				{
					sqliteConnection = new SQLiteConnection("Data Source=" + caminhoArquivoSQLite + "; Version=3;");
					sqliteConnection.Open();

					foreach (string tabela in listaTabelaLocal)
					{
						listaColunas.Clear();

						string sqlDelete = "DELETE FROM " + tabela + " WHERE ID_DISPOSITIVO = '" + idDispositivo + "'";
						listaDeletes.Add(sqlDelete);

						// insere o nome das colunas no array
						sqliteCommand = new SQLiteCommand($"PRAGMA table_info({tabela})", sqliteConnection);
						sqliteDataReader = sqliteCommand.ExecuteReader();
						while (sqliteDataReader.Read())
						{
							listaColunas.Add(sqliteDataReader.GetValue(1).ToString());
						}

						// consulta os dados no SQLite
						sqliteTable = new DataTable();
						sqliteCommand = sqliteConnection.CreateCommand();
						sqliteCommand.CommandText = "SELECT * FROM " + tabela;
						sqliteDataAdapter = new SQLiteDataAdapter(sqliteCommand.CommandText, sqliteConnection);
						sqliteDataAdapter.Fill(sqliteTable);

						for (int h = 0; h < sqliteTable.Rows.Count; h++)
						{
							string sqlInsert;
							string colunas = "";
							string valores = "";

							// completa o insert com o restante dos campos
							for (int i = 1; i < listaColunas.Count; i++)
							{
								colunas += ", " + listaColunas[i];
								if (sqliteTable.Rows[h][i].GetType().Name == "Double")
								{
									valores += ", '" + sqliteTable.Rows[h][i].ToString().Replace(',', '.') + "'";
								}
								else
								{
									valores += ", " + (sqliteTable.Rows[h][i].ToString().Equals("") ? "null" : "'" + sqliteTable.Rows[h][i].ToString() + "'");
								}
							}

							colunas = colunas.Substring(2); // tira a primeira vírgula
							valores = valores.Substring(2); // tira a primeira vírgula
							colunas += ", ID_GERADO_DISPOSITIVO, ID_DISPOSITIVO";
							valores += ", '" + sqliteTable.Rows[h][0].ToString() + "' , '" + idDispositivo + "'";
							sqlInsert = "INSERT INTO " + tabela + " (" + colunas + ") VALUES (" + valores + ")";
							listaInserts.Add(sqlInsert);
						}
					}

					// insere/atualiza os dados no MySQL - banco espelhado do Pegasus na retaguarda
					mysqlConnection = new MySqlConnection(connectionstring);
					mysqlConnection.Open();
					for (int i = 0; i < listaDeletes.Count; i++)
					{
						new MySqlCommand(listaDeletes[i], mysqlConnection).ExecuteNonQuery();
					}
					for (int i = 0; i < listaInserts.Count; i++)
					{
						new MySqlCommand(listaInserts[i], mysqlConnection).ExecuteNonQuery();
					}
				}
				finally
				{
					if (sqliteConnection != null)
					{
						sqliteConnection.Close();
					}
					if (mysqlConnection != null)
					{
						mysqlConnection.Close();
					}
				}
			}
		}

		public string SincronizarCliente(string cnpj)
		{
			using ISession Session = NHibernateHelper.GetSessionFactory().OpenSession();
			string filtro = "CNPJ = '" + cnpj + "'";
			Empresa empresa = new EmpresaService().ConsultarObjetoFiltro(filtro);
			if (empresa != null)
			{
				string connectionstring = @"server=localhost;userid=root;password=root;SSL Mode=None;database=pegasus_" + cnpj;
				MySqlConnection mysqlConnection = null;
				MySqlCommand mySqlCommand;
				DataTable mysqlTable;

				List<ObjetoSincroniza> listaRetorno = new List<ObjetoSincroniza>();

				try
				{
					mysqlConnection = new MySqlConnection(connectionstring);
					mysqlConnection.Open();

					foreach (string tabela in listaTabelaCentral)
					{
						ObjetoSincroniza objetoSincroniza = new ObjetoSincroniza
						{
							Tabela = tabela
						};

						// consulta os dados no MySQL
						mySqlCommand = new MySqlCommand("SELECT * FROM " + tabela, mysqlConnection);
						mysqlTable = new DataTable();
						mysqlTable.Load(mySqlCommand.ExecuteReader());

						objetoSincroniza.Registros = DataTableToJSON(mysqlTable);

						listaRetorno.Add(objetoSincroniza);
					}

					return JsonConvert.SerializeObject(listaRetorno, new JsonSerializerSettings { ContractResolver = new CamelCasePropertyNamesContractResolver() });
				}
				finally
				{
					if (mysqlConnection != null)
					{
						mysqlConnection.Close();
					}
				}
			}
			else
			{
				return "";
			}
		}

		public string DataTableToJSON(DataTable table)
		{
			List<Dictionary<string, object>> parentRow = new List<Dictionary<string, object>>();
			Dictionary<string, object> childRow;
			foreach (DataRow row in table.Rows)
			{
				childRow = new Dictionary<string, object>();
				foreach (DataColumn col in table.Columns)
				{
					string nomeColunaCamelCase = col.ColumnName.ToLower();
					nomeColunaCamelCase = string.Join("", nomeColunaCamelCase.Split("_").Select(i => char.ToUpper(i[0]) + i.Substring(1)));
					nomeColunaCamelCase = Char.ToLowerInvariant(nomeColunaCamelCase[0]) + nomeColunaCamelCase.Substring(1);
					var valorColuna = row[col].ToString();
					childRow.Add(nomeColunaCamelCase, row[col].ToString() == "" ? null : row[col]);
				}
				parentRow.Add(childRow);
			}
			return System.Text.Json.JsonSerializer.Serialize(parentRow);
		}

	}


}