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
import { Controller, Get, Header, Post, Req, Res, ValidationPipe} from '@nestjs/common';
import { Crud, CrudController } from '@nestjsx/crud';
import { Request, Response } from 'express';
import { NfeConfiguracaoService } from './nfe-configuracao.service';
import { NfeConfiguracao } from './nfe-configuracao.entity';
import { Biblioteca } from '../../util/biblioteca';
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

  
	@Post('atualiza-dados')
	async atualizar(
    @Req() request: Request,
    @Res() response: Response,
  ) {
    const corpoRequisicao = Biblioteca.decifrar(request.body);
    let nfeConfiguracao = new NfeConfiguracao(JSON.parse(corpoRequisicao));

    const cnpj = Biblioteca.decifrar(request.headers['cnpj'] as string);
    const pdvConfiguracaoJson = JSON.parse(Biblioteca.decifrar(request.headers['pdv-configuracao'] as string));
    const decimaisQuantidade = pdvConfiguracaoJson['decimaisQuantidade'];
    const decimaisValor = pdvConfiguracaoJson['decimaisValor'];
  
    // chama o método atualizar do service
    nfeConfiguracao = await this.service.atualizar(nfeConfiguracao, cnpj, decimaisQuantidade, decimaisValor);

    const retorno = Biblioteca.cifrar(JSON.stringify(nfeConfiguracao));

    response.setHeader('Content-Type', 'application/json');
    response.status(200);
		response.send(retorno);
	}  

  
}