import * as lodash from "lodash";

export class ComentarioDerJsonModel {

    /**
     * Mais informações sobre essa classe podem ser encontradas no repositório, no documento
     * T2Ti ERP Fenix - Estrutura Objeto JSON Comentario DER.doc
     */

    tabela: string;
    tabelaMestre: string; // ex: BANCO_AGENCIA 
    classeMestre: string; // ex: BancoAgencia
    objetoMestre: string; // ex: bancoAgencia
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
    campoLookupTipoDado: string;
    tipoControle: TipoControle;
    
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
        this.campoLookupTipoDado = objeto["campoLookupTipoDado"];
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