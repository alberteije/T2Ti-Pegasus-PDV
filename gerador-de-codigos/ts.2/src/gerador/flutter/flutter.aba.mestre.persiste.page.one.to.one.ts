import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { FlutterPersistePageBase } from "./flutter.persiste.page.base";
import { Biblioteca } from "../../util/biblioteca";

/// classe base que ajuda a gerar a PersistePage do Flutter usando o mustache
export class FlutterAbaMestrePersistePageOneToOne extends FlutterPersistePageBase {

    objetoMestre: string; // armazena o nome do objeto mestre - ex: PessoaEndereco fará referência ao objeto mestre 'pessoa'
    classeMestre: string; // armazena o nome da classe mestre - ex: PessoaEndereco fará referência à classe mestre 'Pessoa'

    constructor(tabela: string, tabelaMestre: string, dataPacket: CamposModel[]) {
        super(tabela);

        // objeto e classe mestre
        this.objetoMestre = lodash.camelCase(tabelaMestre);
        this.classeMestre = lodash.upperFirst(this.objetoMestre);

        // laço nos campos da tabela para montar a página
        for (let i = 0; i < dataPacket.length; i++) {
            super.definirDadosIniciais(dataPacket[i]);

            // pega o objeto JSON de comentário - se não houver, este campo não será renderizado na janela
            if (dataPacket[i].Comment != '') {
                if (Biblioteca.isJsonString(tabela, this.campoModel.Comment)) {
                    try {
                        this.objetoJsonComentario = new ComentarioDerJsonModel(this.table, dataPacket[i].Comment);

                        // se o objeto não contém o campo desenhaControle, o controle será desenhado mesmo assim, pois o padrão é 'true'
                        // se o objeto contém o campo desenhaControle e estiver marcado como true, desenha o widget
                        if (this.objetoJsonComentario.desenhaControle == null || this.objetoJsonComentario.desenhaControle == true) {
                            // define o campo de lookup
                            this.objetoJsonComentario.campoLookupComTabela = '';
                            if (this.objetoJsonComentario.campoLookup != null && this.objetoJsonComentario.campoLookup != '') {
                                super.definirDadosDeLookup();
                                // variáveis Controller vinculadas aos inputs de lookup
                                this.inputController.push("var importa" + this.objetoJsonComentario.classeMestre + "Controller = TextEditingController();");
                                if (this.campoModel.nomeCampoTabela.includes('ID_')) {
                                    this.inputController.push("importa" + this.objetoJsonComentario.classeMestre + "Controller.text = widget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.objetoJsonComentario.objetoMestre + "?." + this.objetoJsonComentario.campoLookup + " ?? '';");
                                } else { // se é um campo de lookup para simples consulta, não precisa vincular ao objeto mestre, pois o dado será persistido no campo da própria tabela
                                    this.inputController.push("importa" + this.objetoJsonComentario.classeMestre + "Controller.text = widget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " ?? '';");
                                }
                            }

                            // monta o widget
                            if (this.objetoJsonComentario.tipoControle != null) {
                                this.objetoJsonComentario.valida = 'validar';
                                if (this.objetoJsonComentario.tipoControle.tipo == 'textFormField') {
                                    if (this.objetoJsonComentario.campoLookupComTabela != '') { // monta o campo de lookup
                                        this.montarCampoComLookup();
                                    } else { // monta um TextFormField padrão
                                        this.montarTextFormFieldPadrao();                    
                                    }
                                } else if (this.objetoJsonComentario.tipoControle.tipo == 'dropDownButton') {                      
                                    this.montarDropDownButton();
                                } else if (this.objetoJsonComentario.tipoControle.tipo == 'datePickerItem') {
                                    this.montarDatePickerItem();
                                }
                            }
                        }
                    } catch (erro) {
                        this.objetoJsonComentario = null;
                    }
                }
            }
        }

        // imports
        super.arrumarImports();
    }

    montarCampoComLookup() {
        super.abrirCampoDeLookup();

        if (this.campoModel.nomeCampoTabela.includes('ID_')) {    
            if (this.objetoJsonComentario.campoLookupTipoDado == "int") {
                this.inputLookup.push("\t\t\t\t\t\twidget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.objetoJsonComentario.campoLookupComTabela + " = int.tryParse(text);");
            } else {
                this.inputLookup.push("\t\t\t\t\t\twidget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.objetoJsonComentario.campoLookupComTabela + " = text;");
            }
        } else { // se é um campo de lookup para simples consulta, não precisa vincular ao objeto mestre, pois o dado será persistido no campo da própria tabela
            if (this.objetoJsonComentario.campoLookupTipoDado == "int") {
                this.inputLookup.push("\t\t\t\t\t\twidget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " = int.tryParse(text);");
            } else {
                this.inputLookup.push("\t\t\t\t\t\twidget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " = text;");
            }
        }
        this.inputLookup.push("\t\t\t\t\t\tViewUtilLib.paginaMestreDetalheFoiAlterada = true;");

        super.abrirCampoDeLookupExpanded();

        if (this.campoModel.nomeCampoTabela.includes('ID_')) {
            this.inputLookup.push("\t\t\t\t\t\twidget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " = objetoJsonRetorno['id'];");
            this.inputLookup.push("\t\t\t\t\t\twidget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.objetoJsonComentario.objetoMestre + " = new " + this.objetoJsonComentario.classeMestre + ".fromJson(objetoJsonRetorno);");
        } else { // se é um campo de lookup para simples consulta, não precisa vincular ao objeto mestre, pois o dado será persistido no campo da própria tabela
            this.inputLookup.push("\t\t\t\t\t\twidget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " = objetoJsonRetorno['" + this.objetoJsonComentario.campoLookup + "'];");
        }

        super.fecharCampoDeLookup();
    }

    montarTextFormFieldPadrao() {
        super.abrirTextFormFieldPadrao();

        if (this.objetoJsonComentario.tipoControle.mascara != '' && this.objetoJsonComentario.tipoControle.mascara != null) {
            this.importMascara = true;

            // variável Controller
            if (this.campoModel.tipoCampo.includes('decimal')) {
                let casasDecimais = lodash.camelCase("decimais" + this.objetoJsonComentario.tipoControle.mascara);                
                this.inputController.push("var " + this.campoModel.nomeCampoAtributo + "Controller = new MoneyMaskedTextController(precision: Constantes." + casasDecimais + ", initialValue: widget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " ?? 0);");
            } else {
                this.inputController.push("var " + this.campoModel.nomeCampoAtributo + "Controller = new MaskedTextController(")
                this.inputController.push("\tmask: Constantes.mascara" + this.objetoJsonComentario.tipoControle.mascara + ",")
                this.inputController.push("\ttext: widget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " ?? '',")
                this.inputController.push(");")
            }

            // utilização do controller
            this.inputNormal.push("\tcontroller: " + this.campoModel.nomeCampoAtributo + "Controller,");
        } else {
            this.inputNormal.push("\tmaxLength: " + this.campoModel.tamanhoCampo + ",");
            this.inputNormal.push("\tmaxLines: " + this.campoModel.quantidadeLinhas + ",");
            if (this.campoModel.tipoCampo.includes('int')) {
                this.inputNormal.push("\tinitialValue: widget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + "?.toString() ?? '',");
            } else {
                this.inputNormal.push("\tinitialValue: widget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " ?? '',");
            }
        }
 
        super.abrirTextFormFieldPadraoValidacao();

        if (this.campoModel.tipoCampo.includes('decimal')) {
            this.inputNormal.push("\t\twidget." + this.objetoMestre + "." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " = " + this.campoModel.nomeCampoAtributo + "Controller.numberValue;");
        } else if (this.campoModel.tipoCampo.includes('int')) {
            this.inputNormal.push("\t\twidget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " = int.tryParse(text);");
        } else {
            this.inputNormal.push("\t\twidget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " = text;");
        }                                
        this.inputNormal.push("\t\tViewUtilLib.paginaMestreDetalheFoiAlterada = true;");
 
        super.fecharTextFormFieldPadrao();
    }

    montarDropDownButton() {
        super.abrirDropDownButton();

        this.inputNormal.push("\tisEmpty: widget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " == null ||");
        this.inputNormal.push("\t\twidget." + this.objetoMestre + "?." + this.objetoPrincipal + " == null,");
        this.inputNormal.push("\tchild: ViewUtilLib.getDropDownButton(widget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + ",");
        this.inputNormal.push("\t\t(String newValue) {");
        this.inputNormal.push("\tViewUtilLib.paginaMestreDetalheFoiAlterada = true;");
        this.inputNormal.push("\tsetState(() {");                                
        this.inputNormal.push("\t\twidget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " = newValue;");

        super.fecharDropDownButton();
    }

    montarDatePickerItem() {
        super.abrirDatePickerItem();

        this.inputNormal.push("\tisEmpty: widget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " == null,");
        this.inputNormal.push("\tchild: DatePickerItem(");
        this.inputNormal.push("\t\tdateTime: widget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + ",");

        super.abrirDatePickerItemFistLastDate();

        this.inputNormal.push("\t\tonChanged: (DateTime value) {");
        this.inputNormal.push("\t\t\tViewUtilLib.paginaMestreDetalheFoiAlterada = true;");
        this.inputNormal.push("\t\t\tsetState(() {");
        this.inputNormal.push("\t\t\t\twidget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " = value;");

        super.fecharDatePickerItem();
    }
}