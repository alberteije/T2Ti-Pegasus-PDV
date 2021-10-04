package com.t2ti.fenix;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@SpringBootApplication
public class Teste {
	
	@RequestMapping(value = "/teste")
	public String retorno() {
		return "T2Ti ERP Fenix";
	}

}
