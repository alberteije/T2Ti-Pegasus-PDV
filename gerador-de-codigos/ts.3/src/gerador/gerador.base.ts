import * as fs from "fs";
import * as lodash from "lodash";
import { TabelaService } from '../service/tabela.service';
import { CamposModel } from '../model/campos.model';
import { ComentarioDerJsonModel } from '../model/comentario.der.json.model';
import { ComentarioDerJsonParaCampo, DropDownButtonItem } from '../model/comentario.der.json.para.campo';
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


    /// serve parar gerar o comentário JSON direto no campo da tabela
    async gerarComentarioJSON(tabela: string, result: (retorno: any, erro: any) => void) {
        let retorno = "Nada foi processado.";

        try {
            // pega os dados dos campos da tabela
            let listaCampos = await TabelaService.pegarCampos(tabela);
            // remove o ID para ficar igual ao array de definição que será criado logo mais abaixo
            listaCampos.splice(0, 1);
            this.dataPacket = listaCampos;

            // pega a definição da tabela
            let listaDefinicao = await TabelaService.pegarDefinicao(tabela);
            let definicao = listaDefinicao[0]["Create Table"];

            let definicaoCampo = [];
            // separa a definição no array
            definicaoCampo = definicao.split("\n"); 
            // remove as primeiras linhas - abertura e ID
            definicaoCampo.splice(0, 2);
            // remove as duas últimas linhas - fechamento e indices
            definicaoCampo.splice(listaCampos.length, definicaoCampo.length-listaCampos.length);

            let modificacaoCampo = [];
            let objetoJsonComentario: ComentarioDerJsonParaCampo;

            // controla a linha do bootstrap
            let valorLinhaBootstrap = 1;

            for (let i = 0; i < definicaoCampo.length; i++) {
                // remover os espaços no começo do nome
                definicaoCampo[i] = definicaoCampo[i].trim();

                // remover os simbolos `
                definicaoCampo[i] = definicaoCampo[i].split("`").join("");

                // verifica se o comentário é uma string json
                if (Biblioteca.isJsonString(tabela, this.dataPacket[i].Comment)) {
                    objetoJsonComentario = new ComentarioDerJsonParaCampo(this.dataPacket[i].Comment);

                    // só faz alguma coisa se o tipo de controle for diferente de nulo
                    if (objetoJsonComentario.tipoControle != undefined && objetoJsonComentario.tipoControle != null) {
                        // se não houver nada relacionado ao bootstrap, adiciona
                        if (objetoJsonComentario.sizesBootstrap === undefined) {
                            objetoJsonComentario.linhaBootstrap = valorLinhaBootstrap++;
                            objetoJsonComentario.colunaBootstrap = 1;
                            objetoJsonComentario.sizesBootstrap = "col-12";

                            let pos = definicaoCampo[i].indexOf('COMMENT');
                            let sqlAlteracao = " MODIFY COLUMN " + definicaoCampo[i].substring(0, pos) + "COMMENT '" + JSON.stringify(objetoJsonComentario) + "'";
            
                            modificacaoCampo.push(sqlAlteracao);
                        }
                    }
                } else { // caso não seja um objeto JSON, não existe comentário ainda para o campo
                    objetoJsonComentario = new ComentarioDerJsonParaCampo("{}");

                    let campo = this.dataPacket[i].Field;

                    if (campo.includes("ID_") && campo.includes("_CAB")) { // tabela de detalhe
                        objetoJsonComentario.cardinalidade = "@OneToMany";
                        objetoJsonComentario.crud = "CRUD";        
                        objetoJsonComentario.side = "Inverse";
                        objetoJsonComentario.cascade = true;
                        objetoJsonComentario.orphanRemoval = true;
                        objetoJsonComentario.obrigatorio = false;
                        objetoJsonComentario.tipoControle = null;
                        definicaoCampo[i] = definicaoCampo[i].substring(0, definicaoCampo[i].length-1); //remove a virgula final
                        modificacaoCampo.push(" MODIFY COLUMN " + definicaoCampo[i] + " COMMENT '" + JSON.stringify(objetoJsonComentario) + "'");
                    } else {
                        let mascara = "";
                        let validacao = "";
                        let teclado = "";
    
                        if (this.dataPacket[i].Type == "varchar" || this.dataPacket[i].Type == "char") {
                            if (campo.includes("CPF")) {
                                validacao = "CPF";
                                mascara = "CPF";
                            } else if (campo.includes("CNPJ")) {
                                validacao = "CNPJ";
                                mascara = "CNPJ";
                            } else if (campo.includes("DIA")) {
                                validacao = "DIA";
                                mascara = "DIA";
                            } else if (campo.includes("MES")) {
                                validacao = "MES";
                                mascara = "MES";
                            } else if (campo.includes("ANO")) {
                                validacao = "ANO";
                                mascara = "ANO";
                            } else if (campo.includes("FONE") || campo.includes("CELULAR") || campo.includes("FAX")) {
                                mascara = "TELEFONE";
                                teclado = "phone";
                            } else if (campo.includes("HORA")) {
                                mascara = "HORA";
                            } else if (campo.includes("CEP")) {
                                mascara = "CEP";
                            } else if (campo.includes("EMAIL")) {
                                teclado = "emailAddress";
                            } else if (campo.includes("URL")) {
                                teclado = "url";
                            }
                        } else if (this.dataPacket[i].Type == "decimal") {
                            if (campo.includes("QUANTIDADE") || campo.includes("QTDE")) {
                                mascara = "QUANTIDADE";
                            } else if (campo.includes("TAXA") || campo.includes("PERCENT") || campo.includes("ALIQUOTA") || campo.includes("PORCENT")) {
                                mascara = "TAXA";
                            } else {
                                mascara = "VALOR";
                            }
                        } else if (this.dataPacket[i].Type == "date" || this.dataPacket[i].Type == "timestamp") {
                            mascara = "dd/MM/yyyy";
                        }
    
                        if (campo.includes("ID_")) { // lookups
                            let tabelaPai =  campo.substring(3, campo.length);
                            objetoJsonComentario.cardinalidade = "@OneToOne";
                            objetoJsonComentario.crud = "R";        
                            objetoJsonComentario.side = "Local";
                            objetoJsonComentario.campoLookup = "nome";
                            objetoJsonComentario.tabelaLookup = tabelaPai;
                            objetoJsonComentario.campoLookupTipoDado = "";
                            objetoJsonComentario.valorPadraoLookup = "";
                            objetoJsonComentario.readOnly = true;
                        } else {
                            objetoJsonComentario.cardinalidade = "";
                            objetoJsonComentario.crud = "";        
                            objetoJsonComentario.side = "";
                            objetoJsonComentario.campoLookup = "";
                            objetoJsonComentario.tabelaLookup = "";
                            objetoJsonComentario.campoLookupTipoDado = "";
                            objetoJsonComentario.valorPadraoLookup = "";
                            objetoJsonComentario.readOnly = false;
                        }
    
                        objetoJsonComentario.cascade = false;
                        objetoJsonComentario.orphanRemoval = false;
    
                        // formatando o nome do campo para aparecer em labels e afins
                        let campoFormatado = lodash.camelCase(campo);
                        campoFormatado = lodash.upperFirst(campoFormatado);
                        campoFormatado = lodash.startCase(campoFormatado);
    
                        objetoJsonComentario.label = campoFormatado;
                        objetoJsonComentario.labelText = campoFormatado;
                        objetoJsonComentario.tooltip = "Conteúdo para o campo " + campoFormatado;
                        objetoJsonComentario.hintText = "Conteúdo para o campo " + campoFormatado;
    
                        objetoJsonComentario.validacao = validacao; 
    
                        objetoJsonComentario.obrigatorio = false;
                        if (this.dataPacket[i].Null === "NO") {
                            objetoJsonComentario.obrigatorio = true;
                        }
    
                        objetoJsonComentario.desenhaControle = true;
                        objetoJsonComentario.comentario = this.dataPacket[i].Comment;
                        objetoJsonComentario.linhaBootstrap = valorLinhaBootstrap++;
                        objetoJsonComentario.colunaBootstrap = 1;
                        objetoJsonComentario.sizesBootstrap = "col-12";
    
                        if (this.dataPacket[i].Type == "date" || this.dataPacket[i].Type == "timestamp") {
                            objetoJsonComentario.tipoControle.tipo = "datePickerItem";            
                            objetoJsonComentario.tipoControle.firstDate = "1900-01-01";            
                            objetoJsonComentario.tipoControle.lastDate = "now";            
                            objetoJsonComentario.tipoControle.mascara = mascara;            
                        } else if (this.dataPacket[i].Type == "char(1)") {
                            // se o campo for char(1) vamos gerar por padrão um dropDown com Sim e Não - deve-se alterar posteriormente para os itens corretos de acordo com o comentário que já está no campo ou com os requisitos
                            objetoJsonComentario.tipoControle.tipo = "dropDownButton";            
                            objetoJsonComentario.tipoControle.persiste = "char";            
                            objetoJsonComentario.tipoControle.valorPadrao = "";   
                            let dropSim = new DropDownButtonItem();
                            dropSim.dropDownButtonItem = "Sim";
                            objetoJsonComentario.tipoControle.itens.push(dropSim);
                            let dropNao = new DropDownButtonItem();
                            dropNao.dropDownButtonItem = "Não";
                            objetoJsonComentario.tipoControle.itens.push(dropNao);
                        } else {
                            objetoJsonComentario.tipoControle.tipo = "textFormField";            
                            objetoJsonComentario.tipoControle.keyboardType = teclado;            
                            objetoJsonComentario.tipoControle.mascara = mascara;            
                        }                        

                        let sqlAlteracao = "";
                        let pos = definicaoCampo[i].indexOf('COMMENT');
                        if (pos === -1) {
                            // se não tiver comentário remove a virgula final
                            definicaoCampo[i] = definicaoCampo[i].substring(0, definicaoCampo[i].length-1);
                            sqlAlteracao = " MODIFY COLUMN " + definicaoCampo[i] + " COMMENT '" + JSON.stringify(objetoJsonComentario) + "'";
                        } else {
                            sqlAlteracao = " MODIFY COLUMN " + definicaoCampo[i].substring(0, pos) + " COMMENT '" + JSON.stringify(objetoJsonComentario) + "'";
                        }
        
                        modificacaoCampo.push(sqlAlteracao);
                    }
                }   

            }

            // monta a consulta SQL
            if (modificacaoCampo.length > 0) {
                let sqlAlterTable = "ALTER TABLE " + tabela + " ";
                for (let i = 0; i < modificacaoCampo.length; i++) {
                    sqlAlterTable = sqlAlterTable + modificacaoCampo[i];
                    if (i+1 === modificacaoCampo.length) {
                        sqlAlterTable = sqlAlterTable + ";";
                    } else {
                        sqlAlterTable = sqlAlterTable + ", ";
                    }
                }
    
                // altera a tabela
                retorno = await TabelaService.gerarComentariosJSON(sqlAlterTable);    
            }
        } catch (erro) {
            result({ erro: "Ocorreu um erro durante o processo: " + erro }, null);
        }


        // retorna mensagem OK
        result({ mensagem: "Resultado do Processamento: " + JSON.stringify(retorno) }, null);
    }


}
