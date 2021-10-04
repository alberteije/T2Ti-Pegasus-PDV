import * as fs from "fs";
import * as lodash from "lodash";
import * as Mustache from 'mustache';
import { TabelaService } from '../../service/tabela.service';
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { NHibernateModel } from './nhibernate.model';
import { NHibernateController } from './nhibernate.controller';
import { NHibernateHBM } from './nhibernate.hbm';
import { NHibernateService } from "./nhibernate.service";
import { GeradorBase } from "../../gerador/gerador.base";

export class GeradorNHibernate extends GeradorBase {

    caminhoFontes = 'c:/t2ti/gerador.codigo/fontes/nhibernate/';
    arquivoTemplateModel = 'c:/t2ti/gerador.codigo/templates/nhibernate/NHibernate.Model.mustache';
    arquivoTemplateController = 'c:/t2ti/gerador.codigo/templates/nhibernate/NHibernate.Controller.mustache';
    arquivoTemplateService = 'c:/t2ti/gerador.codigo/templates/nhibernate/NHibernate.Service.mustache';
    arquivoTemplateHBM = 'c:/t2ti/gerador.codigo/templates/nhibernate/NHibernate.HBM.mustache';

    constructor() {
        super();
        this.relacionamentos = new Array;
    }

    async gerarArquivos(tabela: string, result: (retorno: any, erro: any) => void) {
        // nome da tabela
        this.tabela = tabela.toUpperCase();

        // criar diretório
        let retorno = await super.criarDiretorio(this.caminhoFontes + this.tabela);
        if (retorno != true) {
            return result(null, retorno);
        }
        retorno = await super.criarDiretorio(this.caminhoFontes + '_CONTROLLER');
        if (retorno != true) {
            return result(null, retorno);
        }        
        retorno = await super.criarDiretorio(this.caminhoFontes + '_SERVICE');
        if (retorno != true) {
            return result(null, retorno);
        }        
        retorno = await super.criarDiretorio(this.caminhoFontes + '_MODEL');
        if (retorno != true) {
            return result(null, retorno);
        }        
        retorno = await super.criarDiretorio(this.caminhoFontes + '_HBM');
        if (retorno != true) {
            return result(null, retorno);
        }        

        // procura pelas tabelas agregadas para criar os relacionamentos de primeiro nível
        retorno = await this.gerarAgregadosPrimeiroNivel();
        if (retorno != true) {
            return result(null, retorno);
        }

        // gera os arquivos para a tabela principal
        retorno = await this.gerarArquivosTabelaPrincipal();
        if (retorno != true) {
            return result(null, retorno);
        }

        // retorna mensagem OK
        result({ mensagem: "Arquivos gerados com sucesso!" }, null);
    }

    /**
     * Encontra todas as tabelas agregadas a partir da chave estrangeira e gera os arquivos de modelo
     * Não procuraremos por tabelas de segundo nível, apenas as de primeiro nível vinculadas diretamente
     * à tabela principal que foi enviada pelo usuário
     */
    async gerarAgregadosPrimeiroNivel() {
        try {
            let lista = await TabelaService.consultarAgregados(this.tabela);
            for (let index = 0; index < lista.length; index++) {
                this.tabelaAgregada = lista[index].TABLE_NAME;

                // pega os campos para a tabela                
                let retorno = await super.pegarCampos(this.tabelaAgregada);
                if (retorno != true) {
                    return retorno;
                }

                // gera o Model
                await this.gerarModel(this.tabelaAgregada);

                // gera o HBM
                await this.gerarHBM(this.tabelaAgregada);
            }
            return true;
        } catch (erro) {
            return erro;
        }
    }

    /**
     * Gera arquivos para a tabela principal
     */
    async gerarArquivosTabelaPrincipal() {
        try {
            // pega os campos para a tabela
            let retorno = await super.pegarCampos(this.tabela);
            if (retorno != true) {
                return retorno;
            }
            // gera o Model
            await this.gerarModel(this.tabela);
            // gera o Controller
            await this.gerarController();
            // gera o Service
            await this.gerarService();
            // gera o HBM
            await this.gerarHBM(this.tabela);

            return true;
        } catch (erro) {
            return erro;
        }
    }

    /**
     * Gera o Model - serve para a tabela principal e também para as tabelas agregadas
     */
    async gerarModel(tabela: string) {
        // só passa os relacionamentos se for a tabela principal
        if (tabela != this.tabela) {
            var modelJson = new NHibernateModel(tabela, this.dataPacket, null);
        } else {
            var modelJson = new NHibernateModel(tabela, this.dataPacket, this.relacionamentos);
        }
        let modelTemplate = fs.readFileSync(this.arquivoTemplateModel).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = lodash.camelCase(tabela);
        nomeArquivo = lodash.upperFirst(nomeArquivo);

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_MODEL/' + nomeArquivo + '.cs', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.cs', modelGerado);
        return retorno;
    }

    /**
     * Gera o Controller para a tabela principal
     */
    async gerarController() {
        let modelJson = new NHibernateController(this.tabela);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateController).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = lodash.camelCase(this.tabela) + 'Controller';
        nomeArquivo = lodash.upperFirst(nomeArquivo);

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_CONTROLLER/' + nomeArquivo + '.cs', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.cs', modelGerado);
        return retorno;
    }

    /**
     * Gera o Service para a tabela principal
     */
    async gerarService() {
        var modelJson = new NHibernateService(this.tabela);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateService).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = lodash.camelCase(this.tabela) + 'Service';
        nomeArquivo = lodash.upperFirst(nomeArquivo);

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_SERVICE/' + nomeArquivo + '.cs', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.cs', modelGerado);
        return retorno;
    }

    /**
     * Gera o HBM para a tabela principal
     */
    async gerarHBM(tabela: string) {
        // só passa os relacionamentos se for a tabela principal
        if (tabela != this.tabela) {
            var modelJson = new NHibernateHBM(tabela, this.dataPacket, null);
        } else {
            var modelJson = new NHibernateHBM(tabela, this.dataPacket, this.relacionamentos);
        }
        let modelTemplate = fs.readFileSync(this.arquivoTemplateHBM).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = lodash.camelCase(tabela);
        nomeArquivo = lodash.upperFirst(nomeArquivo);

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_HBM/' + nomeArquivo + '.hbm.xml', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.hbm.xml', modelGerado);
        return retorno;
   }

}