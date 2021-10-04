import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';

/// classe base que ajuda a gerar a ListaPage do Flutter usando o mustache
export class FlutterAbaMestreListaPage {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    objetoPrincipal: string; // armazena o nome do objeto principal, que costuma ser o nome da classe com a primeira letra em minúsculo
    tituloJanela: string; // armazena o título da janela
    nomeArquivo: string; // armazena o nome do aruqivo que aparece no import

    dataColumn = []; // armazena a lista de dataColumn
    dataCell = []; // armazena a lista de dataCell
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

                    // pega o tipo de dado
                    let tipoDadoCampo = dataPacket[i].Type;
                    let tipoDadoOrdenacao = this.getTipo(tipoDadoCampo);

                    // se o campoLookup for diferente de vazio, ele deve ser utilizado no lugar do campoAtributo
                    if (campoLookup != '') {
                        nomeCampoAtributo = campoLookup;
                        if (this.objetoJsonComentario.campoLookupTipoDado == null || this.objetoJsonComentario.campoLookupTipoDado == '') {
                            tipoDadoOrdenacao = "String";
                        } else {
                            tipoDadoOrdenacao = this.getTipo(this.objetoJsonComentario.campoLookupTipoDado);
                        }
                    }

                    // DataColumn
                    this.dataColumn.push("DataColumn(");
                    if (tipoDadoOrdenacao == 'num') {
                        this.dataColumn.push("\tnumeric: true,");
                    }
                    this.dataColumn.push("\tlabel: const Text('" + this.objetoJsonComentario.label + "'),");
                    this.dataColumn.push("\ttooltip: '" + this.objetoJsonComentario.tooltip + "',");
                    this.dataColumn.push("\tonSort: (int columnIndex, bool ascending) =>");
                    this.dataColumn.push("\t\t_sort<" + tipoDadoOrdenacao + ">((" + this.class + " " + this.objetoPrincipal + ") => " + this.objetoPrincipal + "." + nomeCampoAtributo + ",");
                    this.dataColumn.push("\t\tcolumnIndex, ascending),");
                    this.dataColumn.push("),");

                    // DataCell
                    if (tipoDadoOrdenacao == 'num' && !tipoDadoCampo.includes("int")) {
                        let tipoControle = this.objetoJsonComentario.tipoControle;
                        let formatoDecimais = lodash.camelCase("formatoDecimal" + tipoControle.mascara);
                        let casasDecimais = lodash.camelCase("decimais" + tipoControle.mascara);
                        this.dataCell.push("DataCell(Text('${" + this.objetoPrincipal + "." + nomeCampoAtributo + " != null ? Constantes." + formatoDecimais + ".format(" + this.objetoPrincipal + "." + nomeCampoAtributo + ") : 0.toStringAsFixed(Constantes." + casasDecimais + ")}'), onTap: () {");
                    } else if (tipoDadoOrdenacao == 'DateTime') {
                        this.importData = true;
                        this.dataCell.push("DataCell(Text('${" + this.objetoPrincipal + "." + nomeCampoAtributo + " != null ? DateFormat('dd/MM/yyyy').format(" + this.objetoPrincipal + "." + nomeCampoAtributo + ") : ''}'), onTap: () {");
                } else {
                        this.dataCell.push("DataCell(Text('${" + this.objetoPrincipal + "." + nomeCampoAtributo + " ?? ''}'), onTap: () {");
                    }
                    this.dataCell.push("\tdetalhar" + this.class + "(" + this.objetoPrincipal + ", context);");
                    this.dataCell.push("}),");
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

    // define o tipo de dado para ordenação
    getTipo(pType: any): string {
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
        }
    }

}