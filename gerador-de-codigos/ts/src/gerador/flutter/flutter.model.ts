import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';

/// classe base que ajuda a gerar o model do Flutter usando o mustache
export class FlutterModel {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    objetoPrincipal: string; // armazena o nome do objeto principal, que costuma ser o nome da classe com a primeira letra em minúsculo

    listaDeCampos = []; // armazena a lista de campos separado por vírgulas - ex: ['ID', 'TIPO', 'NUMERO']
    listaDeColunas = []; // armazena a lista de colunas separado por vírgulas - ex: ['Id', 'Tipo', 'Número'];
    atribut = []; // armazena os Atributos da classe
    atributObj = []; // armazena os objetos - relacionamentos OneToOne
    atributList = []; // armazena as listas - relacionamentos OneToMany
    atributConstrutor = []; // armazena os Atributos da classe para o construtor
    atributObjConstrutor = []; // armazena os objetos - relacionamentos OneToOne para o construtor
    atributListConstrutor = []; // armazena as listas - relacionamentos OneToMany para o construtor
    atributFromJson = []; // armazena os Atributos da classe para o método FromJson
    atributObjFromJson = []; // armazena os objetos - relacionamentos OneToOne para o método FromJson
    atributListFromJson = []; // armazena as listas - relacionamentos OneToMany para o método FromJson
    atributToJson = []; // armazena os Atributos da classe para o método ToJson
    atributObjToJson = []; // armazena os objetos - relacionamentos OneToOne para o método ToJson
    atributListToJson = []; // armazena as listas - relacionamentos OneToMany para o método ToJson
    gettersSetters = []; // armazena os Getters e os Setters
    imports = []; // armazena os demais imports para a classe

    objetoJsonComentario: ComentarioDerJsonModel;
    relacionamentosDetalhe: ComentarioDerJsonModel[]; // armazena relacionamentos de uma tabela Detalhe que serão encontrado aqui no Model

    importDate: boolean; // controla os imports para datas
    importBiblioteca: boolean; // controla os imports para a biblioteca de funcoes
    temMascara: boolean; // controla se precisa inserir a chamada ao método que remove a mascara
    importModels: boolean; // controla se precisa importar outros models

