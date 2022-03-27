package com.t2ti.retaguarda_sh.model.sincroniza;

import java.io.Serializable;

public class ObjetoSincroniza implements Serializable {
	private static final long serialVersionUID = 1L;

	private String tabela;
	private String registros;

	public ObjetoSincroniza() {}

	public String getTabela() {
		return tabela;
	}

	public void setTabela(String tabela) {
		this.tabela = tabela;
	}

	public String getRegistros() {
		return registros;
	}

	public void setRegistros(String registros) {
		this.registros = registros;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}


}