import { Request, Response } from 'express';
import { TabelaService } from '../service/tabela.service';
import { RetornoJsonErro } from '../model/retorno.json.erro';
import { GeradorDelphi } from '../gerador/delphi/gerador.delphi';
import { GeradorJava } from '../gerador/java/gerador.java';
import { GeradorCSharp } from '../gerador/csharp/gerador.csharp';
import { GeradorNHibernate } from '../gerador/nhibernate/gerador.nhibernate';
import { GeradorNode } from '../gerador/node/gerador.node';
import { GeradorPHP } from '../gerador/php/gerador.php';
import { GeradorFlutter } from '../gerador/flutter/gerador.flutter';
import { GeradorFlutterAba } from '../gerador/flutter/gerador.flutter.aba';

export class TabelaController {

    constructor() {
    }

    // rota: /:linguagem/:nomeTabela/:modulo?
    public gerarFontes(req: Request, res: Response) {
        let linguagens = ["csharp", "delphi", "java", "node", "php", "flutter", "nhibernate"];
        let linguagem = req.params.linguagem;
        let tabela = req.params.nomeTabela;
        let modulo = req.params.modulo;

        // verifica se a tabela existe
        TabelaService.consultarListaCampos(req.params.nomeTabela, (lista: any, erro: any) => {
            if (erro != null) {
                let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Consultar Lista de Campos]", erro: erro });
                res.status(500).send(jsonErro);
            } else {
                // verifica se a linguagem enviada pelo usuário está na lista de linguagens esperadas
                if (linguagens.includes(linguagem)) {

                    switch (linguagem) {
                        case 'csharp':
                            let geradorCSharp = new GeradorCSharp();
                            geradorCSharp.gerarArquivos(tabela, (retorno: any, erro: any) => {
                                if (erro != null) {
                                    let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos CSharp]", erro: erro });
                                    res.status(500).send(jsonErro);
                                } else {
                                    res.send(retorno);
                                }
                            });
                            break;
                        case 'nhibernate':
                                let geradorNHibernate = new GeradorNHibernate();
                                geradorNHibernate.gerarArquivos(tabela, (retorno: any, erro: any) => {
                                    if (erro != null) {
                                        let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos NHibernate]", erro: erro });
                                        res.status(500).send(jsonErro);
                                    } else {
                                        res.send(retorno);
                                    }
                                });
                                break;
                        case 'delphi':
                            let geradorDelphi = new GeradorDelphi();
                            geradorDelphi.gerarArquivos(tabela, (retorno: any, erro: any) => {
                                if (erro != null) {
                                    let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos Delphi]", erro: erro });
                                    res.status(500).send(jsonErro);
                                } else {
                                    res.send(retorno);
                                }
                            });
                            break;
                        case 'java':
                            let geradorJava = new GeradorJava();
                            geradorJava.gerarArquivos(tabela, modulo, (retorno: any, erro: any) => {
                                if (erro != null) {
                                    let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos Java]", erro: erro });
                                    res.status(500).send(jsonErro);
                                } else {
                                    res.send(retorno);
                                }
                            });
                            break;
                        case 'node':
                            let geradorNode = new GeradorNode();
                            geradorNode.gerarArquivos(tabela, (retorno: any, erro: any) => {
                                if (erro != null) {
                                    let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos Node]", erro: erro });
                                    res.status(500).send(jsonErro);
                                } else {
                                    res.send(retorno);
                                }
                            });
                            break;
                        case 'php':
                            let geradorPHP = new GeradorPHP();
                            geradorPHP.gerarArquivos(tabela, (retorno: any, erro: any) => {
                                if (erro != null) {
                                    let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos PHP]", erro: erro });
                                    res.status(500).send(jsonErro);
                                } else {
                                    res.send(retorno);
                                }
                            });
                            break;
                        case 'flutter':
                            // gerar páginas padrões
                            let geradorFlutter = new GeradorFlutter();
                            geradorFlutter.gerarArquivos(tabela, (retorno: any, erro: any) => {
                                if (erro != null) {
                                    let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos Flutter]", erro: erro });
                                    res.status(500).send(jsonErro);
                                } else {
                                    // gerar páginas mestre-detalhe
                                    let geradorFlutter = new GeradorFlutterAba();
                                    geradorFlutter.gerarArquivos(tabela, (retorno: any, erro: any) => {
                                        if (erro != null) {
                                            let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos Flutter]", erro: erro });
                                            res.status(500).send(jsonErro);
                                        } else {
                                            res.send(retorno);
                                        }
                                    });
                                }
                            });
                            break;
                        default:
                            console.log('Estranho, mas chegou aqui com essa linguagem não suportada: ' + linguagem + '.');
                    }

                } else {
                    let jsonErro = new RetornoJsonErro({ codigo: 400, mensagem: "Erro no Servidor [Gerar Fontes] - Linguagem não suportada", erro: null });
                    res.status(400).send(jsonErro);
                }
            }
        });

    }

    // rota: /gerar/todos/arquivos/:linguagem/:modulo?
    public gerarTudo(req: Request, res: Response) {
        let linguagens = ["csharp", "delphi", "java", "node", "php", "flutter", "nhibernate"];
        let linguagem = req.params.linguagem;
        let modulo = req.params.modulo;
        let listaRetorno = [];

        if (!linguagens.includes(linguagem)) {
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

                    switch (linguagem) {
                        case 'csharp':
                            let geradorCSharp = new GeradorCSharp();
                            await geradorCSharp.gerarArquivos(tabela, (retorno: any, erro: any) => {
                                if (erro != null) {
                                    let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos CSharp]", erro: erro });
                                    res.status(500).send(jsonErro);
                                } else {
                                    listaRetorno.push(retorno + " TABELA --> " + tabela);
                                }
                            });
                            break;
                        case 'nhibernate':
                                let geradorNHibernate = new GeradorNHibernate();
                                await geradorNHibernate.gerarArquivos(tabela, (retorno: any, erro: any) => {
                                    if (erro != null) {
                                        let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos NHibernate]", erro: erro });
                                        res.status(500).send(jsonErro);
                                    } else {
                                        listaRetorno.push(retorno + " TABELA --> " + tabela);
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
                                    listaRetorno.push(retorno + " TABELA --> " + tabela);
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
                                    listaRetorno.push(retorno + " TABELA --> " + tabela);
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
                                    listaRetorno.push(retorno + " TABELA --> " + tabela);
                                }
                            });
                            break;
                        case 'php':
                            let geradorPHP = new GeradorPHP();
                            await geradorPHP.gerarArquivos(tabela, (retorno: any, erro: any) => {
                                if (erro != null) {
                                    let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos PHP]", erro: erro });
                                    res.status(500).send(jsonErro);
                                } else {
                                    listaRetorno.push(retorno + " TABELA --> " + tabela);
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
                                    // gerar páginas mestre-detalhe
                                    let geradorFlutter = new GeradorFlutterAba();
                                    await geradorFlutter.gerarArquivos(tabela, (retorno: any, erro: any) => {
                                        if (erro != null) {
                                            let jsonErro = new RetornoJsonErro({ codigo: 500, mensagem: "Erro no Servidor [Gerar Arquivos Flutter]", erro: erro });
                                            res.status(500).send(jsonErro);
                                        } else {
                                            listaRetorno.push(retorno + " TABELA --> " + tabela);
                                        }
                                    });
                                }
                            });
                            break;
                        default:
                            console.log('Estranho, mas chegou aqui com essa linguagem não suportada: ' + linguagem + '.');
                    }
                }
                res.send(listaRetorno);
            }
        });

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

    // rota: /tabela/:nomeTabela
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

}