import * as lodash from "lodash";
import { CamposModel } from '../../model/campos.model';
import { ComentarioDerJsonModel } from '../../model/comentario.der.json.model';
import { Biblioteca } from "../../util/biblioteca";

/// classe base que ajuda a gerar o service do Delphi usando o mustache
export class DelphiService {

    uses: string; // armazena as uses que serão inseridas no início da unit
    table: string; // armazena o nome da tabela
    class: string; // armazena o nome da classe
    chamaAnexarObjetosVinculados: string; // permite a chamada ao método de dentro dos métodos de consulta
    chamaInserirObjetosFilhos: string; // permite a chamada ao método de dentro do método de inserção e alteração
    chamaExcluirObjetosFilhos : string; // permite a chamada ao método de dentro do método de alteração e exclusão
    anexaObjetosVinculadosInterface = []; // armazena o código da interface dos objetos vinculados
    anexaObjetosVinculadosImplementationObjetoAbertura = []; // armazena o código de abertura do método para objeto
    anexaObjetosVinculadosImplementationObjetoFechamento = []; // armazena o código de fechamento do método para objeto
    anexaObjetosVinculadosImplementationLista = []; // armazena o código do método para lista
    anexaObjetosVinculados = []; // armazena o código para anexar os objetos vinculados
    linkedListInserir = []; // armazena os objetos que são listas e são usados como variáveis locais no método inserir
    insereExcluiObjetosFilhosInterface = []; // armazena o código da interface dos para os métodos de adição e exclusão dos objetos filhos
    insereObjetosFilhosImplementationAbertura = []; // armazena o código de abertura do método para inserir os objetos vinculados
    insereObjetosFilhosImplementationFechamento = []; // armazena o código de fechamento do método para inserir os objetos vinculados
    excluiObjetosFilhosImplementationAbertura = []; // armazena o código de abertura do método para excluir os objetos vinculados
    excluiObjetosFilhosImplementationFechamento = []; // armazena o código de fechamento do método para ecluir os objetos vinculados
    insereObjetosVinculados = []; // armazena o código de inserção dos objetos vinculados
    excluiFilhos = []; // armazena o código para exclusão dos ojetos filhos vinculados

    campoModel: CamposModel;
    relacionamentosDetalhe: ComentarioDerJsonModel[]; // armazena relacionamentos de uma tabela Detalhe que serão encontrado aqui no Service

    constructor(tabela: string, dataPacket: CamposModel[], relacionamentos: ComentarioDerJsonModel[]) {
        // nome da classe
        this.class = lodash.camelCase(tabela);
        this.class = lodash.upperFirst(this.class);

        // nome da tabela
        this.table = tabela.toUpperCase();

        // uses
        this.uses = this.class + ', ';

        for (let i = 0; i < dataPacket.length; i++) {
            // pega o campo
            this.campoModel = dataPacket[i];

            // se houver um campo PK e o Side for 'Local' adiciona o objeto da classe Pai no array relacionamentosDetalhe
            if (this.campoModel.Field.includes('ID_')  && this.campoModel.Comment != '') {
                if (Biblioteca.isJsonString(tabela, this.campoModel.Comment)) {
                    let objeto = new ComentarioDerJsonModel('', this.campoModel.Comment);
                    if (objeto.side == 'Local') {
                        objeto.tabela = lodash.replace(this.campoModel.Field, 'ID_', '');
                        if (this.relacionamentosDetalhe == null) {
                            this.relacionamentosDetalhe = new Array;
                        }
                        this.relacionamentosDetalhe.push(objeto);
                    }
                }
            }
        }

        // declaração e abertura de métodos
        if ((relacionamentos != null && relacionamentos.length > 0) || (this.relacionamentosDetalhe != null && this.relacionamentosDetalhe.length > 0)) {
            this.tratarMetodosObjetosVinculados();
        }

        // relacionamentos agregados ao mestre
        if (relacionamentos != null && relacionamentos.length > 0) {
            this.gerarCodigoObjetosVinculados(relacionamentos);
        }

        // relacionamentos agregados ao Detalhe
        if (this.relacionamentosDetalhe != null && this.relacionamentosDetalhe.length > 0) {
            this.gerarCodigoObjetosVinculados(this.relacionamentosDetalhe);
        }

        // insere o 'begin' no método 'InserirObjetosFilhos'
        if (this.insereObjetosFilhosImplementationAbertura.length > 0) {
            this.linkedListInserir.push('begin');
        }
    }

