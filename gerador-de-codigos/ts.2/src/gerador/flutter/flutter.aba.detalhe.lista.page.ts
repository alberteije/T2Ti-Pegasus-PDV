import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { FlutterListaPageBase } from "./flutter.lista.page.base";
import { Biblioteca } from "../../util/biblioteca";

/// classe base que ajuda a gerar a ListaPage do Flutter usando o mustache
export class FlutterAbaDetalheListaPage extends FlutterListaPageBase {

    constructor(tabela: string, tabelaMestre: string, dataPacket: CamposModel[]) {
        super(tabela, tabelaMestre);

        // laço nos campos da tabela para montar a página
        for (let i = 0; i < dataPacket.length; i++) {
            super.definirDadosIniciais(dataPacket[i]);

            // pega o objeto JSON de comentário - se não houver, este campo não será renderizado na janela
            if (this.campoModel.Comment != '') {
                if (Biblioteca.isJsonString(tabela, this.campoModel.Comment)) {
                    try {
                        this.objetoJsonComentario = new ComentarioDerJsonModel(this.table, this.campoModel.Comment);

                        // se o objeto não contém o campo desenhaControle, o controle será desenhado mesmo assim, pois o padrão é 'true'
                        // se o objeto contém o campo desenhaControle e estiver marcado como true, desenha o widget
                        if (this.objetoJsonComentario.desenhaControle == null || this.objetoJsonComentario.desenhaControle == true) {
                            // define o campo de lookup
                            if (this.campoModel.nomeCampoTabela.includes('ID_')) {
                                if (this.objetoJsonComentario.campoLookup != null && this.objetoJsonComentario.campoLookup != '') {
                                    super.definirDadosDeLookup();
                                } else { // se for o ID da tabela mestre, não precisa exibir esse dado na grid de detalhe
                                    this.objetoJsonComentario.campoLookupComTabela = 'NAO';
                                }
                            }

                            // pega o tipo de dado
                            super.definirTipoDado();

                            // se o campoLookup for diferente de vazio, ele deve ser utilizado no lugar do campoAtributo
                            super.trocarAtributoPorLookup();

                            // DataColumn e DataCell
                            if (this.objetoJsonComentario.campoLookupComTabela != 'NAO') {
                                // DataColumn
                                if (this.campoModel.tipoDadoOrdenacao == 'num') {
                                    this.dataColumn.push("lista.add(DataColumn(numeric: true, label: Text('" + this.objetoJsonComentario.label + "')));");
                                } else {
                                    this.dataColumn.push("lista.add(DataColumn(label: Text('" + this.objetoJsonComentario.label + "')));");
                                }
            
                                // DataCell
                                super.definirDataCell(false, true);
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

}