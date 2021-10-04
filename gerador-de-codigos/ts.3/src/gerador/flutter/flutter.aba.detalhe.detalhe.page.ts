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

                            if (this.objetoJsonComentario.campoLookupComTabela != 'NAO') {
                                // se a linha atual é diferente da linha anterior, deve-se abrir uma nova linha no bootstrap
                                if (this.matrizBootstrap[i].linha != this.matrizBootstrap[i-1].linha) {
                                    // abrir linha bootstrap 
                                    this.abrirLinhaBootstrap(this.matrizBootstrap[i].linha);
                                }

                                // abrir coluna bootstrap 
                                this.abrirColunaBootstrap();

                                // listTileData
                                super.definirListTileData(true);

                                // fechar coluna bootstrap 
                                this.fecharColunaBootstrap();
                            }
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
        super.arrumarImports();
    }

}