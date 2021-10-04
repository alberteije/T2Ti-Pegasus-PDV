/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [TALONARIO_CHEQUE] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2020 T2Ti.COM                                          
                                                                                
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
package com.t2ti.fenix.model.financeiro;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import com.t2ti.fenix.model.cadastros.BancoContaCaixa;

import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import java.util.Set;
import javax.persistence.OneToMany;
import javax.persistence.CascadeType;

@Entity
@Table(name="TALONARIO_CHEQUE")
@NamedQuery(name="TalonarioCheque.findAll", query="SELECT t FROM TalonarioCheque t")
public class TalonarioCheque implements Serializable {
	private static final long serialVersionUID = 1L;

    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

    @Column(name="TALAO")
	private String talao;

    @Column(name="NUMERO")
	private Integer numero;

    @Column(name="STATUS_TALAO")
	private String statusTalao;

    @ManyToOne
	@JoinColumn(name="ID_BANCO_CONTA_CAIXA")
    private BancoContaCaixa bancoContaCaixa;

    @OneToMany(mappedBy = "talonarioCheque", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Cheque> listaCheque;

	public TalonarioCheque() {
	}

    public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

    public String getTalao() {
		return this.talao;
	}

	public void setTalao(String talao) {
		this.talao = talao;
	}

    public Integer getNumero() {
		return this.numero;
	}

	public void setNumero(Integer numero) {
		this.numero = numero;
	}

    public String getStatusTalao() {
		return this.statusTalao;
	}

	public void setStatusTalao(String statusTalao) {
		this.statusTalao = statusTalao;
	}

    public BancoContaCaixa getBancoContaCaixa() {
		return this.bancoContaCaixa;
	}

	public void setBancoContaCaixa(BancoContaCaixa bancoContaCaixa) {
		this.bancoContaCaixa = bancoContaCaixa;
	}

    public Set<Cheque> getListaCheque() {
		return this.listaCheque;
	}

	public void setListaCheque(Set<Cheque> listaCheque) {
		this.listaCheque = listaCheque;
		for (Cheque cheque : listaCheque) {
			cheque.setTalonarioCheque(this);
		}
	}

		
}