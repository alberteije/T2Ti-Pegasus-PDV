<?php

declare(strict_types=1);
/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Biblioteca de funções.
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2020 T2Ti.COM                                          
                                                                                
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
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;


class Biblioteca 
{

	// fonte: https://netcorecloud.com/tutorials/send-an-email-via-gmail-smtp-server-using-php/
	public static function enviarEmail($assunto, $destino, $corpo) {
        $nomeArquivoIni = "c:\\t2ti\\config-email.ini";
		$iniFile = parse_ini_file($nomeArquivoIni, true);
        
		$host = $iniFile['Host'];
		$port = $iniFile['Port'];
		$from = $iniFile['From'];
		//$bccList = $iniFile['BccList'];
		$userName = $iniFile['Username'];
		$password = $iniFile['Password'];		

		$mail = new PHPMailer(true);
		$mail->IsSMTP();
		$mail->Mailer = "smtp";

		$mail->SMTPDebug  = 1;  
		$mail->SMTPAuth   = TRUE;
		$mail->SMTPSecure = "tls";
		$mail->Port       = $port;
		$mail->Host       = $host;
		$mail->Username   = $userName;
		$mail->Password   = $password;		

		$mail->IsHTML(true);
		$mail->AddAddress($destino);
		$mail->SetFrom($from, "from-name");
		//$mail->AddReplyTo($from, "reply-to-name");
		//$mail->AddCC($bccList, "cc-recipient-name");
		$mail->Subject = $assunto;
		$content = $corpo;		

		$mail->MsgHTML($content); 
		if(!$mail->Send()) {
		  echo "Error while sending Email.";
		  var_dump($mail);
		} else {
		  echo "Email sent successfully";
		}		
	}

    public static function camelCase($string)
    {
        $stringRetorno = ucwords(strtolower($string), "_");
        $stringRetorno = str_replace("_", "", $stringRetorno);
        $stringRetorno = lcfirst($stringRetorno);
        return $stringRetorno;
	}
		
    public static function arredondaTruncaValor(string $pOperacao, float $pValor, int $pCasas)  
    {
		return $pValor; //TODO: implementar arredondamento e trucamento
    }

	public static function ufToInt(string $pUF)
	{
		if ($pUF == "RO")
		{
			return 11;
		}
		else if ($pUF == "AC")
		{
			return 12;
		}
		else if ($pUF == "AM")
		{
			return 13;
		}
		else if ($pUF == "RR")
		{
			return 14;
		}
		else if ($pUF == "PA")
		{
			return 15;
		}
		else if ($pUF == "AP")
		{
			return 16;
		}
		else if ($pUF == "TO")
		{
			return 17;
		}
		else if ($pUF == "MA")
		{
			return 21;
		}
		else if ($pUF == "PI")
		{
			return 22;
		}
		else if ($pUF == "CE")
		{
			return 23;
		}
		else if ($pUF == "RN")
		{
			return 24;
		}
		else if ($pUF == "PB")
		{
			return 25;
		}
		else if ($pUF == "PE")
		{
			return 26;
		}
		else if ($pUF == "AL")
		{
			return 27;
		}
		else if ($pUF == "SE")
		{
			return 28;
		}
		else if ($pUF == "BA")
		{
			return 29;
		}
		else if ($pUF == "MG")
		{
			return 31;
		}
		else if ($pUF == "ES")
		{
			return 32;
		}
		else if ($pUF == "RJ")
		{
			return 33;
		}
		else if ($pUF == "SP")
		{
			return 35;
		}
		else if ($pUF == "PR")
		{
			return 41;
		}
		else if ($pUF == "SC")
		{
			return 42;
		}
		else if ($pUF == "RS")
		{
			return 43;
		}
		else if ($pUF == "MS")
		{
			return 50;
		}
		else if ($pUF == "MT")
		{
			return 51;
		}
		else if ($pUF == "GO")
		{
			return 52;
		}
		else if ($pUF == "DF")
		{
			return 53;
		}
		else
		{
			return 0;
		}
	}

