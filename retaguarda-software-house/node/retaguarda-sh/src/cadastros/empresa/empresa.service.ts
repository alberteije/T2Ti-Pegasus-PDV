/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Service relacionado à tabela [EMPRESA] 
                                                                                
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
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { Empresa } from './empresa.entity';
import { getConnection, QueryRunner } from 'typeorm';
import { Biblioteca } from '../../util/biblioteca';
import { Constantes } from '../../util/constantes';

@Injectable()
export class EmpresaService extends TypeOrmCrudService<Empresa> {

  constructor(
    @InjectRepository(Empresa) repository) { super(repository); }
	
    async atualizar(objeto: Empresa): Promise<Empresa> {
      const connection = getConnection();
      const queryRunner = connection.createQueryRunner();  
      await queryRunner.connect();
      await queryRunner.startTransaction();
  
      let empresa = await connection.manager.findOne(Empresa, { where: { cnpj: objeto.cnpj }} );
      if (empresa != null) {
    		// TODO: salva a imagem em disco
        objeto.logotipo = '';
        objeto.id = empresa.id;
        const retorno = await queryRunner.manager.save(objeto);
        await queryRunner.commitTransaction();
        return retorno;
      } 
      return null;
    }
 
    async registrar(objeto: Empresa): Promise<Empresa> {
      const connection = getConnection();
      const queryRunner = connection.createQueryRunner();  
      await queryRunner.connect();
      await queryRunner.startTransaction();
    
      let empresa = await connection.manager.findOne(Empresa, { where: { cnpj: objeto.cnpj }} );
      if (empresa != null) {
        if (empresa.registrado != 'P') {
            objeto.id = empresa.id;
            objeto.registrado = 'P';
            const retorno = await queryRunner.manager.save(objeto);
            await queryRunner.commitTransaction();
            await this.enviarEmailConfirmacao(objeto);
            return retorno;
        }    
      }

      return null;
    }

    async enviarEmailConfirmacao(objeto: Empresa): Promise<Empresa> {
      const codigo = Biblioteca.md5String(objeto.cnpj + Constantes.CHAVE);
            
      let corpo = "";
      corpo = corpo + "<html>";
      corpo = corpo + "<body>";
      corpo = corpo + "<p>Olá " + objeto.nomeFantasia + ", </p>";
      corpo = corpo + "<p>Parabéns pelo seu cadastro na aplicação T2Ti Pegasus PDV. Segue o código de confirmação para liberar o uso da aplicação.</p>";
      corpo = corpo + "<p>Informe o seguinte código na aplicação: " + codigo + "</p>";
      corpo = corpo + "<p>Atenciosamente,</p>";
      corpo = corpo + "<p>Equipe T2Ti.COM</p>";
      corpo = corpo + "</body>";
      corpo = corpo + "</html>";

      Biblioteca.enviarEmail("T2Ti Pegasus PDV - Código de Confirmação", objeto.email, corpo);
      return null;
    }

    async conferirCodigoConfirmacao(objeto: Empresa, codigoConfirmacao: string): Promise<Empresa> {
      const connection = getConnection();
      const queryRunner = connection.createQueryRunner();  
      await queryRunner.connect();
      await queryRunner.startTransaction();

      const codigo = Biblioteca.md5String(objeto.cnpj + Constantes.CHAVE);
      if (codigo == codigoConfirmacao) {
        let empresa = await connection.manager.findOne(Empresa, { where: { cnpj: objeto.cnpj }} );
        if (empresa != null) {
          objeto.id = empresa.id;
          objeto.registrado = 'S';
          objeto.dataRegistro = new Date();
          objeto.horaRegistro = new Date().toISOString();          
          const retorno = await queryRunner.manager.save(objeto);
          await queryRunner.commitTransaction();
          return retorno;
       }
      }      
      return null;
    }
    
}