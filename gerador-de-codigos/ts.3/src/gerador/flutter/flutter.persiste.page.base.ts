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

    matrizBootstrap = []; // organiza as linhas e colunas do bootstrap para conseguirmos desenhar os controles na tela

    campoModel: CamposModel;
    objetoJsonComentario: ComentarioDerJsonModel;

    // controla os imports
    importLookup: boolean;
    importMascara: boolean;
    importValida: boolean;
    importDropdownLista: boolean;

    colunaBootstrapPossuiMaisDeUmSize: boolean; // utilizado para controlar a inserção do padding na coluna e a identação de algumas linhas
    completaEspacosFilhoPadding: string; // quando uma coluna Bootrstrap possui mais de um size, a mesma será filha de um padding e temos que identar com mais espaços

    campoSendoMontadoEhLookup: boolean; // verifica se o campo que está sendo montado no momento é um lookup

    defineFocoNaAbaFilha: boolean; // caso o usuário clique numa aba filha, o foco deve ser colocado no primeiro widget para permitir a detecção dos atalhos daquela aba

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

                        this.campoSendoMontadoEhLookup = this.objetoJsonComentario.campoLookup != null && this.objetoJsonComentario.campoLookup != '';

                        // se o objeto não contém o campo desenhaControle, o controle será desenhado mesmo assim, pois o padrão é 'true'
                        // se o objeto contém o campo desenhaControle e estiver marcado como true, desenha o widget
                        
                        // Caso o objeto não tenha os dados do bootstrap então o controle não será desenhado.
                        if (this.objetoJsonComentario.linhaBootstrap == null) {
                            this.objetoJsonComentario.desenhaControle = false;
                        }
                        
                        if (this.objetoJsonComentario.desenhaControle == null || this.objetoJsonComentario.desenhaControle == true) {
                            // define o campo de lookup
                            this.objetoJsonComentario.campoLookupComTabela = '';
                            if (this.campoSendoMontadoEhLookup) {
                                this.definirDadosDeLookup();
                                // variáveis Controller vinculadas aos inputs de lookup
                                this.inputController.push("final _importa" + this.objetoJsonComentario.classeMestre + "Controller = TextEditingController();");
                                if (this.campoModel.nomeCampoTabela.includes('ID_')) {
                                    this.inputController.push("_importa" + this.objetoJsonComentario.classeMestre + "Controller.text = widget." + this.objetoPrincipal + "?." + this.objetoJsonComentario.objetoMestre + "?." + this.objetoJsonComentario.campoLookup + " ?? '';");
                                } else { // se é um campo de lookup para simples consulta, não precisa vincular ao objeto mestre, pois o dado será persistido no campo da própria tabela
                                    this.inputController.push("_importa" + this.objetoJsonComentario.classeMestre + "Controller.text = widget." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " ?? '';");
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
                                    if (this.campoSendoMontadoEhLookup) { // monta o campo de lookup
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

    abrirLinhaBootstrap(linha: number) {
        // se não for a primeira linha já fecha a linha antes de iniciar uma nova linha
        if (linha > 1) {
            this.fecharLinhaBootstrap();
        }
        if (this.campoSendoMontadoEhLookup) {
            this.inputLookup.push("Divider(color: Colors.white,),");
            this.inputLookup.push("BootstrapRow(");
            this.inputLookup.push("  height: 60,");
            this.inputLookup.push("  children: <BootstrapCol>[");    
        } else {
            this.inputNormal.push("Divider(color: Colors.white,),");
            this.inputNormal.push("BootstrapRow(");
            this.inputNormal.push("  height: 60,");
            this.inputNormal.push("  children: <BootstrapCol>[");    
        }
    }

    fecharLinhaBootstrap() {
        if (this.campoSendoMontadoEhLookup) {
            this.inputLookup.push("  ],");
            this.inputLookup.push("),");
        } else {
            this.inputNormal.push("  ],");
            this.inputNormal.push("),");
        }
    }

    abrirColunaBootstrap() {
        this.colunaBootstrapPossuiMaisDeUmSize = false;

        if (this.campoSendoMontadoEhLookup) {
            this.inputLookup.push("    BootstrapCol(");
            this.inputLookup.push("      sizes: '" + this.objetoJsonComentario.sizesBootstrap + "',");

            // se houver mais do que um size, então tem que colocar o padding para controlar o espaço entre as colunas quando elas quebrarem de linha
            if (this.objetoJsonComentario.sizesBootstrap.includes(" ")) {
                this.inputLookup.push("      child: Padding(");
                this.inputLookup.push("        padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),");
                this.colunaBootstrapPossuiMaisDeUmSize = true;
            }
        } else {
            this.inputNormal.push("    BootstrapCol(");
            this.inputNormal.push("      sizes: '" + this.objetoJsonComentario.sizesBootstrap + "',");

            // se houver mais do que um size, então tem que colocar o padding para controlar o espaço entre as colunas quando elas quebrarem de linha
            if (this.objetoJsonComentario.sizesBootstrap.includes(" ")) {
                this.inputNormal.push("      child: Padding(");
                this.inputNormal.push("        padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),");
                this.colunaBootstrapPossuiMaisDeUmSize = true;
            }
        }
    }

    fecharColunaBootstrap() {
        if (this.campoSendoMontadoEhLookup) {
            if (this.colunaBootstrapPossuiMaisDeUmSize) {
                this.inputLookup.push("      ),");
                this.inputLookup.push("    ),");
            } else {
                this.inputLookup.push("    ),");
            }
        } else {
            if (this.colunaBootstrapPossuiMaisDeUmSize) {
                this.inputNormal.push("      ),");
                this.inputNormal.push("    ),");
            } else {
                this.inputNormal.push("    ),");
            }
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
                this.inputLookup.push("                  widget." + this.objetoPrincipal + "?." + this.objetoJsonComentario.campoLookupComTabela + " = int.tryParse(text);");
            } else {
                this.inputLookup.push("                  widget." + this.objetoPrincipal + "?." + this.objetoJsonComentario.campoLookupComTabela + " = text;");
            }
        } else { // se é um campo de lookup para simples consulta, não precisa vincular ao objeto mestre, pois o dado será persistido no campo da própria tabela
            if (this.objetoJsonComentario.campoLookupTipoDado == "int") {
                this.inputLookup.push("                  widget." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " = int.tryParse(text);");
            } else {
                this.inputLookup.push("                  widget." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " = text;");
            }
        }
        if (paginaDeAba) {
            this.inputLookup.push("            paginaMestreDetalheFoiAlterada = true;");
        } 
        if (controlaFormAlteradoLocal) {                                
            this.inputLookup.push("                  _formFoiAlterado = true;");
        }

        this.abrirCampoDeLookupExpanded();

        if (this.campoModel.nomeCampoTabela.includes('ID_')) {
            this.inputLookup.push("                    widget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " = _objetoJsonRetorno['id'];");
            this.inputLookup.push("                    widget." + this.objetoPrincipal + "." + this.objetoJsonComentario.objetoMestre + " = new " + this.objetoJsonComentario.classeMestre + ".fromJson(_objetoJsonRetorno);");
        } else { // se é um campo de lookup para simples consulta, não precisa vincular ao objeto mestre, pois o dado será persistido no campo da própria tabela
            this.inputLookup.push("                    widget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " = _objetoJsonRetorno['" + this.objetoJsonComentario.campoLookup + "'];");
        }

        this.fecharCampoDeLookup();
    }

    abrirCampoDeLookup() {
        this.inputLookup.push("      child: Row(");
        this.inputLookup.push("        children: <Widget>[");
        this.inputLookup.push("          Expanded(");
        this.inputLookup.push("            flex: 1,");
        this.inputLookup.push("            child: Container(");
        this.inputLookup.push("              child: TextFormField(");
        this.inputLookup.push("                controller: _importa" + this.objetoJsonComentario.classeMestre + "Controller,");
        if (this.defineFocoNaAbaFilha) {
            this.inputLookup.push("                focusNode: widget.foco,");
            this.inputLookup.push("                autofocus: true,");
        }
        this.inputLookup.push("                readOnly: true,");
        this.inputLookup.push("                decoration: getInputDecoration(");
        this.inputLookup.push("                  '" + this.objetoJsonComentario.hintText + "',");
        if (this.objetoJsonComentario.obrigatorio) {
            //this.objetoJsonComentario.valida = this.objetoJsonComentario.valida + 'Obrigatorio';
            this.objetoJsonComentario.validacao = 'Obrigatorio';
            this.inputLookup.push("                  '" + this.objetoJsonComentario.labelText + " *',");
        } else {
            this.inputLookup.push("                  '" + this.objetoJsonComentario.labelText + "',");
        }
        this.inputLookup.push("                  false),");
        this.inputLookup.push("                onSaved: (String value) {");
        this.inputLookup.push("                },");
        if (this.objetoJsonComentario.validacao != null && this.objetoJsonComentario.validacao != '') {
            this.importValida = true;
            this.objetoJsonComentario.valida = this.objetoJsonComentario.valida + this.objetoJsonComentario.validacao;
            this.inputLookup.push("                validator: ValidaCampoFormulario." + this.objetoJsonComentario.valida + ",");
        }
        this.inputLookup.push("                onChanged: (text) {");
    }

    abrirCampoDeLookupExpanded() {
        this.inputLookup.push("                },");
        this.inputLookup.push("              ),");
        this.inputLookup.push("            ),");
        this.inputLookup.push("          ),");
        this.inputLookup.push("          Expanded(");
        this.inputLookup.push("            flex: 0,");
        this.inputLookup.push("            child: IconButton(");
        this.inputLookup.push("              tooltip: 'Importar " + this.objetoJsonComentario.labelText + "',");
        this.inputLookup.push("              icon: ViewUtilLib.getIconBotaoLookup(),");
        this.inputLookup.push("              onPressed: () async {");
        this.inputLookup.push("                ///chamando o lookup");
        this.inputLookup.push("                Map<String, dynamic> _objetoJsonRetorno =");
        this.inputLookup.push("                  await Navigator.push(");
        this.inputLookup.push("                    context,");
        this.inputLookup.push("                    MaterialPageRoute(");
        this.inputLookup.push("                      builder: (BuildContext context) =>");
        this.inputLookup.push("                        LookupPage(");
        this.inputLookup.push("                          title: 'Importar " + this.objetoJsonComentario.labelText + "',");
        this.inputLookup.push("                          colunas: " + this.objetoJsonComentario.classeMestre + ".colunas,");
        this.inputLookup.push("                          campos: " + this.objetoJsonComentario.classeMestre + ".campos,");
        this.inputLookup.push("                          rota: '/" + lodash.replace(this.objetoJsonComentario.tabelaMestre.toLowerCase(), new RegExp("_", "g"), "-") + "/',");
        this.inputLookup.push("                          campoPesquisaPadrao: '" + this.objetoJsonComentario.campoLookup + "',");
        this.inputLookup.push("                          valorPesquisaPadrao: '" + this.objetoJsonComentario.valorPadraoLookup + "',");
        this.inputLookup.push("                        ),");
        this.inputLookup.push("                        fullscreenDialog: true,");
        this.inputLookup.push("                      ));");
        this.inputLookup.push("                if (_objetoJsonRetorno != null) {");
        this.inputLookup.push("                  if (_objetoJsonRetorno['" + this.objetoJsonComentario.campoLookup + "'] != null) {");
        this.inputLookup.push("                    _importa" + this.objetoJsonComentario.classeMestre + "Controller.text = _objetoJsonRetorno['" + this.objetoJsonComentario.campoLookup + "'];");
    }

    fecharCampoDeLookup() {
        this.inputLookup.push("                  }");
        this.inputLookup.push("                }");
        this.inputLookup.push("              },");
        this.inputLookup.push("            ),");
        this.inputLookup.push("          ),");
        this.inputLookup.push("        ],");
        this.inputLookup.push("      ),");
    }

    montarTextFormFieldPadrao(paginaDeAba: boolean, controlaFormAlteradoLocal: boolean) {
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
                this.inputController.push("final _" + this.campoModel.nomeCampoAtributo + "Controller = MoneyMaskedTextController(precision: Constantes." + casasDecimais + ", initialValue: widget." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " ?? 0);");
            } else {
                this.inputController.push("final _" + this.campoModel.nomeCampoAtributo + "Controller = MaskedTextController(")
                this.inputController.push("  mask: Constantes.mascara" + this.objetoJsonComentario.tipoControle.mascara + ",")
                this.inputController.push("  text: widget." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " ?? '',")
                this.inputController.push(");")
            }

            // utilização do controller
            this.inputNormal.push(this.completaEspacosFilhoPadding + "        controller: _" + this.campoModel.nomeCampoAtributo + "Controller,");

            // define o maxLength
            let mascara = this.objetoJsonComentario.tipoControle.mascara;
            if (mascara != 'VALOR' && mascara != 'TAXA' && mascara != 'EEE, d / MMM / yyyy' && mascara != 'QUANTIDADE') {
                this.inputNormal.push(this.completaEspacosFilhoPadding + "        maxLength: Constantes.mascara" + this.objetoJsonComentario.tipoControle.mascara + ".length,");
            }
        } else {
            if (this.campoModel.tamanhoCampo.toString() != 'NaN') {
                this.inputNormal.push(this.completaEspacosFilhoPadding + "        maxLength: " + this.campoModel.tamanhoCampo + ",");
            } else {
                this.inputNormal.push(this.completaEspacosFilhoPadding + "        maxLength: 10,");
            }
            
            this.inputNormal.push(this.completaEspacosFilhoPadding + "        maxLines: " + this.campoModel.quantidadeLinhas + ",");
            if (this.campoModel.tipoCampo.includes('int')) {
                this.inputNormal.push(this.completaEspacosFilhoPadding + "        initialValue: widget." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + "?.toString() ?? '',");
            } else {
                this.inputNormal.push(this.completaEspacosFilhoPadding + "        initialValue: widget." + this.objetoPrincipal + "?." + this.campoModel.nomeCampoAtributo + " ?? '',");
            }
        }

        this.abrirTextFormFieldPadraoValidacao();

        if (this.campoModel.tipoCampo.includes('decimal')) {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "          widget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " = _" + this.campoModel.nomeCampoAtributo + "Controller.numberValue;");
        } else if (this.campoModel.tipoCampo.includes('int')) {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "          widget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " = int.tryParse(text);");
        } else {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "          widget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " = text;");
        }
        if (paginaDeAba) {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "          paginaMestreDetalheFoiAlterada = true;");
        } 
        if (controlaFormAlteradoLocal) {                                
            this.inputNormal.push(this.completaEspacosFilhoPadding + "          _formFoiAlterado = true;");
        }

        this.fecharTextFormFieldPadrao();
    }

    abrirTextFormFieldPadrao() {
        this.inputNormal.push(this.completaEspacosFilhoPadding + "      child: TextFormField(");
        if (this.objetoJsonComentario.tipoControle.keyboardType != null && this.objetoJsonComentario.tipoControle.keyboardType != '') {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "        keyboardType: TextInputType." + this.objetoJsonComentario.tipoControle.keyboardType + ",");
        }
        if (this.objetoJsonComentario.readOnly) {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "        readOnly: true,");
        }
        if (this.defineFocoNaAbaFilha) {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "        focusNode: widget.foco,");
            this.inputNormal.push(this.completaEspacosFilhoPadding + "        autofocus: true,");
        }
        if (this.campoModel.tipoCampo.includes('decimal')) {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "        textAlign: TextAlign.end,");
        }
    }

    abrirTextFormFieldPadraoValidacao() {
        this.inputNormal.push(this.completaEspacosFilhoPadding + "        decoration: getInputDecoration(");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "          '" + this.objetoJsonComentario.hintText + "',");
        if (this.objetoJsonComentario.obrigatorio) {
            //this.objetoJsonComentario.valida = this.objetoJsonComentario.valida + 'Obrigatorio';
            this.objetoJsonComentario.validacao = 'Obrigatorio';
            this.inputNormal.push(this.completaEspacosFilhoPadding + "          '" + this.objetoJsonComentario.labelText + " *',");
        } else {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "          '" + this.objetoJsonComentario.labelText + "',");
        }
        this.inputNormal.push(this.completaEspacosFilhoPadding + "          false),");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "        onSaved: (String value) {");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "        },");
        if (this.objetoJsonComentario.validacao != null && this.objetoJsonComentario.validacao != '') {
            this.importValida = true;
            if (this.campoModel.tipoCampo.includes('decimal')) {
                this.objetoJsonComentario.valida = this.objetoJsonComentario.valida + "ObrigatorioDecimal";
            } else {
                this.objetoJsonComentario.valida = this.objetoJsonComentario.valida + this.objetoJsonComentario.validacao;
            }
            this.inputNormal.push(this.completaEspacosFilhoPadding + "        validator: ValidaCampoFormulario." + this.objetoJsonComentario.valida + ",");
        }
        this.inputNormal.push(this.completaEspacosFilhoPadding + "        onChanged: (text) {");
    }

    fecharTextFormFieldPadrao() {
        this.inputNormal.push(this.completaEspacosFilhoPadding + "        },");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "      ),");
    }

    montarDropDownButton(paginaDeAba: boolean) {
        this.completaEspacosFilhoPadding = "";
        if (this.colunaBootstrapPossuiMaisDeUmSize) {
            this.completaEspacosFilhoPadding = "  ";
        }

        this.abrirDropDownButton();

        this.inputNormal.push(this.completaEspacosFilhoPadding + "        isEmpty: widget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " == null,");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "        child: getDropDownButton(widget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + ",");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "          (String newValue) {");
        if (paginaDeAba) {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "            paginaMestreDetalheFoiAlterada = true;");
        }
        this.inputNormal.push(this.completaEspacosFilhoPadding + "            setState(() {");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "              widget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " = newValue;");

        this.fecharDropDownButton();
    }

    abrirDropDownButton() {
        this.inputNormal.push(this.completaEspacosFilhoPadding + "      child: InputDecorator(");
        if (this.defineFocoNaAbaFilha) {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "        focusNode: widget.foco,");
            this.inputNormal.push(this.completaEspacosFilhoPadding + "        autofocus: true,");
        }
        this.inputNormal.push(this.completaEspacosFilhoPadding + "        decoration: getInputDecoration(");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "          '" + this.objetoJsonComentario.hintText + "',");
        if (this.objetoJsonComentario.obrigatorio) {
            this.objetoJsonComentario.valida = this.objetoJsonComentario.valida + 'Obrigatorio';
            this.inputNormal.push(this.completaEspacosFilhoPadding + "          '" + this.objetoJsonComentario.labelText + " *',");
        } else {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "          '" + this.objetoJsonComentario.labelText + "',");
        }
        this.inputNormal.push(this.completaEspacosFilhoPadding + "          true),");
    }

    fecharDropDownButton() {
        this.inputNormal.push(this.completaEspacosFilhoPadding + "            });");
        if (this.objetoJsonComentario.tipoControle.persiste == 'valor') {
            this.importDropdownLista = true;
            this.inputNormal.push(this.completaEspacosFilhoPadding + "        }, DropdownLista." + this.objetoJsonComentario.tipoControle.itens[0].dropDownButtonItem + ")),");
        } else {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "        }, <String>[");
            for (let i = 0; i < this.objetoJsonComentario.tipoControle.itens.length; i++) {
                this.inputNormal.push(this.completaEspacosFilhoPadding + "          '" + this.objetoJsonComentario.tipoControle.itens[i].dropDownButtonItem + "',");
            }
            this.inputNormal.push(this.completaEspacosFilhoPadding + "      ])),");    
        }
    }

    montarDatePickerItem(paginaDeAba: boolean) {
        this.completaEspacosFilhoPadding = "";
        if (this.colunaBootstrapPossuiMaisDeUmSize) {
            this.completaEspacosFilhoPadding = "  ";
        }

        this.abrirDatePickerItem();

        this.inputNormal.push(this.completaEspacosFilhoPadding + "        isEmpty: widget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " == null,");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "        child: DatePickerItem(");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "          dateTime: widget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + ",");

        this.abrirDatePickerItemFistLastDate();

        this.inputNormal.push(this.completaEspacosFilhoPadding + "          onChanged: (DateTime value) {");
        if (paginaDeAba) {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "            paginaMestreDetalheFoiAlterada = true;");
        }
        this.inputNormal.push(this.completaEspacosFilhoPadding + "            setState(() {");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "              widget." + this.objetoPrincipal + "." + this.campoModel.nomeCampoAtributo + " = value;");

        this.fecharDatePickerItem();
    }

    abrirDatePickerItem() {
        this.inputNormal.push(this.completaEspacosFilhoPadding + "      child: InputDecorator(");
        if (this.defineFocoNaAbaFilha) { 
            /* 
            OBS: esse controle não recebe foco, então quando ocorrer de o formulário ser aberto com esse tipo de controle, 
            vai aparecer um erro em tempo de projeto. O objetivo é chamar atenção do desenvolvedor para que o mesmo mova o 
            código para o próximo controle que possa receber foco, caso exista.
            */
            this.inputNormal.push(this.completaEspacosFilhoPadding + "        focusNode: widget.foco,");
            this.inputNormal.push(this.completaEspacosFilhoPadding + "        autofocus: true,");
        }
        this.inputNormal.push(this.completaEspacosFilhoPadding + "        decoration: getInputDecoration(");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "          '" + this.objetoJsonComentario.hintText + "',");
        if (this.objetoJsonComentario.obrigatorio) {
            this.objetoJsonComentario.valida = this.objetoJsonComentario.valida + 'Obrigatorio';
            this.inputNormal.push(this.completaEspacosFilhoPadding + "          '" + this.objetoJsonComentario.labelText + " *',");
        } else {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "          '" + this.objetoJsonComentario.labelText + "',");
        }
        this.inputNormal.push(this.completaEspacosFilhoPadding + "          true),");
    }

    abrirDatePickerItemFistLastDate() {
        if (this.objetoJsonComentario.tipoControle.firstDate.includes("now") || this.objetoJsonComentario.tipoControle.firstDate == null && this.objetoJsonComentario.tipoControle.firstDate == '') {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "          firstDate: DateTime.now(),");
        } else {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "          firstDate: DateTime.parse('" + this.objetoJsonComentario.tipoControle.firstDate + "'),");
        }
        if (this.objetoJsonComentario.tipoControle.lastDate.includes("now") || this.objetoJsonComentario.tipoControle.firstDate == null && this.objetoJsonComentario.tipoControle.firstDate == '') {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "          lastDate: DateTime.now(),");
        } else {
            this.inputNormal.push(this.completaEspacosFilhoPadding + "          lastDate: DateTime.parse('" + this.objetoJsonComentario.tipoControle.lastDate + "'),");
        }
    }

    fecharDatePickerItem() {
        this.inputNormal.push(this.completaEspacosFilhoPadding + "            });");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "          },");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "        ),");
        this.inputNormal.push(this.completaEspacosFilhoPadding + "      ),");
    }

    arrumarImports() {
        if (this.importLookup) {
            this.imports.push("import 'package:fenix/src/view/shared/page/lookup_page.dart';")
        }
        if (this.importMascara) {
            this.imports.push("import 'package:flutter_masked_text/flutter_masked_text.dart';")
        }
        if (this.importValida) {
            this.imports.push("import 'package:fenix/src/infra/valida_campo_formulario.dart';")
        }
        if (this.importDropdownLista) {
            this.imports.push("import 'package:fenix/src/view/shared/dropdown_lista.dart';")
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