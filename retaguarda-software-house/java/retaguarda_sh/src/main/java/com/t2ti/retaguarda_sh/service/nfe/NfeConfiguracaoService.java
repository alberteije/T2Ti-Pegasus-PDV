/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Service relacionado à tabela [NFE_CONFIGURACAO] 
                                                                                
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
package com.t2ti.retaguarda_sh.service.nfe;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.ini4j.InvalidFileFormatException;
import org.ini4j.Wini;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.t2ti.retaguarda_sh.model.cadastros.AcbrMonitorPorta;
import com.t2ti.retaguarda_sh.model.cadastros.Empresa;
import com.t2ti.retaguarda_sh.model.nfe.NfeConfiguracao;
import com.t2ti.retaguarda_sh.model.transiente.Filtro;
import com.t2ti.retaguarda_sh.repository.nfe.NfeConfiguracaoRepository;
import com.t2ti.retaguarda_sh.service.cadastros.AcbrMonitorPortaService;
import com.t2ti.retaguarda_sh.service.cadastros.EmpresaService;
import com.t2ti.retaguarda_sh.util.Biblioteca;

@Service
public class NfeConfiguracaoService {

	@Autowired
	private NfeConfiguracaoRepository repository;
	@Autowired
	private EmpresaService empresaService;
	@Autowired
	private AcbrMonitorPortaService acbrMonitorPortaService;
	
	@PersistenceContext
    private EntityManager entityManager;	
	
	public List<NfeConfiguracao> consultarLista() {
		return repository.findAll();
	}

	@SuppressWarnings("unchecked")
	public List<NfeConfiguracao> consultarLista(Filtro filtro) {
		String sql = "select * from NFE_CONFIGURACAO where " + filtro.getWhere();
		Query query = entityManager.createNativeQuery(sql, NfeConfiguracao.class);
		return query.getResultList();
	}
	
	public NfeConfiguracao consultarObjeto(Integer id) {
		return repository.findById(id).get();
	}
	
	public NfeConfiguracao consultarObjetoFiltro(String filtro) {
		String sql = "select * from NFE_CONFIGURACAO where " + filtro;
		Query query = entityManager.createNativeQuery(sql, NfeConfiguracao.class);
		if (query.getResultList().size() > 0) {
			return (NfeConfiguracao) query.getResultList().get(0);
		} else {
			return null;
		}
	}
	
	public NfeConfiguracao salvar(NfeConfiguracao objeto) {
		return repository.save(objeto);
	}
		
	public void excluir(Integer id) {
		NfeConfiguracao objeto = consultarObjeto(id);
		repository.delete(objeto);
	}

	public NfeConfiguracao atualizar(NfeConfiguracao nfeConfiguracao, String cnpj, int decimaisQuantidade, int decimaisValor) throws IOException, InterruptedException {
		
		String filtro = "CNPJ = '" + cnpj + "'";
		Empresa empresa = empresaService.consultarObjetoFiltro(filtro);
		if (empresa != null) {
			nfeConfiguracao.setEmpresa(empresa);
			filtro = "ID_EMPRESA = " + empresa.getId().toString();
			NfeConfiguracao objetoBanco = consultarObjetoFiltro(filtro);
			if (objetoBanco != null) {
				nfeConfiguracao.setId(objetoBanco.getId());
			}
			repository.save(nfeConfiguracao);			

			// verificar se já existe uma porta definida para o monitor da empresa
			// ALTER TABLE acbr_monitor_porta AUTO_INCREMENT=3435; - executa um comando no banco de dados para definir a porta inicial para o ID
			AcbrMonitorPorta portaMonitor = acbrMonitorPortaService.consultarObjetoFiltro(filtro);
			if (portaMonitor == null) {
			  portaMonitor = new AcbrMonitorPorta();
			  portaMonitor.setEmpresa(empresa);
			  acbrMonitorPortaService.salvar(portaMonitor);
			}
			
			// criar a pasta do monitor para a empresa
		    String PATH = "C:\\ACBrMonitor\\" + cnpj;
		    File directory = new File(PATH);
			if (!directory.exists()) {
				final Process process = Runtime.getRuntime().exec("c:\\ACBrMonitor\\CopiarBase.bat " + cnpj);
				process.waitFor();				
			}

			// configurar o arquivo INI
			configurarArquivoIniMonitor(empresa, nfeConfiguracao, decimaisQuantidade, decimaisValor, portaMonitor.getId());
			
			return nfeConfiguracao;					
		} else {
			return null;
		}
		
	}	
	
