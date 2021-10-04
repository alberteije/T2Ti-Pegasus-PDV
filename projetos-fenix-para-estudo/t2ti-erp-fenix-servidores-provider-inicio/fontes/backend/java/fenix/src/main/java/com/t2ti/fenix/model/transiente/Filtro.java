package com.t2ti.fenix.model.transiente;

import java.io.Serializable;

/**
 * Classe transiente para controlar o filtro que vem do cliente.
 * tomar como base o seguinte esquema para criar as condições de filtro (filter conditions)
 * https://github.com/nestjsx/crud/wiki/Requests
 */
public class Filtro implements Serializable {
	private static final long serialVersionUID = 1L;

	private String campo;
	private String valor;
	private String dataInicial;
	private String dataFinal;
	private String where;

	public Filtro(String filter) {
		String filtro = filter.replace("||", "-");
        String[] condicoes = filtro.split("-");

        // $cont (LIKE %val%, contains)
        if (condicoes[1].equals("$cont")) {
            this.campo = condicoes[0];
            this.valor = condicoes[2];
        }		
	}

	public String getCampo() {
		return campo;
	}

	public void setCampo(String campo) {
		this.campo = campo;
	}

	public String getValor() {
		return valor;
	}

	public void setValor(String valor) {
		this.valor = valor;
	}

	public String getDataInicial() {
		return dataInicial;
	}

	public void setDataInicial(String dataInicial) {
		this.dataInicial = dataInicial;
	}

	public String getDataFinal() {
		return dataFinal;
	}

	public void setDataFinal(String dataFinal) {
		this.dataFinal = dataFinal;
	}

	public String getWhere() {
	    // verifica se o valor é diferente de vazio e se for filtra por campo/valor
	    if(!valor.isEmpty()) {
	        where = campo + " like '%" + valor + "%'";
	    }
		// se o valor for vazio, filtra pelo período
		else {
	        where = campo + " between " + dataInicial + " and " + dataFinal;
	    }

	    return where;
	}

	public void setWhere(String where) {
		this.where = where;
	}

}