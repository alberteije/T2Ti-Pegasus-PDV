import { Request, Response } from 'express';
import { TabelaService } from '../service/tabela.service';
import { RetornoJsonErro } from '../model/retorno.json.erro';
import { GeradorBase } from '../gerador/gerador.base';
import { GeradorDelphi } from '../gerador/delphi/gerador.delphi';
import { GeradorJava } from '../gerador/java/gerador.java';
import { GeradorCSharp } from '../gerador/csharp/gerador.csharp';
import { GeradorNHibernate } from '../gerador/nhibernate/gerador.nhibernate';
import { GeradorNode } from '../gerador/node/gerador.node';
import { GeradorPHP } from '../gerador/php/gerador.php';
import { GeradorEloquent } from '../gerador/eloquent/gerador.eloquent';
import { GeradorFlutter } from '../gerador/flutter/gerador.flutter';
import { GeradorMoor } from '../gerador/moor/gerador.moor';

export class TabelaController {

    static linguagens = ["csharp-ef", "csharp-nhibernate", "delphi", "java", "node", "php-doctrine", "php-eloquent", "flutter", "moor"];

    constructor() {
    }

    // rota: /:linguagem/:nomeTabela/:modulo?
    public gerarFontes(req: Request, res: Response) {
        let linguagem = req.params.linguagem;
        let tabela = req.params.nomeTabela;
        let modulo = req.params.modulo;
        let listaRetorno = [];

        if (!TabelaController.linguagens.includes(linguagem)) {
            let jsonErro = new RetornoJsonErro({ codigo: 400, mensagem: "Erro no Servidor [Gerar Fontes] - Linguagem não suportada", erro: null });
            res.status(400).send(jsonErro);
        }

        // verifica se a tabela existe
        TabelaService.consultarListaCampos(req.params.nomeTabela, async (lista: any, erro: any) => {
            if (erro != null) {
                let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Consultar Lista de Campos]", erro: erro });
                res.status(500).send(jsonErro);
            } else {
                await TabelaController.gerarArquivos(tabela, linguagem, modulo, listaRetorno, res);
                res.send(listaRetorno);
            }
        });
    }

    // rota: /gerar/todos/arquivos/:linguagem/:modulo?
    public gerarTudo(req: Request, res: Response) {
        let linguagem = req.params.linguagem;
        let modulo = req.params.modulo;
        let listaRetorno = [];

        if (!TabelaController.linguagens.includes(linguagem)) {
            let jsonErro = new RetornoJsonErro({ codigo: 400, mensagem: "Erro no Servidor [Gerar Fontes] - Linguagem não suportada", erro: null });
            res.status(400).send(jsonErro);
        }

        // pega a lista de tabelas para fazer o laço
        TabelaService.consultarLista(async (lista: any, erro: any) => {
            if (erro != null) {
                let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Tudo - " + linguagem + "]", erro: erro });
                res.status(500).send(jsonErro);
            } else {
                let tabela = "";
                for (let i = 0; i < lista.length; i++) {
                    tabela = lista[i].nome;
                    await TabelaController.gerarArquivos(tabela, linguagem, modulo, listaRetorno, res);
                }
                res.send(listaRetorno);
            }
        });

    }
 
    // bloco de códico para geração dos arquivos
    // chamado pelos métodos gerarFontes e gerarTudo
    static async gerarArquivos(tabela: string, linguagem: string, modulo: string, listaRetorno = [],  res: Response) {
        switch (linguagem) {
            case 'csharp-ef':
                let geradorCSharp = new GeradorCSharp();
                await geradorCSharp.gerarArquivos(tabela, (retorno: any, erro: any) => {
                    if (erro != null) {
                        let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos CSharp]", erro: erro });
                        res.status(500).send(jsonErro);
                    } else {
                        listaRetorno.push("TABELA --> " + tabela + " - RESULTADO: " + JSON.stringify(retorno));
                    }
                });
                break;
            case 'csharp-nhibernate':
                let geradorNHibernate = new GeradorNHibernate();
                await geradorNHibernate.gerarArquivos(tabela, (retorno: any, erro: any) => {
                    if (erro != null) {
                        let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos NHibernate]", erro: erro });
                        res.status(500).send(jsonErro);
                    } else {
                        listaRetorno.push("TABELA --> " + tabela + " - RESULTADO: " + JSON.stringify(retorno));
                    }
                });
                break;
            case 'delphi':
                let geradorDelphi = new GeradorDelphi();
                await geradorDelphi.gerarArquivos(tabela, (retorno: any, erro: any) => {
                    if (erro != null) {
                        let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos Delphi]", erro: erro });
                        res.status(500).send(jsonErro);
                    } else {
                        listaRetorno.push("TABELA --> " + tabela + " - RESULTADO: " + JSON.stringify(retorno));
                    }
                });
                break;
            case 'java':
                let geradorJava = new GeradorJava();
                await geradorJava.gerarArquivos(tabela, modulo, (retorno: any, erro: any) => {
                    if (erro != null) {
                        let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos Java]", erro: erro });
                        res.status(500).send(jsonErro);
                    } else {
                        listaRetorno.push("TABELA --> " + tabela + " - RESULTADO: " + JSON.stringify(retorno));
                    }
                });
                break;
            case 'node':
                let geradorNode = new GeradorNode();
                await geradorNode.gerarArquivos(tabela, (retorno: any, erro: any) => {
                    if (erro != null) {
                        let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos Node]", erro: erro });
                        res.status(500).send(jsonErro);
                    } else {
                        listaRetorno.push("TABELA --> " + tabela + " - RESULTADO: " + JSON.stringify(retorno));
                    }
                });
                break;
            case 'php-doctrine':
                let geradorPHP = new GeradorPHP();
                await geradorPHP.gerarArquivos(tabela, (retorno: any, erro: any) => {
                    if (erro != null) {
                        let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos PHP - Doctrine]", erro: erro });
                        res.status(500).send(jsonErro);
                    } else {
                        listaRetorno.push("TABELA --> " + tabela + " - RESULTADO: " + JSON.stringify(retorno));
                    }
                });
                break;
            case 'php-eloquent':
                let geradorEloquent = new GeradorEloquent();
                await geradorEloquent.gerarArquivos(tabela, (retorno: any, erro: any) => {
                    if (erro != null) {
                        let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos PHP - Eloquent]", erro: erro });
                        res.status(500).send(jsonErro);
                    } else {
                        listaRetorno.push("TABELA --> " + tabela + " - RESULTADO: " + JSON.stringify(retorno));
                    }
                });
                break;
            case 'moor':
                let geradorMoor = new GeradorMoor();
                await geradorMoor.gerarArquivos(tabela, (retorno: any, erro: any) => {
                    if (erro != null) {
                        let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos Moor]", erro: erro });
                        res.status(500).send(jsonErro);
                    } else {
                        listaRetorno.push("TABELA --> " + tabela + " - RESULTADO: " + JSON.stringify(retorno));
                    }
                });
                break;
            case 'flutter':
                // gerar páginas padrões
                let geradorFlutter = new GeradorFlutter();
                await geradorFlutter.gerarArquivos(tabela, async (retorno: any, erro: any) => {
                    if (erro != null) {
                        let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos Flutter]", erro: erro });
                        res.status(500).send(jsonErro);
                    } else {
                        listaRetorno.push("TABELA --> " + tabela + " - RESULTADO: " + JSON.stringify(retorno));
                    }
                });
                break;
            default:
                console.log('Estranho, mas chegou aqui com essa linguagem não suportada: ' + linguagem + '.');
        }

    }
    
    // rota: /laco/tabela/node/:modulo
    public gerarArquivosLacoTabelaNode(req: Request, res: Response) {
        let modulo = req.params.modulo;
        let geradorNode = new GeradorNode();

        // gerar arquivos a partir dos nomes das tabelas
        geradorNode.gerarArquivosLacoTabela(modulo, (retorno: any, erro: any) => {
            if (erro != null) {
                let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos Laço Tabela Node]", erro: erro });
                res.status(500).send(jsonErro);
            } else {
                res.send(retorno);
            }
        });
    }

    // rota: /laco/tabela/php/:modulo
    public gerarArquivosLacoTabelaPHP(req: Request, res: Response) {
        let modulo = req.params.modulo;
        let geradorPHP = new GeradorPHP();

        // gerar arquivos a partir dos nomes das tabelas
        geradorPHP.gerarArquivosLacoTabela(modulo, (retorno: any, erro: any) => {
            if (erro != null) {
                let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos Laço Tabela PHP]", erro: erro });
                res.status(500).send(jsonErro);
            } else {
                res.send(retorno);
            }
        });
    }

    // rota: /laco/tabela/php/:modulo
    public gerarArquivosLacoTabelaDelphi(req: Request, res: Response) {
        let modulo = req.params.modulo;
        let geradorDelphi = new GeradorDelphi();

        // gerar arquivos a partir dos nomes das tabelas
        geradorDelphi.gerarArquivosLacoTabela(modulo, (retorno: any, erro: any) => {
            if (erro != null) {
                let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos Laço Tabela PHP]", erro: erro });
                res.status(500).send(jsonErro);
            } else {
                res.send(retorno);
            }
        });
    }

    // rota: /laco/tabela/flutter/:modulo
    public gerarArquivosLacoTabelaFlutter(req: Request, res: Response) {
        let modulo = req.params.modulo;
        let geradorFlutter = new GeradorFlutter();

        // gerar arquivos a partir dos nomes das tabelas
        geradorFlutter.gerarArquivosLacoTabela(modulo, (retorno: any, erro: any) => {
            if (erro != null) {
                let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos Laço Tabela Flutter]", erro: erro });
                res.status(500).send(jsonErro);
            } else {
                res.send(retorno);
            }
        });
    }

    // rota: /laco/tabela/moor/:modulo
    public gerarArquivosLacoTabelaMoor(req: Request, res: Response) {
        let modulo = req.params.modulo;
        let geradorMoor = new GeradorMoor();

        // gerar arquivos a partir dos nomes das tabelas
        geradorMoor.gerarArquivoDatabase(modulo, (retorno: any, erro: any) => {
            if (erro != null) {
                let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivo Database Moor]", erro: erro });
                res.status(500).send(jsonErro);
            } else {
                res.send(retorno);
            }
        });
    }

    // rota: /tabela
    public consultarLista(req: Request, res: Response) {
        TabelaService.consultarLista((lista: any, erro: any) => {
            if (erro != null) {
                let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Consultar Lista de Tabelas]", erro: erro });
                res.status(500).send(jsonErro);
            } else {
                res.send(lista);
            }
        });
    }

    // rota: /tabela/:nomeTabela/
    public consultarListaCampos(req: Request, res: Response) {
        TabelaService.consultarListaCampos(req.params.nomeTabela, (lista: any, erro: any) => {
            if (erro != null) {
                let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Consultar Lista de Campos]", erro: erro });
                res.status(500).send(jsonErro);
            } else {
                res.send(lista);
            }
        });
    }


    // comentários nos campos tabela

    // rota: /json/comentario/gerar/todos
    public gerarComentariosTodasTabelas(req: Request, res: Response) {
        let listaRetorno = [];

        // pega a lista de tabelas para fazer o laço
        TabelaService.consultarLista(async (lista: any, erro: any) => {
            if (erro != null) {
                let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [gerarComentariosTodasTabelas]", erro: erro });
                res.status(500).send(jsonErro);
            } else {
                let tabela = "";
                for (let i = 0; i < lista.length; i++) {
                    tabela = lista[i].nome;
                    if (tabela.substring(0, 4) !== "VIEW" && tabela.substring(0, 4) !== "view") {
                        await TabelaController.gerarComentarios(tabela, listaRetorno, res);
                    }
                }
                res.send(listaRetorno);
            }
        });

    }

    // rota: /json/gerar/comentario/:nomeTabela
    public gerarComentariosTabela(req: Request, res: Response) {
        let tabela = req.params.nomeTabela;
        let listaRetorno = [];
    
        // verifica se a tabela existe
        TabelaService.consultarListaCampos(req.params.nomeTabela, async (lista: any, erro: any) => {
            if (erro != null) {
                let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Consultar Lista de Campos]", erro: erro });
                res.status(500).send(jsonErro);
            } else {
                await TabelaController.gerarComentarios(tabela, listaRetorno, res);
                res.send(listaRetorno);
            }
        });
    }

    static async gerarComentarios(tabela: string, listaRetorno = [],  res: Response) {
        let geradorBase = new GeradorBase();
        await geradorBase.gerarComentarioJSON(tabela, (retorno: any, erro: any) => {
            if (erro != null) {
                let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Comentários Tabela]", erro: erro });
                res.status(500).send(jsonErro);
            } else {
                listaRetorno.push("TABELA --> " + tabela + " - RESULTADO: " + JSON.stringify(retorno));
            }
        });
    }
}