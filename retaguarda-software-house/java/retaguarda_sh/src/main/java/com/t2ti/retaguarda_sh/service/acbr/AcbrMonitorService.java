/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Service relacionado à tabela [NFE_CONFIGURACAO] 
                                                                                
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
package com.t2ti.retaguarda_sh.service.acbr;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;
import java.util.Scanner;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.apache.commons.io.IOUtils;
import org.ini4j.Wini;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zeroturnaround.zip.ZipUtil;

import com.t2ti.retaguarda_sh.model.cadastros.Empresa;
import com.t2ti.retaguarda_sh.model.transiente.ObjetoNfe;
import com.t2ti.retaguarda_sh.service.cadastros.EmpresaService;
import com.t2ti.retaguarda_sh.util.Biblioteca;

@Service
public class AcbrMonitorService {

	@Autowired
	private EmpresaService empresaService;
	
	@PersistenceContext
    private EntityManager entityManager;	

	private String caminhoComCnpj = "";	
	
	@SuppressWarnings("resource")
	public String emitirNfce(String numero, String cnpj, String nfceIni) throws IOException, InterruptedException {
		// configurações
		caminhoComCnpj = "C:\\ACBrMonitor\\" + cnpj + "\\";
		
		// salva o arquivo INI em disco
		String caminhoArquivoIniNfce = caminhoComCnpj + "ini\\nfce\\" + numero + ".ini";
		byte[] nfceIniBytes = Base64.getDecoder().decode(nfceIni);
		FileOutputStream fileOutputStream = new FileOutputStream(caminhoArquivoIniNfce);
		fileOutputStream.write(nfceIniBytes);
		fileOutputStream.close();

		// chama o método para criar a nota
		criarNFe(caminhoArquivoIniNfce);
		// pega o caminho do XML criado
		String caminhoArquivoXml = pegarRetornoSaida("ARQUIVO-XML");
		// chama o método para criar e enviar a nota
		enviarNFe(caminhoArquivoXml);
		String retorno = pegarRetornoSaida("Envio");
		if (!retorno.contains("ERRO")) {
			// chama o método para gerar o PDF
		    imprimirDanfe(caminhoArquivoXml);
		    // captura o retorno do arquivo SAI
		    retorno = pegarRetornoSaida("ARQUIVO-PDF");
		}		
		return retorno;
	}
	
	@SuppressWarnings("resource")
	public String emitirNfceContingencia(String numero, String cnpj, String nfceIni) throws IOException, InterruptedException {
		// configurações
		caminhoComCnpj = "C:\\ACBrMonitor\\" + cnpj + "\\";
		// salva o arquivo INI em disco
		String caminhoArquivoIniNfce = caminhoComCnpj + "ini\\nfce\\" + numero + ".ini";
		byte[] nfceIniBytes = Base64.getDecoder().decode(nfceIni);

		FileOutputStream fileOutputStream = new FileOutputStream(caminhoArquivoIniNfce);
		fileOutputStream.write(nfceIniBytes);
		fileOutputStream.close();
		
		// passa para o modo de emissão off-line
		passarParaModoOffLine();
		// chama o método para criar a nota
		criarNFe(caminhoArquivoIniNfce);
		// pega o caminho do XML criado
		String caminhoArquivoXml = pegarRetornoSaida("ARQUIVO-XML");
		// chama o método para gerar o PDF
		imprimirDanfe(caminhoArquivoXml);
		// captura o retorno do arquivo SAI
		String retorno = pegarRetornoSaida("ARQUIVO-PDF");
		// passa para o modo de emissão on-line
		passarParaModoOnLine();
	  
		return retorno;
	}
	
	public String transmitirNfceContingenciada(String chave, String cnpj) throws IOException, InterruptedException {
		// configurações
		caminhoComCnpj = "C:\\ACBrMonitor\\" + cnpj + "\\";
		String caminhoArquivoXml = caminhoComCnpj + "LOG_NFe\\" + chave + "-nfe.xml";
		// chama o método para criar e enviar a nota
		enviarNFe(caminhoArquivoXml);		
		String retorno = pegarRetornoSaida("Envio");
		if (!retorno.contains("ERRO")) {
			// chama o método para gerar o PDF
		    imprimirDanfe(caminhoArquivoXml);
		    // captura o retorno do arquivo SAI
		    retorno = pegarRetornoSaida("ARQUIVO-PDF");
		}		
		return retorno;
	}

