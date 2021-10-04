/*
Title: T2Ti ERP 3.0                                                              
Description: Model - Empresa - para consultar os dados da empresa via CNPJ
                                                                                
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
class EmpresaConsultaPublica {
	String cnpj;
	String tipo;
	String nome;
  String fantasia;
	String abertura;
  String complemento;
	String uf;
	String telefone;
	String email;
	String situacao;
	String bairro;
	String logradouro;
  String numero;
  String cep;
  String municipio;
  String porte;
  String naturezaJuridica;


	EmpresaConsultaPublica({
      this.cnpj,
      this.tipo,
      this.nome,
      this.fantasia,
      this.abertura,
      this.complemento,
      this.uf,
      this.telefone,
      this.email,
      this.situacao,
      this.bairro,
      this.logradouro,
      this.numero,
      this.cep,
      this.municipio,
      this.porte,
      this.naturezaJuridica,
		});

	EmpresaConsultaPublica.fromJson(Map<String, dynamic> jsonDados) {
    cnpj = jsonDados['cnpj'];
    tipo = jsonDados['tipo'];
    nome = jsonDados['nome'];
    fantasia = jsonDados['fantasia'];
    abertura = jsonDados['abertura'];
    complemento = jsonDados['complemento'];
    uf = jsonDados['uf'];
    telefone = jsonDados['telefone'];
    email = jsonDados['email'];
    situacao = jsonDados['situacao'];
    bairro = jsonDados['bairro'];
    logradouro = jsonDados['logradouro'];
    numero = jsonDados['numero'];
    cep = jsonDados['cep'];
    municipio = jsonDados['municipio'];
    porte = jsonDados['porte'];
    naturezaJuridica = jsonDados['natureza_juridica'];
	}
	
}