/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Controller relacionado à sincronização de dados 
                                                                                
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
import { SincronizaService } from './sincroniza.service';
import { Biblioteca } from '../util/biblioteca';

@Controller('sincroniza')
export class SincronizaController {
  
  constructor(public service: SincronizaService) { }
   
	@Post('upload')
	async sincronizarServidor(
    @Req() request: Request,
    @Res() response: Response,
  ) {
    const bancoSQLite64 = Biblioteca.decifrar(request.body);      
    const cnpj = Biblioteca.decifrar(request.headers['cnpj'] as string);

    await this.service.sincronizarServidor(bancoSQLite64, cnpj);

    response.setHeader('Content-Type', 'application/json');
    response.status(200);
		response.send('Servidor sincronizado com sucesso.');
	}  

	@Post('upload-movimento')
	async armazenarMovimento(
    @Req() request: Request,
    @Res() response: Response,
  ) {
    const bancoSQLite64 = Biblioteca.decifrar(request.body);      
    const cnpj = Biblioteca.decifrar(request.headers['cnpj'] as string);
    const idMovimento = Biblioteca.decifrar(request.headers['movimento'] as string);
    let dispositivo = Biblioteca.decifrar(request.headers['dispositivo'] as string);
    dispositivo = dispositivo.trim().replace(/-/g, ""); 					

    await this.service.armazenarMovimento(bancoSQLite64, cnpj, idMovimento, dispositivo);

    response.setHeader('Content-Type', 'application/json');
    response.status(200);
		response.send('Movimento sincronizado com sucesso.');
	}  

	@Get('download')
	async sincronizarCliente(
    @Req() request: Request,
    @Res() response: Response,
  ) {
    const cnpj = Biblioteca.decifrar(request.headers['cnpj'] as string);
    const listaObjetoSincroniza = await this.service.sincronizarCliente(cnpj);
    const retorno = Biblioteca.cifrar(JSON.stringify(listaObjetoSincroniza));

    response.setHeader('Content-Type', 'application/json');
    response.status(200);
		response.send(retorno);
	}


	@Post('twilio')
	async testarTwilio(
    @Req() request: Request,
    @Res() response: Response,
  ) {
    const corpo = request.body;      
    
    // await this.service.chameAlgumMetodoParaTraabalharOsDadosEnviadosPeloTwilio(corpo);

    let resposta = "";
    resposta += "<?xml version='1.0' encoding='UTF-8'?>";
    resposta += "<Response>";
    resposta += "<Message><Body>Mensagem vinda do Node.</Body></Message>";
    resposta += "</Response>";

    response.setHeader('Content-Type', 'text/html');
    response.status(200);
		response.send(resposta);
	}  

}