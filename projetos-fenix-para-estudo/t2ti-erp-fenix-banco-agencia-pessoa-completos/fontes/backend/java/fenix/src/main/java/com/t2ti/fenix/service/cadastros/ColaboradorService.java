package com.t2ti.fenix.service.cadastros;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.t2ti.fenix.model.cadastros.Colaborador;
import com.t2ti.fenix.repository.cadastros.ColaboradorRepository;

@Service
public class ColaboradorService {

	@Autowired
	private ColaboradorRepository repository;
	@Autowired
	private ServletContext context;
	
	public List<Colaborador> listaTodos() {
		return repository.findAll();
	}
	
	public Colaborador buscaPorId(Integer id) {
		return repository.findById(id).get();
	}
	
	public Colaborador salvaObjeto(Colaborador colaborador) {
		return repository.save(colaborador);
	}
	
	public void excluirObjeto(Integer id) {
		Colaborador colaborador = new Colaborador();
		colaborador.setId(id);
		repository.delete(colaborador);
	}

	public void uploadFoto(MultipartFile file, Integer id) throws Exception {
		String caminhoArquivo = context.getRealPath("/");
		System.out.println(caminhoArquivo);
		File pasta = new File(caminhoArquivo + "\\images\\colaborador\\");
		if (!pasta.exists()) {
			pasta.mkdirs();
		}
		
		File foto = new File(pasta.getAbsolutePath() + "\\" + id + ".jpg");
		
		file.transferTo(foto);
		Colaborador colaborador = buscaPorId(id);
		colaborador.setFoto34("/images/colaborador/" + id + ".jpg");
		salvaObjeto(colaborador);
	}	
}
