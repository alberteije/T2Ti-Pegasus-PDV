import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';

/// classe base que ajuda a gerar o model do Eloquent usando o mustache
export class MoorTabela {

    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe

    campos = []; // armazena os campos da tabela
    camposClasse = [];
    camposConstrutor = [];
    camposFromData = [];
    camposToColumns = [];
    camposToCompanion = [];
    camposFromJson = [];
    camposToJson = [];
    construtorCopyWith = [];
    camposCopyWith = [];
    camposToString = [];
    camposHashCode = [];
    camposOperator = [];
    camposUpdateCompanion = [];
    construtorUpdateCompanion = [];
    camposCompanionInsert = [];
    camposCompanionInsertable = [];
    camposRawValuesInsertable = [];
    camposCompanionCopyWith = [];
    construtorCompanionCopyWith = [];
    camposCompanionToColumns = [];
    camposCompanionToString = [];
    camposColunasTabela = [];
    camposGeneratedColumn = [];
    camposValidateIntegrity = [];

    campoModel: CamposModel;

    constructor(tabela: string, dataPacket: CamposModel[], relacionamentos: ComentarioDerJsonModel[]) {
        // nome da classe
        this.class = lodash.camelCase(tabela);
        this.class = lodash.upperFirst(this.class);

        // nome da tabela
        this.table = tabela.toUpperCase();        

        // atributos e gettersSetters
        for (let i = 0; i < dataPacket.length; i++) {
            // pega o campo
            this.campoModel = dataPacket[i];

            // define os dados do campo
            this.campoModel.nomeCampo = this.campoModel.Field;
            this.campoModel.nomeCampoTabela = this.campoModel.nomeCampo.toUpperCase();
            this.campoModel.nomeCampoAtributo = lodash.camelCase(this.campoModel.nomeCampo);
            this.campoModel.nomeCampoGetSet = lodash.upperFirst(this.campoModel.nomeCampoAtributo);  

            if (this.campoModel.nomeCampoTabela != 'ID') {

                // pega o tipo de dado
                let tipoDado = this.getTipoDadoMoor(this.campoModel.Type);
                let tipoColuna = this.getTipoColuna(this.campoModel.Type);
                let tipoDadoFlutter = this.getTipoFlutter(this.campoModel.Type);
                let tipoFromData = this.getTipoFromData(this.campoModel.Type);
                let tipoSQLite = this.getTipoSQLite(this.campoModel.Type);

                // tamanho do campo
                this.campoModel.tipoCampo = this.campoModel.Type;
                let posicaoAbreParentese = this.campoModel.tipoCampo.indexOf("(");
                let posicaoFechaParentese = this.campoModel.tipoCampo.indexOf(")");
                this.campoModel.tamanhoCampo = 0;
                if (this.campoModel.tipoCampo == "text") {
                    this.campoModel.tamanhoCampo = 250;
                }
                else {
                    this.campoModel.tamanhoCampo = parseInt(this.campoModel.tipoCampo.substring(posicaoAbreParentese + 1, posicaoFechaParentese));
                }        

                let tabelaRelacionada = '';
                let objetoTabelaRelacionada = '';
                let classeTabelaRelacionada = '';  
                let idObjetoTabelaRelacionada = '';
                let nomeAtributoGerado = '';                

                // if (this.campoModel.nomeCampoTabela.includes('ID_') && this.campoModel.Comment != '') {
                if (this.campoModel.nomeCampoTabela.includes('ID_') && tipoDadoFlutter == 'int') {
                    tabelaRelacionada = lodash.replace(this.campoModel.nomeCampoTabela, 'ID_', '');
                    objetoTabelaRelacionada = lodash.camelCase(tabelaRelacionada);
                    classeTabelaRelacionada = lodash.upperFirst(objetoTabelaRelacionada); 
                    idObjetoTabelaRelacionada = 'id' + classeTabelaRelacionada;
                    nomeAtributoGerado = idObjetoTabelaRelacionada;

                    // campos
                    this.campos.push("IntColumn get " + nomeAtributoGerado + " => integer().named('" + this.campoModel.nomeCampoTabela + "').nullable().customConstraint('NULLABLE REFERENCES " + tabelaRelacionada + "(ID)')();");

                    // camposColunasTabela
                    this.camposColunasTabela.push("final VerificationMeta _" + nomeAtributoGerado + "Meta =");
                    this.camposColunasTabela.push("    const VerificationMeta('" + nomeAtributoGerado + "');");
                    this.camposColunasTabela.push("GeneratedColumn<" + tipoDadoFlutter + ">? _" + nomeAtributoGerado + ";");
                    this.camposColunasTabela.push("@override");
                    this.camposColunasTabela.push("GeneratedColumn<" + tipoDadoFlutter + "> get " + nomeAtributoGerado + " =>");
                    this.camposColunasTabela.push("    _" + nomeAtributoGerado + " ??= GeneratedColumn<" + tipoDadoFlutter + ">('" + this.campoModel.nomeCampoTabela + "', aliasedName, true,");
                    this.camposColunasTabela.push("        typeName: '" + tipoSQLite + "',");
                    this.camposColunasTabela.push("        requiredDuringInsert: false,");
                    this.camposColunasTabela.push("        $customConstraints: 'NULLABLE REFERENCES " + tabelaRelacionada + "(ID)');");
                } else {
                    nomeAtributoGerado = this.campoModel.nomeCampoAtributo;

                    // campos
                    if (tipoColuna == 'TextColumn') {
                        this.campos.push("TextColumn get " + nomeAtributoGerado + " => text().named('" + this.campoModel.nomeCampoTabela + "').withLength(min: 0, max: " + this.campoModel.tamanhoCampo + ").nullable()();");
                    } else {
                        this.campos.push(tipoColuna + " get " + nomeAtributoGerado + " => " + tipoDado + ".named('" + this.campoModel.nomeCampoTabela + "').nullable()();");
                    }

                    // camposColunasTabela
                    this.camposColunasTabela.push("final VerificationMeta _" + nomeAtributoGerado + "Meta =");
                    this.camposColunasTabela.push("    const VerificationMeta('" + nomeAtributoGerado + "');");
                    this.camposColunasTabela.push("GeneratedColumn<" + tipoDadoFlutter + ">? _" + nomeAtributoGerado + ";");
                    this.camposColunasTabela.push("@override");
                    this.camposColunasTabela.push("GeneratedColumn<" + tipoDadoFlutter + "> get " + nomeAtributoGerado + " => _" + nomeAtributoGerado + " ??=");
                    this.camposColunasTabela.push("    GeneratedColumn<" + tipoDadoFlutter + ">('" + this.campoModel.nomeCampoTabela + "', aliasedName, true,");
                    this.camposColunasTabela.push("        typeName: '" + tipoSQLite + "', requiredDuringInsert: false);");
                }
                // camposClasse
                this.camposClasse.push("final " + tipoDadoFlutter + "? " + nomeAtributoGerado + ";");  
                // camposConstrutor              
                this.camposConstrutor.push("this." + nomeAtributoGerado + ",");  
                // camposFromData
                this.camposFromData.push(nomeAtributoGerado + ": const " + tipoFromData + ".mapFromDatabaseResponse(data['${effectivePrefix}" + this.campoModel.nomeCampoTabela + "']),");  
                // camposToColumns
                this.camposToColumns.push("if (!nullToAbsent || " + nomeAtributoGerado + " != null) {");
                this.camposToColumns.push("  map['" + this.campoModel.nomeCampoTabela + "'] = Variable<" + tipoDadoFlutter + "?>(" + nomeAtributoGerado + ");");
                this.camposToColumns.push("}");          
                // camposToCompanion
                this.camposToCompanion.push(nomeAtributoGerado + ": " + nomeAtributoGerado + " == null && nullToAbsent");
                this.camposToCompanion.push("  ? const Value.absent()");
                this.camposToCompanion.push("  : Value(" + nomeAtributoGerado + "),");
                // camposFromJson
                this.camposFromJson.push(nomeAtributoGerado + ": serializer.fromJson<" + tipoDadoFlutter + ">(json['" + nomeAtributoGerado + "']),");
                // camposToJson
                this.camposToJson.push("'" + nomeAtributoGerado + "': serializer.toJson<" + tipoDadoFlutter + "?>(" + nomeAtributoGerado + "),");
                // construtorCopyWith
                this.construtorCopyWith.push(tipoDadoFlutter + "? " + nomeAtributoGerado + ",");
                // camposCopyWith
                this.camposCopyWith.push(nomeAtributoGerado + ": " + nomeAtributoGerado + " ?? this." + nomeAtributoGerado + ",");
                // camposToString
                this.camposToString.push("..write('" + nomeAtributoGerado + ": $" + nomeAtributoGerado + ", ')");
                // camposHashCode
                this.camposHashCode.push(nomeAtributoGerado + ",");
                // camposOperator
                this.camposOperator.push("other." + nomeAtributoGerado + " == " + nomeAtributoGerado + " &&");
                // camposUpdateCompanion
                this.camposUpdateCompanion.push("final Value<" + tipoDadoFlutter + "?> " + nomeAtributoGerado + ";");
                // construtorUpdateCompanion
                this.construtorUpdateCompanion.push("this." + nomeAtributoGerado + " = const Value.absent(),");
                // camposCompanionInsert
                this.camposCompanionInsert.push("this." + nomeAtributoGerado + " = const Value.absent(),");
                // camposCompanionInsertable
                this.camposCompanionInsertable.push("Expression<" + tipoDadoFlutter + ">? " + nomeAtributoGerado + ",");
                // camposRawValuesInsertable
                this.camposRawValuesInsertable.push("if (" + nomeAtributoGerado + " != null) '" + this.campoModel.nomeCampoTabela + "': " + nomeAtributoGerado + ",");
                // camposCompanionCopyWith
                this.camposCompanionCopyWith.push("Value<" + tipoDadoFlutter + ">? " + nomeAtributoGerado + ",");
                // construtorCompanionCopyWith
                this.construtorCompanionCopyWith.push(nomeAtributoGerado + ": " + nomeAtributoGerado + " ?? this." + nomeAtributoGerado + ",");
                // camposCompanionToColumns
                this.camposCompanionToColumns.push("if (" + nomeAtributoGerado + ".present) {");
                this.camposCompanionToColumns.push("  map['" + this.campoModel.nomeCampoTabela + "'] = Variable<" + tipoDadoFlutter + "?>(" + nomeAtributoGerado + ".value);");
                this.camposCompanionToColumns.push("}");       
                // camposCompanionToString
                this.camposCompanionToString.push("..write('" + nomeAtributoGerado + ": $" + nomeAtributoGerado + ", ')");
                // camposGeneratedColumn
                this.camposGeneratedColumn.push(nomeAtributoGerado + ",");
                // camposValidateIntegrity
                this.camposValidateIntegrity.push("if (data.containsKey('" + this.campoModel.nomeCampoTabela + "')) {");
                this.camposValidateIntegrity.push("    context.handle(_" + nomeAtributoGerado + "Meta,");
                this.camposValidateIntegrity.push("        " + nomeAtributoGerado + ".isAcceptableOrUnknown(data['" + this.campoModel.nomeCampoTabela + "']!, _" + nomeAtributoGerado + "Meta));");
                this.camposValidateIntegrity.push("}");                        
            }
        }

        // remove o último "&&" do operator
        this.camposOperator[this.camposOperator.length-1] = this.camposOperator[this.camposOperator.length-1].replace('&&', '');

    }

