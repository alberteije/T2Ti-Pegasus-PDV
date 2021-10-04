/*******************************************************************************
Title: T2Ti Retaguarda Software House
Description: Biblioteca de funções 
                                                                                
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
package com.t2ti.retaguarda_sh.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.MathContext;
import java.math.RoundingMode;
import java.nio.channels.FileChannel;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.ini4j.InvalidFileFormatException;
import org.ini4j.Wini;

public class Biblioteca {

	private Biblioteca() {
		throw new IllegalStateException("Biblioteca de Funções");
	}

	// fonte: https://www.devmedia.com.br/enviando-email-com-javamail-utilizando-gmail/18034
	public static boolean enviarEmail(String assunto, String destino, String corpo) throws InvalidFileFormatException, IOException, MessagingException {
		String nomeArquivo = "c:\\t2ti\\config-email.ini";
		Wini iniFile = new Wini(new File(nomeArquivo));
		
		String host = iniFile.get("Email", "Host");
		String port = iniFile.get("Email", "Port");
		String from = iniFile.get("Email", "From");
		//String bccList = iniFile.get("Email", "BccList");
		String userName = iniFile.get("Email", "Username");
		String password = iniFile.get("Email", "Password");
		
	    Properties props = new Properties();
	    props.put("mail.smtp.host", host);
	    props.put("mail.smtp.socketFactory.port", port);
	    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	    props.put("mail.smtp.auth", "true");
	    props.put("mail.smtp.port", port);
		
	    Session session = Session.getDefaultInstance(props,
	      new javax.mail.Authenticator() {
			   protected PasswordAuthentication getPasswordAuthentication()
			   {
				   return new PasswordAuthentication(userName, password);
			   }
	      }
	    );


        Message message = new MimeMessage(session);
        //Remetente
        message.setFrom(new InternetAddress(from));

        //Destinatário(s)
        Address[] toUser = InternetAddress.parse(destino);

        message.setRecipients(Message.RecipientType.TO, toUser);
        message.setSubject(assunto);//Assunto
        message.setText(corpo);
        Transport.send(message);
	    
		return true;
	}
	
	public static String quotedStr(String pValor) {
		return "'" + pValor + "'";
	}

	public static String repete(String string, int quantidade) {
		StringBuffer retorno = new StringBuffer();
		for (int j = 0; j < quantidade; j++) {
			retorno.append(string);
		}
		return retorno.toString();
	}

	public static boolean validaCpfCnpj(String s_aux) {
		if (s_aux.length() == 11) {
			int d1, d2;
			int digito1, digito2, resto;
			int digitoCPF;
			String nDigResult;
			d1 = d2 = 0;
			digito1 = digito2 = resto = 0;
			for (int n_Count = 1; n_Count < s_aux.length() - 1; n_Count++) {
				digitoCPF = Integer.valueOf(s_aux.substring(n_Count - 1, n_Count)).intValue();
				d1 = d1 + (11 - n_Count) * digitoCPF;
				d2 = d2 + (12 - n_Count) * digitoCPF;
			}

			resto = (d1 % 11);
			if (resto < 2) {
				digito1 = 0;
			} else {
				digito1 = 11 - resto;
			}
			d2 += 2 * digito1;
			resto = (d2 % 11);
			if (resto < 2) {
				digito2 = 0;
			} else {
				digito2 = 11 - resto;
			}
			String nDigVerific = s_aux.substring(s_aux.length() - 2, s_aux.length());
			nDigResult = String.valueOf(digito1) + String.valueOf(digito2);
			return nDigVerific.equals(nDigResult);
		} else if (s_aux.length() == 14) {
			int soma = 0, dig;
			String cnpj_calc = s_aux.substring(0, 12);
			char[] chr_cnpj = s_aux.toCharArray();

			for (int i = 0; i < 4; i++) {
				if (chr_cnpj[i] - 48 >= 0 && chr_cnpj[i] - 48 <= 9) {
					soma += (chr_cnpj[i] - 48) * (6 - (i + 1));
				}
			}
			for (int i = 0; i < 8; i++) {
				if (chr_cnpj[i + 4] - 48 >= 0 && chr_cnpj[i + 4] - 48 <= 9) {
					soma += (chr_cnpj[i + 4] - 48) * (10 - (i + 1));
				}
			}
			dig = 11 - (soma % 11);
			cnpj_calc += (dig == 10 || dig == 11) ? "0" : Integer.toString(dig);
			soma = 0;
			for (int i = 0; i < 5; i++) {
				if (chr_cnpj[i] - 48 >= 0 && chr_cnpj[i] - 48 <= 9) {
					soma += (chr_cnpj[i] - 48) * (7 - (i + 1));
				}
			}
			for (int i = 0; i < 8; i++) {
				if (chr_cnpj[i + 5] - 48 >= 0 && chr_cnpj[i + 5] - 48 <= 9) {
					soma += (chr_cnpj[i + 5] - 48) * (10 - (i + 1));
				}
			}
			dig = 11 - (soma % 11);
			cnpj_calc += (dig == 10 || dig == 11) ? "0" : Integer.toString(dig);
			return s_aux.equals(cnpj_calc);
		} else {
			return false;
		}
	}

	public static String md5String(String text) throws NoSuchAlgorithmException, UnsupportedEncodingException {
		MessageDigest md;
		md = MessageDigest.getInstance("MD5");
		byte[] md5hash = new byte[32];
		md.update(text.getBytes("iso-8859-1"), 0, text.length());
		md5hash = md.digest();
		return convertToHex(md5hash);
	}

	private static String convertToHex(byte[] data) {
		StringBuffer buf = new StringBuffer();
		for (int i = 0; i < data.length; i++) {
			int halfbyte = (data[i] >>> 4) & 0x0F;
			int two_halfs = 0;
			do {
				if ((0 <= halfbyte) && (halfbyte <= 9)) {
					buf.append((char) ('0' + halfbyte));
				} else {
					buf.append((char) ('a' + (halfbyte - 10)));
				}
				halfbyte = data[i] & 0x0F;
			} while (two_halfs++ < 1);
		}
		return buf.toString();
	}

	public static String md5File(String arquivo) throws NoSuchAlgorithmException, FileNotFoundException {
		MessageDigest digest = MessageDigest.getInstance("MD5");
		File f = new File(arquivo);
		InputStream is = new FileInputStream(f);
		byte[] buffer = new byte[8192];
		int read = 0;
		try {
			while ((read = is.read(buffer)) > 0) {
				digest.update(buffer, 0, read);
			}
			byte[] md5sum = digest.digest();
			BigInteger bigInt = new BigInteger(1, md5sum);
			String output = bigInt.toString(16);
			return output.toUpperCase();
		} catch (IOException e) {
			throw new RuntimeException("Impossível processar o arquivo.", e);
		} finally {
			try {
				is.close();
			} catch (IOException e) {
			}
		}
	}

	public static void removeLineFromFile(String file, String lineToRemove) {
		try {
			File inFile = new File(file);
			if (!inFile.isFile()) {
				System.out.println("Arquivo não localizado!");
				return;
			}
			// Construct the new file that will later be renamed to the original filename.
			File tempFile = new File(inFile.getAbsolutePath() + ".tmp2");
			BufferedReader br = new BufferedReader(new FileReader(file));
			PrintWriter pw = new PrintWriter(new FileWriter(tempFile));

			try {
				String line = null;
				// Read from the original file and write to the new
				// unless content matches data to be removed.
				while ((line = br.readLine()) != null) {
					if (!line.equals(lineToRemove)) {
						pw.println(line);
						pw.flush();
					}
				}
			} finally {
				pw.close();
				br.close();
			}

			// Delete the original file
			if (!inFile.delete()) {
				System.out.println("Não foi possível apagar o arquivo");
				return;
			}
			// Rename the new file to the filename the original file had.
			if (!tempFile.renameTo(inFile)) {
				System.out.println("Não foi possível renomear o arquivo!");
			}
		} catch (FileNotFoundException ex) {
			ex.printStackTrace();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}

	public static void addLineFromFile(String file, String lineToAdd) {
		try {
			File inFile = new File(file);
			if (!inFile.isFile()) {
				System.out.println("Arquivo não localizado!");
				return;
			}
			// Construct the new file that will later be renamed to the original filename.
			File tempFile = new File(inFile.getAbsolutePath() + ".tmp");
			BufferedReader br = new BufferedReader(new FileReader(file));
			PrintWriter pw = new PrintWriter(new FileWriter(tempFile));

			try {
				String line = null;
				// Read from the original file and write to the new
				// unless content matches data to be removed.
				while ((line = br.readLine()) != null) {
					pw.println(line);
					pw.flush();
				}
				pw.println(lineToAdd);
				pw.flush();
			} finally {
				pw.close();
				br.close();
			}

			// Delete the original file
			if (!inFile.delete()) {
				System.out.println("Não foi possível apagar o arquivo");
				return;
			}
			// Rename the new file to the filename the original file had.
			if (!tempFile.renameTo(inFile)) {
				System.out.println("Não foi possível renomear o arquivo!");
			}
		} catch (FileNotFoundException ex) {
			ex.printStackTrace();
		} catch (IOException ex) {
			ex.printStackTrace();
		}

	}

	/**
	 * Método que verifica se uma data no formato dd/mm/aaaa é valida.
	 *
	 * @param data a ser validada
	 * @return true se a data é valida, false se a data é inválida
	 */
	public static boolean isDataValida(String strData) {
		try {
			if ((strData.length() != 10)) {
				return false;
			}
			Calendar dataValida = Calendar.getInstance();
			dataValida.setLenient(false);
			int dia = Integer.valueOf(strData.substring(0, 2));
			int mes = Integer.valueOf(strData.substring(3, 5));
			int ano = Integer.valueOf(strData.substring(6, 10));

			dataValida.set(Calendar.DAY_OF_MONTH, dia);
			dataValida.set(Calendar.MONTH, mes - 1);
			dataValida.set(Calendar.YEAR, ano);

			dataValida.getTime();

			return true;
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * Retorna uma strig formatada de acordo com a configuração do sistema
	 *
	 * @param tipo Q para quantidade ou V para valor
	 * @return string formatada
	 */
	public static String formatoDecimal(String tipo, double valor) {

		String mascara = "0.";
		if (tipo.equals("Q")) {
			for (int i = 0; i < Constantes.DECIMAIS_QUANTIDADE; i++) {
				mascara += "0";
			}
		} else if (tipo.equals("V")) {
			for (int i = 0; i < Constantes.DECIMAIS_VALOR; i++) {
				mascara += "0";
			}
		}
		DecimalFormat formato = new DecimalFormat(mascara);
		return formato.format(valor);
	}

	/**
	 * Copia arquivos de um local para o outro
	 *
	 * @param origem    - Arquivo de origem
	 * @param destino   - Arquivo de destino
	 * @param overwrite - Confirmação para sobrescrever os arquivos
	 * @throws IOException
	 */
	public static void copy(File origem, File destino, boolean overwrite) throws IOException {
		if (destino.exists() && !overwrite) {
			System.err.println(destino.getName() + " já existe, ignorando...");
			return;
		}
		FileInputStream fisOrigem = new FileInputStream(origem);
		FileOutputStream fisDestino = new FileOutputStream(destino);
		try {
			FileChannel fcOrigem = fisOrigem.getChannel();
			FileChannel fcDestino = fisDestino.getChannel();
			fcOrigem.transferTo(0, fcOrigem.size(), fcDestino);
		} finally {
			fisOrigem.close();
			fisDestino.close();
		}
	}

	public static String primeiraMaiuscula(String texto) {
		return Character.toUpperCase(texto.charAt(0)) + texto.substring(1);
	}

	public static String formataData(Date dataFormatar) {
		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		return format.format(dataFormatar);
	}

	public static String formataHora(Date dataFormatar) {
		SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
		return format.format(dataFormatar);
	}

	public static Date stringToDate(String texto, String formato) throws Exception {
		SimpleDateFormat format = new SimpleDateFormat(formato);
		return format.parse(texto);
	}

	public static Date horaToDate(String hora) throws Exception {
		SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
		return format.parse(hora);
	}

	public static String formataDataHora(Date dataHoraFormatar) {
		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
		return format.format(dataHoraFormatar);
	}

	public static String dateToSQL(Date data) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM--dd");
		return format.format(data);
	}
	
	public static BigDecimal multiplica(BigDecimal valor1, BigDecimal valor2) {
		BigDecimal resultado = valor1.multiply(valor2, MathContext.DECIMAL64);
		resultado = resultado.setScale(Constantes.DECIMAIS_VALOR, RoundingMode.DOWN);
		return resultado;
	}

	public static BigDecimal divide(BigDecimal valor1, BigDecimal valor2) {
		BigDecimal resultado = valor1.divide(valor2, MathContext.DECIMAL64);
		resultado = resultado.setScale(Constantes.DECIMAIS_VALOR, RoundingMode.DOWN);
		return resultado;
	}

	public static BigDecimal subtrai(BigDecimal valor1, BigDecimal valor2) {
		BigDecimal resultado = valor1.subtract(valor2, MathContext.DECIMAL64);
		resultado = resultado.setScale(Constantes.DECIMAIS_VALOR, RoundingMode.DOWN);
		return resultado;
	}

	public static BigDecimal soma(BigDecimal valor1, BigDecimal valor2) {
		BigDecimal resultado = valor1.add(valor2, MathContext.DECIMAL64);
		resultado = resultado.setScale(Constantes.DECIMAIS_VALOR, RoundingMode.DOWN);
		return resultado;
	}

	public static String hashRegistro(Object bean) throws Exception {
		Field fields[] = bean.getClass().getDeclaredFields();
		String hash = "";
		Method metodo = bean.getClass().getDeclaredMethod("setLogss", String.class);
		metodo.invoke(bean, "0");
		for (Field f : fields) {
			if (!f.getName().equals("serialVersionUID")) {
				metodo = bean.getClass().getDeclaredMethod("get" + primeiraMaiuscula(f.getName()));
				if (f.getType() == Integer.class || f.getType() == String.class || f.getType() == BigDecimal.class
						|| f.getType() == Double.class) {
					hash += metodo.invoke(bean);
				} else if (f.getType() == Date.class) {
					Date pData = (Date) metodo.invoke(bean);
					if (pData != null) {
						hash += formataData(pData);
					} else {
						hash += "null";
					}
				} else {
					if (f.getType() != List.class) {
						Object obj = metodo.invoke(bean);
						if (obj != null) {
							metodo = obj.getClass().getDeclaredMethod("getId");
							hash += metodo.invoke(obj);
						} else {
							hash += "null";
						}
					}
				}
			}
		}
		return md5String(hash);
	}

	public static int UFToInt(String pUF) {
		if (pUF.equals("RO")) {
			return 11;
		} else if (pUF.equals("AC")) {
			return 12;
		} else if (pUF.equals("AM")) {
			return 13;
		} else if (pUF.equals("RR")) {
			return 14;
		} else if (pUF.equals("PA")) {
			return 15;
		} else if (pUF.equals("AP")) {
			return 16;
		} else if (pUF.equals("TO")) {
			return 17;
		} else if (pUF.equals("MA")) {
			return 21;
		} else if (pUF.equals("PI")) {
			return 22;
		} else if (pUF.equals("CE")) {
			return 23;
		} else if (pUF.equals("RN")) {
			return 24;
		} else if (pUF.equals("PB")) {
			return 25;
		} else if (pUF.equals("PE")) {
			return 26;
		} else if (pUF.equals("AL")) {
			return 27;
		} else if (pUF.equals("SE")) {
			return 28;
		} else if (pUF.equals("BA")) {
			return 29;
		} else if (pUF.equals("MG")) {
			return 31;
		} else if (pUF.equals("ES")) {
			return 32;
		} else if (pUF.equals("RJ")) {
			return 33;
		} else if (pUF.equals("SP")) {
			return 35;
		} else if (pUF.equals("PR")) {
			return 41;
		} else if (pUF.equals("SC")) {
			return 42;
		} else if (pUF.equals("RS")) {
			return 43;
		} else if (pUF.equals("MS")) {
			return 50;
		} else if (pUF.equals("MT")) {
			return 51;
		} else if (pUF.equals("GO")) {
			return 52;
		} else if (pUF.equals("DF")) {
			return 53;
		} else {
			return 0;
		}
	}

	public static String IntToUF(int pUF) {
		if (pUF == 11) {
			return "RO";
		} else if (pUF == 12) {
			return "AC";
		} else if (pUF == 13) {
			return "AM";
		} else if (pUF == 14) {
			return "RR";
		} else if (pUF == 15) {
			return "PA";
		} else if (pUF == 16) {
			return "AP";
		} else if (pUF == 17) {
			return "TO";
		} else if (pUF == 21) {
			return "MA";
		} else if (pUF == 22) {
			return "PI";
		} else if (pUF == 23) {
			return "CE";
		} else if (pUF == 24) {
			return "RN";
		} else if (pUF == 25) {
			return "PB";
		} else if (pUF == 26) {
			return "PE";
		} else if (pUF == 27) {
			return "AL";
		} else if (pUF == 28) {
			return "SE";
		} else if (pUF == 29) {
			return "BA";
		} else if (pUF == 31) {
			return "MG";
		} else if (pUF == 32) {
			return "ES";
		} else if (pUF == 33) {
			return "RJ";
		} else if (pUF == 35) {
			return "SP";
		} else if (pUF == 41) {
			return "PR";
		} else if (pUF == 42) {
			return "SC";
		} else if (pUF == 43) {
			return "RS";
		} else if (pUF == 50) {
			return "MS";
		} else if (pUF == 51) {
			return "MT";
		} else if (pUF == 52) {
			return "GO";
		} else if (pUF == 53) {
			return "DF";
		} else {
			return "";
		}
	}

	public static String pegarPlanoPdv(String descricaoProduto) {
	  if (descricaoProduto.contains("Mensal")) {
		  return "M";
	  } else if (descricaoProduto.contains("Semestral")) {
		  return "S";
	  } else if (descricaoProduto.contains("Anual")) {
		  return "A";
	  } else {
		  return "";		  
	  }
	}

	public static String pegarModuloFiscalPdv(String descricaoProduto) {
	  if (descricaoProduto.contains("NFC")) {
		  return "NFC";
	  } else if (descricaoProduto.contains("SAT")) {
		  return "SAT";
	  } else if (descricaoProduto.contains("MFE")) {
		  return "MFE";
	  } else {
		  return "";		  
	  }
	}

	public static void killTask(String strProcessName) throws IOException {
	    String strCmdLine = null;
	    strCmdLine = String.format("taskkill /FI \"WINDOWTITLE eq %s\" ", strProcessName);

	    Runtime rt = Runtime.getRuntime();
	    try {
	        rt.exec(strCmdLine);
	        //Process pr = rt.exec(strCmdLine);
	    } finally {
	    }
	}
	
}