	public String tratarNotaAnteriorContingencia(ObjetoNfe objetoNfe) throws IOException, InterruptedException {
		// configurações
		caminhoComCnpj = "C:\\ACBrMonitor\\" + objetoNfe.getCnpj() + "\\";
		String caminhoArquivoXml = caminhoComCnpj + "LOG_NFe\\" + objetoNfe.getChaveAcesso() + "-nfe.xml";

		// vamos verificar o status da nota
		apagarArquivoSaida();
		gerarArquivoEntrada("NFE.ConsultarNFe(" + caminhoArquivoXml + ")");
		aguardarArquivoSaida();
		
		String retorno = pegarRetornoSaida("Consulta");
		if (!retorno.contains("ERRO")) {
			// se a nota anterior foi emitida = cancela. senão = inutiliza.
			if (retorno.contains("Autorizado")) {
				retorno = cancelarNfce(objetoNfe);
			} else {
				retorno = inutilizarNumero(objetoNfe);
			}
		}
		
		return retorno;
	}
	
	public String inutilizarNumero(ObjetoNfe objetoNfe) throws IOException, InterruptedException {
		// configurações
		caminhoComCnpj = "C:\\ACBrMonitor\\" + objetoNfe.getCnpj() + "\\";
		apagarArquivoSaida();
		
		gerarArquivoEntrada("NFE.InutilizarNFe("
	      +objetoNfe.getCnpj() +", "
	      +objetoNfe.getJustificativa() +", "
	      +objetoNfe.getAno() +", "
	      +objetoNfe.getModelo() +", "
	      +objetoNfe.getSerie() +", "
	      +objetoNfe.getNumeroInicial() +", "
	      +objetoNfe.getNumeroFinal() +")");

 	    aguardarArquivoSaida();
		return pegarRetornoSaida("Inutilizacao");
	}

	public String cancelarNfce(ObjetoNfe objetoNfe) throws IOException, InterruptedException {
		caminhoComCnpj = "C:\\ACBrMonitor\\" + objetoNfe.getCnpj() + "\\";
		apagarArquivoSaida();
		gerarArquivoEntrada("NFe.CANCELARNFE(" + objetoNfe.getChaveAcesso() + ", " + objetoNfe.getJustificativa() + ", " + objetoNfe.getCnpj() + ")");

 	    aguardarArquivoSaida();
		return pegarRetornoSaida("Cancelamento");
	}

	public String gerarPdfDanfeNfce(String chave, String cnpj) throws IOException, InterruptedException {
		// configurações
		caminhoComCnpj = "C:\\ACBrMonitor\\" + cnpj + "\\";
		// pega o caminho do arquivo XML da nota em contingência
		String caminhoArquivoXml = caminhoComCnpj + "LOG_NFe\\" + chave + "-nfe.xml";
		// chama o método para gerar o PDF
		imprimirDanfe(caminhoArquivoXml);
		// captura o retorno do arquivo SAI
		return pegarRetornoSaida("ARQUIVO-PDF");	
	}
	
	public void criarNFe(String caminhoArquivoIniNfce) throws IOException, InterruptedException {
		apagarArquivoSaida();
		gerarArquivoEntrada("NFE.CriarNFe(" + caminhoArquivoIniNfce + ")"); 
		aguardarArquivoSaida();
	}

	public void enviarNFe(String caminhoArquivoXml) throws IOException, InterruptedException {
		apagarArquivoSaida();
		gerarArquivoEntrada("NFE.EnviarNFe(" + caminhoArquivoXml + ", 001, , , , 1, , )"); 
		aguardarArquivoSaida();
	}
	
	public void imprimirDanfe(String caminhoArquivoXml) throws IOException, InterruptedException {
		apagarArquivoSaida();
		gerarArquivoEntrada("NFE.ImprimirDANFEPDF(" + caminhoArquivoXml + ", , , 1,)"); 
		aguardarArquivoSaida();
	}
	
	public boolean passarParaModoOffLine() throws IOException, InterruptedException {
		apagarArquivoSaida();
		gerarArquivoEntrada("NFE.SetFormaEmissao(9)"); // 9=offline
		return aguardarArquivoSaida();
	}

	public boolean passarParaModoOnLine() throws IOException, InterruptedException {
		apagarArquivoSaida();
		gerarArquivoEntrada("NFE.SetFormaEmissao(1)"); // 1=normal
		return aguardarArquivoSaida();
	}
	
