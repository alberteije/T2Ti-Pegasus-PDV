import * as fs from "fs";
import { TabelaService } from '../service/tabela.service';
import { CamposModel } from '../model/campos.model';
import { ComentarioDerJsonModel } from '../model/comentario.der.json.model';
import { Biblioteca } from "../util/biblioteca";

export class GeradorBase {

    tabela: string;
    tabelaAgregada: string;
    modulo: string;
    dataPacket: CamposModel[];
    relacionamentos: ComentarioDerJsonModel[];
    listaTabelas = [];

    constructor() { }

    /**
      * Cria o diretório que armazenará os arquivos (código fonte gerado) da tabela selecionada
      */
    async criarDiretorio(caminho: string) {
        try {
            if (!fs.existsSync(caminho)) {
                fs.mkdirSync(caminho);
            }
            return true;
        } catch (erro) {
            return erro;
        }
    }

    /**
      * Salva o arquivo no disco
      */
    async gravarArquivo(caminho: string, conteudo: any) {
        fs.writeFile(caminho, conteudo, function (erro: any) {
            if (erro) {
                return erro;
            } else {
                return true;
            }
        });
    }

    /**
     * Pega as colunas de determinada tabela e atribui ao datapacket (variável de classe)
     */
    async pegarCampos(tabela: string) {
        try {
            let lista = await TabelaService.pegarCampos(tabela);
            this.dataPacket = lista;

            // verifica se a tabela que está sendo utilizada neste momento é diferente da tabela principal
            // aqui geramos apenas os relacionamentos agregados onde a FK se encontra em uma outra tabela diferente da principal
            // esses relacionamentos serão utilizados apenas para a geração da classe principal
            // todo e qualquer relacionamento (objeto na classe filha) será tratado dentro do gerador do model
            if (tabela != this.tabela) {
                // monta o nome do campo: Ex: ID_PESSOA
                let nomeCampoFK = 'ID_' + this.tabela.toUpperCase();

                // verifica se o campo FK contem algum comentário para inserir como relacionamento
                for (let i = 0; i < lista.length; i++) {
                    if (lista[i].Field == nomeCampoFK && lista[i].Comment != '') {
                        if (Biblioteca.isJsonString(tabela, lista[i].Comment)) {
                            let objeto = new ComentarioDerJsonModel(tabela, lista[i].Comment, this.tabela);
                            // vamos inserir apenas os relacionamentos cujo Side não seja 'Local', pois esses serão encontrados e tratados no Model
                            if (objeto.side != 'Local') {
                                this.relacionamentos.push(objeto);
                            }
                        }
                    }
                }
            }
            return true;
        } catch (erro) {
            return erro;
        }
    }

}
