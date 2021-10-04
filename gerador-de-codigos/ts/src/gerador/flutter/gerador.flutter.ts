import * as fs from "fs";
import * as Mustache from 'mustache';
import { TabelaService } from '../../service/tabela.service';
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { GeradorBase } from "../../gerador/gerador.base";
import { FlutterService } from "./flutter.service";
import { FlutterViewModel } from "./flutter.view.model";
import { FlutterModel } from './flutter.model';
import { FlutterListaPage } from './flutter.lista.page';
import { FlutterDetalhePage } from './flutter.detalhe.page';
import { FlutterPersistePage } from './flutter.persiste.page';
import { FlutterExportsRotas } from "./flutter.exports.rotas";

export class GeradorFlutter extends GeradorBase {

    tabela: string;
    tabelaAgregada: string;
    dataPacket: CamposModel[];
    relacionamentos: ComentarioDerJsonModel[];
    listaTabelas = [];

    caminhoFontes = 'c:/t2ti/gerador.codigo/fontes/flutter/';
    arquivoTemplateService = 'c:/t2ti/gerador.codigo/templates/flutter/Flutter.Service.mustache';
    arquivoTemplateViewModel = 'c:/t2ti/gerador.codigo/templates/flutter/Flutter.ViewModel.mustache';
    arquivoTemplateModel = 'c:/t2ti/gerador.codigo/templates/flutter/Flutter.Model.mustache';
    arquivoTemplateListaPage = 'c:/t2ti/gerador.codigo/templates/flutter/Flutter.ListaPage.mustache';
    arquivoTemplateDetalhePage = 'c:/t2ti/gerador.codigo/templates/flutter/Flutter.DetalhePage.mustache';
    arquivoTemplatePersistePage = 'c:/t2ti/gerador.codigo/templates/flutter/Flutter.PersistePage.mustache';
    arquivoTemplateExportsRotas = 'c:/t2ti/gerador.codigo/templates/flutter/Flutter.Exports.Rotas.mustache';

    constructor() {
        super();
        this.relacionamentos = new Array;
    }

    async gerarArquivos(tabela: string, result: (retorno: any, erro: any) => void) {
        // nome da tabela
        this.tabela = tabela.toUpperCase();

        // criar diretório
        let retorno = await super.criarDiretorio(this.caminhoFontes + this.tabela.toLowerCase());
        if (retorno != true) {
            return result(null, retorno);
        }
        retorno = await super.criarDiretorio(this.caminhoFontes + '_VIEW_MODEL');
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
            // gera o Service
            await this.gerarService();
            // gera o ViewModel
            await this.gerarViewModel();
            // gera o Model
            await this.gerarModel(this.tabela);
            // gera a ListaPage
            await this.gerarListaPage();
            // gera a DetalhePage
            await this.gerarDetalhePage();            
            // gera o PersistePage
            await this.gerarPersistePage();

            // gera o conjunto de páginas mestre-detalhe
            
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
     * Gera o Service para a tabela principal
     */
    async gerarService() {
        var modelJson = new FlutterService(this.tabela);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateService).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = this.tabela.toLowerCase() + '_service';

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_SERVICE/' + nomeArquivo + '.dart', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.dart', modelGerado);
        return retorno;
    }

    /**
     * Gera o ViewModel para a tabela principal
     */
    async gerarViewModel() {
        var modelJson = new FlutterViewModel(this.tabela);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateViewModel).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = this.tabela.toLowerCase() + '_view_model';

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_VIEW_MODEL/' + nomeArquivo + '.dart', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.dart', modelGerado);
        return retorno;
    }

    /**
     * Gera o Model - serve para a tabela principal e também para as tabelas agregadas
     */
    async gerarModel(tabela: string) {
        // só passa os relacionamentos se for a tabela principal
        if (tabela != this.tabela) {
            var modelJson = new FlutterModel(tabela, this.dataPacket, null);
        } else {
            var modelJson = new FlutterModel(tabela, this.dataPacket, this.relacionamentos);
        }
        let modelTemplate = fs.readFileSync(this.arquivoTemplateModel).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = tabela.toLowerCase();

        let retorno = await super.gravarArquivo(this.caminhoFontes + '_MODEL/' + nomeArquivo + '.dart', modelGerado);
        retorno = await super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.dart', modelGerado);
        return retorno;
    }

    /**
     * Gera a ListaPage para a tabela principal
     */
    async gerarListaPage() {
        let modelJson = new FlutterListaPage(this.tabela, this.dataPacket);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateListaPage).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = this.tabela.toLowerCase() + '_lista_page';

        return super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.dart', modelGerado);
    }

    /**
     * Gera a DetalhePage para a tabela principal
     */
    async gerarDetalhePage() {
        let modelJson = new FlutterDetalhePage(this.tabela, this.dataPacket);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateDetalhePage).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = this.tabela.toLowerCase() + '_detalhe_page';

        return super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.dart', modelGerado);
    }

    /**
     * Gera a PersistePage para a tabela principal
     */
    async gerarPersistePage() {
        let modelJson = new FlutterPersistePage(this.tabela, this.dataPacket);
        let modelTemplate = fs.readFileSync(this.arquivoTemplatePersistePage).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = this.tabela.toLowerCase() + '_persiste_page';

        return super.gravarArquivo(this.caminhoFontes + this.tabela + '/' + nomeArquivo + '.dart', modelGerado);
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
            
            // gera o arquivo com o conteúdo para todas e para os includes
            var modelJson = new FlutterExportsRotas(modulo, this.listaTabelas);
            let modelTemplate = fs.readFileSync(this.arquivoTemplateExportsRotas).toString();
            let modelGerado = Mustache.render(modelTemplate, modelJson);
            let nomeArquivo = "FlutterExports.txt";
            super.gravarArquivo(this.caminhoFontes + '/' + nomeArquivo, modelGerado);

            result({ mensagem: "Arquivos gerados com sucesso!" }, null);
        } catch (erro) {
            return result(null, erro);
        }

    }

}