/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Controller relacionado à tabela [NFE_CONFIGURACAO] 
                                                                                
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
package com.t2ti.retaguarda_sh.controller.acbr;

import java.io.File;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.t2ti.retaguarda_sh.exception.AcbrMonitorException;
import com.t2ti.retaguarda_sh.exception.ExcecaoGenericaServidorException;
import com.t2ti.retaguarda_sh.model.transiente.ObjetoNfe;
import com.t2ti.retaguarda_sh.service.acbr.AcbrMonitorService;
import com.t2ti.retaguarda_sh.util.Biblioteca;

@RestController
@RequestMapping(value = "/acbr-monitor", produces = "application/json;charset=UTF-8")
public class AcbrMonitorController {

	@Autowired
	private AcbrMonitorService service;
	
	@PostMapping(value = "/emite-nfce", produces = "application/pdf")
	public FileSystemResource emitirNfce(@RequestBody String corpoRequisicao, @RequestHeader("numero") String numero, @RequestHeader("cnpj") String cnpj, HttpServletResponse response) {
		boolean erroMonitor = false;
		String retorno = "";
		try {
			String nfceIni = Biblioteca.decifrar(corpoRequisicao);
			retorno = service.emitirNfce(Biblioteca.decifrar(numero), Biblioteca.decifrar(cnpj), nfceIni);
			if (!retorno.contains("ERRO")) {
			    return new FileSystemResource(new File(retorno));							
			} else {
				erroMonitor = true;
				throw new Exception();
			}
		} catch (Exception e) {
			if (erroMonitor) {
				throw new AcbrMonitorException(retorno);
			} else {
				throw new ExcecaoGenericaServidorException(
						"Erro no Servidor [Emitir NFC-e] - Exceção: " + e.getMessage());				
			}
		}
	}
	
	@PostMapping(value = "/emite-nfce-contingencia", produces = "application/pdf")
	public FileSystemResource emitirNfceContingencia(@RequestBody String corpoRequisicao, @RequestHeader("numero") String numero, @RequestHeader("cnpj") String cnpj, HttpServletResponse response) {
		boolean erroMonitor = false;
		String retorno = "";
		try {
			String nfceIni = Biblioteca.decifrar(corpoRequisicao);
			retorno = service.emitirNfceContingencia(Biblioteca.decifrar(numero), Biblioteca.decifrar(cnpj), nfceIni);
			if (!retorno.contains("ERRO")) {
			    return new FileSystemResource(new File(retorno));							
			} else {
				erroMonitor = true;
				throw new Exception();
			}
		} catch (Exception e) {
			if (erroMonitor) {
				throw new AcbrMonitorException(retorno);
			} else {
				throw new ExcecaoGenericaServidorException(
						"Erro no Servidor [Emitir NFC-e Contingência] - Exceção: " + e.getMessage());
			}
		}
	}
	
	@PostMapping(value = "/transmite-nfce-contingenciada", produces = "application/pdf")
	public FileSystemResource transmitirNfceContingenciada(@RequestHeader("chave") String chave, @RequestHeader("cnpj") String cnpj, HttpServletResponse response) {
		boolean erroMonitor = false;
		String retorno = "";
		try {
			retorno = service.transmitirNfceContingenciada(Biblioteca.decifrar(chave), Biblioteca.decifrar(cnpj));
			if (!retorno.contains("ERRO")) {
			    return new FileSystemResource(new File(retorno));							
			} else {
				erroMonitor = true;
				throw new Exception();
			}
		} catch (Exception e) {
			if (erroMonitor) {
				throw new AcbrMonitorException(retorno);
			} else {
				throw new ExcecaoGenericaServidorException(
						"Erro no Servidor [Transmitir NFC-e Contingenciada] - Exceção: " + e.getMessage());
			}
		}
	}
	
