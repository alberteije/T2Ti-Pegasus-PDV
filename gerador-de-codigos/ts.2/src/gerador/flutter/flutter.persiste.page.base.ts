import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { Biblioteca } from "../../util/biblioteca";

/// classe base que ajuda a gerar a PersistePage do Flutter usando o mustache
export class FlutterPersistePageBase {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    objetoPrincipal: string; // armazena o nome do objeto principal, que costuma ser o nome da classe com a primeira letra em minúsculo
    nomeArquivo: string; // armazena o nome do arquivo que aparece no import

    imports = []; // armazena os demais imports para a classe
    inputController = []; // armazena o código referente às variáveis Controller vinculadas aos inputs de lookup e que tem máscaras
    inputLookup = []; // armazena os widgets input de lookup
    inputNormal = []; // armazena os widgets input normais

    campoModel: CamposModel;
    objetoJsonComentario: ComentarioDerJsonModel;

    // controla os imports
    importLookup: boolean;
    importMascara: boolean;
    importValida: boolean;
    importDropdownLista: boolean;

    constructor(tabela: string) {
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

        // nomeArquivo
        this.nomeArquivo = tabela.toLowerCase();
    }

    /**
     * @param dataPacket 
     * @param paginaDeAba para páginas mestre, detalhe e OneToOne
     * @param controlaFormAlteradoLocal acrescenta o código para informar que o form local foi alterado
     */
    montarPagina(dataPacket: CamposModel[], paginaDeAba: boolean, controlaFormAlteradoLocal: boolean) {
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
                            this.objetoJsonComentario.campoLookupComTabela = '';
                            if (this.objetoJsonComentario.campoLookup != null && this.objetoJsonComentario.campoLookup != '') {
                                this.definirDadosDeLookup();
                                // variáveis Controller vinculadas aos inputs de lookup
                                this.inputController.push("var importa" + this.objetoJsonComentario.classeMestre + "Controller = TextEditingController();");
                                if (this.campoModel.nomeCampoTabela.includes('ID_')) {
                                    this.inputController.push("importa" + this.objetoJsonComentario.classeMestre + "Controller.text = widget." + this.objetoPrincipal + "?." + this.objetoJsonComentario.objetoMestre + "?." + this.objetoJsonComentario.campoLookup + " ?? '';");
                                } else { // se é um campo de lookup para simples consulta, não precisa vincular ao objeto mestre, pois o dado será persistido no campo da própria tabela
                                    this.inputController.push("importa" + this.objetoJsonComentario.classeMestre + "Controller.text = widget." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " ?? '';");
                                }
                            }

                            // monta o widget
                            if (this.objetoJsonComentario.tipoControle != null) {
                                this.objetoJsonComentario.valida = 'validar';
                                if (this.objetoJsonComentario.tipoControle.tipo == 'textFormField') {
                                    if (this.objetoJsonComentario.campoLookupComTabela != '') { // monta o campo de lookup
                                        this.montarCampoComLookup(paginaDeAba, controlaFormAlteradoLocal);
                                    } else { // monta um TextFormField padrão
                                        this.montarTextFormFieldPadrao(paginaDeAba, controlaFormAlteradoLocal);
                                    }
                                } else if (this.objetoJsonComentario.tipoControle.tipo == 'dropDownButton') {
                                    this.montarDropDownButton(paginaDeAba);
                                } else if (this.objetoJsonComentario.tipoControle.tipo == 'datePickerItem') {
                                    this.montarDatePickerItem(paginaDeAba);
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
        this.arrumarImports();
    }

    definirDadosIniciais(campoModel: CamposModel) {
        // pega o campo
        this.campoModel = campoModel;

        // define o nome do campo
        this.campoModel.nomeCampo = this.campoModel.Field;
        this.campoModel.nomeCampoTabela = this.campoModel.nomeCampo.toUpperCase();
        this.campoModel.nomeCampoAtributo = lodash.camelCase(this.campoModel.nomeCampo);

        // tamanho do campo
        this.campoModel.tipoCampo = this.campoModel.Type;
        let posicaoAbreParentese = this.campoModel.tipoCampo.indexOf("(");
        let posicaoFechaParentese = this.campoModel.tipoCampo.indexOf(")");
        this.campoModel.tamanhoCampo = 0;
        if (this.campoModel.tipoCampo == "text") {
            this.campoModel.tamanhoCampo = 1000;
        } else {
            this.campoModel.tamanhoCampo = parseInt(this.campoModel.tipoCampo.substring(posicaoAbreParentese+1, posicaoFechaParentese));
        }

        // quantidade de linhas do widget
        this.campoModel.quantidadeLinhas = 1;
        if (this.campoModel.tipoCampo == "text" || this.campoModel.tamanhoCampo > 200) {
            this.campoModel.quantidadeLinhas = 3;
        }
    }

    definirDadosDeLookup() {
        this.importLookup = true;
        let tabelaMestre = this.objetoJsonComentario.tabelaLookup; // tabelaLookup deve ser definida inclusive para campos PK
        this.objetoJsonComentario.tabelaMestre = tabelaMestre.toLowerCase(); // ex: banco
        this.objetoJsonComentario.objetoMestre = lodash.camelCase(tabelaMestre); // ex: banco
        this.objetoJsonComentario.classeMestre = lodash.upperFirst(lodash.camelCase(tabelaMestre)); // ex: Banco
        this.objetoJsonComentario.campoLookupComTabela = this.objetoJsonComentario.objetoMestre + "?." + this.objetoJsonComentario.campoLookup; // ex: "banco.nome"
    }
    
    montarCampoComLookup(paginaDeAba: boolean, controlaFormAlteradoLocal: boolean) {
        this.abrirCampoDeLookup();

        if (this.campoModel.nomeCampoTabela.includes('ID_')) {
            if (this.objetoJsonComentario.campoLookupTipoDado == "int") {
                this.inputLookup.push("\t\t\t\t\t\twidget." + this.objetoPrincipal + "?." + this.objetoJsonComentario.campoLookupComTabela + " = int.tryParse(text);");
            } else {
                this.inputLookup.push("\t\t\t\t\t\twidget." + this.objetoPrincipal + "?." + this.objetoJsonComentario.campoLookupComTabela + " = text;");
            }
        } else { // se é um campo de lookup para simples consulta, não precisa vincular ao objeto mestre, pois o dado será persistido no campo da própria tabela
            if (this.objetoJsonComentario.campoLookupTipoDado == "int") {
                this.inputLookup.push("\t\t\t\t\t\twidget." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " = int.tryParse(text);");
            } else {
                this.inputLookup.push("\t\t\t\t\t\twidget." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " = text;");
            }
        }
        if (paginaDeAba) {
            this.inputLookup.push("\t\t\t\t\t\tViewUtilLib.paginaMestreDetalheFoiAlterada = true;");
        } 
        if (controlaFormAlteradoLocal) {                                
            this.inputLookup.push("\t\t\t\t\t\t_formFoiAlterado = true;");
        }

        this.abrirCampoDeLookupExpanded();

        if (this.campoModel.nomeCampoTabela.includes('ID_')) {
            this.inputLookup.push("\t\t\t\t\t\twidget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " = objetoJsonRetorno['id'];");
            this.inputLookup.push("\t\t\t\t\t\twidget." + this.objetoPrincipal + "." + this.objetoJsonComentario.objetoMestre + " = new " + this.objetoJsonComentario.classeMestre + ".fromJson(objetoJsonRetorno);");
        } else { // se é um campo de lookup para simples consulta, não precisa vincular ao objeto mestre, pois o dado será persistido no campo da própria tabela
            this.inputLookup.push("\t\t\t\t\t\twidget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " = objetoJsonRetorno['" + this.objetoJsonComentario.campoLookup + "'];");
        }

        this.fecharCampoDeLookup();
    }

    abrirCampoDeLookup() {
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
            this.objetoJsonComentario.valida = this.objetoJsonComentario.valida + 'Obrigatorio';
            this.inputLookup.push("\t\t\t\t\t\t'" + this.objetoJsonComentario.labelText + " *',");
        } else {
            this.inputLookup.push("\t\t\t\t\t\t'" + this.objetoJsonComentario.labelText + "',");
        }
        this.inputLookup.push("\t\t\t\t\t\tfalse),");
        this.inputLookup.push("\t\t\t\t\tonSaved: (String value) {");
        this.inputLookup.push("\t\t\t\t\t},");
        if (this.objetoJsonComentario.validacao != null && this.objetoJsonComentario.validacao != '') {
            this.importValida = true;
            this.objetoJsonComentario.valida = this.objetoJsonComentario.valida + this.objetoJsonComentario.validacao;
            this.inputLookup.push("\t\t\t\t\tvalidator: ValidaCampoFormulario." + this.objetoJsonComentario.valida + ",");
        }
        this.inputLookup.push("\t\t\t\t\tonChanged: (text) {");
    }

    abrirCampoDeLookupExpanded() {
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
        this.inputLookup.push("\t\t\t\t\t\t\t\t\t\tvalorPesquisaPadrao: '" + this.objetoJsonComentario.valorPadraoLookup + "',");
        this.inputLookup.push("\t\t\t\t\t\t\t\t\t),");
        this.inputLookup.push("\t\t\t\t\t\t\t\t\tfullscreenDialog: true,");
        this.inputLookup.push("\t\t\t\t\t\t\t\t));");
        this.inputLookup.push("\t\t\t\tif (objetoJsonRetorno != null) {");
        this.inputLookup.push("\t\t\t\t\tif (objetoJsonRetorno['" + this.objetoJsonComentario.campoLookup + "'] != null) {");
        this.inputLookup.push("\t\t\t\t\t\timporta" + this.objetoJsonComentario.classeMestre + "Controller.text = objetoJsonRetorno['" + this.objetoJsonComentario.campoLookup + "'];");
    }

    fecharCampoDeLookup() {
        this.inputLookup.push("\t\t\t\t\t}");
        this.inputLookup.push("\t\t\t\t}");
        this.inputLookup.push("\t\t\t},");
        this.inputLookup.push("\t\t),");
        this.inputLookup.push("\t\t),");
        this.inputLookup.push("\t],");
        this.inputLookup.push("),");
    }

    montarTextFormFieldPadrao(paginaDeAba: boolean, controlaFormAlteradoLocal: boolean) {
        this.abrirTextFormFieldPadrao();

        if (this.objetoJsonComentario.tipoControle.mascara != '' && this.objetoJsonComentario.tipoControle.mascara != null) {
            this.importMascara = true;

            // variável Controller
            if (this.campoModel.tipoCampo.includes('decimal')) {
                let casasDecimais = lodash.camelCase("decimais" + this.objetoJsonComentario.tipoControle.mascara);                
                this.inputController.push("var " + this.campoModel.nomeCampoAtributo + "Controller = new MoneyMaskedTextController(precision: Constantes." + casasDecimais + ", initialValue: widget." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " ?? 0);");
            } else {
                this.inputController.push("var " + this.campoModel.nomeCampoAtributo + "Controller = new MaskedTextController(")
                this.inputController.push("\tmask: Constantes.mascara" + this.objetoJsonComentario.tipoControle.mascara + ",")
                this.inputController.push("\ttext: widget." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " ?? '',")
                this.inputController.push(");")
            }

            // utilização do controller
            this.inputNormal.push("\tcontroller: " + this.campoModel.nomeCampoAtributo + "Controller,");
        } else {
            this.inputNormal.push("\tmaxLength: " + this.campoModel.tamanhoCampo + ",");
            this.inputNormal.push("\tmaxLines: " + this.campoModel.quantidadeLinhas + ",");
            if (this.campoModel.tipoCampo.includes('int')) {
                this.inputNormal.push("\tinitialValue: widget." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + "?.toString() ?? '',");
            } else {
                this.inputNormal.push("\tinitialValue: widget." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " ?? '',");
            }
        }

        this.abrirTextFormFieldPadraoValidacao();

        if (this.campoModel.tipoCampo.includes('decimal')) {
            this.inputNormal.push("\t\twidget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " = " + this.campoModel.nomeCampoAtributo + "Controller.numberValue;");
        } else if (this.campoModel.tipoCampo.includes('int')) {
            this.inputNormal.push("\t\twidget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " = int.tryParse(text);");
        } else {
            this.inputNormal.push("\t\twidget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " = text;");
        }
        if (paginaDeAba) {
            this.inputNormal.push("\t\tViewUtilLib.paginaMestreDetalheFoiAlterada = true;");
        } 
        if (controlaFormAlteradoLocal) {                                
            this.inputNormal.push("\t\t_formFoiAlterado = true;");
        }

        this.fecharTextFormFieldPadrao();
    }

    abrirTextFormFieldPadrao() {
        this.inputNormal.push("const SizedBox(height: 24.0),");
        this.inputNormal.push("TextFormField(");
        if (this.objetoJsonComentario.tipoControle.keyboardType != null && this.objetoJsonComentario.tipoControle.keyboardType != '') {
            this.inputNormal.push("\tkeyboardType: TextInputType." + this.objetoJsonComentario.tipoControle.keyboardType + ",");
        }
        if (this.objetoJsonComentario.readOnly) {
            this.inputNormal.push("\treadOnly: true,");
        }
    }

    abrirTextFormFieldPadraoValidacao() {
        this.inputNormal.push("\tdecoration: ViewUtilLib.getInputDecorationPersistePage(");
        this.inputNormal.push("\t\t'" + this.objetoJsonComentario.hintText + "',");
        if (this.objetoJsonComentario.obrigatorio) {
            this.objetoJsonComentario.valida = this.objetoJsonComentario.valida + 'Obrigatorio';
            this.inputNormal.push("\t\t'" + this.objetoJsonComentario.labelText + " *',");
        } else {
            this.inputNormal.push("\t\t'" + this.objetoJsonComentario.labelText + "',");
        }
        this.inputNormal.push("\t\tfalse),");
        this.inputNormal.push("\tonSaved: (String value) {");
        this.inputNormal.push("\t},");
        if (this.objetoJsonComentario.validacao != null && this.objetoJsonComentario.validacao != '') {
            this.importValida = true;
            this.objetoJsonComentario.valida = this.objetoJsonComentario.valida + this.objetoJsonComentario.validacao;
            this.inputNormal.push("\tvalidator: ValidaCampoFormulario." + this.objetoJsonComentario.valida + ",");
        }
        this.inputNormal.push("\tonChanged: (text) {");
    }

    fecharTextFormFieldPadrao() {
        this.inputNormal.push("\t},");
        this.inputNormal.push("\t),");
    }

    montarDropDownButton(paginaDeAba: boolean) {
        this.abrirDropDownButton();

        this.inputNormal.push("\tisEmpty: widget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " == null,");
        this.inputNormal.push("\tchild: ViewUtilLib.getDropDownButton(widget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + ",");
        this.inputNormal.push("\t\t(String newValue) {");
        if (paginaDeAba) {
            this.inputNormal.push("\t\tViewUtilLib.paginaMestreDetalheFoiAlterada = true;");
        }
        this.inputNormal.push("\tsetState(() {");
        this.inputNormal.push("\t\twidget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " = newValue;");

        this.fecharDropDownButton();
    }

    abrirDropDownButton() {
        this.inputNormal.push("const SizedBox(height: 24.0),");
        this.inputNormal.push("InputDecorator(");
        this.inputNormal.push("\tdecoration: ViewUtilLib.getInputDecorationPersistePage(");
        this.inputNormal.push("\t\t'" + this.objetoJsonComentario.hintText + "',");
        if (this.objetoJsonComentario.obrigatorio) {
            this.objetoJsonComentario.valida = this.objetoJsonComentario.valida + 'Obrigatorio';
            this.inputNormal.push("\t\t'" + this.objetoJsonComentario.labelText + " *',");
        } else {
            this.inputNormal.push("\t\t'" + this.objetoJsonComentario.labelText + "',");
        }
        this.inputNormal.push("\t\ttrue),");
    }

    fecharDropDownButton() {
        this.inputNormal.push("\t});");
        if (this.objetoJsonComentario.tipoControle.persiste == 'valor') {
            this.importDropdownLista = true;
            this.inputNormal.push("\t}, DropdownLista." + this.objetoJsonComentario.tipoControle.itens[0].dropDownButtonItem + ")),");
        } else {
            this.inputNormal.push("\t}, <String>[");
            for (let i = 0; i < this.objetoJsonComentario.tipoControle.itens.length; i++) {
                this.inputNormal.push("\t\t'" + this.objetoJsonComentario.tipoControle.itens[i].dropDownButtonItem + "',");
            }
            this.inputNormal.push("])),");    
        }
    }

    montarDatePickerItem(paginaDeAba: boolean) {
        this.abrirDatePickerItem();

        this.inputNormal.push("\tisEmpty: widget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " == null,");
        this.inputNormal.push("\tchild: DatePickerItem(");
        this.inputNormal.push("\t\tdateTime: widget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + ",");

        this.abrirDatePickerItemFistLastDate();

        this.inputNormal.push("\t\tonChanged: (DateTime value) {");
        if (paginaDeAba) {
            this.inputNormal.push("\t\t\tViewUtilLib.paginaMestreDetalheFoiAlterada = true;");
        }
        this.inputNormal.push("\t\t\tsetState(() {");
        this.inputNormal.push("\t\t\t\twidget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " = value;");

        this.fecharDatePickerItem();
    }

    abrirDatePickerItem() {
        this.inputNormal.push("const SizedBox(height: 24.0),");
        this.inputNormal.push("InputDecorator(");
        this.inputNormal.push("\tdecoration: ViewUtilLib.getInputDecorationPersistePage(");
        this.inputNormal.push("\t\t'" + this.objetoJsonComentario.hintText + "',");
        if (this.objetoJsonComentario.obrigatorio) {
            this.objetoJsonComentario.valida = this.objetoJsonComentario.valida + 'Obrigatorio';
            this.inputNormal.push("\t\t'" + this.objetoJsonComentario.labelText + " *',");
        } else {
            this.inputNormal.push("\t\t'" + this.objetoJsonComentario.labelText + "',");
        }
        this.inputNormal.push("\t\ttrue),");
    }

    abrirDatePickerItemFistLastDate() {
        if (this.objetoJsonComentario.tipoControle.firstDate.includes("now") || this.objetoJsonComentario.tipoControle.firstDate == null && this.objetoJsonComentario.tipoControle.firstDate == '') {
            this.inputNormal.push("\t\tfirstDate: DateTime.now(),");
        } else {
            this.inputNormal.push("\t\tfirstDate: DateTime.parse('" + this.objetoJsonComentario.tipoControle.firstDate + "'),");
        }
        if (this.objetoJsonComentario.tipoControle.lastDate.includes("now") || this.objetoJsonComentario.tipoControle.firstDate == null && this.objetoJsonComentario.tipoControle.firstDate == '') {
            this.inputNormal.push("\t\tlastDate: DateTime.now(),");
        } else {
            this.inputNormal.push("\t\tlastDate: DateTime.parse('" + this.objetoJsonComentario.tipoControle.lastDate + "'),");
        }
    }

    fecharDatePickerItem() {
        this.inputNormal.push("\t\t\t});");
        this.inputNormal.push("\t\t},");
        this.inputNormal.push("\t),");
        this.inputNormal.push("),");
    }

    arrumarImports() {
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