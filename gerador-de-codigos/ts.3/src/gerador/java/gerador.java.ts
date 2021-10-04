import * as fs from "fs";
import * as lodash from "lodash";
import * as Mustache from 'mustache';
import { TabelaService } from '../../service/tabela.service';
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { JavaModel } from './java.model';
import { JavaController } from './java.controller';
import { JavaRepository } from './java.repository';
import { JavaService } from "./java.service";
import { GeradorBase } from "../../gerador/gerador.base";

export class GeradorJava extends GeradorBase {

    caminhoFontes = 'c:/t2ti/gerador.codigo/fontes/java/';
    arquivoTemplateModel = 'c:/t2ti/gerador.codigo/templates/java/Java.Model.mustache';
    arquivoTemplateController = 'c:/t2ti/gerador.codigo/templates/java/Java.Controller.mustache';
    arquivoTemplateRepository = 'c:/t2ti/gerador.codigo/templates/java/Java.Repository.mustache';
    arquivoTemplateService = 'c:/t2ti/gerador.codigo/templates/java/Java.Service.mustache';

    constructor() {
        super();
        this.relacionamentos = new Array;
    }

    async gerarArquivos(tabela: string, modulo: string, result: (retorno: any, erro: any) => void) {

        // nome da tabela
        this.tabela = tabela.toUpperCase();

        // nome do package
        this.modulo = modulo;

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
        retorno = await super.criarDiretorio(this.caminhoFontes + '_REPOSITORY');
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
            // gera o Repository
            await this.gerarRepository();
            // gera o Service
            await this.gerarService();

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
            var modelJson = new JavaModel(tabela, this.modulo, this.dataPacket, null);
        } else {
            var modelJson = new JavaModel(tabela, this.modulo, this.dataPacket, this.relacionamentos);
        }
        let modelTemplate = fs.readFileSync(this.arquivoTemplateModel).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = lodash.camelCase(tabela);
        nomeArquivo = lodash.upperFirst(nomeArquivo);

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_MODEL/' + nomeArquivo + '.java', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.java', modelGerado);
        return retorno;
    }

    /**
     * Gera o Controller para a tabela principal
     */
    async gerarController() {
        let modelJson = new JavaController(this.tabela, this.modulo);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateController).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = lodash.camelCase(this.tabela) + 'Controller';
        nomeArquivo = lodash.upperFirst(nomeArquivo);

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_CONTROLLER/' + nomeArquivo + '.java', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.java', modelGerado);
        return retorno;
    }

    /**
     * Gera o Repository para a tabela principal
     */
    async gerarRepository() {
        let modelJson = new JavaRepository(this.tabela, this.modulo);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateRepository).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = lodash.camelCase(this.tabela) + 'Repository';
        nomeArquivo = lodash.upperFirst(nomeArquivo);

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_REPOSITORY/' + nomeArquivo + '.java', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.java', modelGerado);
        return retorno;
    }

    /**
     * Gera o Service para a tabela principal
     */
    async gerarService() {
        var modelJson = new JavaService(this.tabela, this.modulo);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateService).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = lodash.camelCase(this.tabela) + 'Service';
        nomeArquivo = lodash.upperFirst(nomeArquivo);

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_SERVICE/' + nomeArquivo + '.java', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.java', modelGerado);
        return retorno;
    }

}