    tratarMetodosObjetosVinculados() {
        /// objetos vinculados - consulta
        // permite a chamada ao método
        this.chamaAnexarObjetosVinculados = 'AnexarObjetosVinculados(Result);';

        // define os métodos AnexarObjetosVinculados na interface
        let metodoLista = 'class procedure AnexarObjetosVinculados(ALista' + this.class + ': TObjectList<T' + this.class + '>); overload;'
        this.anexaObjetosVinculadosInterface.push(metodoLista);
        let metodoObjeto = 'class procedure AnexarObjetosVinculados(A' + this.class + ': T' + this.class + '); overload;';
        this.anexaObjetosVinculadosInterface.push(metodoObjeto);

        // define os métodos AnexarObjetosVinculados na implementation
        let abrirMetodoObjeto = 'class procedure T' + this.class + 'Service.AnexarObjetosVinculados(A' + this.class + ': T' + this.class + ');\nbegin';
        this.anexaObjetosVinculadosImplementationObjetoAbertura.push(abrirMetodoObjeto);
        this.anexaObjetosVinculadosImplementationObjetoFechamento.push('end;');

        metodoLista = 'class procedure T' + this.class + 'Service.AnexarObjetosVinculados(ALista' + this.class + ': TObjectList<T' + this.class + '>);\nvar';
        this.anexaObjetosVinculadosImplementationLista.push(metodoLista);
        this.anexaObjetosVinculadosImplementationLista.push('  ' + this.class + ': T' + this.class + ';\nbegin');
        this.anexaObjetosVinculadosImplementationLista.push('  for ' + this.class + ' in ALista' + this.class + ' do');
        this.anexaObjetosVinculadosImplementationLista.push('  begin');
        this.anexaObjetosVinculadosImplementationLista.push('    AnexarObjetosVinculados(' + this.class + ');');
        this.anexaObjetosVinculadosImplementationLista.push('  end;');
        this.anexaObjetosVinculadosImplementationLista.push('end;');

        /// objetos vinculados - inserção e exclusão
        // permite a chamada ao método
        this.chamaInserirObjetosFilhos = 'InserirObjetosFilhos(A' + this.class + ');';
        this.chamaExcluirObjetosFilhos = 'ExcluirObjetosFilhos(A' + this.class + ');';

        // define os métodos inserir e excluir objetos filhos na interface
        let metodo = 'class procedure InserirObjetosFilhos(A' + this.class + ': T' + this.class + ');';
        this.insereExcluiObjetosFilhosInterface.push(metodo);
        metodo = 'class procedure ExcluirObjetosFilhos(A' + this.class + ': T' + this.class + ');';
        this.insereExcluiObjetosFilhosInterface.push(metodo);

        // define o método InserirObjetosFilhos na implementation
        let abrirMetodo = 'class procedure T' + this.class + 'Service.InserirObjetosFilhos(A' + this.class + ': T' + this.class + ');';
        this.insereObjetosFilhosImplementationAbertura.push(abrirMetodo);
        this.insereObjetosFilhosImplementationFechamento.push('end;');

        // define o método ExcluirObjetosFilhos na implementation
        abrirMetodo = 'class procedure T' + this.class + 'Service.ExcluirObjetosFilhos(A' + this.class + ': T' + this.class + ');\nbegin';
        this.excluiObjetosFilhosImplementationAbertura.push(abrirMetodo);
        this.excluiObjetosFilhosImplementationFechamento.push('end;');
    }

