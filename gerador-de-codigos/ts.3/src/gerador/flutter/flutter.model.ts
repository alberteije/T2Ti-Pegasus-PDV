import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { Biblioteca } from "../../util/biblioteca";

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

    campoModel: CamposModel;
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

            // pega o campo
            this.campoModel = dataPacket[i];

            // define os dados do campo
            this.campoModel.nomeCampo = this.campoModel.Field;
            this.campoModel.nomeCampoTabela = this.campoModel.nomeCampo.toUpperCase();
            this.campoModel.nomeCampoAtributo = lodash.camelCase(this.campoModel.nomeCampo);
            this.campoModel.nomeCampoGetSet = lodash.upperFirst(this.campoModel.nomeCampoAtributo);  

            // pega o objeto JSON de comentário
            if (this.campoModel.Comment != '') {
                if (Biblioteca.isJsonString(tabela, this.campoModel.Comment)) {
                    try {
                        this.objetoJsonComentario = new ComentarioDerJsonModel(this.table, this.campoModel.Comment);
                    } catch (erro) {
                        this.objetoJsonComentario = null;
                    }
                }
            }

            // lista de campos e colunas
            if (!this.campoModel.nomeCampoTabela.includes('ID_')) {
                // campos
                this.listaDeCampos.push("'" + this.campoModel.nomeCampoTabela + "', ");

                // colunas
                if (this.campoModel.nomeCampoTabela == 'ID') {
                    this.listaDeColunas.push("'Id', ");
                } else {
                    if (this.objetoJsonComentario != null) {
                        this.listaDeColunas.push("'" + this.objetoJsonComentario.labelText + "', ");
                    } else { // para views teremos que tentar montar o nome do campo da melhor forma possível
                        this.listaDeColunas.push("'" + lodash.startCase(lodash.camelCase(this.campoModel.nomeCampoTabela)) + "', ");
                    }
                }
            }

            // encontra os relacionamentos nas tabelas com chave estrangeira (PK)
            if (this.campoModel.nomeCampoTabela.includes('ID_') && this.campoModel.Comment != '') {
                if (Biblioteca.isJsonString(tabela, this.campoModel.Comment)) {
                    let objeto = new ComentarioDerJsonModel('', this.campoModel.Comment);
                    objeto.tabela = lodash.replace(this.campoModel.nomeCampoTabela, 'ID_', '');
                    if (this.relacionamentosDetalhe == null) {
                        this.relacionamentosDetalhe = new Array;
                    }
                    this.relacionamentosDetalhe.push(objeto);
                }
            }

            // pega o tipo de dado
            this.campoModel.tipoCampo = this.getTipo(this.campoModel.Type);

            // define o atributo
            let atributo = '';
            atributo = this.campoModel.tipoCampo + ' ' + this.campoModel.nomeCampoAtributo + ';';
            this.atribut.push(atributo);

            // configurações vindas no comentário do campo para montar atributos, gets, sets etc
            let atributoGet = '';
            let atributoSet = '';
            let atributoConstrutor = '';
            if (this.objetoJsonComentario != null) {
                if (this.objetoJsonComentario.tipoControle != null) {
                    if (this.objetoJsonComentario.tipoControle.tipo == 'dropDownButton') {
                        if (this.objetoJsonComentario.tipoControle.persiste != 'valor') { // se for para persistir o valor, não precisamos de get e set - Ex: UF em PESSOA_ENDERECO
                            // atributo get
                            atributoGet = this.campoModel.nomeCampoAtributo + " = get" + this.campoModel.nomeCampoGetSet + "(jsonDados['" + this.campoModel.nomeCampoAtributo + "'])";
                            // método get
                            this.gettersSetters.push("get" + this.campoModel.nomeCampoGetSet + "(String " + this.campoModel.nomeCampoAtributo + ") {");
                            this.gettersSetters.push("\tswitch (" + this.campoModel.nomeCampoAtributo + ") {");
                            for (let i = 0; i < this.objetoJsonComentario.tipoControle.itens.length; i++) {
                                let criterio = this.objetoJsonComentario.tipoControle.persiste == 'char' ? this.objetoJsonComentario.tipoControle.itens[i].dropDownButtonItem.substring(0, 1) : i.toString();
                                this.gettersSetters.push("\t\tcase '" + criterio + "':");
                                this.gettersSetters.push("\t\t\treturn '" + this.objetoJsonComentario.tipoControle.itens[i].dropDownButtonItem + "';");
                                this.gettersSetters.push("\t\t\tbreak;");
                            }
                            this.gettersSetters.push("\t\tdefault:");
                            this.gettersSetters.push("\t\t\treturn null;");
                            this.gettersSetters.push("\t\t}");
                            this.gettersSetters.push("\t}\n");

                            // atributo set
                            atributoSet = "jsonDados['" + this.campoModel.nomeCampoAtributo + "']" + " = set" + this.campoModel.nomeCampoGetSet + "(this." + this.campoModel.nomeCampoAtributo + ")";
                            // método set
                            this.gettersSetters.push("set" + this.campoModel.nomeCampoGetSet + "(String " + this.campoModel.nomeCampoAtributo + ") {");
                            this.gettersSetters.push("\tswitch (" + this.campoModel.nomeCampoAtributo + ") {");
                            for (let i = 0; i < this.objetoJsonComentario.tipoControle.itens.length; i++) {
                                let criterio = this.objetoJsonComentario.tipoControle.persiste == 'char' ? this.objetoJsonComentario.tipoControle.itens[i].dropDownButtonItem.substring(0, 1) : i.toString();
                                this.gettersSetters.push("\t\tcase '" + this.objetoJsonComentario.tipoControle.itens[i].dropDownButtonItem + "':");
                                this.gettersSetters.push("\t\t\treturn '" + criterio + "';");
                                this.gettersSetters.push("\t\t\tbreak;");
                            }
                            this.gettersSetters.push("\t\tdefault:");
                            this.gettersSetters.push("\t\t\treturn null;");
                            this.gettersSetters.push("\t\t}");
                            this.gettersSetters.push("\t}\n");
                        } else {
                            // atributo get - apenas para casos em que temos uma lista fixa na aplicação - Ex: UF em PESSOA_ENDERECO
                            atributoGet = this.campoModel.nomeCampoAtributo + " = jsonDados['" + this.campoModel.nomeCampoAtributo + "'] == '' ? null : jsonDados['" + this.campoModel.nomeCampoAtributo + "']";
                        }

                        // atributo construtor
                        if (this.objetoJsonComentario.tipoControle.valorPadrao != null && this.objetoJsonComentario.tipoControle.valorPadrao != '') {
                            atributoConstrutor = "this." + this.campoModel.nomeCampoAtributo + " = '" + this.objetoJsonComentario.tipoControle.valorPadrao + "',";
                        }

                    } else if (this.objetoJsonComentario.tipoControle.tipo == 'textFormField' && this.campoModel.tipoCampo != 'double') {
                        if (this.objetoJsonComentario.tipoControle.mascara != '' && this.objetoJsonComentario.tipoControle.mascara != null) {
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
                atributo = 'this.' + this.campoModel.nomeCampoAtributo;
                if (this.campoModel.tipoCampo == 'double') {
                    atributo = atributo + ' = 0.0';
                }
                atributo = atributo + ','
            }
            this.atributConstrutor.push(atributo);

            // define o FromJson - atributos normais
            if (atributoGet != '') {
                atributo = atributoGet;
            } else {
                atributo = this.campoModel.nomeCampoAtributo + " = jsonDados['" + this.campoModel.nomeCampoAtributo + "']";
            }
            
            if (this.campoModel.tipoCampo == 'DateTime') {
                atributo = atributo + " != null ? DateTime.tryParse(jsonDados['" + this.campoModel.nomeCampoAtributo + "']) : null;";
            } else if (this.campoModel.tipoCampo == 'double') {
                atributo = atributo + " != null ? jsonDados['" + this.campoModel.nomeCampoAtributo + "'].toDouble() : null;";
            } else {
                atributo = atributo + ';';
            }
            
            this.atributFromJson.push(atributo);

            // define o ToJson - atributos normais
            if (this.temMascara) {
                atributo = "jsonDados['" + this.campoModel.nomeCampoAtributo + "']" + " = Biblioteca.removerMascara(this." + this.campoModel.nomeCampoAtributo + ");";
            } else {
                if (atributoSet != '') {
                    atributo = atributoSet;
                } else {
                    atributo = "jsonDados['" + this.campoModel.nomeCampoAtributo + "']" + " = this." + this.campoModel.nomeCampoAtributo;
                }
                if (this.campoModel.tipoCampo == 'int') {
                    atributo = atributo + ' ?? 0;';
                } else if (this.campoModel.tipoCampo == 'DateTime') {
                    atributo = atributo + " != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this." + this.campoModel.nomeCampoAtributo + ") : null;";
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
            this.campoModel.nomeCampoAtributo = lodash.camelCase(nomeTabelaRelacionamento);
            this.campoModel.nomeCampoGetSet = lodash.upperFirst(this.campoModel.nomeCampoAtributo);

            // verifica a cardinalidade para definir o código
            if (relacionamento.cardinalidade == '@OneToOne') {
                // só vai inserir esses objetos em classes mestre (PESSOA) ou em classes de detalhe que precisem de um objeto mestre (BANCO_AGENCIA)
                if (relacionamento.classeMestre != '' || relacionamento.side == 'Local') {
                    // import
                    this.importModels = true;
                    // atributo
                    this.atributObj.push(this.campoModel.nomeCampoGetSet + ' ' + this.campoModel.nomeCampoAtributo + ';');
                    this.atributObjConstrutor.push('this.' + this.campoModel.nomeCampoAtributo + ',');
                    //this.atributObjFromJson.push(this.campoModel.nomeCampoAtributo + " = jsonDados['" + this.campoModel.nomeCampoAtributo + "'] == null ? null : new " + this.campoModel.nomeCampoGetSet + ".fromJson(jsonDados['" + this.campoModel.nomeCampoAtributo + "']);");
                    this.atributObjFromJson.push(this.campoModel.nomeCampoAtributo + " = jsonDados['" + this.campoModel.nomeCampoAtributo + "'] == null ? null : " + this.campoModel.nomeCampoGetSet + ".fromJson(jsonDados['" + this.campoModel.nomeCampoAtributo + "']);");
                    this.atributObjToJson.push("jsonDados['" + this.campoModel.nomeCampoAtributo + "'] = this." + this.campoModel.nomeCampoAtributo + " == null ? null : this." + this.campoModel.nomeCampoAtributo + ".toJson;");
                }
            } else if (relacionamento.cardinalidade == '@OneToMany') {
                // define o atributo - lista
                if (relacionamento.classeMestre != "") {//classe detalhe e inverse não precisa de um objeto da classe mestre - ex: pessoa_fisica, pessoa_contato
                    // import
                    this.importModels = true;
                    // atributo
                    this.atributList.push('List<' + this.campoModel.nomeCampoGetSet + '>' + ' lista' + this.campoModel.nomeCampoGetSet + ' = [];');
                    this.atributListConstrutor.push('this.lista' + this.campoModel.nomeCampoGetSet + ',');
                    this.atributListFromJson.push("lista" + this.campoModel.nomeCampoGetSet + " = (jsonDados['lista" + this.campoModel.nomeCampoGetSet + "'] as Iterable)?.map((m) => " + this.campoModel.nomeCampoGetSet + ".fromJson(m))?.toList() ?? [];");

                    this.atributListToJson.push("\n");
                    this.atributListToJson.push("var lista" + this.campoModel.nomeCampoGetSet + "Local = [];");
                    this.atributListToJson.push("for (" + this.campoModel.nomeCampoGetSet + " objeto in this.lista" + this.campoModel.nomeCampoGetSet + " ?? []) {");
                    this.atributListToJson.push("\tlista" + this.campoModel.nomeCampoGetSet + "Local.add(objeto.toJson);");
                    this.atributListToJson.push("}");
                    this.atributListToJson.push("jsonDados['lista" + this.campoModel.nomeCampoGetSet + "'] = lista" + this.campoModel.nomeCampoGetSet + "Local;");
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
        } else if (pType.includes('timestamp')) {
            this.importDate = true;
            return 'DateTime';
        }
    }

}