	@PostMapping(value = "/trata-nota-anterior-contingencia")
	public String tratarNotaAnteriorContingencia(@RequestBody String corpoRequisicao) {
		ObjectMapper objectMapper = new ObjectMapper();
		try {
	        ObjetoNfe objetoNfe = objectMapper.readValue(Biblioteca.decifrar(corpoRequisicao), ObjetoNfe.class);
	        String retorno = service.tratarNotaAnteriorContingencia(objetoNfe);
	        return Biblioteca.cifrar(retorno);
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Tratar Nota Anterior Contingencia] - Exceção: " + e.getMessage());
		}
	}
	
	@PostMapping(value = "/inutiliza-numero-nota")
	public String inutilizarNumeroNota(@RequestBody String corpoRequisicao) {
		ObjectMapper objectMapper = new ObjectMapper();
		try {
	        ObjetoNfe objetoNfe = objectMapper.readValue(Biblioteca.decifrar(corpoRequisicao), ObjetoNfe.class);
	        String retorno = service.inutilizarNumero(objetoNfe);
	        return Biblioteca.cifrar(retorno);
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Inutilizar Numero Nota] - Exceção: " + e.getMessage());
		}
	}

	@PostMapping(value = "/cancela-nfce")
	public String cancelarNfce(@RequestBody String corpoRequisicao) {
		ObjectMapper objectMapper = new ObjectMapper();
		try {
	        ObjetoNfe objetoNfe = objectMapper.readValue(Biblioteca.decifrar(corpoRequisicao), ObjetoNfe.class);
	        String retorno = service.cancelarNfce(objetoNfe);
	        return Biblioteca.cifrar(retorno);
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Cancelar NFC-e] - Exceção: " + e.getMessage());
		}
	}
	
	@PostMapping(value = "/gera-pdf-danfe-nfce", produces = "application/pdf")
	public FileSystemResource gerarPdfDanfeNfce(@RequestHeader("chave") String chave, @RequestHeader("cnpj") String cnpj, HttpServletResponse response) {
		boolean erroMonitor = false;
		String retorno = "";
		try {
			retorno = service.gerarPdfDanfeNfce(Biblioteca.decifrar(chave), Biblioteca.decifrar(cnpj));
			if (!retorno.contains("ERRO")) {
			    return new FileSystemResource(new File(retorno));							
			} else {
				erroMonitor = true;
				throw new Exception();
			}
		} catch (Exception e) {
			if (erroMonitor) {
				throw new AcbrMonitorException(retorno);
			} else {
				throw new ExcecaoGenericaServidorException(
						"Erro no Servidor [Gerar Pdf Danfe Nfce] - Exceção: " + e.getMessage());
			}
		}
	}
		
	@GetMapping(value = "/download-xml-periodo", produces = "application/zip")
	public FileSystemResource retornarArquivosXmlPeriodo(@RequestHeader("periodo") String periodo, @RequestHeader("cnpj") String cnpj) {
		try {
			boolean retorno = service.gerarZipArquivosXml(Biblioteca.decifrar(periodo), Biblioteca.decifrar(cnpj));
			if (retorno) {
			    String caminhoArquivo = "C:\\ACBrMonitor\\" + cnpj + "\\NotasFiscaisNFCe_" + periodo + ".zip";
			    return new FileSystemResource(new File(caminhoArquivo));							
			} else {				
				throw new Exception();
			}
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException(
					"Erro no Servidor [Retornar XML Período] - Exceção: " + e.getMessage());
		}
	}

	@PostMapping(value = "/atualiza-certificado")
	public String atualizarCertificado(@RequestBody String corpoRequisicao, @RequestHeader("hash-registro") String senha, @RequestHeader("cnpj") String cnpj) {
		try {
			String certificadoBase64 = Biblioteca.decifrar(corpoRequisicao);
			service.atualizarCertificado(certificadoBase64, Biblioteca.decifrar(senha), Biblioteca.decifrar(cnpj));			
			return "Certificado atualizado com sucesso.";
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Atualizar Certificado] - Exceção: " + e.getMessage());
		}
	}

	
}