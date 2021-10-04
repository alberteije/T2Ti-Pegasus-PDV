/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Controller relacionado à tabela [NFE_CONFIGURACAO] 
                                                                                
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
import { Controller, Get, Header, Param, Post, Req, Res} from '@nestjs/common';
import { Crud, CrudController } from '@nestjsx/crud';
import { Request, Response } from 'express';
import { NfeConfiguracaoService } from './nfe-configuracao.service';
import { NfeConfiguracao } from './nfe-configuracao.entity';
import { Constantes } from '../../util/constantes';
import { createReadStream } from 'fs';

@Crud({
  model: {
    type: NfeConfiguracao,
  },
  query: {
    join: {
    },
  },
})
@Controller('nfe-configuracao')
export class NfeConfiguracaoController implements CrudController<NfeConfiguracao> {
  constructor(public service: NfeConfiguracaoService) { }

	@Post(':cnpj')
	async atualizar(
    @Req() request: Request,
    @Res() response: Response,
    @Param('cnpj') cnpj: string, 
  ) {
		let objetoJson = request.body;
		let nfeConfiguracao = new NfeConfiguracao(objetoJson);
    let pdvConfiguracaoJson = request.headers['pdv-configuracao'];
    let decimaisQuantidade = pdvConfiguracaoJson['decimaisQuantidade'];
    let decimaisValor = pdvConfiguracaoJson['decimaisValor'];
  
    // chama o método atualizar do service e aguarda um objeto para a porta
    const portaMonitor = await this.service.atualizar(nfeConfiguracao, cnpj, decimaisQuantidade, decimaisValor);
    if (portaMonitor != null) {
      response.setHeader('endereco-monitor', Constantes.ENDERECO_SERVIDOR);
      response.setHeader('porta-monitor', portaMonitor.id);  
    }

    response.status(200);
		response.send(objetoJson);
	}  

	@Post()
	async atualizarCertificado(@Req() request: Request,) {
		let certificadoBase64 = request.body;
    let senha = request.headers['hash-registro'] as string;
    let cnpj = request.headers['cnpj'] as string;

    // chama o método para atualizar o certificado
    await this.service.atualizarCertificado(certificadoBase64, senha, cnpj);

    return 'Certificado atualizado com sucesso.';
	}  

	@Get()
	@Header('Content-Type', 'application/zip')
	async retornarArquivosXmlPeriodo(@Req() request: Request, @Res() response: Response) {
    let periodo = request.headers['periodo'] as string;
    let cnpj = request.headers['cnpj'] as string;

    const retorno = await this.service.gerarZipArquivosXml(periodo, cnpj);

    if (retorno) {
      let caminhoArquivo = "C:\\ACBrMonitor\\" + cnpj + "\\NotasFiscaisNFCe_" + periodo + ".zip";
      const data = createReadStream(caminhoArquivo);
      data.pipe(response);  
    }


	}  
  
}