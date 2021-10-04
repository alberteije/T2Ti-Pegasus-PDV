package com.t2ti.retaguarda_sh.model.transiente;

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
	private String condicao;

	public Filtro() {}
	
	public Filtro(String filter) {
		String filtro = filter.replace("||", ":");
		String[] partesDoFiltro = filtro.split("\\?");
		
		for (int i = 0; i < partesDoFiltro.length; i++) {
			String[] condicoes = partesDoFiltro[i].split(":");

	        setCondicao(condicoes[1]);

	        if (i > 0) {
	            setWhere(getWhere() + " AND ");
	        }
	        
	        // $cont (LIKE %val%, contains)
	        if (condicao.equals("$cont")) {
	            this.campo = condicoes[0];
	            this.valor = condicoes[2];
	            setWhere(getWhere() + campo + " like '%" + valor + "%'");
	        }

	        // $eq (=, equal)
	        if (condicao.equals("$eq")) {
	            this.campo = condicoes[0];
	            this.valor = condicoes[2];
	            setWhere(getWhere() + campo + " = '" + valor + "'");
	        }
	        
	        // $between (BETWEEN, between, accepts two values)
	        if (condicao.equals("$between")) {
				String[] datas = condicoes[2].split(",");
	            this.campo = condicoes[0];
	            this.dataInicial = datas[0];
	            this.dataFinal = datas[1];
	            setWhere(getWhere() + campo + " between '" + dataInicial + "' and '" + dataFinal + "'");
	        }			
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
		if (where == null)
			return "";
	    return where;
	}

	public void setWhere(String where) {
		this.where = where;
	}

	public String getCondicao() {
		return condicao;
	}

	public void setCondicao(String condicao) {
		this.condicao = condicao;
	}

}