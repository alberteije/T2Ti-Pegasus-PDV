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
package com.t2ti.retaguarda_sh.controller.nfe;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.t2ti.retaguarda_sh.exception.ExcecaoGenericaServidorException;
import com.t2ti.retaguarda_sh.exception.RecursoNaoEncontradoException;
import com.t2ti.retaguarda_sh.exception.RequisicaoRuimException;
import com.t2ti.retaguarda_sh.model.cadastros.AcbrMonitorPorta;
import com.t2ti.retaguarda_sh.model.nfe.NfeConfiguracao;
import com.t2ti.retaguarda_sh.model.transiente.Filtro;
import com.t2ti.retaguarda_sh.service.nfe.NfeConfiguracaoService;
import com.t2ti.retaguarda_sh.util.Constantes;

@RestController
@RequestMapping(value = "/nfe-configuracao", produces = "application/json;charset=UTF-8")
public class NfeConfiguracaoController {

	@Autowired
	private NfeConfiguracaoService service;
	
	@GetMapping
	public List<NfeConfiguracao> consultarLista(@RequestParam(required = false) String filter) {
		try {
			if (filter == null) {
				return service.consultarLista();
			} else {
				// define o filtro
				Filtro filtro = new Filtro(filter);
				return service.consultarLista(filtro);				
			}
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Consultar Lista NfeConfiguracao] - Exceção: " + e.getMessage());
		}
	}

	@GetMapping("/{id}")
	public NfeConfiguracao consultarObjeto(@PathVariable Integer id) {
		try {
			return service.consultarObjeto(id);
		} catch (NoSuchElementException e) {
			throw new RecursoNaoEncontradoException("Registro não localizado [Consultar Objeto NfeConfiguracao].");
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException(
					"Erro no Servidor [Consultar Objeto NfeConfiguracao] - Exceção: " + e.getMessage());
		}
	}

	@PostMapping("/{cnpj}")
	public NfeConfiguracao atualizar(HttpServletResponse response, @RequestBody NfeConfiguracao objJson, @PathVariable String cnpj, @RequestHeader("pdv-configuracao") String pdvConfiguracaoJson) {
		try {
			// pega o objeto de configuração do pdv no cabeçalho para descobrir o valor das decimais de quantidade e valor 
			@SuppressWarnings("unchecked")
			Map<String,Object> pdvConfiguracaoMap = new ObjectMapper().readValue(pdvConfiguracaoJson, HashMap.class);
			int decimaisQuantidade = (int) pdvConfiguracaoMap.get("decimaisQuantidade");
			int decimaisValor = (int) pdvConfiguracaoMap.get("decimaisValor");
			
			// chama o método atualizar do service e aguarda um objeto para a porta
			AcbrMonitorPorta portaMonitor = service.atualizar(objJson, cnpj, decimaisQuantidade, decimaisValor);
			
			// configura o cabeçalho de retorno, enviando a porta e o endereço do servidor
			if (portaMonitor != null) {
				response.addHeader("endereco-monitor", Constantes.ENDERECO_SERVIDOR);
				response.addHeader("porta-monitor", portaMonitor.getId().toString());
			}
			
			// envia no corpo o objeto inserido
			return objJson;
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Inserir NfeConfiguracao] - Exceção: " + e.getMessage());
		}
	}

	@PostMapping
	public String atualizarCertificado(@RequestBody String certificadoBase64, @RequestHeader("hash-registro") String senha, @RequestHeader("cnpj") String cnpj) {
		try {
			// chama o método para atualizar o certificado
			service.atualizarCertificado(certificadoBase64, senha, cnpj);
			
			return "Certificado atualizado com sucesso.";
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Inserir NfeConfiguracao] - Exceção: " + e.getMessage());
		}
	}

	@GetMapping(value = "/nfe-configuracao", produces = "application/zip")
	public FileSystemResource retornarArquivosXmlPeriodo(@RequestHeader("periodo") String periodo, @RequestHeader("cnpj") String cnpj) {
		try {
			boolean retorno = service.gerarZipArquivosXml(periodo, cnpj);
			if (retorno) {
			    String caminhoArquivo = "C:\\ACBrMonitor\\" + cnpj + "\\NotasFiscaisNFCe_" + periodo + ".zip";
			    return new FileSystemResource(new File(caminhoArquivo));							
			} else {				
				throw new ExcecaoGenericaServidorException(
						"Problemas na criação do arquivo [Retornar XML Período]");
			}
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException(
					"Erro no Servidor [Download Arquivos XML] - Exceção: " + e.getMessage());
		}
	}
	
	@PutMapping("/{id}")
	public NfeConfiguracao alterar(@RequestBody NfeConfiguracao objJson, @PathVariable Integer id) {	
		try {			
			if (!objJson.getId().equals(id)) {
				throw new RequisicaoRuimException("Objeto inválido [Alterar NfeConfiguracao] - ID do objeto difere do ID da URL.");
			}

			NfeConfiguracao objeto = service.consultarObjeto(objJson.getId());
			if (objeto != null) {
				return service.salvar(objJson);				
			} else
			{
				throw new RequisicaoRuimException("Objeto com ID inválido [Alterar NfeConfiguracao].");				
			}
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Alterar NfeConfiguracao] - Exceção: " + e.getMessage());
		}
	}
	
	@DeleteMapping("/{id}")
	public void excluir(@PathVariable Integer id) {
		try {
			service.excluir(id);
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Excluir NfeConfiguracao] - Exceção: " + e.getMessage());
		}
	}
	
}