<?php

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

class SincronizaService extends ServiceBase
{

	private static $listaTabelaCentral = array(
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

	private static $listaTabelaCentralDelete = array(
		"TRIBUT_ICMS_CUSTOM_DET",
		"TRIBUT_ICMS_CUSTOM_CAB",
		"TRIBUT_COFINS",
		"TRIBUT_ICMS_UF",
		"TRIBUT_IPI",
		"TRIBUT_ISS",
		"TRIBUT_PIS",
		"TRIBUT_CONFIGURA_OF_GT",
		"TRIBUT_OPERACAO_FISCAL",
		"CLIENTE",
		"COLABORADOR",
		"FORNECEDOR",
		"PRODUTO_IMAGEM",
		"PRODUTO_FICHA_TECNICA",
		"PRODUTO_PROMOCAO",
		"PRODUTO",
		"TRIBUT_GRUPO_TRIBUTARIO",
		"PRODUTO_SUBGRUPO",
		"PRODUTO_GRUPO",
		"PRODUTO_TIPO",
		"PRODUTO_UNIDADE",
		"PDV_TIPO_PAGAMENTO",
		"COMPRA_PEDIDO_DETALHE",
		"COMPRA_PEDIDO_CABECALHO",
		"CONTAS_PAGAR",
		"CONTAS_RECEBER"
	); 

	private static $listaTabelaLocal = array(
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

	public static function sincronizarServidor($bancoSQLite64, $cnpj)
	{
	  $filtro = 'CNPJ = "' . $cnpj . '"';
	  $empresaRetorno = Empresa::whereRaw($filtro)->get();
	  if ($empresaRetorno->count() > 0) {
		$empresa = $empresaRetorno[0];
  
		// configura os caminhos
		$caminhoComCnpj = 'C:\\ACBrMonitor\\' . $empresa->cnpj . '\\';
		$caminhoArquivoSQLite = $caminhoComCnpj . 'sqlite\\' . $empresa->cnpj . '.sqlite';
  
		// converte e salva o arquivo em disco
		$ifp = fopen($caminhoArquivoSQLite, 'wb');
		fwrite($ifp, base64_decode($bancoSQLite64));
		fclose($ifp);

		// conexão com o SQLite
		$pdo = new \PDO("sqlite:" . $caminhoArquivoSQLite);

		$listaInserts = [];
		$listaDeletes = [];

		foreach (self::$listaTabelaCentralDelete as &$tabela) {
			$sqlDelete = "DELETE FROM " . $tabela;
			$listaDeletes[] = $sqlDelete;
		}

		foreach (self::$listaTabelaCentral as &$tabela) {
			$listaColunas = [];

			// insere o nome das colunas no array
			$consulta = "select * from pragma_table_info('" . $tabela ."')";
			$stmt = $pdo->query($consulta);
			while ($registro = $stmt->fetch(\PDO::FETCH_ASSOC)) {
				$listaColunas[] = $registro['name'];
			}		
	
	        // consulta os dados no SQLite
          	$consulta = "select * from " . $tabela;
			$stmt = $pdo->query($consulta);
			while ($registro = $stmt->fetch(\PDO::FETCH_ASSOC)) {
				$sqlInsert = "";
				$colunas = "";
				$valores = "";
  
				// primeiro campo do insert - insere ele primeiro para evitar problemas com a vírgula
				$colunas .= $listaColunas[0];
				$valores .= "'" . $registro[$listaColunas[0]] . "'";

				// completa o insert com o restante dos campos
				for ($j = 1; $j < count($listaColunas); $j++) { // pega o conteúdo de cada campo do registro
					$colunas .= ", " . $listaColunas[$j];
					$valorCampo = $registro[$listaColunas[$j]];
					if ($valorCampo === null) {
						$valores .= ", " . "null";
					} else {
						$valores .= ", " . ($valorCampo === "" ? "null" : "'" . $valorCampo . "'");
					}
				}              
				$sqlInsert = "INSERT INTO " . $tabela . " (" . $colunas . ") VALUES (" . $valores . ")";
				$listaInserts[] = $sqlInsert;
			}		  
		}
  
        // insere/atualiza os dados no MySQL - banco espelhado do Pegasus na retaguarda
		$serverName = "localhost";
		$database = "pegasus_" . $cnpj;
		$username = "root";
		$password = "root";

		$conexaoMySQL = mysqli_connect($serverName, $username, $password, $database);
		for ($i = 0; $i <= count($listaDeletes)-1; $i++) {
			$conexaoMySQL->query($listaDeletes[$i]);
		}
		for ($i = 0; $i <= count($listaInserts)-1; $i++) {
			$conexaoMySQL->query($listaInserts[$i]);
		}
		$conexaoMySQL->close();		
	  }
	}

	public static function armazenarMovimento($bancoSQLite64, $cnpj, $idMovimento, $idDispositivo)
	{
	  $filtro = 'CNPJ = "' . $cnpj . '"';
	  $empresaRetorno = Empresa::whereRaw($filtro)->get();
	  if ($empresaRetorno->count() > 0) {
		$empresa = $empresaRetorno[0];
  
		// configura os caminhos
		$caminhoComCnpj = 'C:\\ACBrMonitor\\' . $empresa->cnpj . '\\';
		$caminhoArquivoSQLite = $caminhoComCnpj . 'sqlite\\' . $idDispositivo . '.sqlite';
  
		// converte e salva o arquivo em disco
		$ifp = fopen($caminhoArquivoSQLite, 'wb');
		fwrite($ifp, base64_decode($bancoSQLite64));
		fclose($ifp);

		// conexão com o SQLite
		$pdo = new \PDO("sqlite:" . $caminhoArquivoSQLite);

		$listaInserts = [];
		$listaDeletes = [];

		foreach (self::$listaTabelaLocal as &$tabela) {
			$listaColunas = [];

			$sqlDelete = "DELETE FROM " . $tabela . " WHERE ID_DISPOSITIVO = '" . $idDispositivo . "'"; 
			$listaDeletes[] = $sqlDelete;

			// insere o nome das colunas no array
			$consulta = "select * from pragma_table_info('" . $tabela ."')";
			$stmt = $pdo->query($consulta);
			while ($registro = $stmt->fetch(\PDO::FETCH_ASSOC)) {
				$listaColunas[] = $registro['name'];
			}		
	
	        // consulta os dados no SQLite
          	$consulta = "select * from " . $tabela;
			$stmt = $pdo->query($consulta);
			while ($registro = $stmt->fetch(\PDO::FETCH_ASSOC)) {
				$sqlInsert = "";
				$colunas = "";
				$valores = "";
  
				// completa o insert com o restante dos campos
				for ($j = 1; $j < count($listaColunas); $j++) { // pega o conteúdo de cada campo do registro
					$colunas .= ", " . $listaColunas[$j];
					$valorCampo = $registro[$listaColunas[$j]];
					if ($valorCampo === null) {
						$valores .= ", " . "null";
					} else {
						$valores .= ", " . ($valorCampo === "" ? "null" : "'" . $valorCampo . "'");
					}
				  }              
				$colunas = substr($colunas, 2); // tira a primeira vírgula
				$valores = substr($valores, 2); // tira a primeira vírgula
				$colunas .= ", ID_GERADO_DISPOSITIVO, ID_DISPOSITIVO";
				$valores .= ", '" . $registro['ID'] . "' , '" . $idDispositivo . "'";
				$sqlInsert = "INSERT INTO " . $tabela . " (" . $colunas . ") VALUES (" . $valores . ")";
				$listaInserts[] = $sqlInsert;
			}		  
		}
  
        // insere/atualiza os dados no MySQL - banco espelhado do Pegasus na retaguarda
		$serverName = "localhost";
		$database = "pegasus_" . $cnpj;
		$username = "root";
		$password = "root";

		$conexaoMySQL = mysqli_connect($serverName, $username, $password, $database);
		for ($i = 0; $i <= count($listaDeletes)-1; $i++) {
			$conexaoMySQL->query($listaDeletes[$i]);
		}
		for ($i = 0; $i <= count($listaInserts)-1; $i++) {
			$conexaoMySQL->query($listaInserts[$i]);
		}
		$conexaoMySQL->close();		
	  }
	}

	public static function sincronizarCliente($cnpj)
	{
	  $filtro = 'CNPJ = "' . $cnpj . '"';
	  $empresaRetorno = Empresa::whereRaw($filtro)->get();
	  if ($empresaRetorno->count() > 0) {

        // consulta os dados no MySQL - banco espelhado do Pegasus na retaguarda
		$serverName = "localhost";
		$database = "pegasus_" . $cnpj;
		$username = "root";
		$password = "root";

		$listaRetorno = [];

		$conexaoMySQL = mysqli_connect($serverName, $username, $password, $database);
		foreach (self::$listaTabelaCentral as &$tabela) {
			$objetoSincroniza = new ObjetoSincroniza();
			$objetoSincroniza->tabela = $tabela;

			$arrayConsulta = array();
			if ($result = $conexaoMySQL->query("SELECT * FROM " . $tabela)) {			
				while($row = $result->fetch_array(MYSQLI_ASSOC)) {
						$arrayConsulta[] = $row;
				}
				
				$objetoSincroniza->registros = self::jsonToCamelCase(json_encode($arrayConsulta, JSON_NUMERIC_CHECK));
				$listaRetorno[] = $objetoSincroniza;
			}
		}
		$conexaoMySQL->close();		
  
		return $listaRetorno;
	  }
	}

	private static function jsonToCamelCase($stringJson) {
		$arrayJson = json_decode($stringJson);
		$arrayJsonRetorno = [];
		foreach ($arrayJson as $key => $jsons) { 
			foreach($jsons as $key => $value) {
				$arrayJsonRetorno += [self::underlineToCamelCase($key) => $value];
			}
	   	}
		return json_encode($arrayJsonRetorno);
	}

	private static function underlineToCamelCase($string, $capitalizeFirstCharacter = false) 
	{
		$string = strtolower($string);
		$str = str_replace('_', '', ucwords($string, '_')); 
		if (!$capitalizeFirstCharacter) {
			$str = lcfirst($str);
		}
		return $str;
	}	  

}