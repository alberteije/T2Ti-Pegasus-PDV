import * as fs from "fs";
import * as Mustache from 'mustache';
import { TabelaService } from '../../service/tabela.service';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { GeradorBase } from "../../gerador/gerador.base";
import { FlutterAbaDetalheListaPage } from './flutter.aba.detalhe.lista.page';
import { FlutterAbaDetalheDetalhePage } from './flutter.aba.detalhe.detalhe.page';
import { FlutterAbaDetalhePersistePage } from './flutter.aba.detalhe.persiste.page';
import { FlutterAbaMestreListaPage } from './flutter.aba.mestre.lista.page';
import { FlutterAbaMestreDetalhePage } from './flutter.aba.mestre.detalhe.page';
import { FlutterAbaMestrePersistePage } from './flutter.aba.mestre.persiste.page';
import { FlutterAbaMestrePersistePageOneToOne } from './flutter.aba.mestre.persiste.page.one.to.one';
import { FlutterAbaMestrePage } from './flutter.aba.mestre.page';
import { Biblioteca } from "../../util/biblioteca";

export class GeradorFlutterAba extends GeradorBase {

    relacionamentosOneToOne: ComentarioDerJsonModel[];

    caminhoFontes = 'c:/t2ti/gerador.codigo/fontes/flutter/';
    arquivoTemplateAbaDetalheListaPage = 'c:/t2ti/gerador.codigo/templates/flutter/Flutter.AbaDetalheListaPage.mustache';
    arquivoTemplateAbaDetalheDetalhePage = 'c:/t2ti/gerador.codigo/templates/flutter/Flutter.AbaDetalheDetalhePage.mustache';
    arquivoTemplateAbaDetalhePersistePage = 'c:/t2ti/gerador.codigo/templates/flutter/Flutter.AbaDetalhePersistePage.mustache';
    arquivoTemplateAbaMestreListaPage = 'c:/t2ti/gerador.codigo/templates/flutter/Flutter.AbaMestreListaPage.mustache';
    arquivoTemplateAbaMestreDetalhePage = 'c:/t2ti/gerador.codigo/templates/flutter/Flutter.AbaMestreDetalhePage.mustache';
    arquivoTemplateAbaMestrePersistePage = 'c:/t2ti/gerador.codigo/templates/flutter/Flutter.AbaMestrePersistePage.mustache';
    arquivoTemplateAbaMestrePersistePageOneToOne = 'c:/t2ti/gerador.codigo/templates/flutter/Flutter.AbaMestrePersistePageOneToOne.mustache';
    arquivoTemplateAbaMestrePage = 'c:/t2ti/gerador.codigo/templates/flutter/Flutter.AbaMestrePage.mustache';

    constructor() {
        super();
        this.relacionamentos = new Array;
        this.relacionamentosOneToOne = new Array;
    }

