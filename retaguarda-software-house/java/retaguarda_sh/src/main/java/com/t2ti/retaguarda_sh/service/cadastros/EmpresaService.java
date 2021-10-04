/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Service relacionado à tabela [EMPRESA] 
                                                                                
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
package com.t2ti.retaguarda_sh.service.cadastros;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.List;

import javax.mail.MessagingException;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.ini4j.InvalidFileFormatException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.t2ti.retaguarda_sh.model.cadastros.Empresa;
import com.t2ti.retaguarda_sh.repository.cadastros.EmpresaRepository;
import com.t2ti.retaguarda_sh.util.Biblioteca;
import com.t2ti.retaguarda_sh.util.Constantes;
import com.t2ti.retaguarda_sh.model.transiente.Filtro;

@Service
public class EmpresaService {

	@Autowired
	private EmpresaRepository repository;
	
	@PersistenceContext
    private EntityManager entityManager;	
	
	public List<Empresa> consultarLista() {
		return repository.findAll();
	}

	@SuppressWarnings("unchecked")
	public List<Empresa> consultarLista(Filtro filtro) {
		String sql = "select * from EMPRESA where " + filtro.getWhere();
		Query query = entityManager.createNativeQuery(sql, Empresa.class);
		return query.getResultList();
	}
	
	public Empresa consultarObjetoFiltro(String filtro) {
		String sql = "select * from EMPRESA where " + filtro;
		Query query = entityManager.createNativeQuery(sql, Empresa.class);
		if (query.getResultList().size() > 0) {
			return (Empresa) query.getResultList().get(0);
		} else {
			return null;
		}
	}
	
	public Empresa consultarObjeto(Integer id) {
		return repository.findById(id).get();
	}

	public Empresa atualizar(Empresa objeto) {
		// TODO: salva a imagem em disco
		objeto.setLogotipo("");
		Empresa empresa = consultarObjetoFiltro("CNPJ = '" + objeto.getCnpj() + "'");
		if (empresa != null) {
			objeto.setId(empresa.getId());			
		}
		return repository.save(objeto);
	}

	public Empresa registrar(Empresa objeto) throws NoSuchAlgorithmException, InvalidFileFormatException, IOException, MessagingException {
		objeto.setLogotipo("");
		Empresa empresa = consultarObjetoFiltro("CNPJ = '" + objeto.getCnpj() + "'");
		if (empresa != null) {
			if (!empresa.getRegistrado().equals("P")) {
				objeto.setId(empresa.getId());			
				objeto.setRegistrado("P");
				objeto = repository.save(objeto);
				enviarEmailConfirmacao(objeto);
				return objeto;
			}
		}
		return null;
	}

	public Empresa enviarEmailConfirmacao(Empresa objeto) throws NoSuchAlgorithmException, InvalidFileFormatException, IOException, MessagingException {
		String codigo = Biblioteca.md5String(objeto.getCnpj() + Constantes.CHAVE);
		
		String corpo = "";
	    corpo = corpo + "<html>";
	    corpo = corpo + "<body>";
	    corpo = corpo + "<p>Olá " + objeto.getNomeFantasia() + ", </p>";
	    corpo = corpo + "<p>Parabéns pelo seu cadastro na aplicação T2Ti Pegasus PDV. Segue o código de confirmação para liberar o uso da aplicação.</p>";
	    corpo = corpo + "<p>Informe o seguinte código na aplicação: " + codigo + "</p>";
	    corpo = corpo + "<p>Atenciosamente,</p>";
	    corpo = corpo + "<p>Equipe T2Ti.COM</p>";
	    corpo = corpo + "</body>";
	    corpo = corpo + "</html>";		
		
	    Biblioteca.enviarEmail("T2Ti Pegasus PDV - Código de Confirmação", objeto.getEmail(), corpo);
	    
		return objeto;
	}
	
	public Empresa conferirCodigoConfirmacao(Empresa objeto, String codigoConfirmacao) throws NoSuchAlgorithmException, UnsupportedEncodingException {
		String codigo = Biblioteca.md5String(objeto.getCnpj() + Constantes.CHAVE);
		if (codigo.equals(codigoConfirmacao)) {
			String filtro = "CNPJ = '" + objeto.getCnpj() + "'";
			Empresa empresa = consultarObjetoFiltro(filtro);
			if (empresa != null) {
				objeto.setId(empresa.getId());			
				objeto.setLogotipo("");
				objeto.setRegistrado("S");
				objeto.setDataRegistro(new Date());
				objeto.setHoraRegistro(Biblioteca.formataHora(new Date()));
				objeto = repository.save(objeto);
				return objeto;
			}			
		}
		return null;
	}
	
	public Empresa salvar(Empresa objeto) {
		return repository.save(objeto);
	}
		
	public void excluir(Integer id) {
		Empresa objeto = consultarObjeto(id);
		repository.delete(objeto);
	}
	
}