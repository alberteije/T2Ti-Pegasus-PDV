import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';

/// classe base que ajuda a gerar a DetalhePage do Flutter usando o mustache
export class FlutterDetalhePage {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    objetoPrincipal: string; // armazena o nome do objeto principal, que costuma ser o nome da classe com a primeira letra em minúsculo
    tituloJanela: string; // armazena o título da janela
    nomeArquivo: string; // armazena o nome do aruqivo que aparece no import

    listTileData = []; // armazena a lista de listTileData
    imports = []; // armazena os demais imports para a classe

    objetoJsonComentario: ComentarioDerJsonModel;

    importConstantes: boolean; // controla os imports para as constantes
    importData: boolean; // controla o import para o intl para formatar datas

    constructor(tabela: string, dataPacket: CamposModel[]) {
        // imports diversos
        this.importConstantes = false;
        this.importData = false;

        // nome da classe
        this.class = lodash.camelCase(tabela);
        this.objetoPrincipal = this.class;
        this.class = lodash.upperFirst(this.class);

        // nome da tabela
        this.table = tabela.toUpperCase();

        // nomeArquivo
        this.nomeArquivo = tabela.toLowerCase();

        // título da janela
        this.tituloJanela = lodash.startCase(this.class);

        // laço nos campos da tabela para montar a página
        for (let i = 0; i < dataPacket.length; i++) {
            // define o nome do campo
            let nomeCampo = dataPacket[i].Field;
            let nomeCampoTabela = nomeCampo.toUpperCase();
            let nomeCampoAtributo = lodash.camelCase(nomeCampo);

            // pega o objeto JSON de comentário - se não houver, este campo não será renderizado na janela
            if (dataPacket[i].Comment != '') {
                try {
                    this.objetoJsonComentario = new ComentarioDerJsonModel(this.table, dataPacket[i].Comment);

                    // pega o valor do campo de lookup que deve ser exibido no lugar do ID da chave estrangeira
                    let campoLookup = '';
                    if (nomeCampoTabela.includes('ID_')) {
                        if (this.objetoJsonComentario.campoLookup != null && this.objetoJsonComentario.campoLookup != '') {
                            let tabelaMestre = lodash.replace(nomeCampoTabela, 'ID_', '');
                            tabelaMestre = lodash.camelCase(tabelaMestre);
                            campoLookup = tabelaMestre + "?." + this.objetoJsonComentario.campoLookup;
                        }
                    }

                    // se o campoLookup for diferente de vazio, ele deve ser utilizado no lugar do campoAtributo
                    if (campoLookup != '') {
                        nomeCampoAtributo = campoLookup;
                    }

                    // listTileData
                    this.listTileData.push("ViewUtilLib.getListTileDataDetalhePage(");
                    if (dataPacket[i].Type.includes('decimal')) {
                        this.importConstantes = true;
                        let tipoControle = this.objetoJsonComentario.tipoControle;
                        let formatoDecimais = lodash.camelCase("formatoDecimal" + tipoControle.mascara);
                        let casasDecimais = lodash.camelCase("decimais" + tipoControle.mascara);
                        this.listTileData.push("\t" + this.objetoPrincipal + "." + nomeCampoAtributo + " != null ? Constantes." + formatoDecimais + ".format(" + this.objetoPrincipal + "." + nomeCampoAtributo + ") : 0.toStringAsFixed(Constantes." + casasDecimais + "), '" + this.objetoJsonComentario.labelText + "'),");
                    } else if (dataPacket[i].Type.includes('date')) {
                        this.importData = true;
                        this.listTileData.push("\t" + this.objetoPrincipal + "." + nomeCampoAtributo + " != null ? DateFormat('dd/MM/yyyy').format(" + this.objetoPrincipal + "." + nomeCampoAtributo + ") : '', '" + this.objetoJsonComentario.labelText + "'),");
                    } else if (dataPacket[i].Type.includes('int')) {
                        this.listTileData.push("\t" + this.objetoPrincipal + "." + nomeCampoAtributo + "?.toString() ?? '', '" + this.objetoJsonComentario.labelText + "'),");
                    } else {
                        this.listTileData.push("\t" + this.objetoPrincipal + "." + nomeCampoAtributo + " ?? '', '" + this.objetoJsonComentario.labelText + "'),");
                    }
                } catch (erro) {
                    this.objetoJsonComentario = null;
                }
            } 
        }
        // imports
        if (this.importConstantes) {
            this.imports.push("import 'package:fenix/src/infra/constantes.dart';")
        }
        if (this.importData) {
            this.imports.push("import 'package:intl/intl.dart';")
        }
    }

}