    constructor(tabela: string, dataPacket: CamposModel[], relacionamentos: ComentarioDerJsonModel[]) {
        // imports diversos
        this.importDate = false;
        this.importBiblioteca = false;
        this.importModels = false;

        // nome da classe
        this.class = lodash.camelCase(tabela);
        this.objetoPrincipal = this.class;
        this.class = lodash.upperFirst(this.class);

        // nome da tabela
        this.table = tabela.toUpperCase();

        // atributos
        for (let i = 0; i < dataPacket.length; i++) {
            // sempre que iterar no laço, seta esse controle para false até que se encontre uma máscara
            this.temMascara = false;

            // define o nome do campo
            let nomeCampo = dataPacket[i].Field;

            let nomeCampoTabela = nomeCampo.toUpperCase();          
            let nomeCampoAtributo = lodash.camelCase(nomeCampo);    
            let nomeCampoGetSet = lodash.upperFirst(nomeCampoAtributo);  

            // pega o objeto JSON de comentário
            if (dataPacket[i].Comment != '') {
                try {
                    this.objetoJsonComentario = new ComentarioDerJsonModel(this.table, dataPacket[i].Comment);
                } catch (erro) {
                    this.objetoJsonComentario = null;
                }
            }

            // lista de campos e colunas
            if (!nomeCampoTabela.includes('ID_')) {
                // campos
                this.listaDeCampos.push("'" + nomeCampoTabela + "', ");

                // colunas
                if (nomeCampoTabela == 'ID') {
                    this.listaDeColunas.push("'Id', ");
                } else {
                    if (this.objetoJsonComentario != null) {
                        this.listaDeColunas.push("'" + this.objetoJsonComentario.labelText + "', ");
                    } else { // para views teremos que tentar montar o nome do campo da melhor forma possível
                        this.listaDeColunas.push("'" + lodash.startCase(lodash.camelCase(nomeCampoTabela)) + "', ");
                    }
                }
            }

            // encontra os relacionamentos nas tabelas com chave estrangeira (PK)
            if (nomeCampoTabela.includes('ID_') && dataPacket[i].Comment != '') {
                let objeto = new ComentarioDerJsonModel('', dataPacket[i].Comment);
                objeto.tabela = lodash.replace(nomeCampoTabela, 'ID_', '');
                if (this.relacionamentosDetalhe == null) {
                    this.relacionamentosDetalhe = new Array;
                }
                this.relacionamentosDetalhe.push(objeto);
            }

            // pega o tipo de dado
            let tipoDado = this.getTipo(dataPacket[i].Type);

            // define o atributo
            let atributo = '';
            atributo = tipoDado + ' ' + nomeCampoAtributo + ';';
            this.atribut.push(atributo);

            // configurações vindas no comentário do campo para montar atributos, gets, sets etc
            let atributoGet = '';
            let atributoSet = '';
            let atributoConstrutor = '';
            if (this.objetoJsonComentario != null) {
                let tipoControle = this.objetoJsonComentario.tipoControle;
                if (tipoControle != null) {
                    if (tipoControle.tipo == 'dropDownButton') {
                        if (tipoControle.persiste != 'valor') { // se for para persistir o valor, não precisamos de get e set - Ex: UF em PESSOA_ENDERECO
                            // atributo get
                            atributoGet = nomeCampoAtributo + " = get" + nomeCampoGetSet + "(jsonDados['" + nomeCampoAtributo + "'])";
                            // método get
                            this.gettersSetters.push("get" + nomeCampoGetSet + "(String " + nomeCampoAtributo + ") {");
                            this.gettersSetters.push("\tswitch (" + nomeCampoAtributo + ") {");
                            for (let i = 0; i < tipoControle.itens.length; i++) {
                                let criterio = tipoControle.persiste == 'char' ? tipoControle.itens[i].dropDownButtonItem.substring(0, 1) : i.toString();
                                this.gettersSetters.push("\t\tcase '" + criterio + "':");
                                this.gettersSetters.push("\t\t\treturn '" + tipoControle.itens[i].dropDownButtonItem + "';");
                                this.gettersSetters.push("\t\t\tbreak;");
                            }
                            this.gettersSetters.push("\t\tdefault:");
                            this.gettersSetters.push("\t\t\treturn null;");
                            this.gettersSetters.push("\t\t}");
                            this.gettersSetters.push("\t}\n");

                            // atributo set
                            atributoSet = "jsonDados['" + nomeCampoAtributo + "']" + " = set" + nomeCampoGetSet + "(this." + nomeCampoAtributo + ")";
                            // método set
                            this.gettersSetters.push("set" + nomeCampoGetSet + "(String " + nomeCampoAtributo + ") {");
                            this.gettersSetters.push("\tswitch (" + nomeCampoAtributo + ") {");
                            for (let i = 0; i < tipoControle.itens.length; i++) {
                                let criterio = tipoControle.persiste == 'char' ? tipoControle.itens[i].dropDownButtonItem.substring(0, 1) : i.toString();
                                this.gettersSetters.push("\t\tcase '" + tipoControle.itens[i].dropDownButtonItem + "':");
                                this.gettersSetters.push("\t\t\treturn '" + criterio + "';");
                                this.gettersSetters.push("\t\t\tbreak;");
                            }
                            this.gettersSetters.push("\t\tdefault:");
                            this.gettersSetters.push("\t\t\treturn null;");
                            this.gettersSetters.push("\t\t}");
                            this.gettersSetters.push("\t}\n");
                        } else {
                            // atributo get - apenas para casos em que temos uma lista fixa na aplicação - Ex: UF em PESSOA_ENDERECO
                            atributoGet = nomeCampoAtributo + " = jsonDados['" + nomeCampoAtributo + "'] == '' ? null : jsonDados['" + nomeCampoAtributo + "']";
                        }

                        // atributo construtor
                        if (tipoControle.valorPadrao != null && tipoControle.valorPadrao != '') {
                            atributoConstrutor = "this." + nomeCampoAtributo + " = '" + tipoControle.valorPadrao + "',";
                        }

                    } else if (tipoControle.tipo == 'textFormField' && tipoDado != 'double') {
                        if (tipoControle.mascara != '' && tipoControle.mascara != null) {
                            this.temMascara = true;
                            this.importBiblioteca = true;
                        }
                    }
                }
            }

            // define o atributo para o construtor
            if (atributoConstrutor != '') {
                atributo = atributoConstrutor;
            } else {
                atributo = 'this.' + nomeCampoAtributo + ',';
            }
            this.atributConstrutor.push(atributo);

            // define o FromJson - atributos normais
            if (atributoGet != '') {
                atributo = atributoGet;
            } else {
                atributo = nomeCampoAtributo + " = jsonDados['" + nomeCampoAtributo + "']";
            }
            
            if (tipoDado == 'DateTime') {
                atributo = atributo + " != null ? DateTime.tryParse(jsonDados['" + nomeCampoAtributo + "']) : null;";
            } else if (tipoDado == 'double') {
                atributo = atributo + " != null ? jsonDados['" + nomeCampoAtributo + "'].toDouble() : null;";
            } else {
                atributo = atributo + ';';
            }
            
            this.atributFromJson.push(atributo);

            // define o ToJson - atributos normais
            if (this.temMascara) {
                atributo = "jsonDados['" + nomeCampoAtributo + "']" + " = Biblioteca.removerMascara(this." + nomeCampoAtributo + ");";
            } else {
                if (atributoSet != '') {
                    atributo = atributoSet;
                } else {
                    atributo = "jsonDados['" + nomeCampoAtributo + "']" + " = this." + nomeCampoAtributo;
                }
                if (tipoDado == 'int') {
                    atributo = atributo + ' ?? 0;';
                } else if (tipoDado == 'DateTime') {
                    atributo = atributo + " != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this." + nomeCampoAtributo + ") : null;";
                } else {
                    atributo = atributo + ';';
                }
            }
            this.atributToJson.push(atributo);
        }

        // relacionamentos agregados ao Mestre
        if (relacionamentos != null) {
            this.tratarRelacionamentos(relacionamentos);
        }

        // relacionamentos agregados ao Detalhe
        if (this.relacionamentosDetalhe != null) {
            this.tratarRelacionamentos(this.relacionamentosDetalhe);
        }

        // imports
        if (this.importDate) {
            this.imports.push("import 'package:intl/intl.dart';")
        }
        if (this.importBiblioteca) {
            this.imports.push("import 'package:fenix/src/infra/biblioteca.dart';")
        }
        if (this.importModels) {
            this.imports.push("import 'package:fenix/src/model/model.dart';")
        }

    }