    // define o tipo de dado
    getTipoDadoMoor(pType: any): string {
        if (pType.includes('int')) {
            return 'integer()';
        } else if (pType.includes('varchar')) {
            return 'text()';
        } else if (pType.includes('decimal')) {
            return 'real()';
        } else if (pType.includes('char')) {
            return 'text()';
        } else if (pType.includes('text')) {
            return 'text()';
        } else if (pType.includes('date')) {
            return 'dateTime()';
        } else if (pType.includes('timestamp')) {
            return 'dateTime()';
        }
    }

    // define o tipo de coluna
    getTipoColuna(pType: any): string {
        if (pType.includes('int')) {
            return 'IntColumn';
        } else if (pType.includes('varchar')) {
            return 'TextColumn';
        } else if (pType.includes('decimal')) {
            return 'RealColumn';
        } else if (pType.includes('char')) {
            return 'TextColumn';
        } else if (pType.includes('text')) {
            return 'TextColumn';
        } else if (pType.includes('date')) {
            return 'DateTimeColumn';
        } else if (pType.includes('timestamp')) {
            return 'DateTimeColumn';
        }
    }

    // define o tipo para o método FromData
    getTipoFromData(pType: any): string {
        if (pType.includes('int')) {
            return 'IntType()';
        } else if (pType.includes('varchar')) {
            return 'StringType()';
        } else if (pType.includes('decimal')) {
            return 'RealType()';
        } else if (pType.includes('char')) {
            return 'StringType()';
        } else if (pType.includes('text')) {
            return 'StringType()';
        } else if (pType.includes('date')) {
            return 'DateTimeType()';
        } else if (pType.includes('timestamp')) {
            return 'DateTimeType()';
        }
    }

    // define o tipo de dado Flutter
    getTipoFlutter(pType: any): string {
        if (pType.includes('int')) {
            return 'int';
        } else if (pType.includes('varchar')) {
            return 'String';
        } else if (pType.includes('decimal')) {
            return 'double';
        } else if (pType.includes('char')) {
            return 'String';
        } else if (pType.includes('text')) {
            return 'String';
        } else if (pType.includes('date')) {
            return 'DateTime';
        } else if (pType.includes('timestamp')) {
            return 'DateTime';
        }
    }    

    // define o tipo de dado SQLite
    getTipoSQLite(pType: any): string {
        if (pType.includes('int')) {
            return 'INTEGER';
        } else if (pType.includes('varchar')) {
            return 'TEXT';
        } else if (pType.includes('decimal')) {
            return 'REAL';
        } else if (pType.includes('char')) {
            return 'TEXT';
        } else if (pType.includes('text')) {
            return 'TEXT';
        } else if (pType.includes('date')) {
            return 'INTEGER';
        } else if (pType.includes('timestamp')) {
            return 'INTEGER';
        }
    }     

}