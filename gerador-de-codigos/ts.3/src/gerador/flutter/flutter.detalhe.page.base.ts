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

    matrizBootstrap = []; // organiza as linhas e colunas do bootstrap para conseguirmos desenhar os controles na tela

    campoModel: CamposModel;
    objetoJsonComentario: ComentarioDerJsonModel;

    importData: boolean; // controla o import para o intl para formatar datas

    colunaBootstrapPossuiMaisDeUmSize: boolean; // utilizado para controlar a inserção do padding na coluna e a identação de algumas linhas

    constructor(tabela: string) {
        // imports diversos
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

        // começa colocando o ID na matriz apenas para que o laço que testa se a linha anterior é direrente da atual funcione
        this.matrizBootstrap.push({
            campo: 'ID', 
            linha: 0, 
            coluna: 0, 
            juncao: 0,
        });

        // laço inicial para montar a matriz bootstrap
        for (let i = 0; i < dataPacket.length; i++) {
            this.definirDadosIniciais(dataPacket[i]);
            if (Biblioteca.isJsonString(this.table, this.campoModel.Comment)) {
                try {
                    this.objetoJsonComentario = new ComentarioDerJsonModel(this.table, dataPacket[i].Comment);
                    this.matrizBootstrap.push({
                        campo: this.campoModel.nomeCampoTabela, 
                        linha: this.objetoJsonComentario.linhaBootstrap, 
                        coluna: this.objetoJsonComentario.colunaBootstrap, 
                        juncao: this.objetoJsonComentario.linhaBootstrap?.toString() + this.objetoJsonComentario.colunaBootstrap?.toString(),
                    });
                } catch (erro) {
                    this.objetoJsonComentario = null;
                }
            }
        }
        // ordena a matriz de acordo com o campo juncao para que as linhas e colunas fiquem agrupadas
        this.matrizBootstrap.sort(this.compararItensMatriz);

        // monta a tela de acordo com a matriz
        for (var i = 0; i < this.matrizBootstrap.length; i++) {
            if (i>0) {
                // pega o campo do datapacket de acordo com o campo da matriz que já está devidamente ordenado
                const colunaBancoDados = dataPacket.find(campo => campo.Field === this.matrizBootstrap[i].campo);

                this.definirDadosIniciais(colunaBancoDados);
                if (Biblioteca.isJsonString(this.table, this.campoModel.Comment)) {
                    try {
                        this.objetoJsonComentario = new ComentarioDerJsonModel(this.table, colunaBancoDados.Comment);

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

                            // se a linha atual é diferente da linha anterior, deve-se abrir uma nova linha no bootstrap
                            if (this.matrizBootstrap[i].linha != this.matrizBootstrap[i-1].linha) {
                                // abrir linha bootstrap 
                                this.abrirLinhaBootstrap(this.matrizBootstrap[i].linha);
                            }

                            // abrir coluna bootstrap 
                            this.abrirColunaBootstrap();

                            // listTileData
                            this.definirListTileData(true);

                            // fechar coluna bootstrap 
                            this.fecharColunaBootstrap();
                        }
                    } catch (erro) {
                        this.objetoJsonComentario = null;
                    }
                }
            }
        }          

        // fecha a última linha
        this.fecharLinhaBootstrap();

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

    abrirLinhaBootstrap(linha: number) {
        // se não for a primeira linha já fecha a linha antes de iniciar uma nova linha
        if (linha > 1) {
            this.fecharLinhaBootstrap();
        }
        this.listTileData.push("SizedBox(height: 8),");
        this.listTileData.push("BootstrapRow(");
        this.listTileData.push("  height: 60,");
        this.listTileData.push("  children: <BootstrapCol>[");
    }

    fecharLinhaBootstrap() {
        this.listTileData.push("  ],");
        this.listTileData.push("),");
    }

    abrirColunaBootstrap() {
        this.listTileData.push("    BootstrapCol(");
        this.listTileData.push("      sizes: '" + this.objetoJsonComentario.sizesBootstrap + "',");

        // se houver mais do que um size, então tem que colocar o padding para controlar o espaço entre as colunas quando elas quebrarem de linha
        this.colunaBootstrapPossuiMaisDeUmSize = false;
        if (this.objetoJsonComentario.sizesBootstrap.includes(" ")) {
            this.listTileData.push("      child: Padding(");
            this.listTileData.push("        padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),");
            this.colunaBootstrapPossuiMaisDeUmSize = true;
        }
    }

    fecharColunaBootstrap() {
        if (this.colunaBootstrapPossuiMaisDeUmSize) {
            this.listTileData.push("      ),");
            this.listTileData.push("    ),");
        } else {
            this.listTileData.push("    ),");
        }
    }

    definirListTileData(objetoPrincipalNoWidget: boolean) {
        let usaWidget = "";
        if (objetoPrincipalNoWidget) {
            if (this.colunaBootstrapPossuiMaisDeUmSize) {
                usaWidget = "  widget.";
                this.listTileData.push("        child: getListTileDataDetalhePage(");
            } else {
                usaWidget = "widget.";
                this.listTileData.push("      child: getListTileDataDetalhePage(");
            }
        }

        if (this.campoModel.Type.includes('decimal')) {
            let formatoDecimais = lodash.camelCase("formatoDecimal" + this.objetoJsonComentario.tipoControle.mascara);
            let casasDecimais = lodash.camelCase("decimais" + this.objetoJsonComentario.tipoControle.mascara);
            this.listTileData.push("        " + usaWidget + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " != null ? Constantes." + formatoDecimais + ".format(" + usaWidget + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + ") : 0.toStringAsFixed(Constantes." + casasDecimais + "), '" + this.objetoJsonComentario.labelText + "'),");
        } else if (this.campoModel.Type.includes('date') || this.campoModel.Type.includes('timestamp')) {
            this.importData = true;
            this.listTileData.push("        " + usaWidget + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " != null ? DateFormat('dd/MM/yyyy').format(" + usaWidget + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + ") : '', '" + this.objetoJsonComentario.labelText + "'),");
        } else if (this.campoModel.Type.includes('int')) {
            this.listTileData.push("        " + usaWidget + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + "?.toString() ?? '', '" + this.objetoJsonComentario.labelText + "'),");
        } else {
            this.listTileData.push("        " + usaWidget + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " ?? '', '" + this.objetoJsonComentario.labelText + "'),");
        }
    }

    trocarAtributoPorLookup() {
        if (this.objetoJsonComentario.campoLookupComTabela != null && this.objetoJsonComentario.campoLookupComTabela != '') {
            this.campoModel.nomeCampoAtributo = this.objetoJsonComentario.campoLookupComTabela;
        }
    }

    arrumarImports() {
        if (this.importData) {
            this.imports.push("import 'package:intl/intl.dart';")
        }
    }

    compararItensMatriz(a: any, b: any) {
        if (a.juncao > b.juncao) {
          return 1;
        }
        if (a.juncao < b.juncao) {
          return -1;
        }
        // a = b
        return 0;
    }
      
}