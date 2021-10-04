import * as lodash from "lodash";

/// classe base que ajuda a gerar o arquivo WebModule
export class DelphiWebModule {

    units = []; // units de controller
    addController = []; // addController

    constructor(modulo: string, listaTabelas: string[]) {
        let nomeTabela = "";
        let nomeClasse = "";
        let path = "";

        for (let i = 0; i < listaTabelas.length; i++) {
            nomeTabela = listaTabelas[i];
            nomeClasse = lodash.camelCase(nomeTabela);
            nomeClasse = lodash.upperFirst(nomeClasse);
            path = lodash.replace(nomeTabela.toLowerCase(), new RegExp("_", "g"), "-");

            // unit
            this.units.push(nomeClasse + "Controller,");

            // addController
            this.addController.push("FEngine.AddController(T" + nomeClasse + "Controller);");
        }


    }

}