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
import { Injectable } from '@nestjs/common';
import { getConnection } from 'typeorm';
import { Empresa } from '../entities-export';
import { ObjetoSincroniza } from './objeto.sincroniza';
import * as fs from "fs";
import { open } from 'sqlite';
import * as lodash from "lodash";
const mysql = require('mysql');
const sqlite3 = require('sqlite3').verbose();
const util = require('util');

@Injectable()
export class SincronizaService {

  listaTabelaCentral = [
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
  ];

  listaTabelaCentralDelete = [
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
  ];

  listaTabelaLocal = [
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
  ];

  async sincronizarServidor(bancoSQLite64: string, cnpj: string): Promise<boolean> {
    const connection = getConnection();
    const queryRunner = connection.createQueryRunner();
    await queryRunner.connect();
    await queryRunner.startTransaction();

    const empresa = await connection.manager.findOne(Empresa, { where: { cnpj: cnpj } });
    if (empresa != null) {
      // configura os caminhos
      let caminhoComCnpj = 'C:\\ACBrMonitor\\' + empresa.cnpj + '\\';
      const caminhoArquivoSQLite = caminhoComCnpj + "sqlite\\" + empresa.cnpj + ".sqlite";

      // converte e salva o arquivo do banco em disco
      let buff = Buffer.from(bancoSQLite64, 'base64');
      fs.writeFileSync(caminhoArquivoSQLite, buff);

      const dbSqlite = await open({
        filename: caminhoArquivoSQLite,
        driver: sqlite3.Database
      })

      let conexaoMySQL = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "root",
        database: "pegasus_" + cnpj,
      });

      let listaColunas = [];
      let listaInserts = [];
      let listaDeletes = [];

