import * as fs from "fs";
import * as Mustache from 'mustache';
import { TabelaService } from '../../service/tabela.service';
import { MoorTabela } from './moor.tabela';
import { MoorDao } from "./moor.dao";
import { MoorDatabase } from "./moor.database";
import { GeradorBase } from "../../gerador/gerador.base";

export class GeradorMoor extends GeradorBase {

    caminhoFontes = 'c:/t2ti/gerador.codigo/fontes/moor/';
    arquivoTemplateTabela = 'c:/t2ti/gerador.codigo/templates/moor/Moor.Tabela.mustache';
    arquivoTemplateDao = 'c:/t2ti/gerador.codigo/templates/moor/Moor.Dao.mustache';
    arquivoTemplateDatabase = 'c:/t2ti/gerador.codigo/templates/moor/Moor.Database.mustache';

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
        retorno = await super.criarDiretorio(this.caminhoFontes + '_TABELA');
        if (retorno != true) {
            return result(null, retorno);
        }
        retorno = await super.criarDiretorio(this.caminhoFontes + '_DAO');
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
                // await this.gerarModel(this.tabelaAgregada);
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
            // gera o Tabela
            await this.gerarTabela(this.tabela);
            // gera o Database
            await this.gerarDao();

            return true;
        } catch (erro) {
            return erro;
        }
    }

    /**
     * Gera o Tabela - serve para a tabela principal e também para as tabelas agregadas
     */
    async gerarTabela(tabela: string) {
        // só passa os relacionamentos se for a tabela principal
        if (tabela != this.tabela) {
            var modelJson = new MoorTabela(tabela, this.dataPacket, null);
        } else {
            var modelJson = new MoorTabela(tabela, this.dataPacket, this.relacionamentos);
        }
        let modelTemplate = fs.readFileSync(this.arquivoTemplateTabela).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = tabela.toLowerCase();

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_TABELA/' + nomeArquivo + '.dart', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.dart', modelGerado);
        return retorno;
    }

    /**
     * Gera o Dao
     */
    async gerarDao() {
        var modelJson = new MoorDao(this.tabela, this.relacionamentos);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateDao).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = this.tabela.toLowerCase() + '_dao';

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_DAO/' + nomeArquivo + '.dart', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.dart', modelGerado);
        return retorno;
    }

    /**
      * Gera o arquivo Database - é apenas um arquivo
      */
    async gerarArquivoDatabase(modulo: string, result: (retorno: any, erro: any) => void) {
        try {
            // pega a lista com o nome das tabelas
            let lista = await TabelaService.pegarTabelas();
            for (let index = 0; index < lista.length; index++) {
                this.listaTabelas.push(lista[index].nome);
            }
            
            // gera o arquivo com o conteúdo para todas e para os includes
            var modelJson = new MoorDatabase(modulo, this.listaTabelas);
            let modelTemplate = fs.readFileSync(this.arquivoTemplateDatabase).toString();
            let modelGerado = Mustache.render(modelTemplate, modelJson);
            let nomeArquivo = "FlutterDatabaseExports.txt";
            super.gravarArquivo(this.caminhoFontes + '/' + nomeArquivo, modelGerado);

            result({ mensagem: "Arquivos gerados com sucesso!" }, null);
        } catch (erro) {
            return result(null, erro);
        }
    }

}