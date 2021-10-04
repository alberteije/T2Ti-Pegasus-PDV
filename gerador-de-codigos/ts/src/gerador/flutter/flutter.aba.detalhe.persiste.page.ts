import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';

/// classe base que ajuda a gerar a PersistePage do Flutter usando o mustache
export class FlutterAbaDetalhePersistePage {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    objetoPrincipal: string; // armazena o nome do objeto principal, que costuma ser o nome da classe com a primeira letra em minúsculo
    objetoMestre: string; // armazena o nome do objeto mestre - ex: PessoaEndereco fará referência ao objeto mestre 'pessoa'
    classeMestre: string; // armazena o nome da classe mestre - ex: PessoaEndereco fará referência à classe mestre 'Pessoa'

    imports = []; // armazena os demais imports para a classe
    inputController = []; // armazena o código referente às variáveis Controller vinculadas aos inputs de lookup e que tem máscaras
    inputLookup = []; // armazena os widgets input de lookup
    inputNormal = []; // armazena os widgets input normais

    objetoJsonComentario: ComentarioDerJsonModel;

    importLookup: boolean;
    importMascara: boolean;
    importValida: boolean;
    importDropdownLista: boolean;

    constructor(tabela: string, tabelaMestre: string, dataPacket: CamposModel[]) {
        // trata imports
        this.importLookup = false;
        this.importMascara = false;
        this.importValida = false;
        this.importDropdownLista = false;

        // nome da classe
        this.class = lodash.camelCase(tabela);
        this.objetoPrincipal = this.class;
        this.class = lodash.upperFirst(this.class);

        // nome da tabela
        this.table = tabela.toUpperCase();

        // objeto e classe mestre
        this.objetoMestre = lodash.camelCase(tabelaMestre);
        this.classeMestre = lodash.upperFirst(this.objetoMestre);

        // laço nos campos da tabela para montar a página
        for (let i = 0; i < dataPacket.length; i++) {
            // define o nome do campo
            let nomeCampo = dataPacket[i].Field;
            let nomeCampoTabela = nomeCampo.toUpperCase();
            let nomeCampoAtributo = lodash.camelCase(nomeCampo);

            // tamanho do campo
            let tipoCampo = dataPacket[i].Type;
            let posicaoAbreParentese = tipoCampo.indexOf("(");
            let posicaoFechaParentese = tipoCampo.indexOf(")");
            let tamanhoCampo = 0;
            if (tipoCampo == "text") {
                tamanhoCampo = 1000;
            } else {
                tamanhoCampo = parseInt(tipoCampo.substring(posicaoAbreParentese+1, posicaoFechaParentese));
            }

            // quantidade de linhas do widget
            let quantidadeLinhas = 1;
            if (tipoCampo == "text" || tamanhoCampo > 200) {
                quantidadeLinhas = 3;
            }

            // pega o objeto JSON de comentário - se não houver, este campo não será renderizado na janela
            if (dataPacket[i].Comment != '') {
                try {
                    this.objetoJsonComentario = new ComentarioDerJsonModel(this.table, dataPacket[i].Comment);

                    // pega o valor do campo de lookup que deve ser exibido no lugar do ID da chave estrangeira
                    let campoLookupComTabela = '';
                    if (nomeCampoTabela.includes('ID_')) {
                        if (this.objetoJsonComentario.campoLookup != null && this.objetoJsonComentario.campoLookup != '') {
                            this.importLookup = true;
                            let tabelaMestre = lodash.replace(nomeCampoTabela, 'ID_', '');
                            this.objetoJsonComentario.tabelaMestre = tabelaMestre.toLowerCase(); // ex: banco
                            this.objetoJsonComentario.objetoMestre = lodash.camelCase(tabelaMestre); // ex: banco
                            this.objetoJsonComentario.classeMestre = lodash.upperFirst(lodash.camelCase(tabelaMestre)); // ex: Banco
                            campoLookupComTabela = this.objetoJsonComentario.objetoMestre + "?." + this.objetoJsonComentario.campoLookup; // ex: "banco.nome"

                            // variáveis Controller vinculadas aos inputs de lookup
                            this.inputController.push("var importa" + this.objetoJsonComentario.classeMestre + "Controller = TextEditingController();");
                            this.inputController.push("importa" + this.objetoJsonComentario.classeMestre + "Controller.text = widget." + this.objetoPrincipal + "?." + this.objetoJsonComentario.objetoMestre + "?." + this.objetoJsonComentario.campoLookup + " ?? '';");
                        }
                    }

                    let tipoControle = this.objetoJsonComentario.tipoControle;
                    if (tipoControle != null) {
                        let valida = 'validar';
                        if (tipoControle.tipo == 'textFormField') {
                            if (campoLookupComTabela != '') { // monta o campo de lookup
                                this.inputLookup.push("const SizedBox(height: 24.0),");
                                this.inputLookup.push("Row(");
                                this.inputLookup.push("\tchildren: <Widget>[");
                                this.inputLookup.push("\t\tExpanded(");
                                this.inputLookup.push("\t\t\tflex: 1,");
                                this.inputLookup.push("\t\t\tchild: Container(");
                                this.inputLookup.push("\t\t\t\tchild: TextFormField(");
                                this.inputLookup.push("\t\t\t\t\tcontroller: importa" + this.objetoJsonComentario.classeMestre + "Controller,");
                                this.inputLookup.push("\t\t\t\t\treadOnly: true,");
                                this.inputLookup.push("\t\t\t\t\tdecoration: ViewUtilLib.getInputDecorationPersistePage(");
                                this.inputLookup.push("\t\t\t\t\t\t'" + this.objetoJsonComentario.hintText + "',");
                                if (this.objetoJsonComentario.obrigatorio) {
                                    valida = valida + 'Obrigatorio';
                                    this.inputLookup.push("\t\t\t\t\t\t'" + this.objetoJsonComentario.labelText + " *',");
                                } else {
                                    this.inputLookup.push("\t\t\t\t\t\t'" + this.objetoJsonComentario.labelText + "',");
                                }
                                this.inputLookup.push("\t\t\t\t\t\tfalse),");
                                this.inputLookup.push("\t\t\t\t\tonSaved: (String value) {");
                                // 20200105 - EIJE - porção de código movida para o método onChanged
                                // if (this.objetoJsonComentario.campoLookupTipoDado == "int") {
                                //     this.inputLookup.push("\t\t\t\t\t\twidget." + this.objetoPrincipal + "?." + campoLookupComTabela + " = int.tryParse(value);");
                                // } else {
                                //     this.inputLookup.push("\t\t\t\t\t\twidget." + this.objetoPrincipal + "?." + campoLookupComTabela + " = value;");
                                // }
                                this.inputLookup.push("\t\t\t\t\t},");
                                if (this.objetoJsonComentario.validacao != null && this.objetoJsonComentario.validacao != '') {
                                    this.importValida = true;
                                    valida = valida + this.objetoJsonComentario.validacao;
                                    this.inputLookup.push("\t\t\t\t\tvalidator: ValidaCampoFormulario." + valida + ",");
                                }
                                this.inputLookup.push("\t\t\t\t\tonChanged: (text) {");
                                if (this.objetoJsonComentario.campoLookupTipoDado == "int") {
                                    this.inputLookup.push("\t\t\t\t\t\twidget." + this.objetoPrincipal + "?." + campoLookupComTabela + " = int.tryParse(text);");
                                } else {
                                    this.inputLookup.push("\t\t\t\t\t\twidget." + this.objetoPrincipal + "?." + campoLookupComTabela + " = text;");
                                }
                                this.inputLookup.push("\t\t\t\t\t\tViewUtilLib.paginaMestreDetalheFoiAlterada = true;");
                                this.inputLookup.push("\t\t\t\t\t\t_formFoiAlterado = true;");
                                this.inputLookup.push("\t\t\t\t\t},");
                                this.inputLookup.push("\t\t\t\t),");
                                this.inputLookup.push("\t\t\t),");
                                this.inputLookup.push("\t\t),");
                                this.inputLookup.push("\t\tExpanded(");
                                this.inputLookup.push("\t\t\tflex: 0,");
                                this.inputLookup.push("\t\t\tchild: IconButton(");
                                this.inputLookup.push("\t\t\t\ttooltip: 'Importar " + this.objetoJsonComentario.labelText + "',");
                                this.inputLookup.push("\t\t\t\ticon: const Icon(Icons.search),");
                                this.inputLookup.push("\t\t\t\tonPressed: () async {");
                                this.inputLookup.push("\t\t\t\t\t///chamando o lookup");
                                this.inputLookup.push("\t\t\t\t\tMap<String, dynamic> objetoJsonRetorno =");
                                this.inputLookup.push("\t\t\t\t\t\tawait Navigator.push(");
                                this.inputLookup.push("\t\t\t\t\t\t\tcontext,");
                                this.inputLookup.push("\t\t\t\t\t\t\tMaterialPageRoute(");
                                this.inputLookup.push("\t\t\t\t\t\t\t\tbuilder: (BuildContext context) =>");
                                this.inputLookup.push("\t\t\t\t\t\t\t\t\tLookupPage(");
                                this.inputLookup.push("\t\t\t\t\t\t\t\t\t\ttitle: 'Importar " + this.objetoJsonComentario.labelText + "',");
                                this.inputLookup.push("\t\t\t\t\t\t\t\t\t\tcolunas: " + this.objetoJsonComentario.classeMestre + ".colunas,");
                                this.inputLookup.push("\t\t\t\t\t\t\t\t\t\tcampos: " + this.objetoJsonComentario.classeMestre + ".campos,");                                
                                this.inputLookup.push("\t\t\t\t\t\t\t\t\t\trota: '/" + lodash.replace(this.objetoJsonComentario.tabelaMestre.toLowerCase(), new RegExp("_", "g"), "-") + "/',");
                                this.inputLookup.push("\t\t\t\t\t\t\t\t\t\tcampoPesquisaPadrao: '" + this.objetoJsonComentario.campoLookup + "',");
                                this.inputLookup.push("\t\t\t\t\t\t\t\t\t),");
                                this.inputLookup.push("\t\t\t\t\t\t\t\t\tfullscreenDialog: true,");
                                this.inputLookup.push("\t\t\t\t\t\t\t\t));");
                                this.inputLookup.push("\t\t\t\tif (objetoJsonRetorno != null) {");
                                this.inputLookup.push("\t\t\t\t\tif (objetoJsonRetorno['" + this.objetoJsonComentario.campoLookup + "'] != null) {");
                                this.inputLookup.push("\t\t\t\t\t\timporta" + this.objetoJsonComentario.classeMestre + "Controller.text = objetoJsonRetorno['" + this.objetoJsonComentario.campoLookup + "'];");
                                this.inputLookup.push("\t\t\t\t\t\twidget." + this.objetoPrincipal + "." + nomeCampoAtributo + " = objetoJsonRetorno['id'];");
                                this.inputLookup.push("\t\t\t\t\t\twidget." + this.objetoPrincipal + "." + this.objetoJsonComentario.objetoMestre + " = new " + this.objetoJsonComentario.classeMestre + ".fromJson(objetoJsonRetorno);");
                                this.inputLookup.push("\t\t\t\t\t}");
                                this.inputLookup.push("\t\t\t\t}");
                                this.inputLookup.push("\t\t\t},");
                                this.inputLookup.push("\t\t),");
                                this.inputLookup.push("\t\t),");
                                this.inputLookup.push("\t],");
                                this.inputLookup.push("),");
                            } else { // monta um TextFormField padrão
                                this.inputNormal.push("const SizedBox(height: 24.0),");
                                this.inputNormal.push("TextFormField(");
                                if (tipoControle.keyboardType != null && tipoControle.keyboardType != '') {
                                    this.inputNormal.push("\tkeyboardType: TextInputType." + tipoControle.keyboardType + ",");
                                }
                                if (tipoControle.mascara != '' && tipoControle.mascara != null) {
                                    this.importMascara = true;
 
                                    // variável Controller
                                    if (tipoCampo.includes('decimal')) {
                                        let tipoControle = this.objetoJsonComentario.tipoControle;
                                        let casasDecimais = lodash.camelCase("decimais" + tipoControle.mascara);                
                                        this.inputController.push("var " + nomeCampoAtributo + "Controller = new MoneyMaskedTextController(precision: Constantes." + casasDecimais + ", initialValue: widget." + this.objetoPrincipal + "?." + nomeCampoAtributo + " ?? 0);");
                                    } else {
                                        this.inputController.push("var " + nomeCampoAtributo + "Controller = new MaskedTextController(")
                                        this.inputController.push("\tmask: Constantes.mascara" + tipoControle.mascara + ",")
                                        this.inputController.push("\ttext: widget." + this.objetoPrincipal + "?." + nomeCampoAtributo + " ?? '',")
                                        this.inputController.push(");")
                                    }

                                    // utilização do controller
                                    this.inputNormal.push("\tcontroller: " + nomeCampoAtributo + "Controller,");
                                } else {
                                    this.inputNormal.push("\tmaxLength: " + tamanhoCampo + ",");
                                    this.inputNormal.push("\tmaxLines: " + quantidadeLinhas + ",");
                                    if (tipoCampo.includes('int')) {
                                        this.inputNormal.push("\tinitialValue: widget." + this.objetoPrincipal + "?." + nomeCampoAtributo + "?.toString() ?? '',");
                                    } else {
                                        this.inputNormal.push("\tinitialValue: widget." + this.objetoPrincipal + "?." + nomeCampoAtributo + " ?? '',");
                                    }
                                }
                                this.inputNormal.push("\tdecoration: ViewUtilLib.getInputDecorationPersistePage(");
                                this.inputNormal.push("\t\t'" + this.objetoJsonComentario.hintText + "',");
                                if (this.objetoJsonComentario.obrigatorio) {
                                    valida = valida + 'Obrigatorio';
                                    this.inputNormal.push("\t\t'" + this.objetoJsonComentario.labelText + " *',");
                                } else {
                                    this.inputNormal.push("\t\t'" + this.objetoJsonComentario.labelText + "',");
                                }
                                this.inputNormal.push("\t\tfalse),");
                                this.inputNormal.push("\tonSaved: (String value) {");
                                // 20200105 - EIJE - porção de código movida para o método onChanged
                                // if (tipoCampo.includes('decimal')) {
                                //     this.inputNormal.push("\t\twidget." + this.objetoPrincipal + "." + nomeCampoAtributo + " = " + nomeCampoAtributo + "Controller.numberValue;");
                                // } else if (tipoCampo.includes('int')) {
                                //     this.inputNormal.push("\t\twidget." + this.objetoPrincipal + "." + nomeCampoAtributo + " = int.tryParse(value);");
                                // } else {
                                //     this.inputNormal.push("\t\twidget." + this.objetoPrincipal + "." + nomeCampoAtributo + " = value;");
                                // }
                                this.inputNormal.push("\t},");
                                if (this.objetoJsonComentario.validacao != null && this.objetoJsonComentario.validacao != '') {
                                    this.importValida = true;
                                    valida = valida + this.objetoJsonComentario.validacao;
                                    this.inputNormal.push("\tvalidator: ValidaCampoFormulario." + valida + ",");
                                }
                                this.inputNormal.push("\tonChanged: (text) {");
                                if (tipoCampo.includes('decimal')) {
                                    this.inputNormal.push("\t\twidget." + this.objetoPrincipal + "." + nomeCampoAtributo + " = " + nomeCampoAtributo + "Controller.numberValue;");
                                } else if (tipoCampo.includes('int')) {
                                    this.inputNormal.push("\t\twidget." + this.objetoPrincipal + "." + nomeCampoAtributo + " = int.tryParse(text);");
                                } else {
                                    this.inputNormal.push("\t\twidget." + this.objetoPrincipal + "." + nomeCampoAtributo + " = text;");
                                }
                                // 20200105 - EIJE - comentado por conta do código acima que foi movido de onSaved
                                // if (tipoControle.mascara != '' && tipoControle.mascara != null && !tipoCampo.includes('decimal')) {
                                //     this.inputNormal.push("\t\twidget." + this.objetoPrincipal + "." + nomeCampoAtributo + " = text;");
                                // }
                                this.inputNormal.push("\t\tViewUtilLib.paginaMestreDetalheFoiAlterada = true;");
                                this.inputNormal.push("\t\t_formFoiAlterado = true;");
                                this.inputNormal.push("\t},");
                                this.inputNormal.push("\t),");
                            }
                        } else if (tipoControle.tipo == 'dropDownButton') {
                            this.inputNormal.push("const SizedBox(height: 24.0),");
                            this.inputNormal.push("InputDecorator(");
                            this.inputNormal.push("\tdecoration: ViewUtilLib.getInputDecorationPersistePage(");
                            this.inputNormal.push("\t\t'" + this.objetoJsonComentario.hintText + "',");
                            if (this.objetoJsonComentario.obrigatorio) {
                                valida = valida + 'Obrigatorio';
                                this.inputNormal.push("\t\t'" + this.objetoJsonComentario.labelText + " *',");
                            } else {
                                this.inputNormal.push("\t\t'" + this.objetoJsonComentario.labelText + "',");
                            }
                            this.inputNormal.push("\t\ttrue),");
                            this.inputNormal.push("\tisEmpty: widget." + this.objetoPrincipal + "." + nomeCampoAtributo + " == null,");
                            this.inputNormal.push("\tchild: ViewUtilLib.getDropDownButton(widget." + this.objetoPrincipal + "." + nomeCampoAtributo + ",");
                            this.inputNormal.push("\t\t(String newValue) {");
                            this.inputNormal.push("\tViewUtilLib.paginaMestreDetalheFoiAlterada = true;");
                            this.inputNormal.push("\tsetState(() {");                                
                            this.inputNormal.push("\t\twidget." + this.objetoPrincipal + "." + nomeCampoAtributo + " = newValue;");
                            this.inputNormal.push("\t});");
                            if (tipoControle.persiste == 'valor') {
                                this.importDropdownLista = true;
                                this.inputNormal.push("\t}, DropdownLista." + tipoControle.itens[0].dropDownButtonItem + ")),");
                            } else {
                                this.inputNormal.push("\t}, <String>[");
                                for (let i = 0; i < tipoControle.itens.length; i++) {
                                    this.inputNormal.push("\t\t'" + tipoControle.itens[i].dropDownButtonItem + "',");
                                }
                                this.inputNormal.push("])),");    
                            }

                        } else if (tipoControle.tipo == 'datePickerItem') {
                            this.inputNormal.push("const SizedBox(height: 24.0),");
                            this.inputNormal.push("InputDecorator(");
                            this.inputNormal.push("\tdecoration: ViewUtilLib.getInputDecorationPersistePage(");
                            this.inputNormal.push("\t\t'" + this.objetoJsonComentario.hintText + "',");
                            if (this.objetoJsonComentario.obrigatorio) {
                                valida = valida + 'Obrigatorio';
                                this.inputNormal.push("\t\t'" + this.objetoJsonComentario.labelText + " *',");
                            } else {
                                this.inputNormal.push("\t\t'" + this.objetoJsonComentario.labelText + "',");
                            }
                            this.inputNormal.push("\t\ttrue),");
                            this.inputNormal.push("\tisEmpty: widget." + this.objetoPrincipal + "." + nomeCampoAtributo + " == null,");
                            this.inputNormal.push("\tchild: DatePickerItem(");
                            this.inputNormal.push("\t\tdateTime: widget." + this.objetoPrincipal + "." + nomeCampoAtributo + ",");
                            if (tipoControle.firstDate.includes("now") || tipoControle.firstDate == null && tipoControle.firstDate == '') {
                                this.inputNormal.push("\t\tfirstDate: DateTime.now(),");
                            } else {
                                this.inputNormal.push("\t\tfirstDate: DateTime.parse('" + tipoControle.firstDate + "'),");
                            }
                            if (tipoControle.lastDate.includes("now") || tipoControle.firstDate == null && tipoControle.firstDate == '') {
                                this.inputNormal.push("\t\tlastDate: DateTime.now(),");
                            } else {
                                this.inputNormal.push("\t\tlastDate: DateTime.parse('" + tipoControle.lastDate + "'),");
                            }
                            this.inputNormal.push("\t\tonChanged: (DateTime value) {");
                            this.inputNormal.push("\t\t\tViewUtilLib.paginaMestreDetalheFoiAlterada = true;");
                            this.inputNormal.push("\t\t\tsetState(() {");
                            this.inputNormal.push("\t\t\t\twidget." + this.objetoPrincipal + "." + nomeCampoAtributo + " = value;");
                            this.inputNormal.push("\t\t\t});");
                            this.inputNormal.push("\t\t},");
                            this.inputNormal.push("\t),");
                            this.inputNormal.push("),");
                        }
                    }

                } catch (erro) {
                    this.objetoJsonComentario = null;
                }
            }
        }

        // imports
        if (this.importLookup) {
            this.imports.push("import 'package:fenix/src/view/shared/lookup_page.dart';")
        }
        if (this.importMascara) {
            this.imports.push("import 'package:flutter_masked_text/flutter_masked_text.dart';")
            this.imports.push("import 'package:fenix/src/infra/constantes.dart';")
        }
        if (this.importValida) {
            this.imports.push("import 'package:fenix/src/view/shared/valida_campo_formulario.dart';")
        }
        if (this.importDropdownLista) {
            this.imports.push("import 'package:fenix/src/view/shared/dropdown_lista.dart';")
        }
 
    }
}