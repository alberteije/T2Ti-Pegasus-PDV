import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { FlutterDetalhePageBase } from "./flutter.detalhe.page.base";
import { Biblioteca } from "../../util/biblioteca";

/// classe base que ajuda a gerar a DetalhePage do Flutter usando o mustache
export class FlutterAbaDetalheDetalhePage extends FlutterDetalhePageBase {

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
                            if (this.campoModel.nomeCampoTabela.includes('ID_')) {
                                if (this.objetoJsonComentario.campoLookup != null && this.objetoJsonComentario.campoLookup != '') {
                                    super.definirDadosDeLookup();
                                } else { // se for o ID da tabela mestre, não precisa exibir esse dado na grid de detalhe
                                    this.objetoJsonComentario.campoLookupComTabela = 'NAO';
                                }
                            }

                            // se o campoLookup for diferente de vazio, ele deve ser utilizado no lugar do campoAtributo
                            super.trocarAtributoPorLookup();

                            // listTileData
                            if (this.objetoJsonComentario.campoLookupComTabela != 'NAO') {
                                super.definirListTileData(true);
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