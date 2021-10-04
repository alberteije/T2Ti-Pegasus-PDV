import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { Biblioteca } from "../../util/biblioteca";

/// classe base que ajuda a gerar a DetalhePage do Flutter usando o mustache
export class FlutterDetalhePageBase {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    objetoPrincipal: string; // armazena o nome do objeto principal, que costuma ser o nome da classe com a primeira letra em minúsculo
    tituloJanela: string; // armazena o título da janela
    nomeArquivo: string; // armazena o nome do aruqivo que aparece no import

    listTileData = []; // armazena a lista de listTileData
    imports = []; // armazena os demais imports para a classe

    campoModel: CamposModel;
    objetoJsonComentario: ComentarioDerJsonModel;

    importConstantes: boolean; // controla os imports para as constantes
    importData: boolean; // controla o import para o intl para formatar datas

    constructor(tabela: string) {
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
    }

    montarPagina(dataPacket: CamposModel[]) {
        // laço nos campos da tabela para montar a página
        for (let i = 0; i < dataPacket.length; i++) {
            this.definirDadosIniciais(dataPacket[i]);

            // pega o objeto JSON de comentário - se não houver, este campo não será renderizado na janela
            if (dataPacket[i].Comment != '') {
                if (Biblioteca.isJsonString(this.table, this.campoModel.Comment)) {
                    try {
                        this.objetoJsonComentario = new ComentarioDerJsonModel(this.table, dataPacket[i].Comment);

                        // se o objeto não contém o campo desenhaControle, o controle será desenhado mesmo assim, pois o padrão é 'true'
                        // se o objeto contém o campo desenhaControle e estiver marcado como true, desenha o widget
                        if (this.objetoJsonComentario.desenhaControle == null || this.objetoJsonComentario.desenhaControle == true) {
                            // define o campo de lookup
                            if (this.campoModel.nomeCampoTabela.includes('ID_')) {
                                if (this.objetoJsonComentario.campoLookup != null && this.objetoJsonComentario.campoLookup != '') {
                                    this.definirDadosDeLookup();
                                }
                            }

                            // se o campoLookup for diferente de vazio, ele deve ser utilizado no lugar do campoAtributo
                            this.trocarAtributoPorLookup();

                            // listTileData
                            this.definirListTileData(false);
                        }
                    } catch (erro) {
                        this.objetoJsonComentario = null;
                    }
                }
            } 
        }

        // imports
        this.arrumarImports();
    }

    definirDadosIniciais(campoModel: CamposModel) {
        // pega o campo
        this.campoModel = campoModel;

        // define o nome do campo
        this.campoModel.nomeCampo = this.campoModel.Field;
        this.campoModel.nomeCampoTabela = this.campoModel.nomeCampo.toUpperCase();
        this.campoModel.nomeCampoAtributo = lodash.camelCase(this.campoModel.nomeCampo);
    }

    definirDadosDeLookup() {
        let tabelaMestre = this.objetoJsonComentario.tabelaLookup; // tabelaLookup deve ser definida inclusive para campos PK
        tabelaMestre = lodash.camelCase(tabelaMestre);
        this.objetoJsonComentario.campoLookupComTabela = tabelaMestre + "?." + this.objetoJsonComentario.campoLookup;
    }

    definirListTileData(objetoPrincipalNoWidget: boolean) {
        let usaWidget = "";
        if (objetoPrincipalNoWidget) {
            usaWidget = "widget.";
        }

        this.listTileData.push("ViewUtilLib.getListTileDataDetalhePage(");
        if (this.campoModel.Type.includes('decimal')) {
            this.importConstantes = true;
            let formatoDecimais = lodash.camelCase("formatoDecimal" + this.objetoJsonComentario.tipoControle.mascara);
            let casasDecimais = lodash.camelCase("decimais" + this.objetoJsonComentario.tipoControle.mascara);
            this.listTileData.push("\t" + usaWidget + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " != null ? Constantes." + formatoDecimais + ".format(" + usaWidget + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + ") : 0.toStringAsFixed(Constantes." + casasDecimais + "), '" + this.objetoJsonComentario.labelText + "'),");
        } else if (this.campoModel.Type.includes('date') || this.campoModel.Type.includes('timestamp')) {
            this.importData = true;
            this.listTileData.push("\t" + usaWidget + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " != null ? DateFormat('dd/MM/yyyy').format(" + usaWidget + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + ") : '', '" + this.objetoJsonComentario.labelText + "'),");
        } else if (this.campoModel.Type.includes('int')) {
            this.listTileData.push("\t" + usaWidget + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + "?.toString() ?? '', '" + this.objetoJsonComentario.labelText + "'),");
        } else {
            this.listTileData.push("\t" + usaWidget + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " ?? '', '" + this.objetoJsonComentario.labelText + "'),");
        }

    }

    trocarAtributoPorLookup() {
        if (this.objetoJsonComentario.campoLookupComTabela != null && this.objetoJsonComentario.campoLookupComTabela != '') {
            this.campoModel.nomeCampoAtributo = this.objetoJsonComentario.campoLookupComTabela;
        }
    }

    arrumarImports() {
        if (this.importConstantes) {
            this.imports.push("import 'package:fenix/src/infra/constantes.dart';")
        }
        if (this.importData) {
            this.imports.push("import 'package:intl/intl.dart';")
        }
    }
}