	public boolean gerarZipArquivosXml(String periodo, String cnpj) {
		String filtro = "CNPJ = '" + cnpj + "'";
		Empresa empresa = empresaService.consultarObjetoFiltro(filtro);
		if (empresa != null) {
			ZipUtil.pack(new File("C:\\ACBrMonitor\\" + cnpj + "\\DFes\\" + periodo), new File("C:\\ACBrMonitor\\" + cnpj + "\\NotasFiscaisNFCe_" + periodo + ".zip"));
			return true; 
		} else {
			return false;
		}
	}
	
	@SuppressWarnings("resource")
	public void atualizarCertificado(String certificadoBase64, String senha, String cnpj) throws FileNotFoundException, IOException, InterruptedException {
		String filtro = "CNPJ = '" + cnpj + "'";
		Empresa empresa = empresaService.consultarObjetoFiltro(filtro);
		if (empresa != null) {
		    // configura os caminhos
			String caminhoComCnpj = "C:\\ACBrMonitor\\" + empresa.getCnpj() + '\\';
		    String caminhoArquivoCertificado = caminhoComCnpj + empresa.getCnpj() + ".pfx";

		    // converte e salva o arquivo do certificado em disco
			byte[] certificadoBytes = Base64.getDecoder().decode(certificadoBase64);
			FileOutputStream fileOutputStream = new FileOutputStream(caminhoArquivoCertificado);
			fileOutputStream.write(certificadoBytes);
			fileOutputStream.close();
			
		    apagarArquivoSaida();
		    gerarArquivoEntrada("NFE.SetCertificado(" + caminhoArquivoCertificado + "," + senha + ")");
		    aguardarArquivoSaida();
			
		    Biblioteca.killTask("ACBrMonitor_" + empresa.getCnpj() + ".exe");
		    String caminhoExecutavel = caminhoComCnpj + "ACBrMonitor_" + empresa.getCnpj() + ".exe";
		    Runtime.getRuntime().exec(caminhoExecutavel);
		}		
	}
	
	private void gerarArquivoEntrada(String comando) throws IOException
	{
		FileWriter ArquivoEntrada = new FileWriter(caminhoComCnpj + "ent.txt");
		PrintWriter gravarArquivo = new PrintWriter(ArquivoEntrada);
		gravarArquivo.printf(comando);
		ArquivoEntrada.close();
	}
	
	private String pegarRetornoSaida(String operacao) throws IOException {
		String retorno = "";
		Wini arquivoSaida = new Wini(new File(caminhoComCnpj + "sai.txt"));

		// carrega o conteúdo completo do arquivo
		FileInputStream arquivoCompleto = new FileInputStream(caminhoComCnpj + "sai.txt"); 
		Scanner scanner = new Scanner(arquivoCompleto);		

		String codigoStatus = arquivoSaida.get(operacao, "CStat");
		String motivo = arquivoSaida.get(operacao, "XMotivo");
		
		String caminhoArquivoXml = "";
		
		try {			
			if (operacao.equals("ARQUIVO-XML")) {
	            caminhoArquivoXml = scanner.nextLine();
	            caminhoArquivoXml = caminhoArquivoXml.replaceAll("OK: ", "");
	            caminhoArquivoXml = caminhoArquivoXml.trim();
	            return caminhoArquivoXml; 
			} else if (operacao.equals("ARQUIVO-PDF")) {
				retorno = IOUtils.toString(arquivoCompleto, StandardCharsets.UTF_8.name());
				return retorno.replaceAll("OK: Arquivo criado em: ", "").trim();					
			} else if (operacao.equals("Envio")) {
				retorno = motivo;
			} else if (operacao.equals("Cancelamento")) {
				retorno = motivo;
			} else if (operacao.equals("Consulta")) {
				retorno = motivo;
			} else if (operacao.equals("Inutilizacao")) {
				return IOUtils.toString(arquivoCompleto, StandardCharsets.UTF_8.name());
			}
			
			List<String> listaStatus = Arrays.asList("", "100" , "102", "135"); // se o status não for um dos que estiverem nessa lista, vamos retornar um erro.
			
			if (!listaStatus.contains(codigoStatus)) {
				return "[ERRO] - [" + codigoStatus + "] " + motivo;
			}
		} finally {
			scanner.close(); 
		}
		return retorno;
	}
	
	private boolean apagarArquivoSaida() {
		File file = new File(caminhoComCnpj + "sai.txt"); 
		return file.delete();		
	}
	
	private boolean aguardarArquivoSaida() throws InterruptedException {
		int tempoEspera = 0;
		
		File file = new File(caminhoComCnpj + "sai.txt"); 
		while (!file.exists()) {
			Thread.sleep(1000);
			tempoEspera++;
			
			if (tempoEspera > 30) {
				return false;
			}
		}
		
		return true;
	}	
}