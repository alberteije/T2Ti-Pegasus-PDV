import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { Biblioteca } from "../../util/biblioteca";

/// classe base que ajuda a gerar a ListaPage do Flutter usando o mustache
export class FlutterListaPageBase {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    objetoPrincipal: string; // armazena o nome do objeto principal, que costuma ser o nome da classe com a primeira letra em minúsculo
    tituloJanela: string; // armazena o título da janela
    nomeArquivo: string; // armazena o nome do aruqivo que aparece no import
    objetoMestre: string; // armazena o nome do objeto mestre - ex: PessoaEndereco fará referência ao objeto mestre 'pessoa'
    classeMestre: string; // armazena o nome da classe mestre - ex: PessoaEndereco fará referência à classe mestre 'Pessoa'

    dataColumn = []; // armazena a lista de dataColumn
    dataCell = []; // armazena a lista de dataCell
    imports = []; // armazena os demais imports para a classe

    campoModel: CamposModel;
    objetoJsonComentario: ComentarioDerJsonModel;

    importConstantes: boolean; // controla os imports para as constantes
    importData: boolean; // controla o import para o intl para formatar datas

    constructor(tabela: string, tabelaMestre?: string) {
        // imports diversos
        this.importConstantes = false;
        this.importData = false;

        // nome da classe
        this.class = lodash.camelCase(tabela);
        this.objetoPrincipal = this.class;
        this.class = lodash.upperFirst(this.class);

        // objeto e classe mestre
        this.objetoMestre = lodash.camelCase(tabelaMestre);
        this.classeMestre = lodash.upperFirst(this.objetoMestre);

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
            if (this.campoModel.Comment != '') {
                if (Biblioteca.isJsonString(this.table, this.campoModel.Comment)) {
                    try {
                        this.objetoJsonComentario = new ComentarioDerJsonModel(this.table, this.campoModel.Comment);

                        // se o objeto não contém o campo desenhaControle, o controle será desenhado mesmo assim, pois o padrão é 'true'
                        // se o objeto contém o campo desenhaControle e estiver marcado como true, desenha o widget
                        if (this.objetoJsonComentario.desenhaControle == null || this.objetoJsonComentario.desenhaControle == true) {
                            // define o campo de lookup
                            if (this.campoModel.nomeCampoTabela.includes('ID_')) {
                                if (this.objetoJsonComentario.campoLookup != null && this.objetoJsonComentario.campoLookup != '') {
                                    this.definirDadosDeLookup();
                                }
                            }

                            // pega o tipo de dado
                            this.definirTipoDado();

                            // se o campoLookup for diferente de vazio, ele deve ser utilizado no lugar do campoAtributo
                            this.trocarAtributoPorLookup();

                            // DataColumn
                            this.definirDataColumn(false);

                            // DataCell
                            this.definirDataCell(false, false);
                        }
                    } catch (erro) {
                        this.objetoJsonComentario = null;
                    }
                }
            } else { // caso esteja gerando a tela a partir de uma view - a princípcio só precisa desse código na lista-page principal
                // pega o tipo de dado
                this.definirTipoDado();

                // DataColumn
                this.definirDataColumn(true);

                // DataCell
                this.definirDataCell(true, false);
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

    definirTipoDado() {
        this.campoModel.tipoCampo = this.campoModel.Type;
        this.campoModel.tipoDadoOrdenacao = this.getTipoDadoOrdenacao(this.campoModel.tipoCampo);
    }

    trocarAtributoPorLookup() {
        if (this.objetoJsonComentario.campoLookupComTabela != null && this.objetoJsonComentario.campoLookupComTabela != '') {
            this.campoModel.nomeCampoAtributo = this.objetoJsonComentario.campoLookupComTabela;
            if (this.objetoJsonComentario.campoLookupTipoDado == null || this.objetoJsonComentario.campoLookupTipoDado == '') {
                this.campoModel.tipoDadoOrdenacao = "String";
            } else {
                this.campoModel.tipoDadoOrdenacao = this.getTipoDadoOrdenacao(this.objetoJsonComentario.campoLookupTipoDado);
            }
        }
    }

    definirDataColumn(viewDB: boolean) {
        this.dataColumn.push("DataColumn(");
        if (this.campoModel.tipoDadoOrdenacao == 'num') {
            this.dataColumn.push("\tnumeric: true,");
        }
        if (viewDB) {
            // nome do campo tratado para mostrar para o usuário
            let nomeDoCampoTratado = lodash.startCase(lodash.camelCase(this.campoModel.nomeCampoTabela));
            this.dataColumn.push("\tlabel: const Text('" + nomeDoCampoTratado + "'),");
            this.dataColumn.push("\ttooltip: '" + nomeDoCampoTratado + "',");
        } else {
            this.dataColumn.push("\tlabel: const Text('" + this.objetoJsonComentario.label + "'),");
            this.dataColumn.push("\ttooltip: '" + this.objetoJsonComentario.tooltip + "',");    
        }
        this.dataColumn.push("\tonSort: (int columnIndex, bool ascending) =>");
        this.dataColumn.push("\t\t_sort<" + this.campoModel.tipoDadoOrdenacao + ">((" + this.class + " " + this.objetoPrincipal + ") => " + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + ",");
        this.dataColumn.push("\t\tcolumnIndex, ascending),");
        this.dataColumn.push("),");

    }

    definirDataCell(viewDB: boolean, abaDetalhe: boolean) {
        if (this.campoModel.tipoDadoOrdenacao == 'num' && !this.campoModel.tipoCampo.includes("int")) {
            let formatoDecimais = "";
            let casasDecimais = "";
            if (viewDB) {
                formatoDecimais = lodash.camelCase("formatoDecimalValor"); 
                casasDecimais = lodash.camelCase("decimaisValor");            
            } else {
                formatoDecimais = lodash.camelCase("formatoDecimal" + this.objetoJsonComentario.tipoControle.mascara); 
                casasDecimais = lodash.camelCase("decimais" + this.objetoJsonComentario.tipoControle.mascara);    
            }
            this.dataCell.push("DataCell(Text('${" + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " != null ? Constantes." + formatoDecimais + ".format(" + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + ") : 0.toStringAsFixed(Constantes." + casasDecimais + ")}'), onTap: () {");
        } else if (this.campoModel.tipoDadoOrdenacao == 'DateTime') {
            this.importData = true;
            this.dataCell.push("DataCell(Text('${" + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " != null ? DateFormat('dd/MM/yyyy').format(" + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + ") : ''}'), onTap: () {");
        } else {
            this.dataCell.push("DataCell(Text('${" + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " ?? ''}'), onTap: () {");
        }
        if (abaDetalhe) {
            this.dataCell.push("\tdetalhar" + this.class + "(widget." + this.objetoMestre + ", " + this.objetoPrincipal + ", context);");
        } else {
            this.dataCell.push("\tdetalhar" + this.class + "(" + this.objetoPrincipal + ", context);");
        }
        this.dataCell.push("}),");
    }

    arrumarImports() {
        if (this.importConstantes) {
            this.imports.push("import 'package:fenix/src/infra/constantes.dart';")
        }
        if (this.importData) {
            this.imports.push("import 'package:intl/intl.dart';")
        }
    }

    // define o tipo de dado para ordenação
    getTipoDadoOrdenacao(pType: any): string {
        if (pType.includes('int')) {
            return 'num';
        } else if (pType.includes('varchar')) {
            return 'String';
        } else if (pType.includes('decimal')) {
            this.importConstantes = true;
            return 'num';
        } else if (pType.includes('char')) {
            return 'String';
        } else if (pType.includes('text')) {
            return 'String';
        } else if (pType.includes('date')) {
            return 'DateTime';
        } else if (pType.includes('timestamp')) {
            return 'DateTime';
        }
    }

}