	public static function intToUF(int $pUF)
	{
		if ($pUF == 11)
		{
			return "RO";
		}
		else if ($pUF == 12)
		{
			return "AC";
		}
		else if ($pUF == 13)
		{
			return "AM";
		}
		else if ($pUF == 14)
		{
			return "RR";
		}
		else if ($pUF == 15)
		{
			return "PA";
		}
		else if ($pUF == 16)
		{
			return "AP";
		}
		else if ($pUF == 17)
		{
			return "TO";
		}
		else if ($pUF == 21)
		{
			return "MA";
		}
		else if ($pUF == 22)
		{
			return "PI";
		}
		else if ($pUF == 23)
		{
			return "CE";
		}
		else if ($pUF == 24)
		{
			return "RN";
		}
		else if ($pUF == 25)
		{
			return "PB";
		}
		else if ($pUF == 26)
		{
			return "PE";
		}
		else if ($pUF == 27)
		{
			return "AL";
		}
		else if ($pUF == 28)
		{
			return "SE";
		}
		else if ($pUF == 29)
		{
			return "BA";
		}
		else if ($pUF == 31)
		{
			return "MG";
		}
		else if ($pUF == 32)
		{
			return "ES";
		}
		else if ($pUF == 33)
		{
			return "RJ";
		}
		else if ($pUF == 35)
		{
			return "SP";
		}
		else if ($pUF == 41)
		{
			return "PR";
		}
		else if ($pUF == 42)
		{
			return "SC";
		}
		else if ($pUF == 43)
		{
			return "RS";
		}
		else if ($pUF == 50)
		{
			return "MS";
		}
		else if ($pUF == 51)
		{
			return "MT";
		}
		else if ($pUF == 52)
		{
			return "GO";
		}
		else if ($pUF == 53)
		{
			return "DF";
		}
		else
		{
			return "";
		}
	}

	/**
     * Write an ini configuration file
     * 
     * @param string $file
     * @param array  $array
     * @return bool
	 * Fonte: https://www.it-swarm.dev/pt/php/como-ler-e-gravar-em-um-arquivo-ini-com-php/971394629/
     */
    public static function writeIniFile($file, $array = []) {
        // check first argument is string
        if (!is_string($file)) {
            throw new \InvalidArgumentException('Function argument 1 must be a string.');
        }

        // check second argument is array
        if (!is_array($array)) {
            throw new \InvalidArgumentException('Function argument 2 must be an array.');
        }

        // process array
        $data = array();
        foreach ($array as $key => $val) {
            if (is_array($val)) {
                $data[] = "[$key]";
                foreach ($val as $skey => $sval) {
                    if (is_array($sval)) {
                        foreach ($sval as $_skey => $_sval) {
                            if (is_numeric($_skey)) {
                                $data[] = $skey.'[] = '.(is_numeric($_sval) ? $_sval : (ctype_upper($_sval) ? $_sval : '"'.$_sval.'"'));
                            } else {
                                $data[] = $skey.'['.$_skey.'] = '.(is_numeric($_sval) ? $_sval : (ctype_upper($_sval) ? $_sval : '"'.$_sval.'"'));
                            }
                        }
                    } else {
                        $data[] = $skey.' = '.(is_numeric($sval) ? $sval : (ctype_upper($sval) ? $sval : '"'.$sval.'"'));
                    }
                }
            } else {
                $data[] = $key.' = '.(is_numeric($val) ? $val : (ctype_upper($val) ? $val : '"'.$val.'"'));
            }
            // empty line
            $data[] = null;
        }

        // open file pointer, init flock options
        $fp = fopen($file, 'w');
        $retries = 0;
        $max_retries = 100;

        if (!$fp) {
            return false;
        }

        // loop until get lock, or reach max retries
        do {
            if ($retries > 0) {
                usleep(Rand(1, 5000));
            }
            $retries += 1;
        } while (!flock($fp, LOCK_EX) && $retries <= $max_retries);

        // couldn't get the lock
        if ($retries == $max_retries) {
            return false;
        }

        // got lock, write data
        fwrite($fp, implode(PHP_EOL, $data).PHP_EOL);

        // release lock
        flock($fp, LOCK_UN);
        fclose($fp);

        return true;
    }	

	public static function iniWriteString($secao, $chave, $valor, &$arquivoIni) {
        $arquivoIni[$secao][$chave] = $valor;
	}

	public static function pegarPlanoPdv($descricaoProduto) {
		if (str_contains($descricaoProduto, 'Mensal')) {
			return "M";
		} else if (str_contains($descricaoProduto, 'Semestral')) {
			return "S";
		} else if (str_contains($descricaoProduto, 'Anual')) {
			return "A";
		} else {
			return "";		  
		}
	}
  
	public static function pegarModuloFiscalPdv($descricaoProduto) {
		if (str_contains($descricaoProduto, 'NFC')) {
			return "NFC";
		} else if (str_contains($descricaoProduto, 'SAT')) {
			return "SAT";
		} else if (str_contains($descricaoProduto, 'MFE')) {
			return "MFE";
		} else {
			return "";		  
		}
	}

    public static function killTask($appName) {
		$output = shell_exec('taskkill /F /IM "' . $appName . '"');
    }

	public static function compactarPasta($pasta, $nomeArquivoZip) {
		// Create new zip class
		$zip = new ZipArchive;
		if($zip -> open($nomeArquivoZip, ZipArchive::CREATE ) === TRUE) {      
			// Store the path into the variable
			$dir = opendir($pasta);       
			while($file = readdir($dir)) {
				if(is_file($pasta.$file)) {
					$zip -> addFile($pasta.$file, $file);
				}
			}
			$zip ->close();
		}		
	}

}