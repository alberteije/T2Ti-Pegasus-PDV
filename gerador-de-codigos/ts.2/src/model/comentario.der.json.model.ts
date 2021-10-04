import * as lodash from "lodash";

export class ComentarioDerJsonModel {

    /**
     * Mais informações sobre essa classe podem ser encontradas no repositório, no documento
     * T2Ti ERP Fenix - Estrutura Objeto JSON Comentario DER.doc
     */
    cardinalidade: string;
    crud: string;
    create: boolean; //[C]RUD
    read: boolean;   //C[R]UD
    update: boolean; //CR[U]D
    delete: boolean; //CRU[D]
    /**
     * Local: cria um objeto da classe pai (mestre) na classe filha (detalhe) apenas
     * Inverse: cria um objeto (@OneToOne) ou uma lista (@OneToMany) na classe pai (mestre)
     */
    side: string;
    cascade: boolean;
    obrigatorio: boolean;
    orphanRemoval: boolean;
    label: string;
    labelText: string;
    validacao: string;
    tooltip: string;
    hintText: string;
    campoLookup: string;
    tabelaLookup: string; 
    campoLookupTipoDado: string;
    valorPadraoLookup: string;
    readOnly: boolean;
    desenhaControle: boolean;
    tipoControle: TipoControle; 

    // os dados abaixo não vem do DER, são gerados pelo Gerador
    tabela: string; // ex: BANCO_AGENCIA
    tabelaMestre: string; // ex: BANCO 
    classeMestre: string; // ex: Banco
    objetoMestre: string; // ex: banco - no caso de um campo de lookup que busca dados em uma tabela de consulta (CEP, por exemplo), o objetoMestre não é, necessariamente, o pai de um relacionamento mestre/detalhe
    campoLookupComTabela: string; // é a concatenação de objetoMestre + campoLookup - ex: 'banco.nome'    
    valida: string; // monta a string da validação: validaCPF, validaCNPJ, validaObrigatorio, etc

    constructor(tabela: string, objetoJson: string, tabelaMestre?: string) {
        this.tabela = tabela;
        this.tabelaMestre = tabelaMestre;
        this.objetoMestre = lodash.camelCase(tabelaMestre);
        this.classeMestre = lodash.upperFirst(this.objetoMestre);

        let objeto = JSON.parse(objetoJson);

        this.cardinalidade = objeto["cardinalidade"];

        this.crud = objeto["crud"];
        this.create = this.crud.includes('C') ? true : false;
        this.read = this.crud.includes('R') ? true : false;
        this.update = this.crud.includes('U') ? true : false;
        this.delete = this.crud.includes('D') ? true : false;
        
        this.side = objeto["side"];
        this.cascade = objeto["cascade"];
        this.obrigatorio = objeto["obrigatorio"];
        this.orphanRemoval = objeto["orphanRemoval"];
        this.label = objeto["label"];
        this.labelText = objeto["labelText"];
        this.validacao = objeto["validacao"];
        this.tooltip = objeto["tooltip"];
        this.hintText = objeto["hintText"];
        this.tipoControle = objeto["tipoControle"];
        this.campoLookup = objeto["campoLookup"];
        this.tabelaLookup = objeto["tabelaLookup"];
        this.campoLookupTipoDado = objeto["campoLookupTipoDado"];
        this.valorPadraoLookup = objeto["valorPadraoLookup"];
        this.readOnly = objeto["readOnly"];
        this.desenhaControle = objeto["desenhaControle"];
    }

}

class TipoControle {
    tipo: string;
    persiste: string; 
    valorPadrao: string; 
    keyboardType: string;
    mascara: string;
    firstDate: string;
    lastDate: string;
    itens = [];
}