const capitalize = require('capitalize');

/// classe base que ajuda a gerar o model do Delphi usando o mustache
class DelphiModel {
    constructor(tabela, dataPacket) {
        // nome da classe
        this.class = capitalize(tabela);

        // arrays
        this.fields = [];
        this.properties = [];

        // fields e properties
        var i;
        for (i = 0; i < dataPacket.length; i++) {
            // define o nome do campo
            var nomeCampo = dataPacket[i].Field;
            var nomeCampoUpper = nomeCampo.toUpperCase();
            var nomeCampoLower = nomeCampo.toLowerCase();

            nomeCampo = capitalize(nomeCampoLower);

            // define o tipo de dado
            var tipoDado = dataPacket[i].Type;
            if (tipoDado.includes('int')) {
                tipoDado = 'Integer';
            } else if (tipoDado.includes('varchar')) {
                tipoDado = 'string';
            }

            // define o field
            var field = 'F' + nomeCampo + ': ' + tipoDado + ';';
            this.fields.push(field);

            // define a property
            var atributoNomeCampo = "[MVCColumn('" + nomeCampoUpper;
            if (nomeCampoUpper == 'ID') {
                atributoNomeCampo = atributoNomeCampo + "', True)]";
            } else {
                atributoNomeCampo = atributoNomeCampo + "')]";
            }
            var atributoNomeJson = "[MapperJSONSer('" + nomeCampoLower + "')]";
            var property = 'property ' + nomeCampo + ': ' + tipoDado + ' read F' + nomeCampo + ' write F' + nomeCampo + ';';

            var atributosComPropriedade = atributoNomeCampo + '\n\t\t' + atributoNomeJson + '\n\t\t' + property;

            this.properties.push(atributosComPropriedade);
        }

    }
}

module.exports = DelphiModel;