    gerarCodigoObjetosVinculados(relacionamentos: ComentarioDerJsonModel[]) {
        for (let i = 0; i < relacionamentos.length; i++) {
            let tabelaRelacionamento = relacionamentos[i].tabela.toUpperCase();
            let classeRelacionamento = lodash.camelCase(tabelaRelacionamento);
            classeRelacionamento = lodash.upperFirst(classeRelacionamento);

            // uses
            this.uses = this.uses + classeRelacionamento + ', ';

            // comentário identificando o relacionamento
            let comentario = '// ' + classeRelacionamento + '\n';
            // começa anexando os objetos/listas vinculados
            let codigoAnexarObjeto = comentario;
            let sql = '';
            if (relacionamentos[i].side == 'Inverse') {
                sql = "'SELECT * FROM " + tabelaRelacionamento + " WHERE ID_" + this.table + " = ' + A" + this.class + ".Id.ToString;";
            } else if (relacionamentos[i].side == 'Local') {
                sql = "'SELECT * FROM " + tabelaRelacionamento + " WHERE ID = ' + A" + this.class + ".Id" + classeRelacionamento + ".ToString;";
            }
            codigoAnexarObjeto = codigoAnexarObjeto + '  sql := ' + sql + '\n';

            // exclui os objetos filhos
            if (relacionamentos[i].delete) {
                let codigoExclusao = "ExcluirFilho(A" + this.class + ".Id, '" + tabelaRelacionamento + "', 'ID_" + this.table + "');";
                this.excluiFilhos.push(codigoExclusao);
            }

            // verifica a cardinalidade para definir o nome do Field
            if (relacionamentos[i].cardinalidade == '@OneToOne') {
                // anexar objetos vinculados
                let atribuiObjeto = '  A' + this.class + '.' + classeRelacionamento + ' := GetQuery(sql).AsObject<T' + classeRelacionamento + '>;';
                codigoAnexarObjeto = codigoAnexarObjeto + atribuiObjeto + '\n';
                this.anexaObjetosVinculados.push(codigoAnexarObjeto);

                // inserir objetos vinculados
                if (relacionamentos[i].create) {
                    let atribuiId = '  A' + this.class + '.' + classeRelacionamento + '.Id' + this.class + ' := ' + 'A' + this.class + '.Id;\n';
                    let insereBase = "  InserirBase(A" + this.class + "." + classeRelacionamento + ", '" + tabelaRelacionamento + "');\n";
                    this.insereObjetosVinculados.push(comentario + atribuiId + insereBase);
                }

            } else if (relacionamentos[i].cardinalidade == '@OneToMany') {
                // anexar listas vinculadas
                let atribuiLista = '  A' + this.class + '.Lista' + classeRelacionamento + ' := GetQuery(sql).AsObjectList<T' + classeRelacionamento + '>;';
                codigoAnexarObjeto = codigoAnexarObjeto + atribuiLista + '\n';
                this.anexaObjetosVinculados.push(codigoAnexarObjeto);

                // define os objetos que são listas - inserção
                if (relacionamentos[i].create) {
                    if (this.linkedListInserir.length == 0) {
                        this.linkedListInserir.push('var');
                    }
                    let variavel = '  ' + classeRelacionamento + ': T' + classeRelacionamento + ';';
                    this.linkedListInserir.push(variavel);
                }

                // inserir listas vinculadas
                if (relacionamentos[i].create) {
                    let abreLaco = '  for ' + classeRelacionamento + ' in A' + this.class + '.Lista' + classeRelacionamento + ' do\n';
                    abreLaco = abreLaco + '  begin\n';
                    let atribuiId = '    ' + classeRelacionamento + '.Id' + this.class + ' := ' + 'A' + this.class + '.Id;\n';
                    let insereBase = "    InserirBase(" + classeRelacionamento + ", '" + tabelaRelacionamento + "');\n";
                    let fechaLaco = '  end;\n';
                    this.insereObjetosVinculados.push(comentario + abreLaco + atribuiId + insereBase + fechaLaco);
                }

            }
        }

 
    }
}