    async gerarArquivos(tabela: string, result: (retorno: any, erro: any) => void) {
        // nome da tabela
        this.tabela = tabela.toUpperCase();

        // criar diretório
        let retorno = await super.criarDiretorio(this.caminhoFontes + this.tabela + '/MestreDetalhe');
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
     * Encontra todas as tabelas agregadas a partir da chave estrangeira e gera as páginas filhas
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

                // gera a ListaPage de Detalhe
                await this.gerarDetalheListaPage(this.tabelaAgregada);
                // gera a DetalhePage de Detalhe
                await this.gerarDetalheDetalhePage(this.tabelaAgregada);            
                // gera o PersistePage de Detalhe
                await this.gerarDetalhePersistePage(this.tabelaAgregada);
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
            
            // gera a ListaPage - Mestre
            await this.gerarMestreListaPage(this.tabela);
            // gera a DetalhePage - Mestre
            await this.gerarMestreDetalhePage(this.tabela);            
            // gera a PersistePage - Mestre
            await this.gerarMestrePersistePage(this.tabela);
            
            // gera a page mester
            await this.gerarMestrePage(this.tabela);

            // gera a PersistePage - @OneToOne
            for (let index = 0; index < this.relacionamentosOneToOne.length; index++) {
                await this.gerarMestrePersistePageOneToOne(this.relacionamentosOneToOne[index].tabela);
            }

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

            // vamos armazenar dois arrays de relacionamento
            // completo: usado para montar a página mestre das abas
            // OneToOne: usado para criar as páginas OneToOne
            if (tabela != this.tabela) {
                // monta o nome do campo: Ex: ID_PESSOA
                let nomeCampoFK = 'ID_' + this.tabela.toUpperCase();

                // verifica se o campo FK contem algum comentário para inserir como relacionamento
                for (let i = 0; i < lista.length; i++) {
                    if (lista[i].Field == nomeCampoFK && lista[i].Comment != '') {
                        if (Biblioteca.isJsonString(tabela, lista[i].Comment)) {
                            let objeto = new ComentarioDerJsonModel(tabela, lista[i].Comment, this.tabela);
                            if (objeto.cardinalidade == '@OneToOne') {
                                this.relacionamentosOneToOne.push(objeto);
                            }
                            if (objeto.side != 'Local') {
                                this.relacionamentos.push(objeto);
                            }
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
     * Gera a ListaPage de Detalhe
     */
    async gerarDetalheListaPage(tabela: string) {
        let modelJson = new FlutterAbaDetalheListaPage(tabela, this.tabela, this.dataPacket);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateAbaDetalheListaPage).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = tabela.toLowerCase() + '_lista_page';

        return super.gravarArquivo(this.caminhoFontes + this.tabela + '/MestreDetalhe/' + nomeArquivo + '.dart', modelGerado);
    }

    /**
     * Gera a DetalhePage de Detalhe
     */
    async gerarDetalheDetalhePage(tabela: string) {
        let modelJson = new FlutterAbaDetalheDetalhePage(tabela, this.tabela, this.dataPacket);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateAbaDetalheDetalhePage).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = tabela.toLowerCase() + '_detalhe_page';

        return super.gravarArquivo(this.caminhoFontes + this.tabela + '/MestreDetalhe/' + nomeArquivo + '.dart', modelGerado);
    }

    /**
     * Gera a PersistePage de Detalhe
     */
    async gerarDetalhePersistePage(tabela: string) {
        let modelJson = new FlutterAbaDetalhePersistePage(tabela, this.tabela, this.dataPacket);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateAbaDetalhePersistePage).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = tabela.toLowerCase() + '_persiste_page';

        return super.gravarArquivo(this.caminhoFontes + this.tabela + '/MestreDetalhe/' + nomeArquivo + '.dart', modelGerado);
    }


    /**
     * Gera a ListaPage - mestre
     */
    async gerarMestreListaPage(tabela: string) {
        let modelJson = new FlutterAbaMestreListaPage(tabela, this.dataPacket);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateAbaMestreListaPage).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = tabela.toLowerCase() + '_lista_page';

        return super.gravarArquivo(this.caminhoFontes + this.tabela + '/MestreDetalhe/' + nomeArquivo + '.dart', modelGerado);
    }

    /**
     * Gera a DetalhePage - mestre
     */
    async gerarMestreDetalhePage(tabela: string) {
        let modelJson = new FlutterAbaMestreDetalhePage(tabela, this.dataPacket);

        let modelTemplate = fs.readFileSync(this.arquivoTemplateAbaMestreDetalhePage).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = tabela.toLowerCase() + '_detalhe_page';

        return super.gravarArquivo(this.caminhoFontes + this.tabela + '/MestreDetalhe/' + nomeArquivo + '.dart', modelGerado);
    }

    /**
     * Gera a PersistePage - mestre
     */
    async gerarMestrePersistePage(tabela: string) {
        let modelJson = new FlutterAbaMestrePersistePage(tabela, this.dataPacket);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateAbaMestrePersistePage).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = tabela.toLowerCase() + '_persiste_page';

        return super.gravarArquivo(this.caminhoFontes + this.tabela + '/MestreDetalhe/' + nomeArquivo + '.dart', modelGerado);
    }

    /**
     * Gera a PersistePage - mestre - OneToOne - Ex: PESSOA_FISICA / PESSOA_JURIDICA
     */
    async gerarMestrePersistePageOneToOne(tabela: string) {
        // vamos pegar o datapacket da tabela novamente, pois neste momento o datapacket da vez é o da tabela mestre
        let lista = await TabelaService.pegarCampos(tabela);
        this.dataPacket = lista;

        let modelJson = new FlutterAbaMestrePersistePageOneToOne(tabela, this.tabela, this.dataPacket);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateAbaMestrePersistePageOneToOne).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = tabela.toLowerCase() + '_persiste_page_OneToOne';

        return super.gravarArquivo(this.caminhoFontes + this.tabela + '/MestreDetalhe/' + nomeArquivo + '.dart', modelGerado);
    }

    /**
     * Gera a MestrePage das abas
     */
    async gerarMestrePage(tabela: string) {
        let modelJson = new FlutterAbaMestrePage(tabela, this.relacionamentos);
        let modelTemplate = fs.readFileSync(this.arquivoTemplateAbaMestrePage).toString();
        let modelGerado = Mustache.render(modelTemplate, modelJson);

        let nomeArquivo = tabela.toLowerCase() + '_page';

        return super.gravarArquivo(this.caminhoFontes + this.tabela + '/MestreDetalhe/' + nomeArquivo + '.dart', modelGerado);
    }

}