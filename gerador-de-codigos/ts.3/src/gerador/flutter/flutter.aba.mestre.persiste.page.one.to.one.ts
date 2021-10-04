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
                    if (this.objetoJsonComentario.linhaBootstrap != null) {
                        this.matrizBootstrap.push({
                            campo: this.campoModel.nomeCampoTabela, 
                            linha: this.objetoJsonComentario.linhaBootstrap, 
                            coluna: this.objetoJsonComentario.colunaBootstrap, 
                            juncao: this.objetoJsonComentario.linhaBootstrap?.toString() + this.objetoJsonComentario.colunaBootstrap?.toString(),
                        });
                    }
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

                this.defineFocoNaAbaFilha = false;
                if (this.matrizBootstrap[i].juncao == 11) {
                    this.defineFocoNaAbaFilha = true;
                }

                this.definirDadosIniciais(colunaBancoDados);
                if (Biblioteca.isJsonString(this.table, this.campoModel.Comment)) {
                    try {
                        this.objetoJsonComentario = new ComentarioDerJsonModel(this.table, colunaBancoDados.Comment);

                        this.campoSendoMontadoEhLookup = this.objetoJsonComentario.campoLookup != null && this.objetoJsonComentario.campoLookup != '';

                        // se o objeto não contém o campo desenhaControle, o controle será desenhado mesmo assim, pois o padrão é 'true'
                        // se o objeto contém o campo desenhaControle e estiver marcado como true, desenha o widget
                        if ((this.objetoJsonComentario.desenhaControle == null || this.objetoJsonComentario.desenhaControle == true) && this.objetoJsonComentario.linhaBootstrap != null) {
                            // define o campo de lookup
                            this.objetoJsonComentario.campoLookupComTabela = '';
                            if (this.campoSendoMontadoEhLookup) {
                                this.definirDadosDeLookup();
                                // variáveis Controller vinculadas aos inputs de lookup
                                this.inputController.push("var _importa" + this.objetoJsonComentario.classeMestre + "Controller = TextEditingController();");
                                if (this.campoModel.nomeCampoTabela.includes('ID_')) {
                                    this.inputController.push("_importa" + this.objetoJsonComentario.classeMestre + "Controller.text = widget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.objetoJsonComentario.objetoMestre + "?." + this.objetoJsonComentario.campoLookup + " ?? '';");
                                } else { // se é um campo de lookup para simples consulta, não precisa vincular ao objeto mestre, pois o dado será persistido no campo da própria tabela
                                    this.inputController.push("_importa" + this.objetoJsonComentario.classeMestre + "Controller.text = widget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " ?? '';");
                                }
                            }

                            // se a linha atual é diferente da linha anterior, deve-se abrir uma nova linha no bootstrap
                            if (this.matrizBootstrap[i].linha != this.matrizBootstrap[i-1].linha) {
                                // abrir linha bootstrap 
                                this.abrirLinhaBootstrap(this.matrizBootstrap[i].linha);
                            }

                            // abrir coluna bootstrap 
                            this.abrirColunaBootstrap();

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

    montarCampoComLookup() {
        this.abrirCampoDeLookup();

        if (this.campoModel.nomeCampoTabela.includes('ID_')) {    
            if (this.objetoJsonComentario.campoLookupTipoDado == "int") {
                this.inputLookup.push("                  widget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.objetoJsonComentario.campoLookupComTabela + " = int.tryParse(text);");
            } else {
                this.inputLookup.push("                  widget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.objetoJsonComentario.campoLookupComTabela + " = text;");
            }
        } else { // se é um campo de lookup para simples consulta, não precisa vincular ao objeto mestre, pois o dado será persistido no campo da própria tabela
            if (this.objetoJsonComentario.campoLookupTipoDado == "int") {
                this.inputLookup.push("                  widget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " = int.tryParse(text);");
            } else {
                this.inputLookup.push("                  widget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " = text;");
            }
        }
        this.inputLookup.push("                  paginaMestreDetalheFoiAlterada = true;");

        this.abrirCampoDeLookupExpanded();

        if (this.campoModel.nomeCampoTabela.includes('ID_')) {
            this.inputLookup.push("                    widget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " = _objetoJsonRetorno['id'];");
            //this.inputLookup.push("                    widget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.objetoJsonComentario.objetoMestre + " = new " + this.objetoJsonComentario.classeMestre + ".fromJson(_objetoJsonRetorno);");
            this.inputLookup.push("                    widget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.objetoJsonComentario.objetoMestre + " = " + this.objetoJsonComentario.classeMestre + ".fromJson(_objetoJsonRetorno);");
        } else { // se é um campo de lookup para simples consulta, não precisa vincular ao objeto mestre, pois o dado será persistido no campo da própria tabela
            this.inputLookup.push("                    widget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " = _objetoJsonRetorno['" + this.objetoJsonComentario.campoLookup + "'];");
        }

        this.fecharCampoDeLookup();
    }

    montarTextFormFieldPadrao() {
        this.completaEspacosFilhoPadding = "";
        if (this.colunaBootstrapPossuiMaisDeUmSize) {
            this.completaEspacosFilhoPadding = "  ";
        }

        this.abrirTextFormFieldPadrao();

        if (this.objetoJsonComentario.tipoControle.mascara != '' && this.objetoJsonComentario.tipoControle.mascara != null) {
            this.importMascara = true;

            // variável Controller
            if (this.campoModel.tipoCampo.includes('decimal')) {
                let casasDecimais = lodash.camelCase("decimais" + this.objetoJsonComentario.tipoControle.mascara);                
                this.inputController.push("var _" + this.campoModel.nomeCampoAtributo + "Controller = MoneyMaskedTextController(precision: Constantes." + casasDecimais + ", initialValue: widget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " ?? 0);");
            } else {
                this.inputController.push("var _" + this.campoModel.nomeCampoAtributo + "Controller = MaskedTextController(")
                this.inputController.push("  mask: Constantes.mascara" + this.objetoJsonComentario.tipoControle.mascara + ",")
                this.inputController.push("  text: widget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " ?? '',")
                this.inputController.push(");")
            }

            // utilização do controller
            this.inputNormal.push(this.completaEspacosFilhoPadding + "        controller: _" + this.campoModel.nomeCampoAtributo + "Controller,");
        } else {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "        maxLength: " + this.campoModel.tamanhoCampo + ",");
            this.inputNormal.push(this.completaEspacosFilhoPadding + "        maxLines: " + this.campoModel.quantidadeLinhas + ",");
            if (this.campoModel.tipoCampo.includes('int')) {
                this.inputNormal.push(this.completaEspacosFilhoPadding + "        initialValue: widget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + "?.toString() ?? '',");
            } else {
                this.inputNormal.push(this.completaEspacosFilhoPadding + "        initialValue: widget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " ?? '',");
            }
        }
 
        this.abrirTextFormFieldPadraoValidacao();

        if (this.campoModel.tipoCampo.includes('decimal')) {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "          widget." + this.objetoMestre + "." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " = _" + this.campoModel.nomeCampoAtributo + "Controller.numberValue;");
        } else if (this.campoModel.tipoCampo.includes('int')) {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "          widget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " = int.tryParse(text);");
        } else {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "          widget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " = text;");
        }                                
        this.inputNormal.push(this.completaEspacosFilhoPadding + "          paginaMestreDetalheFoiAlterada = true;");
 
        this.fecharTextFormFieldPadrao();
    }

    montarDropDownButton() {
        this.completaEspacosFilhoPadding = "";
        if (this.colunaBootstrapPossuiMaisDeUmSize) {
            this.completaEspacosFilhoPadding = "  ";
        }

        this.abrirDropDownButton();

        this.inputNormal.push(this.completaEspacosFilhoPadding + "        isEmpty: widget." + this.objetoMestre + "?." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " == null || widget." + this.objetoMestre + "?." + this.objetoPrincipal + " == null,");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "        child: getDropDownButton(widget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + ", (String newValue) {");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "          paginaMestreDetalheFoiAlterada = true;");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "          setState(() {");                                
        this.inputNormal.push(this.completaEspacosFilhoPadding + "            widget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " = newValue;");

        this.fecharDropDownButton();
    }

    montarDatePickerItem() {
        this.completaEspacosFilhoPadding = "";
        if (this.colunaBootstrapPossuiMaisDeUmSize) {
            this.completaEspacosFilhoPadding = "  ";
        }

        this.abrirDatePickerItem();

        this.inputNormal.push(this.completaEspacosFilhoPadding + "        isEmpty: widget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " == null,");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "        child: DatePickerItem(");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "          dateTime: widget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + ",");

        this.abrirDatePickerItemFistLastDate();

        this.inputNormal.push(this.completaEspacosFilhoPadding + "          onChanged: (DateTime value) {");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "            paginaMestreDetalheFoiAlterada = true;");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "            setState(() {");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "              widget." + this.objetoMestre + "." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " = value;");

        this.fecharDatePickerItem();
    }
}