    tratarRelacionamentos(relacionamentos: ComentarioDerJsonModel[]) {
        for (let i = 0; i < relacionamentos.length; i++) {
            let relacionamento = relacionamentos[i];

            let nomeTabelaRelacionamento = relacionamento.tabela;
            let nomeCampoAtributo = lodash.camelCase(nomeTabelaRelacionamento);
            let nomeCampoGetSet = lodash.upperFirst(nomeCampoAtributo);

            // verifica a cardinalidade para definir o código
            if (relacionamento.cardinalidade == '@OneToOne') {
                // só vai inserir esses objetos em classes mestre (PESSOA) ou em classes de detalhe que precisem de um objeto mestre (BANCO_AGENCIA)
                if (relacionamento.classeMestre != '' || relacionamento.side == 'Local') {
                    // import
                    this.importModels = true;
                    // atributo
                    this.atributObj.push(nomeCampoGetSet + ' ' + nomeCampoAtributo + ';');
                    this.atributObjConstrutor.push('this.' + nomeCampoAtributo + ',');
                    this.atributObjFromJson.push(nomeCampoAtributo + " = jsonDados['" + nomeCampoAtributo + "'] == null ? null : new " + nomeCampoGetSet + ".fromJson(jsonDados['" + nomeCampoAtributo + "']);");
                    this.atributObjToJson.push("jsonDados['" + nomeCampoAtributo + "'] = this." + nomeCampoAtributo + " == null ? null : this." + nomeCampoAtributo + ".toJson;");
                }
            } else if (relacionamento.cardinalidade == '@OneToMany') {
                // define o atributo - lista
                if (relacionamento.classeMestre != "") {//classe detalhe e inverse não precisa de um objeto da classe mestre - ex: pessoa_fisica, pessoa_contato
                    // import
                    this.importModels = true;
                    // atributo
                    this.atributList.push('List<' + nomeCampoGetSet + '>' + ' lista' + nomeCampoGetSet + ' = [];');
                    this.atributListConstrutor.push('this.lista' + nomeCampoGetSet + ',');
                    this.atributListFromJson.push("lista" + nomeCampoGetSet + " = (jsonDados['lista" + nomeCampoGetSet + "'] as Iterable)?.map((m) => " + nomeCampoGetSet + ".fromJson(m))?.toList() ?? [];");

                    this.atributListToJson.push("\n");
                    this.atributListToJson.push("var lista" + nomeCampoGetSet + "Local = [];");
                    this.atributListToJson.push("for (" + nomeCampoGetSet + " objeto in this.lista" + nomeCampoGetSet + " ?? []) {");
                    this.atributListToJson.push("\tlista" + nomeCampoGetSet + "Local.add(objeto.toJson);");
                    this.atributListToJson.push("}");
                    this.atributListToJson.push("jsonDados['lista" + nomeCampoGetSet + "'] = lista" + nomeCampoGetSet + "Local;");
                }
            }
        }
    }

    // define o tipo de dado
    getTipo(pType: any): string {
        if (pType.includes('int')) {
            return 'int';
        } else if (pType.includes('varchar')) {
            return 'String';
        } else if (pType.includes('decimal')) {
            return 'double';
        } else if (pType.includes('char')) {
            return 'String';
        } else if (pType.includes('text')) {
            return 'String';
        } else if (pType.includes('date')) {
            this.importDate = true;
            return 'DateTime';
        }
    }

}