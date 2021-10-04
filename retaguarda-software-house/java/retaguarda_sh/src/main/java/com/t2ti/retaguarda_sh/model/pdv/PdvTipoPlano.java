/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Model relacionado à tabela [PDV_TIPO_PLANO] 
                                                                                
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
package com.t2ti.retaguarda_sh.model.pdv;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import java.math.BigDecimal;
import java.util.Set;
import javax.persistence.OneToMany;
import javax.persistence.CascadeType;

@Entity
@Table(name="PDV_TIPO_PLANO")
@NamedQuery(name="PdvTipoPlano.findAll", query="SELECT t FROM PdvTipoPlano t")
public class PdvTipoPlano implements Serializable {
	private static final long serialVersionUID = 1L;

    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

    @Column(name="MODULO")
	private String modulo;

    @Column(name="PLANO")
	private String plano;

    @Column(name="MODULO_FISCAL")
	private String moduloFiscal;

    @Column(name="VALOR")
	private BigDecimal valor;

    @OneToMany(mappedBy = "pdvTipoPlano", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<PdvPlanoPagamento> listaPdvPlanoPagamento;

	public PdvTipoPlano() {
		//construtor padrão
	}

    public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

    public String getModulo() {
		return this.modulo;
	}

	public void setModulo(String modulo) {
		this.modulo = modulo;
	}

    public String getPlano() {
		return this.plano;
	}

	public void setPlano(String plano) {
		this.plano = plano;
	}

    public String getModuloFiscal() {
		return this.moduloFiscal;
	}

	public void setModuloFiscal(String moduloFiscal) {
		this.moduloFiscal = moduloFiscal;
	}

    public BigDecimal getValor() {
		return this.valor;
	}

	public void setValor(BigDecimal valor) {
		this.valor = valor;
	}

    public Set<PdvPlanoPagamento> getListaPdvPlanoPagamento() {
		return this.listaPdvPlanoPagamento;
	}

	public void setListaPdvPlanoPagamento(Set<PdvPlanoPagamento> listaPdvPlanoPagamento) {
		this.listaPdvPlanoPagamento = listaPdvPlanoPagamento;
		for (PdvPlanoPagamento pdvPlanoPagamento : listaPdvPlanoPagamento) {
			pdvPlanoPagamento.setPdvTipoPlano(this);
		}
	}

		
}