	private void configurarArquivoIniMonitor(Empresa empresa, NfeConfiguracao nfeConfiguracao, Integer decimaisQuantidade, Integer decimaisValor, Integer portaMonitor) throws InvalidFileFormatException, IOException {
		String caminhoComCnpj = "C:\\ACBrMonitor\\" + empresa.getCnpj() + '\\';
		nfeConfiguracao.setCaminhoSalvarPdf(caminhoComCnpj + "PDF");
		nfeConfiguracao.setCaminhoSalvarXml(caminhoComCnpj + "DFes");

		String nomeArquivoIni = caminhoComCnpj + "ACBrMonitor.ini"; 
		Wini acbrMonitorIni = new Wini(new File(nomeArquivoIni));
		
		try {
		    //*******************************************************************************************
		    //  [ACBrMonitor]
		    //*******************************************************************************************
		    acbrMonitorIni.put("ACBrMonitor", "TCP_Porta", portaMonitor.toString());

		    //*******************************************************************************************
		    //  [ACBrNFeMonitor]
		    //*******************************************************************************************
		    acbrMonitorIni.put("ACBrNFeMonitor", "Arquivo_Log_Comp", caminhoComCnpj + "LOG_DFe.TXT");
		    acbrMonitorIni.put("ACBrNFeMonitor", "ArquivoWebServices", caminhoComCnpj + "ACBrNFeServicos.ini");
		    acbrMonitorIni.put("ACBrNFeMonitor", "ArquivoWebServicesCTe", caminhoComCnpj + "ACBrCTeServicos.ini");
		    acbrMonitorIni.put("ACBrNFeMonitor", "ArquivoWebServicesMDFe", caminhoComCnpj + "ACBrMDFeServicos.ini");
		    acbrMonitorIni.put("ACBrNFeMonitor", "ArquivoWebServicesGNRe", caminhoComCnpj + "ACBrGNREServicos.ini");
		    acbrMonitorIni.put("ACBrNFeMonitor", "ArquivoWebServiceseSocial", caminhoComCnpj + "ACBreSocialServicos.ini");
		    acbrMonitorIni.put("ACBrNFeMonitor", "ArquivoWebServicesReinf", caminhoComCnpj + "ACBrReinfServicos.ini");
		    acbrMonitorIni.put("ACBrNFeMonitor", "ArquivoWebServicesBPe", caminhoComCnpj + "ACBrBPeServicos.ini");

		    //*******************************************************************************************
		    //  [WebService]
		    //*******************************************************************************************
		    // tpAmb - 1-Produção/ 2-Homologação
		    // OBS: o monitor leva em conta o índice do Radiogroup, ou seja, será 0 para produção e 1 para homologação
		    Integer ambiente = nfeConfiguracao.getWebserviceAmbiente()-1;
		    acbrMonitorIni.put("WebService", "Ambiente", ambiente.toString());
		    acbrMonitorIni.put("WebService", "UF", empresa.getUf());

		    //*******************************************************************************************
		    //  [RespTecnico]
		    //*******************************************************************************************
		    if (nfeConfiguracao.getRespTecHashCsrt() != "0")
		      acbrMonitorIni.put("RespTecnico", "CSRT", nfeConfiguracao.getRespTecHashCsrt());
		    if (nfeConfiguracao.getRespTecIdCsrt() != "0")
		      acbrMonitorIni.put("RespTecnico", "idCSRT", nfeConfiguracao.getRespTecIdCsrt());

		    //*******************************************************************************************
		    //  [NFCe]
		    //*******************************************************************************************
		    acbrMonitorIni.put("NFCe", "IdToken", nfeConfiguracao.getNfceIdCsc());
		    acbrMonitorIni.put("NFCe", "Token", nfeConfiguracao.getNfceCsc());
		    if (nfeConfiguracao.getNfceModeloImpressao() == "A4")
		      acbrMonitorIni.put("NFCe", "ModoImpressaoEvento", "0");
		    else
		      acbrMonitorIni.put("NFCe", "ModoImpressaoEvento", "1");
		    if (nfeConfiguracao.getNfceImprimirItensUmaLinha() == "S")
		      acbrMonitorIni.put("NFCe", "ImprimirItem1Linha", "1");
		    else
		      acbrMonitorIni.put("NFCe", "ImprimirItem1Linha", "0");
		    if (nfeConfiguracao.getNfceImprimirDescontoPorItem() == "S")
		      acbrMonitorIni.put("NFCe", "ImprimirDescAcresItem", "1");
		    else
		      acbrMonitorIni.put("NFCe", "ImprimirDescAcresItem", "0");
		    if (nfeConfiguracao.getNfceImprimirQrcodeLateral() == "S")
		      acbrMonitorIni.put("NFCe", "QRCodeLateral", "1");
		    else
		      acbrMonitorIni.put("NFCe", "QRCodeLateral", "0");
		    if (nfeConfiguracao.getNfceImprimirGtin() == "S")
		      acbrMonitorIni.put("NFCe", "UsaCodigoEanImpressao", "1");
		    else
		      acbrMonitorIni.put("NFCe", "UsaCodigoEanImpressao", "0");
		    if (nfeConfiguracao.getNfceImprimirNomeFantasia() == "S")
		      acbrMonitorIni.put("NFCe", "ImprimeNomeFantasia", "1");
		    else
		      acbrMonitorIni.put("NFCe", "ImprimeNomeFantasia", "0");
		    if (nfeConfiguracao.getNfceImpressaoTributos() == "S")
		      acbrMonitorIni.put("NFCe", "ExibeTotalTributosItem", "1");
		    else
		      acbrMonitorIni.put("NFCe", "ExibeTotalTributosItem", "0");

		    //*******************************************************************************************
		    //  [DANFCe]
		    //*******************************************************************************************
		    acbrMonitorIni.put("DANFCe", "MargemInf", nfeConfiguracao.getNfceMargemInferior().toString().replaceAll(".", ","));
		    acbrMonitorIni.put("DANFCe", "MargemSup", nfeConfiguracao.getNfceMargemSuperior().toString().replaceAll(".", ","));
		    acbrMonitorIni.put("DANFCe", "MargemDir", nfeConfiguracao.getNfceMargemDireita().toString().replaceAll(".", ","));
		    acbrMonitorIni.put("DANFCe", "MargemEsq", nfeConfiguracao.getNfceMargemEsquerda().toString().replaceAll(".", ","));
		    acbrMonitorIni.put("DANFCe", "LarguraBobina", nfeConfiguracao.getNfceResolucaoImpressao().toString());

		    //*******************************************************************************************
		    //  [FonteLinhaItem]
		    //*******************************************************************************************
		    acbrMonitorIni.put("FonteLinhaItem", "Size", nfeConfiguracao.getNfceTamanhoFonteItem().toString());

		    //*******************************************************************************************
		    //  [DANFE]
		    //*******************************************************************************************
		    acbrMonitorIni.put("DANFE", "PathPDF", nfeConfiguracao.getCaminhoSalvarPdf());
		    acbrMonitorIni.put("DANFE", "DecimaisQTD", decimaisQuantidade.toString());
		    acbrMonitorIni.put("DANFE", "DecimaisValor", decimaisValor.toString());

		    //*******************************************************************************************
		    //  [Arquivos]
		    //*******************************************************************************************
		    acbrMonitorIni.put("Arquivos", "PathNFe", nfeConfiguracao.getCaminhoSalvarXml());
		    acbrMonitorIni.put("Arquivos", "PathInu", caminhoComCnpj + "Inutilizacao");
		    acbrMonitorIni.put("Arquivos", "PathDPEC", caminhoComCnpj + "EPEC");
		    acbrMonitorIni.put("Arquivos", "PathEvento", caminhoComCnpj + "Evento");
		    acbrMonitorIni.put("Arquivos", "PathArqTXT", caminhoComCnpj + "TXT");
		    acbrMonitorIni.put("Arquivos", "PathDonwload", caminhoComCnpj + "DistribuicaoDFe");
		    
		    acbrMonitorIni.store();		    
		} finally {
		    Biblioteca.killTask("ACBrMonitor_" + empresa.getCnpj());
		    String caminhoExecutavel = caminhoComCnpj + "ACBrMonitor_" + empresa.getCnpj() + ".exe";
		    Runtime.getRuntime().exec(caminhoExecutavel);
		}
	}
	
}