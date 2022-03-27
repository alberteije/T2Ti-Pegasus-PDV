/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Controller relacionado ao ACBrMonitor
                                                                                
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
import { Controller, Get, Header, Post, Req, Res, ValidationPipe} from '@nestjs/common';
import { Request, Response } from 'express';
import { AcbrMonitorService } from './acbr-monitor.service';
import { Biblioteca } from '../../util/biblioteca';
import { ObjetoNfe } from '../../util/objeto.nfe';
import { createReadStream } from 'fs';

@Controller('acbr-monitor')
export class AcbrMonitorController {
  
  constructor(public service: AcbrMonitorService) { }
 
	@Post('emite-nfce')
	@Header('Content-Type', 'application/pdf')
	async emitirNfce(
    @Req() request: Request,
    @Res() response: Response,
  ) {
    const nfceIni = Biblioteca.decifrar(request.body);      
    const numero = Biblioteca.decifrar(request.headers['numero'] as string);
    const cnpj = Biblioteca.decifrar(request.headers['cnpj'] as string);

    const retorno = await this.service.emitirNfce(numero, cnpj, nfceIni);

    if (!retorno.includes('ERRO')) {
      response.status(200);
      const data = createReadStream(retorno);
      data.pipe(response);  
    } else {
      response.setHeader('Content-Type', 'application/json');
      response.status(418);
      response.send(retorno);  
    }
	}  

	@Post('emite-nfce-contingencia')
	@Header('Content-Type', 'application/pdf')
	async emitirNfceContingencia(
    @Req() request: Request,
    @Res() response: Response,
  ) {
    const nfceIni = Biblioteca.decifrar(request.body);      
    const numero = Biblioteca.decifrar(request.headers['numero'] as string);
    const cnpj = Biblioteca.decifrar(request.headers['cnpj'] as string);

    const retorno = await this.service.emitirNfceContingencia(numero, cnpj, nfceIni);

    if (!retorno.includes('ERRO')) {
      response.status(200);
      const data = createReadStream(retorno);
      data.pipe(response);  
    } else {
      response.setHeader('Content-Type', 'application/json');
      response.status(418);
      response.send(retorno);  
    }
	}  

	@Post('transmite-nfce-contingenciada')
	@Header('Content-Type', 'application/pdf')
	async transmitirNfceContingenciada(
    @Req() request: Request,
    @Res() response: Response,
  ) {
    const chave = Biblioteca.decifrar(request.headers['chave'] as string);
    const cnpj = Biblioteca.decifrar(request.headers['cnpj'] as string);

    const retorno = await this.service.transmitirNfceContingenciada(chave, cnpj);

    if (!retorno.includes('ERRO')) {
      response.status(200);
      const data = createReadStream(retorno);
      data.pipe(response);  
    } else {
      response.setHeader('Content-Type', 'application/json');
      response.status(418);
      response.send(retorno);  
    }
	}  

	@Post('trata-nota-anterior-contingencia')
	async tratarNotaAnteriorContingencia(
    @Req() request: Request,
    @Res() response: Response,
  ) {
    const corpoRequisicao = Biblioteca.decifrar(request.body);
    const objetoNfe = new ObjetoNfe(JSON.parse(corpoRequisicao));

    const retorno = await this.service.tratarNotaAnteriorContingencia(objetoNfe);

    response.setHeader('Content-Type', 'application/json');
    response.status(200);
    response.send(Biblioteca.cifrar(retorno));  
	}  

	@Post('inutiliza-numero-nota')
	async inutilizarNumeroNota(
    @Req() request: Request,
    @Res() response: Response,
  ) {
    const corpoRequisicao = Biblioteca.decifrar(request.body);
    const objetoNfe = new ObjetoNfe(JSON.parse(corpoRequisicao));

    const retorno = await this.service.inutilizarNumero(objetoNfe);

    response.setHeader('Content-Type', 'application/json');
    response.status(200);
    response.send(Biblioteca.cifrar(retorno));  
	}  

	@Post('cancela-nfce')
	async cancelarNfce(
    @Req() request: Request,
    @Res() response: Response,
  ) {
    const corpoRequisicao = Biblioteca.decifrar(request.body);
    const objetoNfe = new ObjetoNfe(JSON.parse(corpoRequisicao));

    const retorno = await this.service.cancelarNfce(objetoNfe);

    response.setHeader('Content-Type', 'application/json');
    response.status(200);
    response.send(Biblioteca.cifrar(retorno));  
	}  

	@Post('gera-pdf-danfe-nfce')
	@Header('Content-Type', 'application/pdf')
	async gerarPdfDanfeNfce(
    @Req() request: Request,
    @Res() response: Response,
  ) {
    const chave = Biblioteca.decifrar(request.headers['chave'] as string);
    const cnpj = Biblioteca.decifrar(request.headers['cnpj'] as string);

    const retorno = await this.service.gerarPdfDanfeNfce(chave, cnpj);

    if (!retorno.includes('ERRO')) {
      response.status(200);
      const data = createReadStream(retorno);
      data.pipe(response);  
    } else {
      response.setHeader('Content-Type', 'application/json');
      response.status(418);
      response.send(retorno);  
    }
	}  
  
	@Get('download-xml-periodo')
	@Header('Content-Type', 'application/zip')
	async retornarArquivosXmlPeriodo(
    @Req() request: Request, 
    @Res() response: Response
  ) {
    const periodo = Biblioteca.decifrar(request.headers['periodo'] as string);
    const cnpj = Biblioteca.decifrar(request.headers['cnpj'] as string);

    const retorno = await this.service.gerarZipArquivosXml(periodo, cnpj);

    if (retorno) {
      let caminhoArquivo = "C:\\ACBrMonitor\\" + cnpj + "\\NotasFiscaisNFCe_" + periodo + ".zip";
      const data = createReadStream(caminhoArquivo);
      data.pipe(response);  
    }
	}  
  
	@Post('atualiza-certificado')
	async atualizarCertificado(
    @Req() request: Request,
    @Res() response: Response,
  ) {
    const certificadoBase64 = Biblioteca.decifrar(request.body);      
    const senha = Biblioteca.decifrar(request.headers['hash-registro'] as string);
    const cnpj = Biblioteca.decifrar(request.headers['cnpj'] as string);

    // chama o método para atualizar o certificado
    await this.service.atualizarCertificado(certificadoBase64, senha, cnpj);

    response.setHeader('Content-Type', 'application/json');
    response.status(200);
		response.send('Certificado atualizado com sucesso.');
	}  

}