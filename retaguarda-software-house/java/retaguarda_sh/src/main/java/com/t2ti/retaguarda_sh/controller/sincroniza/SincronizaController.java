/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Controller relacionado à sincronização de dados 
                                                                                
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
package com.t2ti.retaguarda_sh.controller.sincroniza;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.t2ti.retaguarda_sh.exception.ExcecaoGenericaServidorException;
import com.t2ti.retaguarda_sh.service.sincroniza.SincronizaService;
import com.t2ti.retaguarda_sh.util.Biblioteca;

@RestController
@RequestMapping(value = "/sincroniza", produces = "application/json;charset=UTF-8")
public class SincronizaController {

	@Autowired
	private SincronizaService service;
	
	@PostMapping(value = "/upload")
	public String sincronizarServidor(@RequestBody String corpoRequisicao, @RequestHeader("cnpj") String cnpj) {
		try {
			String bancoSQLite64 = Biblioteca.decifrar(corpoRequisicao);
			service.sincronizarServidor(bancoSQLite64, Biblioteca.decifrar(cnpj));			
			return "Servidor sincronizado com sucesso.";
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Problemas na sincronização [Sincronizar Servidor] - Exceção: " + e.getMessage());
		}
	}

	@PostMapping(value = "/upload-movimento")
	public String armazenarMovimento(@RequestBody String corpoRequisicao, @RequestHeader("cnpj") String cnpj, @RequestHeader("movimento") String idMovimento, @RequestHeader("dispositivo") String idDispositivo) {
		try {
			String bancoSQLite64 = Biblioteca.decifrar(corpoRequisicao);
			String dispositivo = Biblioteca.decifrar(idDispositivo);
			dispositivo = dispositivo.trim().replaceAll("-", ""); 					
			service.armazenarMovimento(bancoSQLite64, Biblioteca.decifrar(cnpj), Biblioteca.decifrar(idMovimento), dispositivo);			
			return "Movimento sincronizado com sucesso.";
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Problemas na sincronização [Armazenar Movimento] - Exceção: " + e.getMessage());
		}
	}
	
	@GetMapping(value = "/download")
	public String sincronizarCliente(@RequestHeader("cnpj") String cnpj) {
		try {
	        String retorno = service.sincronizarCliente(Biblioteca.decifrar(cnpj));
	        return Biblioteca.cifrar(retorno);			
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Problemas na sincronização [Sincronizar Cliente] - Exceção: " + e.getMessage());
		}
	}

	
	@PostMapping(value = "/twilio", produces = "text/html")
	public String testarTwilio(@RequestBody String corpoRequisicao) {
		try {
			String corpo = corpoRequisicao;
			String resposta = "";
		    resposta +=  "<?xml version='1.0' encoding='UTF-8'?>";
		    resposta +=  "<Response>";
		    resposta +=  "<Message><Body>Mensagem vinda do Java.</Body></Message>";
		    resposta +=  "</Response>";
			
			return resposta;
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Problemas na sincronização [Sincronizar Servidor] - Exceção: " + e.getMessage());
		}
	}
	
}