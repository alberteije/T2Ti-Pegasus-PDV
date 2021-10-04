import * as lodash from "lodash";

export class ComentarioDerJsonParaCampo {

    /**
     * Classe usada para instanciar um objeto JSON que será armazenado no campo
     * Usado para popular as tabelas com comentários JSON genéricos
     */
    cardinalidade: string;
    crud: string;
    side: string;
    cascade: boolean;
    orphanRemoval: boolean;
    campoLookup: string;
    tabelaLookup: string; 
    campoLookupTipoDado: string;
    valorPadraoLookup: string;
    label: string;
    labelText: string;
    validacao: string;
    obrigatorio: boolean;
    readOnly: boolean;
    desenhaControle: boolean;
    tooltip: string;
    hintText: string;
    comentario: string;
    linhaBootstrap: number;
    colunaBootstrap: number;
    sizesBootstrap: string;
    tipoControle: TipoControle; 

    constructor(objetoJson: string) {
        let objeto = JSON.parse(objetoJson);

        this.cardinalidade = objeto["cardinalidade"];
        this.crud = objeto["crud"];        
        this.side = objeto["side"];
        this.cascade = objeto["cascade"];
        this.orphanRemoval = objeto["orphanRemoval"];
        this.campoLookup = objeto["campoLookup"];
        this.tabelaLookup = objeto["tabelaLookup"];
        this.campoLookupTipoDado = objeto["campoLookupTipoDado"];
        this.valorPadraoLookup = objeto["valorPadraoLookup"];
        this.label = objeto["label"];
        this.labelText = objeto["labelText"];
        this.validacao = objeto["validacao"]; 
        this.obrigatorio = objeto["obrigatorio"];
        this.readOnly = objeto["readOnly"];
        this.desenhaControle = objeto["desenhaControle"];
        this.tooltip = objeto["tooltip"];
        this.hintText = objeto["hintText"];
        this.hintText = objeto["comentario"];
        this.linhaBootstrap = objeto["linhaBootstrap"];
        this.colunaBootstrap = objeto["colunaBootstrap"];
        this.sizesBootstrap = objeto["sizesBootstrap"];
        this.tipoControle = objeto["tipoControle"];

        if (this.tipoControle === undefined) {
            this.tipoControle = new TipoControle();
        }
    }

}

export class TipoControle {
    tipo: string;
    persiste: string; 
    valorPadrao: string; 
    keyboardType: string;
    mascara: string;
    firstDate: string;
    lastDate: string;
    itens = [];
}

export class DropDownButtonItem {
    dropDownButtonItem: string;
}