      try {
        for (let index = 0; index < this.listaTabelaCentralDelete.length; index++) {
          let tabela = this.listaTabelaCentralDelete[index];        
          let sqlDelete = "DELETE FROM " + tabela;
          listaDeletes.push(sqlDelete);
        }
      
        for (let index = 0; index < this.listaTabelaCentral.length; index++) {
          let tabela = this.listaTabelaCentral[index];        
          listaColunas = [];

          // insere o nome das colunas no array
          let consulta = "select * from pragma_table_info('" + tabela + "')";
          try{
            const campos = await dbSqlite.all(consulta);
            for (let i = 0; i < campos.length; i++) {
              let campo = campos[i];
              listaColunas.push(campo.name);
            }
          } catch (e) {
              throw e;
          }          

          // consulta os dados no SQLite
          consulta = "select * from " + tabela;
          try{
            const registros = await dbSqlite.all(consulta);
            for (let i = 0; i < registros.length; i++) { // navega pelos registros

              let registro = registros[i];
              
              let sqlInsert = "";
              let colunas = "";
              let valores = "";

              // primeiro campo do insert - insere ele primeiro para evitar problemas com a vírgula
              colunas += listaColunas[0];
              valores += "'" + registro[listaColunas[0]] + "'";
              
              // completa o insert com o restante dos campos
              for (let j = 1; j < listaColunas.length; j++) { // pega o conteúdo de cada campo do registro
                colunas += ", " + listaColunas[j];
                let valorCampo = registro[listaColunas[j]];
                if (valorCampo == null) {
                  valores += ", " +  null;			                	
                } else {
                  valores += ", " + (valorCampo == "" ? null : "'" + valorCampo + "'");
                }
              }              
              sqlInsert = "INSERT INTO " + tabela + " (" + colunas + ") VALUES (" + valores + ")";
              listaInserts.push(sqlInsert);              
            }
          } catch (e) {
            throw e;
          }          
        };

        // insere/atualiza os dados no MySQL - banco espelhado do Pegasus na retaguarda
        conexaoMySQL.connect((erro: any) => {
          if (erro) throw erro;
        });

        for (let i = 0; i < listaDeletes.length; i++) {
          const query = util.promisify(conexaoMySQL.query).bind(conexaoMySQL);
          const retorno = await query(listaDeletes[i]);
		    }
        for (let i = 0; i < listaInserts.length; i++) {
          const query = util.promisify(conexaoMySQL.query).bind(conexaoMySQL);
          const retorno = await query(listaInserts[i]);
        }
        
        return true;

      } catch (e) {
        throw e;
      }
    }
  }

  async armazenarMovimento(bancoSQLite64: string, cnpj: string, idMovimento: string, idDispositivo: string): Promise<boolean> {
    const connection = getConnection();
    const queryRunner = connection.createQueryRunner();
    await queryRunner.connect();
    await queryRunner.startTransaction();

    const empresa = await connection.manager.findOne(Empresa, { where: { cnpj: cnpj } });
    if (empresa != null) {
      // configura os caminhos
      let caminhoComCnpj = 'C:\\ACBrMonitor\\' + empresa.cnpj + '\\';
      const caminhoArquivoSQLite = caminhoComCnpj + "sqlite\\" + idDispositivo + ".sqlite";

      // converte e salva o arquivo do banco em disco
      let buff = Buffer.from(bancoSQLite64, 'base64');
      fs.writeFileSync(caminhoArquivoSQLite, buff);

      const dbSqlite = await open({
        filename: caminhoArquivoSQLite,
        driver: sqlite3.Database
      })

      let conexaoMySQL = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "root",
        database: "pegasus_" + cnpj,
      });

      let listaColunas = [];
      let listaInserts = [];
      let listaDeletes = [];

      try {
        for (let index = 0; index < this.listaTabelaLocal.length; index++) {
          let tabela = this.listaTabelaLocal[index];        
          listaColunas = [];

          let sqlDelete = "DELETE FROM " + tabela + " WHERE ID_DISPOSITIVO = '" + idDispositivo + "'"; ;;
          listaDeletes.push(sqlDelete);

          // insere o nome das colunas no array
          let consulta = "select * from pragma_table_info('" + tabela + "')";
          try{
            const campos = await dbSqlite.all(consulta);
            for (let i = 0; i < campos.length; i++) {
              let campo = campos[i];
              listaColunas.push(campo.name);
            }
          } catch (e) {
              throw e;
          }          

          // consulta os dados no SQLite
          consulta = "select * from " + tabela;
          try{
            const registros = await dbSqlite.all(consulta);
            for (let i = 0; i < registros.length; i++) { // navega pelos registros

              let registro = registros[i];
              
              let sqlInsert = "";
              let colunas = "";
              let valores = "";

              // completa o insert com o restante dos campos
              for (let j = 1; j < listaColunas.length; j++) { // pega o conteúdo de cada campo do registro
                colunas += ", " + listaColunas[j];
                let valorCampo = registro[listaColunas[j]];
                if (valorCampo == null) {
                  valores += ", " +  null;			                	
                } else {
                  valores += ", " + (valorCampo == "" ? null : "'" + valorCampo + "'");
                }
              }              
              colunas = colunas.substring(2); // tira a primeira vírgula
              valores = valores.substring(2); // tira a primeira vírgula
              colunas += ", ID_GERADO_DISPOSITIVO, ID_DISPOSITIVO";
              valores += ", '" + registro['ID'] + "' , '" + idDispositivo + "'";
              sqlInsert = "INSERT INTO " + tabela + " (" + colunas + ") VALUES (" + valores + ")";
              listaInserts.push(sqlInsert);
            }
          } catch (e) {
            throw e;
          }          
        };

        // insere/atualiza os dados no MySQL - banco espelhado do Pegasus na retaguarda
        conexaoMySQL.connect((erro: any) => {
          if (erro) throw erro;
        });

        for (let i = 0; i < listaDeletes.length; i++) {
          const query = util.promisify(conexaoMySQL.query).bind(conexaoMySQL);
          const retorno = await query(listaDeletes[i]);
		    }
        for (let i = 0; i < listaInserts.length; i++) {
          const query = util.promisify(conexaoMySQL.query).bind(conexaoMySQL);
          const retorno = await query(listaInserts[i]);
        }
        
        return true;

      } catch (e) {
        throw e;
      }
    }
  }

  async sincronizarCliente(cnpj: string): Promise<ObjetoSincroniza[]> {
    const connection = getConnection();
    const queryRunner = connection.createQueryRunner();
    await queryRunner.connect();
    await queryRunner.startTransaction();

    const empresa = await connection.manager.findOne(Empresa, { where: { cnpj: cnpj } });
    if (empresa != null) {

      let conexaoMySQL = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "root",
        database: "pegasus_" + cnpj,
      });

      try {
        conexaoMySQL.connect((erro: any) => {
          if (erro) throw erro;
        });

        let listaRetorno = [];

        for (let index = 0; index < this.listaTabelaCentral.length; index++) {
          let tabela = this.listaTabelaCentral[index];        

          let objetoSincroniza = new ObjetoSincroniza({});
          objetoSincroniza.tabela = tabela;

          const query = util.promisify(conexaoMySQL.query).bind(conexaoMySQL);
          const retorno = await query('select * from ' + tabela);
          
          objetoSincroniza.registros = JSON.stringify(JSON.parse(JSON.stringify(retorno), this.toCamelCase));
          listaRetorno.push(objetoSincroniza);
        }
 
        return listaRetorno; 
      } catch (e) {
        throw e;
      }
    }
  }

  toCamelCase(key, value) {
    if (value && typeof value === 'object'){
      for (var k in value) {
        if (/^[A-Z]/.test(k) && Object.hasOwnProperty.call(value, k)) {
          value[lodash.camelCase(k)] = value[k];
          delete value[k];
        }
      }
    }
    return value;
  }

}