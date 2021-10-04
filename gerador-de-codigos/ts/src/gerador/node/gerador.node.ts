import * as fs from "fs";
import * as lodash from "lodash";
import * as Mustache from 'mustache';
import { TabelaService } from '../../service/tabela.service';
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { NodeModel } from './node.model';
import { NodeController } from './node.controller';
import { NodeModule } from './node.module';
import { NodeService } from "./node.service";
import { NodeEntitiesExport } from "./node.entities.export";
import { NodeModulesExport } from "./node.modules.export";
import { GeradorBase } from "../../gerador/gerador.base";

export class GeradorNode extends GeradorBase {

    tabela: string;
    modulo: string;
    nomePasta: string;
    tabelaAgregada: string;
    dataPacket: CamposModel[];
    relacionamentos: ComentarioDerJsonModel[];
    listaTabelas = [];

    caminhoFontes = 'c:/t2ti/gerador.codigo/fontes/node/';
    arquivoTemplateModel = 'c:/t2ti/gerador.codigo/templates/node/Node.Model.mustache';
    arquivoTemplateController = 'c:/t2ti/gerador.codigo/templates/node/Node.Controller.mustache';
    arquivoTemplateModule = 'c:/t2ti/gerador.codigo/templates/node/Node.Module.mustache';
    arquivoTemplateService = 'c:/t2ti/gerador.codigo/templates/node/Node.Service.mustache';
    arquivoTemplateEntitiesExport = 'c:/t2ti/gerador.codigo/templates/node/Node.Entities.Export.mustache';
    arquivoTemplateModulesExport = 'c:/t2ti/gerador.codigo/templates/node/Node.Modules.Export.mustache';

    constructor() {
        super();
        this.relacionamentos = new Array;
    }

    async gerarArquivos(tabela: string, result: (retorno: any, erro: any) => void) {

        // nome da tabela
        this.tabela = tabela.toUpperCase();
        this.nomePasta = lodash.replace(this.tabela.toLowerCase(), new RegExp("_", "g"), "-");

        // criar diretório
        let retorno = await super.criarDiretorio(this.caminhoFontes + this.nomePasta);
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
        retorno = await super.criarDiretorio(this.caminhoFontes + '_MODULE');
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
            // gera o Module
            await this.gerarModule();
            // gera o Service
            await this.gerarService();

            return true;
        } catch (erro) {
            return erro;
        }
    }

    /**
     * Pega as colunas de determinada tabela e atribui ao datapacket (variável de classe)
     */
    async pegarCampos(tabela: string) {
        try {
            let lista = await TabelaService.pegarCampos(tabela);
            this.dataPacket = lista;

            // verifica se a tabela que está sendo utilizada neste momento é diferente da tabela principal
            // aqui geramos apenas os relacionamentos agregados onde a FK se encontra em uma outra tabela diferente da principal
            // esses relacionamentos serão utilizados apenas para a geração da classe principal
            // todo e qualquer relacionamento (objeto na classe filha) será tratado dentro do gerador do model
            if (tabela != this.tabela) {
                // monta o nome do campo: Ex: ID_PESSOA
                let nomeCampoFK = 'ID_' + this.tabela.toUpperCase();

                // verifica se o campo FK contem algum comentário para inserir como relacionamento
                for (let i = 0; i < lista.length; i++) {
                    if (lista[i].Field == nomeCampoFK && lista[i].Comment != '') {
                        let objeto = new ComentarioDerJsonModel(tabela, lista[i].Comment, this.tabela);
                        // vamos inserir apenas os relacionamentos cujo Side não seja 'Local', pois esses serão encontrados e tratados no Model
                        if (objeto.side != 'Local') {
                            this.relacionamentos.push(objeto);
                        }
                    }
                }
            }
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
            var modelJson = new NodeModel(tabela, this.dataPacket, null);
        } else {
            var modelJson = new NodeModel(tabela, this.dataPacket, this.relacionamentos);
        }
        let modelTemplate = fs.readFileSync(this.arquivoTemplateModel).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = lodash.replace(tabela.toLowerCase(), new RegExp("_", "g"), "-") + '.entity';

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_MODEL/' + nomeArquivo + '.ts', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.nomePasta + '/' + nomeArquivo + '.ts', modelGerado);
        return retorno;
    }

    /**
     * Gera o Controller para a tabela principal
     */
    async gerarController() {
        let modelJson = new NodeController(this.tabela, this.dataPacket, this.relacionamentos);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateController).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = lodash.replace(this.tabela.toLowerCase(), new RegExp("_", "g"), "-") + '.controller';

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_CONTROLLER/' + nomeArquivo + '.ts', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.nomePasta + '/' + nomeArquivo + '.ts', modelGerado);
        return retorno;
    }

    /**
     * Gera o Module para a tabela principal
     */
    async gerarModule() {
        let modelJson = new NodeModule(this.tabela);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateModule).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = lodash.replace(this.tabela.toLowerCase(), new RegExp("_", "g"), "-") + '.module';

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_MODULE/' + nomeArquivo + '.ts', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.nomePasta + '/' + nomeArquivo + '.ts', modelGerado);
        return retorno;
    }

    /**
     * Gera o Service para a tabela principal
     */
    async gerarService() {
        var modelJson = new NodeService(this.tabela, this.relacionamentos);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateService).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = lodash.replace(this.tabela.toLowerCase(), new RegExp("_", "g"), "-") + '.service';

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_SERVICE/' + nomeArquivo + '.ts', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.nomePasta + '/' + nomeArquivo + '.ts', modelGerado);
        return retorno;
    }

    /**
     * Gera arquivos a partir do nome das tabelas
     */
    async gerarArquivosLacoTabela(modulo: string, result: (retorno: any, erro: any) => void) {
        try {
            // pega a lista com o nome das tabelas
            let lista = await TabelaService.pegarTabelas();
            for (let index = 0; index < lista.length; index++) {
                this.listaTabelas.push(lista[index].nome);
            }
            
            // gera o arquivo com a exportação das entities
            var modelJson = new NodeEntitiesExport(modulo, this.listaTabelas);
            let modelTemplate = fs.readFileSync(this.arquivoTemplateEntitiesExport).toString();
            let modelGerado = Mustache.render(modelTemplate, modelJson);
            let nomeArquivo = "NodeEntitiesExport.txt";
            super.gravarArquivo(this.caminhoFontes + '/' + nomeArquivo, modelGerado);

            // gera o arquivo com a exportação dos Module
            // para cada módulo do banco existirá um arquivo desses
            // ex: cadastros.module
            // ex: compras.module
            modelJson = new NodeModulesExport(modulo, this.listaTabelas);
            modelTemplate = fs.readFileSync(this.arquivoTemplateModulesExport).toString();
            modelGerado = Mustache.render(modelTemplate, modelJson);
            nomeArquivo = "NodeModulesExport.txt";
            super.gravarArquivo(this.caminhoFontes + '/' + nomeArquivo, modelGerado);

            result({ mensagem: "Arquivos gerados com sucesso!" }, null);
        } catch (erro) {
            return result(null, erro);
        }

    }

}