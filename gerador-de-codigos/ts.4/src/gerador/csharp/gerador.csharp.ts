import * as fs from "fs";
import * as lodash from "lodash";
import * as Mustache from 'mustache';
import { TabelaService } from '../../service/tabela.service';
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { CSharpModel } from './csharp.model';
import { CSharpController } from './csharp.controller';
import { CSharpRepository } from './csharp.repository';
import { CSharpIRepository } from './csharp.irepository';
import { CSharpExtension } from "./csharp.extension";
import { CSharpWrapperContext } from "./csharp.wrapper.context";
import { GeradorBase } from "../../gerador/gerador.base";

export class GeradorCSharp extends GeradorBase {

    tabela: string;
    tabelaAgregada: string;
    dataPacket: CamposModel[];
    relacionamentos: ComentarioDerJsonModel[];

    caminhoFontes = 'c:/t2ti/gerador.codigo/fontes/csharp/';
    arquivoTemplateModel = 'c:/t2ti/gerador.codigo/templates/csharp/CSharp.Model.mustache';
    arquivoTemplateController = 'c:/t2ti/gerador.codigo/templates/csharp/CSharp.Controller.mustache';
    arquivoTemplateRepository = 'c:/t2ti/gerador.codigo/templates/csharp/CSharp.Repository.mustache';
    arquivoTemplateIRepository = 'c:/t2ti/gerador.codigo/templates/csharp/CSharp.IRepository.mustache';
    arquivoTemplateExtension = 'c:/t2ti/gerador.codigo/templates/csharp/CSharp.Extension.mustache';
    arquivoTemplateWrapperContext = 'c:/t2ti/gerador.codigo/templates/csharp/CSharp.WrapperContext.mustache';

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
        retorno = await super.criarDiretorio(this.caminhoFontes + '_EXTENSION');
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
        retorno = await super.criarDiretorio(this.caminhoFontes + '_IREPOSITORY');
        if (retorno != true) {
            return result(null, retorno);
        }        
        retorno = await super.criarDiretorio(this.caminhoFontes + '_WRAPPER_CONTEXT');
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
                let retorno = await this.pegarCampos(this.tabelaAgregada);
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
            let retorno = await this.pegarCampos(this.tabela);
            if (retorno != true) {
                return retorno;
            }
            // gera o Model
            await this.gerarModel(this.tabela);
            // gera o Controller
            await this.gerarController();
            // gera o Repository
            await this.gerarRepository();
            // gera o IRepository
            await this.gerarIRepository();
            // gera o Extension
            await this.gerarExtension();
            // gera o código para os arquivos RepositoryWrapper, IRepositoryWrapper e RepositoryContext
            await this.gerarWrapperContext();

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
            var modelJson = new CSharpModel(tabela, this.dataPacket, null);
        } else {
            var modelJson = new CSharpModel(tabela, this.dataPacket, this.relacionamentos);
        }
        let modelTemplate = fs.readFileSync(this.arquivoTemplateModel).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = lodash.camelCase(tabela);
        nomeArquivo = lodash.upperFirst(nomeArquivo);

        super.gravarArquivo(this.caminhoFontes + '_MODEL/' + nomeArquivo + '.cs', modelGerado);
        return super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.cs', modelGerado);
    }

    /**
     * Gera o Controller para a tabela principal
     */
    async gerarController() {
        let modelJson = new CSharpController(this.tabela);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateController).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = lodash.camelCase(this.tabela) + 'Controller';
        nomeArquivo = lodash.upperFirst(nomeArquivo);

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_CONTROLLER/' + nomeArquivo + '.cs', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.cs', modelGerado);
        return retorno;
    }

    /**
     * Gera o Repository para a tabela principal
     */
    async gerarRepository() {
        let modelJson = new CSharpRepository(this.tabela, this.dataPacket, this.relacionamentos);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateRepository).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = lodash.camelCase(this.tabela) + 'Repository';
        nomeArquivo = lodash.upperFirst(nomeArquivo);

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_REPOSITORY/' + nomeArquivo + '.cs', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.cs', modelGerado);
        return retorno;
    }

    /**
     * Gera o IRepository para a tabela principal
     */
    async gerarIRepository() {
        let modelJson = new CSharpIRepository(this.tabela);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateIRepository).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeClasse = lodash.camelCase(this.tabela);
        nomeClasse = lodash.upperFirst(nomeClasse);

        let nomeArquivo = 'I' + nomeClasse + 'Repository';
        nomeArquivo = lodash.upperFirst(nomeArquivo);

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_IREPOSITORY/' + nomeArquivo + '.cs', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.cs', modelGerado);
        return retorno;
    }

    /**
     * Gera o Extension para a tabela principal
     */
    async gerarExtension() {
        var modelJson = new CSharpExtension(this.tabela, this.dataPacket, this.relacionamentos);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateExtension).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = lodash.camelCase(this.tabela) + 'Extension';
        nomeArquivo = lodash.upperFirst(nomeArquivo);

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_EXTENSION/' + nomeArquivo + '.cs', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.cs', modelGerado);
        return retorno;
    }

   /**
     * Gera o Extension para a tabela principal
     */
    async gerarWrapperContext() {
        var modelJson = new CSharpWrapperContext(this.tabela);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateWrapperContext).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = lodash.camelCase(this.tabela) + 'WrapperContext';
        nomeArquivo = lodash.upperFirst(nomeArquivo);

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_WRAPPER_CONTEXT/' + nomeArquivo + '.txt', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.txt', modelGerado);
        return retorno;
    }

}