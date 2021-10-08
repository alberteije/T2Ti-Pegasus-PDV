/*
Title: T2Ti ERP 3.0                                                                
Description: Página de registro do usuário
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (alberteije@gmail.com)                    
@version 1.0.0

Based on: Flutter UI Challenges by Many - https://github.com/lohanidamodar/flutter_ui_challenges
*******************************************************************************/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/model/model.dart';
import 'package:pegasus_pdv/src/service/service.dart';

import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

class RegistroPage extends StatefulWidget {
  final String title;
  
  const RegistroPage({Key key, this.title}): super(key: key);

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  // final _emailController = TextEditingController(text: Sessao.empresa.email ?? '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final _valorFoco = FocusNode();
  final _codigoConfirmacaoController = TextEditingController();

  bool _aceitaTermosDeUso = false;
  bool _empresaMEI = Sessao.empresa.simei ?? false;

  String _textoInformativo = 'Leia com atenção os Termos de Uso da aplicação. Caso concorde com os termos, marque a caixa '
                             'correspondente e informe seu e-mail para realizar seu cadastro. Se você for MEI, devidamente '
                             'cadastrado no SIMEI, marque a caixa correspondente para que seja possível utilizar a aplicação '
                             'com emissão de Recibo.';
  bool _pendenteDeConfirmacao = false;

  @override
  void initState() {
    super.initState();
    _valorFoco.requestFocus();        
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade600]),
              ),
            ),
            ListView.builder(
              itemCount: 3,
              itemBuilder: _mainListBuilder,
            ),
          ],
        ),
      ),
    );
  }

  Widget _mainListBuilder(BuildContext context, int index) {
    if (index == 0) return _cabecalhoTela(context);
    if (index == 1) return _termoDeUso(context);
    if (index == 2) return _conteudoTela(context);
    return null;
  }
  
  Container _cabecalhoTela(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      _textoInformativo, textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: _pendenteDeConfirmacao ? FontWeight.bold : FontWeight.normal, 
                        color: _pendenteDeConfirmacao ? Colors.red : Colors.black,
                      ),
                    ),                
                  ),
                  Divider(
                    indent: 10,
                    endIndent: 10,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage(Constantes.opcoesGerenteIcon),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  Container _termoDeUso(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Html(
                        data: htmlData,
                        style: {
                          "ul": Style(
                            listStyleType: ListStyleType.SQUARE,
                          ),
                          "table": Style(
                            backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                          ),
                          "tr": Style(
                            border: Border(bottom: BorderSide(color: Colors.grey)),
                          ),
                          "th": Style(
                            padding: EdgeInsets.all(6),
                            backgroundColor: Colors.grey,
                          ),
                          "td": Style(
                            padding: EdgeInsets.all(6),
                            alignment: Alignment.topLeft,
                          ),
                          'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
                        },
                        onLinkTap: (url, _, __, ___) {
                          print("Opening $url...");
                        },
                        onImageTap: (src, _, __, ___) {
                          print(src);
                        },
                        onImageError: (exception, stackTrace) {
                          print(exception);
                        },
                      ),
                    ),                    
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _conteudoTela(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.0),
      child: Form(
        key: _formKey,
        autovalidateMode: _autoValidate,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 40.0),
              child: Material(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                elevation: 5.0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Visibility(
                        visible: !_pendenteDeConfirmacao,
                        child: SizedBox(height: 10.0),
                      ),
                      /*
                      Visibility(
                        visible: !_pendenteDeConfirmacao,
                        child: TextFormField(
                          readOnly: true,
                          validator: ValidaCampoFormulario.validarObrigatorioEmail,
                          keyboardType: TextInputType.emailAddress,
                          maxLength: 250,
                          focusNode: _valorFoco,
                          controller: _emailController,
                          decoration: getInputDecoration(
                            'Informe o EMail',
                            'EMail *',
                            false),
                          onSaved: (String value) {
                          },
                          onChanged: (text) {
                          },
                        ),     
                      ),               
                      Visibility(
                        visible: !_pendenteDeConfirmacao,
                        child: SizedBox(height: 10.0),
                      ),
                      */
                      Visibility(
                        visible: !_pendenteDeConfirmacao,
                        child: ListTile(
                          leading: Icon(
                            Icons.account_balance_outlined,
                            color: Colors.blue,
                          ),
                          title: Text("Informo que sou MEI devidamente cadastrado no SIMEI"),
                          trailing: CupertinoSwitch(
                            value: _empresaMEI,
                            onChanged: (val) {
                              _empresaMEI = !_empresaMEI;
                              setState(() {});
                            },
                          )
                        ),                      
                      ),
                      Visibility(
                        visible: !_pendenteDeConfirmacao,
                        child: SizedBox(height: 10.0),
                      ),
                      Visibility(
                        visible: !_pendenteDeConfirmacao,
                        child: ListTile(
                          leading: Icon(
                            Icons.fact_check_outlined ,
                            color: Colors.green,
                          ),
                          title: Text("Aceito e Concordo com os Termos de Uso"),
                          trailing: CupertinoSwitch(
                            value: _aceitaTermosDeUso,
                            onChanged: (val) {
                              _aceitaTermosDeUso = !_aceitaTermosDeUso;
                              setState(() {});
                            },
                          )
                        ),   
                      ),
                      Visibility(
                        visible: _pendenteDeConfirmacao,
                        child: SizedBox(height: 10.0),
                      ),
                      Visibility(
                        visible: _pendenteDeConfirmacao,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            _textoInformativo, textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: _pendenteDeConfirmacao ? FontWeight.bold : FontWeight.normal, 
                              color: _pendenteDeConfirmacao ? Colors.red : Colors.black,
                            ),
                          ),                
                        ),
                      ),
                      Visibility(
                        visible: _pendenteDeConfirmacao,
                        child: SizedBox(height: 10.0),
                      ),
                      Visibility(
                        visible: _pendenteDeConfirmacao,
                        child: TextFormField(
                          maxLength: 32,
                          maxLines: 1,
                          controller: _codigoConfirmacaoController,
                          decoration: getInputDecoration(
                            'Informe o Código de Confirmação Enviado para o seu E-mail',
                            'Código de Confirmação',
                            false),
                          onSaved: (String value) {
                          },
                          onChanged: (text) async {
                            if (_codigoConfirmacaoController.text.length == 32) {
                              await _conferirCodigoConfirmacao();
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _getBotoesRodape(context: context),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getBotoesRodape({BuildContext context}) {
    List<Widget> listaBotoes = [];
    if (!_pendenteDeConfirmacao) {
      listaBotoes.add(
        Container(
          width: 200,
          child: getBotaoGenericoPdv(
            descricao: 'Confirmar',
            cor: Colors.green, 
            onPressed: () async {
              await _confirmar();
            }
          ),
        ),
      );
    }
    if (_pendenteDeConfirmacao) {
      listaBotoes.add(
        SizedBox(width: 10.0),
      );
      listaBotoes.add(
        Container(
          width: 200,
          child: getBotaoGenericoPdv(
            descricao: 'Reenviar Email',
            cor: Colors.blue, 
            onPressed: () async {
              gerarDialogBoxEspera(context);
              await _reenviarEmail();
              Sessao.fecharDialogBoxEspera(context);
            }
          ),
        ),
      );
    }

    return listaBotoes;
  }

  Future _conferirCodigoConfirmacao() async {
    gerarDialogBoxEspera(context);
    EmpresaService servico = EmpresaService();
    EmpresaModel empresa = EmpresaModel.fromDB(Sessao.empresa);
    empresa = await servico.conferirCodigoConfirmacao(empresa, _codigoConfirmacaoController.text);
    if (empresa != null) {
      if (empresa.registrado == 'S') {
        Sessao.empresa = Sessao.empresa.copyWith(
          registrado: true, 
          simei: empresa.simei == 'S' ? true : false,
          dataRegistro: empresa.dataRegistro,
          horaRegistro: empresa.horaRegistro,
        );
        await Sessao.db.empresaDao.alterar(Sessao.empresa, Sessao.configuracaoPdv.modulo != 'G');
        Sessao.empresa = await Sessao.db.empresaDao.consultarObjeto(1);
        Sessao.fecharDialogBoxEspera(context);
        gerarDialogBoxInformacao(context, 'Código confirmado com sucesso. Sistema liberado.', 
        onOkPressed: () { 
          Navigator.of(context).pop(); // fecha caixa da mensagem
          Navigator.of(context).pop(); // fecha janela de registro
        });              
      }
    } else {
      Sessao.fecharDialogBoxEspera(context);
      gerarDialogBoxInformacao(context, 'Código inválido.', onOkPressed: () { Navigator.of(context).pop(); });      
    }
  }

  Future _reenviarEmail() async {
    EmpresaService servico = EmpresaService();
    EmpresaModel empresa = EmpresaModel.fromDB(Sessao.empresa);
    final retorno = await servico.reenviarEmail(empresa);
    if (retorno) {
      showInSnackBar('E-Mail reenviado com sucesso.', context, corFundo: Colors.blue);    
    } else {
      showInSnackBar('Ocorreu um problema ao tentar reenviar o e-mail.', context, corFundo: Colors.red);    
    }
  }

  Future _confirmar() async {
    if (_aceitaTermosDeUso) {
      final FormState form = _formKey.currentState;
      if (!form.validate()) {
        _autoValidate = AutovalidateMode.always;
        _valorFoco.requestFocus();        
      } else {
        gerarDialogBoxEspera(context);
        Sessao.empresa = Sessao.empresa.copyWith(
          simei: _empresaMEI, 
        );
        EmpresaModel empresa = EmpresaModel.fromDB(Sessao.empresa);
        EmpresaService servico = EmpresaService();
        empresa = await servico.registrar(empresa);        
        Sessao.fecharDialogBoxEspera(context);
        if (empresa != null) {
          if (empresa.registrado == 'P') {
            setState(() {
              _pendenteDeConfirmacao = true;
              _textoInformativo = 'Pegue o código que foi enviado para o seu e-mail e cole na caixa "Código de Confirmação" [verifique a caixa de SPAM / Lixo Eletrônico]. Dessa forma, seu cadastro será concluído.';
            });
          } else if (empresa.registrado == 'S') {
            // normalmente só entrará aqui na versão release para testes
            Sessao.empresa = Sessao.empresa.copyWith(
              registrado: true, 
              simei: empresa.simei == 'S' ? true : false,
              dataRegistro: DateTime.now(),
              horaRegistro: Biblioteca.formatarHora(DateTime.now()),
            );
            await Sessao.db.empresaDao.alterar(Sessao.empresa, Sessao.configuracaoPdv.modulo != 'G');
            Sessao.empresa = await Sessao.db.empresaDao.consultarObjeto(1);
            Navigator.of(context).pop();
            showInSnackBar('Registro realizado com sucesso.', context, corFundo: Colors.blue);
          }
        } else {
          showInSnackBar('Ocorreu um problema ao tentar salvar os dados no Servidor.', context, corFundo: Colors.red);
        }        
      }      
    } else {
      gerarDialogBoxInformacao(context, 'É necessário ler e aceitar os Termos de Uso.');      
    }
  }
}

const htmlData = r"""
<p id='top'><a href='#bottom'>Navegar para o Final do Documento</a></p>

<div data-dmtmpl="true" data-element-type="paragraph" style="transition: opacity 1s ease-in-out 0s;" data-uialign="center" data-editor-state="closed">
   <div style="text-align: center;"><b style="background-color: transparent;"><font style="color: #0000ff; font-size: 24px;"><br></font></b></div>
   <div style="text-align: center;"><b style="background-color: transparent;"><font style="color: #0000ff; font-size: 24px;">TERMOS GERAIS E CONDIÇÕES DE USO</font></b></div>
   <div>&nbsp;</div>
   <div><br></div>
   <div>Este instrumento contém os termos gerais e condições de uso so SOFTWARE T2Ti Pegasus PDV disponibilizado pela <b>T2Ti.COM</b>, pessoa jurídica de direito privado, com sede na QNE 06, nº 18, Taguatinga, na cidade de Brasília, Distrito Federal, inscrita no CNPJ sob o nº 10.793.118/0001-78, doravante denominada T2Ti.&nbsp;</div>
   <div><br></div>
   <div><br></div>
   <div>
      <b>
      <font style="color: #0000ff; font-size: 18px;">
      PREÂMBULO
      </font>
      </b>
   </div>
   <div><br></div>
   <div><b>CONSIDERANDO QUE A ACEITAÇÃO DESTES TERMOS E CONDIÇÕES GERAIS É ABSOLUTAMENTE INDISPENSÁVEL À UTILIZAÇÃO DO SOFTWARE.</b></div>
   <div><br></div>
   <div>CONSIDERANDO QUE AO CLICAR NA CAIXA QUE INDICA SUA CONCORDÂNCIA VOCÊ ESTARÁ ACEITANDO OS TERMOS, DECLARANDO QUE LEU E CONCORDOU COM A VERSÃO MAIS RECENTE DOS TERMOS DE USO DO SOFTWARE, VINCULANDO-SE AUTOMATICAMENTE ÀS REGRAS AQUI CONTIDAS.</div>
   <div><br></div>
   <div>Considerando que é necessário que o USUÁRIO leia os presentes Termos de Uso, atentando-se para todas as normas e políticas a ele relacionadas, incluindo suas normas específicas, restrições de uso e outros procedimentos ou condições antes de efetivar a contratação.</div>
   <div><br></div>
   <div><b>CONSIDERANDO QUE OS PRESENTES TERMOS DE USO FORAM DISPONIBILIZADOS INICIALMENTE NA DATA</b> 
      DE 25/09/2021, sendo esta a versão número 001/2021e que substitui os demais contratos porventura anteriores a este.
   </div>
   <div><br></div>
   <div>Considerando que este Contrato entra em vigor em relação ao USUÁRIO na data em que este clicar no botão “Aceito”, sendo esta a considerada “data efetiva” da contratação.</div>
   <div><br></div>
   <div>Considerando que o USUÁRIO declara estar ciente de que as operações que correspondam à aceitação do presente Contrato, de determinadas condições e opções, bem como eventual rescisão do presente instrumento e demais alterações, serão registradas nos bancos de dados do SOFTWARE, juntamente com a data e hora em que foram realizadas pelo USUÁRIO, podendo tais informações serem utilizadas como prova pelas partes, independentemente do cumprimento de qualquer outra formalidade.</div>
   <div><br></div>
   <div><b>Considerando que o SOFTWARE não presta consultoria profissional relacionada às áreas jurídica, financeira, contábil, fiscal, ou de outros serviços ou consultoria profissional, devendo o USUÁRIO consultar os serviços de um profissional competente quando precisar desse tipo de assistência.</b></div>
   <div><br></div>
   <div>Considerando que se o USUÁRIO estiver aceitando este Termo em nome de terceiros, este declara e garante que: (i) tem plena autoridade legal para sujeitar seu empregador (ou a entidade em questão) a estes termos e condições; (ii) leu e entendeu este Contrato e (iii) concorda, em nome da parte que você representa, com os termos deste Contrato.</div>
   <div><br></div>
   <div><b>Considerando que a T2Ti se reserva o direito de alterar este Contrato a qualquer momento e que as alterações entrem em vigor quando divulgadas por meio de seu website ou quando informar o USUÁRIO por outros meios, incluindo atualizações do SOFTWARE. Nestes casos, a continuação do uso pelo USUÁRIO indicará sua concordância com as alterações.</b></div>
   <div><br></div>
   <div>Considerando que registrando-se, acessando e utilizando o SOFTWARE de qualquer forma, incluindo navegação, visualização, download, geração, recebimento e transmissão de quaisquer dados, informações ou mensagens, Você manifesta Sua expressa concordância, em Seu nome e em nome da Sua empresa ou em nome do Seu empregador para com estes Termos, conforme periodicamente atualizados, seja Você USUÁRIO registrado dos Serviços ou não, pelo que Você se compromete a respeitar e cumprir todas as disposições aqui contidas, bem como as disposições dos avisos legais que regulam a utilização dos Aplicativos e dos Serviços.</div>
   <div><br></div>
   <div><br></div>
   <div>
      <b>
      <font style="color: #0000ff; font-size: 18px;">
      1. DEFINIÇÕES
      </font>
      </b>
   </div>
   <div><br></div>
   <div>1.1. Para efeitos do presente instrumento, todas as palavras e expressões constantes da lista abaixo, deverão ser entendidas conforme o respectivo significado:</div>
   <div><br></div>
   <div>1.1.1. <b>USUÁRIO:</b> 
      É a pessoa física responsável pela gestão do cadastro e pela utilização em nome do estabelecimento empresarial que deseja gerenciar seus dados a partir do uso do serviço oferecido pelo SOFTWARE.
   </div>
   <div><br></div>
   <div>1.1.2. <b>SOFTWARE:</b> 
      É a ferramenta denominada “T2Ti Pegasus PDV”, que possibilita que o USUÁRIO gerencie suas vendas, compras, controle de estoque, financeiro e emissão de Nota Fiscal de Consumitor Eletrônica (NFC-e) por seus próprios critérios e necessidades, seguindo as configurações definidas pelo USUÁRIO. 
      De acordo com a Lei nº. 9609/98 trata-se da expressão de um conjunto organizado de instruções em linguagem natural ou codificado, contido em suporte físico de qualquer natureza, de emprego necessário em máquinas automáticas de tratamento da informação, dispositivos, instrumentos ou equipamentos periféricos, baseados em técnica digital ou análoga, para fazê-los funcionar de modo e para fins determinados. Neste Contrato, SOFTWARE dirá respeito ao programa de computador de PROPRIEDADE da T2Ti devidamente licenciado.
   </div>
   <div><br></div>
   <div>1.1.3. <b>INFORMAÇÕES DE CONTA:</b> 
      Tratam-se das informações e dados relativos aos colaboradores, ao estabelecimento empresarial, incluindo logins, senhas e demais informações necessárias para acessar, coletar, armazenar e tratar as informações obtidas pelo SOFTWARE.
   </div>
   <div><br></div>
   <div>1.1.4. <b>INFORMAÇÕES PESSOAIS:</b> 
      Trata-se de qualquer informação disponibilizada pelo USUÁRIO que o identifique ou ao estabelecimento empresarial que representa, tais como nome, endereço, telefone, e-mail, número de documentos, etc.
   </div>
   <div><br></div>
   <div>1.1.5. <b>INFRAESTRUTURA:</b> 
      Trata-se do equipamento de armazenagem do SOFTWARE e do banco de dados utilizado por este, incluindo-se o servidor e demais equipamentos necessários.
   </div>
   <div><br></div>
   <div>1.1.6. <b>IMPLANTAÇÃO:</b> 
      Entenda-se como capacitar o USUÁRIO-chave do estabelecimento empresarial contratante, para a perfeita e correta instalação e utilização do sistema.
   </div>
   <div><br></div>
   <div>1.1.7. <b>MELHORIAS (UPGRADES)</b>: Significam alterações no SOFTWARE que melhoram seu desempenho e operacionalidade ou que incluam novas funcionalidades.</div>
   <div><br></div>
   <div>1.1.8. <b>MEI:</b> 
      Considera-se Microempreendedor Individual - MEI o empresário a que se refere o art. 966 da Lei 10.406/2002 (Código Civil), que tenha auferido receita bruta acumulada nos anos-calendário anterior e em curso de até R$ 81.000,00, ou seu limite proporcional se estiver no ano de início de atividade, e que atenda aos seguintes requisitos:
      <br /><br />
        <b>(i)</b> exerça tão-somente as ocupações constantes do Anexo XIII da Resolução CGSN 94/2011;<br />
        <b>(ii)</b> possua um único estabelecimento;<br />
        <b>(iii)</b> não participe de outra empresa como titular, sócio ou administrador;<br />
        <b>(iv)</b> não contrate mais de um empregado, observado o disposto no art. 96 da Resolução CGSN 94/2011.
      <br /><br />
      O MEI deve emitir Nota Fiscal apenas em operações que envolvam pessoas jurídicas, independentemente do serviço, valor da mercadoria ou contrato assinado. 
      Ou seja, o MEI não tem a necessidade de emitir Nota Fiscal para o cliente final, apenas quando o consumidor for uma outra empresa ou órgão público, ou quando a pessoa física assim o exigir.
      Entretanto, o MEI pode emitir Notas Fiscais eletrônicas, se preferir. Nesse caso, é preciso realizar o cadastro na Secretaria da Fazenda onde a empresa está registrada.
   </div>
   <div><br></div>
   <div>1.1.9. <b>SIMEI:</b> 
      É o sistema de recolhimento em valores fixos mensais dos tributos abrangidos pelo Simples Nacional, devidos pelo Microempreendedor Individual, conforme previsto no artigo 18-A da Lei Complementar nº 123, de 14 de dezembro de 2006.
   </div>
   <div><br></div>
   <div>1.1.10. <b>NFC-e:</b> 
      Nota Fiscal do Consumidor Eletrônica (NFC-e) é um documento emitido para o consumidor final. 
      Sua função consiste em oferecer as informações sobre o produto adquirido, como valor de compra, tributos e demais características. 
      A emissão da NFC-e é fundamental para fins de fiscalização e comprovação tributária.
   </div>
   <div><br></div>
   <div>1.1.11. <b>Certificado Digital:</b> 
      Certificado digital é um documento eletrônico que contém dados sobre a pessoa física ou jurídica que o utiliza, servindo como uma identidade virtual que confere validade jurídica e aspectos de segurança digital em transações digitais.
      É necessário possuir um Certificado Digital do tipo A1 para a emissão da NFC-e.
   </div>
   <div><br></div>
   <div>1.1.12. <b>Módulo Gratuito - Lite - Free:</b> 
      Trata-se da versão do SOFTWARE em que o USUÁRIO não paga nada para utilizá-lo. Nessa versão o USUÁRIO poderá realizar todos os controles oferecidos
      pelo SOFTWARE, sendo que o comprovante emitido é um RECIBO sem valor fiscal. Este módulo deve ser utilizado apenas por MEI devidamente cadastrado
      no SIMEI. É de responsabilidade exclusiva do usuário a emissão do recibo sem valor fiscal. Caso a empresa inscrita no SIMEI venha a não 
      mais ser enquadrada como MEI por conta de seu faturamento, o usuário deverá emitir o respectivo comprovante fiscal de acordo com a legislação.
      A T2Ti não se responsabiliza pelo fato de o usuário estar emitindo Recibos quando na verdade deveria emitir comprovantes fiscais (NFC-e, SAT ou MFE).
      O usuário é ciente de suas responsabilidades perante o fisco e deve responder pelos seus atos.
   </div>
   <div><br></div>
   <div>1.1.13. <b>Módulo Fiscal - Professional:</b> 
      Trata-se da versão do SOFTWARE em que o USUÁRIO paga uma taxa (mensal, semestral ou anual) para utilizá-lo. Nessa versão o USUÁRIO poderá realizar todos os controles oferecidos
      pelo SOFTWARE, sendo que o comprovante fiscal emitido é a NFC-e.
   </div>
   <div><br></div>
   <div><br></div>
   <div>
      <b>
      <font style="color: #0000ff; font-size: 18px;">
      2. OBJETO
      </font>
      </b>
   </div>
   <div><br></div>
   <div>2.1. O objeto deste contrato é o estabelecimento das condições de uso do SOFTWARE da T2Ti, de forma não exclusiva e intransferível, que proporciona ao USUÁRIO 
   o gerenciamento local de suas vendas, seja por emissão de recibo (no caso de MEI) ou por emissão de NFC-e, sendo possível ainda realizar o controle
   de compras, controle de estoque e controle financeiro (contas a pagar e contas a receber).</div>
   <div><br></div>
   <div>2.1.1. O objeto contratado não inclui, de forma alguma, acesso à Internet e infraestrutura local no USUÁRIO. Desta forma, será de integral e exclusiva responsabilidade do USUÁRIO obter, de forma independente e às suas custas, o equipamento, SOFTWAREs e os serviços necessários para garantir sua conexão à Internet e ao SOFTWARE que proporciona acesso aos Serviços.</div>
   <div><br></div>
   <div>2.1.2. A T2Ti poderá incluir links que remetam a páginas de Internet, conteúdos ou recursos de terceiros, os quais não estão sob controle da T2Ti. <b>Em razão disto, o USUÁRIO reconhece e concorda expressamente que esta não terá qualquer responsabilidade sobre referidas páginas, conteúdos ou recursos.</b></div>
   <div><br></div>
   <div>2.2. Qualquer pessoa que pretenda utilizar este SOFTWARE e os demais serviços oferecidos por este ou vinculados a este no site da T2Ti deverá aceitar estes Termos e as demais políticas eventualmente disponibilizadas.</div>
   
   <div><br></div>
   <div><br></div>
   <div>
      <b>
      <font style="color: #0000ff; font-size: 18px;">
      3. CAPACIDADE PARA CONTRATAR E DO CADASTRO
      </font>
      </b>
   </div>
   <div><br></div>   
   
   <div>3.1.     Para utilizar o SOFTWARE é necessária a realização de um cadastro prévio, no qual o USUÁRIO deve informar um e-mail válido, que será confirmado na sequência por meio do envio de um e-mail automático, bem como demais dados requeridos.</div>
   <div><br></div>
   <div>3.2.     O USUÁRIO deverá ter, no mínimo, 18 (dezoito) anos de idade completos, capacidade civil e declarar e garantir que as informações prestadas são verdadeiras e que leu, compreendeu, concordou e está integralmente de acordo com o disposto neste Termo.</div>
   <div><br></div>
   <div>3.3. O USUÁRIO declara que é responsável legal e/ou possui autorização para realizar a gestão do SOFTWARE.</div>
   <div><br></div>
   <div>3.4. Quando solicitado, o USUÁRIO concorda em fornecer informações verdadeiras, corretas, atualizadas e completas (os “Dados de Cadastro”), conforme solicitados no formato de cadastro disponibilizado, sob pena de responsabilização nos termos da legislação aplicável vigente.</div>
   <div><br></div>
   <div>3.5. A T2Ti dependerá dos seus Dados de Cadastro para avaliar sua situação de negócio, para fornecer informação sobre os serviços, 
   para configurar o ambiente para emissão da NFC-e, ou, alternativamente, para identificar e/ou entrar em contato com o USUÁRIO. <b>Se os Dados de Cadastro não forem verdadeiros e corretos, ou estiverem desatualizados e incompletos, a T2Ti poderá encerrar o licenciamento e todos os usos correntes ou futuros dos Serviços, respeitando o Contrato de Licenciamento firmado entre as partes.</b></div>
   <div><br></div>
   <div>3.6. O USUÁRIO poderá receber uma senha e designação de conta no momento em que completar o processo de cadastro, sendo certo que tais dados são pessoais e intransferíveis (os “Dados de Acesso”). O USUÁRIO é o único e exclusivo responsável por manter a confidencialidade de tais dados, bem como por todas as atividades que ocorrerem mediante o emprego de seus Dados de Acesso.</div>
   <div><br></div>
   <div>3.6.1. Neste sentido, o USUÁRIO obriga-se a:</div>
   <div><br></div>
   <div><b>(i)</b> 
      notificar imediatamente a T2Ti de qualquer uso não autorizado de seus Dados de Acesso ou qualquer outra violação de segurança, incluindo, mas não se limitando, o extravio, perda ou roubo de seus Dados de Acesso; e
   </div>
   <div><b>(ii)</b> 
      efetuar logout em sua conta ao final de cada sessão de utilização.
   </div>
   <div><b>(iii)</b> 
      notificar a T2Ti sobre desligamentos de USUÁRIOs do SOFTWARE.
   </div>
   <div><b>(iv)</b> 
      manter os dados dos USUÁRIOs do SOFTWARE atualizados.
   </div>
   <div><br></div>
   <div>3.6.2. A T2Ti não será responsável por qualquer perda ou dano decorrente da falha do USUÁRIO em cumprir ao que estabelece esta seção.</div>

   <div><br></div>
   <div><br></div>
   <div>
      <b>
      <font style="color: #0000ff; font-size: 18px;">
      4. DA RESPONSABILIDADE DE INSERÇÃO E DA GESTÃO DOS DADOS NO SOFTWARE
      </font>
      </b>
   </div>
   <div><br></div>   

   <div>4.1.     Da responsabilidade quanto aos dados disponibilizados e do uso do SOFTWARE:</div>
   <div><br></div>
   <div>4.1.1.  O USUÁRIO está ciente de que todas as informações e dados são inseridos, produzidos e disponibilizados sob sua responsabilidade, sem que haja qualquer tipo de modificação ou criação por parte do SOFTWARE, que não cria, não edita, e não é, de qualquer forma, responsável pelo conteúdo das informações e dados introduzidos no sistema, na medida em que o serviço prestado restringe-se à disponibilização de um SOFTWARE de facilitação do gerenciamento dos dados do USUÁRIO.</div>
   <div><br></div>
   <div>4.1.2. O USUÁRIO concorda que é responsável pelas definições do SOFTWARE, por seus próprios critérios, interesses e necessidades.</div>
   <div><br></div>
   <div><b>4.3. A T2Ti não se responsabiliza pela existência, quantidade, qualidade, estado, integridade ou legitimidade dos dados, conteúdos e informações inseridas pelo USUÁRIO, na medida em que não realiza qualquer controle quanto ao uso dos dados, restringindo-se a garantir o funcionamento do sistema.</b></div>
   <div><br></div>
   <div><b>4.4. Em nenhum caso a T2Ti será responsável pelo lucro cessante ou por qualquer outro dano e/ou prejuízo que o USUÁRIO possa sofrer devido às configurações estabelecidas no SOFTWARE.</b></div>
   <div><br></div>
   <div><b>4.5. Em nenhum caso a T2Ti será responsável por problemas advindos pelo uso mal intencionado do SOFTWARE. É de inteira responsabilidade do USUÁRIO emitir o comprovante fiscal em situações em que é obrigado por lei.</b></div>
   <div><br></div>
   <div>4.6. A T2Ti não se responsabiliza pelo serviço de instalação de seus aplicativos nos dispositivos do USUÁRIO.</div>
   <div><br></div>
   <div>4.7. A T2Ti não se responsabiliza por eventuais erros e/ou falhas apresentadas pelo SOFTWARE que tenham por causa problemas nos computadores, dispositivos móveis ou na rede utilizada pelo USUÁRIO, sendo certo que, nesses casos, o USUÁRIO assume toda a responsabilidade pelo erro e/ou falha apresentada.</div>
   <div><br></div>
   <div>4.8.     O USUÁRIO é responsável por toda a atividade que ocorrer em sua conta de acesso aos serviços.</div>
   <div><br></div>
   <div><b>4.9. O USUÁRIO é exclusivamente responsável pelo cumprimento de todas as leis aplicáveis ao seu negócio, incluindo leis e regulamentos, e quaisquer licenças ou contratos a que estiver obrigado.</b></div>
   <div><br></div>
   <div>4.10. O USUÁRIO garante que seus arquivos estão livres de quaisquer malware, vírus, cavalos de Troia, spyware, vermes, ou outro código malicioso ou danoso.</div>
   <div><br></div>
   <div>4.11. O USUÁRIO se responsabiliza ​​por: (a) manter a confidencialidade da senha e das Contas de Administrador; (b) designar quem está autorizado a acessar as Contas de Administrador e (c) assegurar que todas as atividades que ocorrerem em conexão com as Contas de Administrador cumpram os direitos e deveres contidos nestes Termos.</div>
   <div><br></div>
   <div><b>4.12. O USUÁRIO concorda que a emissão de documentos eletrônicos é de sua inteira e exclusiva responsabilidade, na medida em que feita a partir de configurações que são de responsabilidade do USUÁRIO, sob os seus exclusivos critérios, interesses e necessidades, sendo certo que o SOFTWARE não realiza conferência aos dados lançados no sistema.</b></div>
   <div><br></div>
   <div>4.13. A T2Ti garante ao USUÁRIO que o SOFTWARE deverá funcionar regularmente, se respeitadas as condições de uso definidas na documentação. Na ocorrência de falhas de programação (“bugs”), a T2Ti obrigar-se-á a corrigir tais falhas, podendo a seu critério substituir a cópia dos Programas com falhas por cópias corrigidas.</div>
   <div><br></div>
   <div>4.14. A T2Ti responsabiliza-se por manter as INFORMAÇÕES DE CONTA, INFORMAÇÕES ADMINISTRATIVAS e INFORMAÇÕES PESSOAIS do USUÁRIO, bem como seus registros de acesso, em sigilo, sendo que as referidas INFORMAÇÕES serão armazenadas em ambiente seguro, sendo respeitadas a intimidade, a vida privada, a honra e a imagem do USUÁRIO, em conformidade com as disposições da Lei nº 12.965/2014 e com a Política de Privacidade.</div>
   <div><br></div>
   <div>4.15. Exceto no caso de conduta dolosa comprovada, em nenhum momento a T2Ti será responsável por perda ou dano de qualquer natureza que surja como resultado de uso do SOFTWARE ou qualquer outra informação, dados, ou serviço fornecido através desta Infraestrutura.</div>
   <div><br></div>
   <div>4.16. Em nenhuma hipótese a T2Ti será responsável por quaisquer danos indiretos, de qualquer natureza, que possam, direta ou indiretamente, ser atribuíveis ao uso, ou à incapacidade de uso do SOFTWARE, mesmo se advertida sobre a possibilidade de tais danos ou se tais danos fossem previsíveis.</div>
   <div><br></div>
   <div>4.17. A T2Ti não é responsável perante o USUÁRIO por qualquer atraso ou não execução do SOFTWARE, ou falha em acessar a Infraestrutura, decorrente de qualquer causa além do razoável controle.</div>
   <div><br></div>
   <div>4.18. O USUÁRIO é responsável por todas as obrigações perante terceiros decorrentes da utilização do SOFTWARE, incluindo contratuais, trabalhistas, tributários e passivos regulatórios.</div>
   <div><br></div>
   <div>4.19.  A T2Ti não garante que o SOFTWARE será ininterrupto ou livre de erros, que defeitos serão corrigidos ou que o servidor em que ele é disponibilizado ou qualquer sistema conectado a ele está livre de vírus ou outros componentes nocivos.</div>
   <div><br></div>
   <div><b>4.20. A T2Ti não se responsabiliza por:</b></div>
   <div><br></div>
   <div><b>1. Falha de operação, operação por pessoas não autorizadas ou qualquer outra causa em que não possua culpa;</b></div>
   <div><b><br></b></div>
   <div><b>2. Cumprimento dos prazos legais do USUÁRIO para a entrega de documentos fiscais ou pagamentos;</b></div>
   <div><b><br></b></div>
   <div><b>3. Danos ou prejuízos decorrentes de decisões administrativas, gerenciais ou comerciais tomadas com base nas informações fornecidas pelo SOFTWARE;</b></div>
   <div><b><br></b></div>
   <div><b>4. Problemas advindos de casos fortuitos ou de força maior, nos termos da legislação;</b></div>
   <div><b><br></b></div>
   <div><b>5. Eventuais problemas oriundos de ações de terceiros, que possam interferir na qualidade;</b></div>
   <div><b><br></b></div>
   <div><b>6. Danos causados a terceiros em razão de culpa ou dolo do USUÁRIO;</b></div>
   <div><b><br></b></div>
   <div><b>7. Revisar as INFORMAÇÕES DE CONTA fornecidas pelo USUÁRIO, bem como as demais informações obtidas pelo USUÁRIO ou por sites de terceiros, seja no que tange à precisão dos dados quanto à legalidade, ameaça de violação, etc.</b></div>
   <div>&nbsp;</div>
   <div><br></div>
   <div>4.21.  O USUÁRIO declara, neste ato, que possui autoridade para fornecer as informações necessárias para o SOFTWARE e concorda que analisará e cumprirá todos os termos de Produto e Serviço de Terceiros, não utilizará os Serviços e Produtos de terceiros de forma que infrinja ou viole direitos do SOFTWARE ou de terceiros.</div>
   <div><br></div>
   <div>4.22. A T2Ti responsabiliza-se a adotar as medidas de segurança adequadas ao padrão de mercado para a proteção das informações do USUÁRIO. <b>Contudo, o USUÁRIO, desde já, reconhece que nenhum sistema, servidor ou SOFTWARE está absolutamente imune a ataques, não sendo o SOFTWARE responsável por qualquer exclusão, obtenção utilização ou divulgação não autorizada de informações que seja resultante de ataques.</b></div>
   <div><br></div>
   <div>4.23. O USUÁRIO expressamente declara e garante que:</div>
   <div><br></div>
   <div>1. Não utilizará o SOFTWARE para fins ilegais;</div>
   <div><br></div>
   <div>2. Não veiculará informações sobre atividades ilegais e incitação ao crime;</div>
   <div><br></div>
   <div>3. Não veiculará material pornográfico;</div>
   <div><br></div>
   <div>4. Não divulgará informação relativa à pirataria do SOFTWARE;</div>
   <div><br></div>
   <div>5. Não divulgará material protegido por direitos autorias ou confidencialidade sem a autorização dos seus titulares;</div>
   <div><br></div>
   <div>6. Não se fará passar por outra pessoa, empresa ou entidade;</div>
   <div><br></div>
   <div>7. Não coletará ou divulgará dados dos USUÁRIOs;</div>
   <div><br></div>
   <div>8. Não modificará, adaptará, fará engenharia reversa do SOFTWARE;</div>
   <div><br></div>
   <div>9. Não enviará mensagens não solicitadas, reconhecidas como “spam, “junk mail” ou correntes de&nbsp;</div>
   <div>correspondência;</div>
   <div><br></div>
   <div>10. Não utilizará o SOFTWARE para enviar quaisquer tipos de vírus de computador;</div>
   <div><br></div>
   <div>11. Não obterá ou tentará obter acesso não autorizado;</div>
   <div><br></div>
   <div>12. Não interferirá com o funcionamento normal da Infraestrutura.</div>
   <div><br></div>
   <div>4.24. A T2Ti reserva-se o direito de suspender ou bloquear imediatamente o acesso do USUÁRIO à Infraestrutura e a remover quaisquer informações ou dados que considere uma violação de qualquer um destes Termos Gerais, sem aviso prévio e/ou disponibilizar dita informação quando solicitada por órgãos públicos ou por ordem judicial.</div>
   <div><br></div>
   <div>4.25. A T2Ti trabalha e envidará os seus maiores esforços para manter a Infraestrutura e os Serviços em funcionamento, contudo, todos os serviços online estão sujeitos a interrupções e paradas ocasionais.</div>
   <div><br></div>
   <div>4.26. A T2Ti compromete-se a prestar os serviços objeto deste contrato com emprego de pessoal qualificado e observando as melhores técnicas aplicáveis.  Entretanto, o USUÁRIO será a única parte responsável pela verificação da idoneidade dos dados de entrada e inserção de parâmetros operacionais configuráveis pelo USUÁRIO, bem como pelo controle da qualidade e consistência dos dados de saída e materiais gerados pelo emprego do SOFTWARE, os quais deverão verificar sempre antes de utilizá-los em quaisquer aplicações que dependam de forma crítica da exatidão dos mesmos.</div>
   <div><br></div>
   <div>4.27. A T2Ti responsabiliza-se perante o USUÁRIO pela observância das normas trabalhistas, previdenciárias e de higiene e segurança do trabalho relativas a todo o pessoal que direta ou indiretamente, sob qualquer modalidade, venha a utilizar para dar cumprimento ao objeto deste contrato.</div>
   <div><br></div>
   <div>4.28. A T2Ti compromete-se a repetir, sem qualquer ônus para o USUÁRIO, quaisquer serviços realizados de forma deficiente, bem como a reparar qualquer dano decorrente deste tipo de evento, uma vez que o USUÁRIO tenha previamente observado todas as condições previstas neste contrato.</div>
   <div><br></div>
   <div>4.29. A T2Ti não se responsabiliza, em nenhuma hipótese, por perdas ou geração de passivos fiscais, trabalhistas ou previdenciários para o estabelecimento empresarial do USUÁRIO por força de decisões de tribunais ou de alterações legislativas, municipais, estaduais ou de acordos/convenções de sindicatos que venham a alterar o os parâmetros de cálculo no SOFTWARE, responsabilizando-se apenas pelas mudanças de legislações federais.</div>
   <div><br></div>
   <div><b>4.30. A T2Ti não se responsabiliza por quaisquer ações geradas antes da assinatura do presente contrato, especialmente por quaisquer cálculos e processos realizados por SOFTWAREs anteriores, cujos dados foram migrados para o sistema da T2Ti.</b></div>
   <div><br></div>
   <div>4.31. Por fim, são responsabilidades do USUÁRIO:&nbsp;</div>
   <div><br></div>
   <div>a) Operar o SOFTWARE em conformidade com as especificações e orientações da T2Ti, incluindo-se o conjunto de atividades de preparação, seleção e digitação das informações inerentes e necessárias para atingir os objetivos a que se propõe;</div>
   <div><br></div>
   <div>b) Contratar terceiros e seus SOFTWAREs, se necessários, para implantar e manter o melhor funcionamento do SOFTWARE da T2Ti, bem como seus aplicativos e funcionalidades;</div>
   <div><br></div>
   <div>c) Disponibilizar a infraestrutura necessária para o funcionamento do SOFTWARE, ou seja, garantir o ambiente básico para execução dos Módulos do SOFTWARE, tal como hardware adequado (capacidade de processador, memória, espaço em disco, entre outros), Sistema Operacional, Banco de Dados ou outros SOFTWARES interdependentes), infraestrutura de comunicação (links, equipamentos de rede) e ambiente de trabalho;</div>
   <div><br></div>
   <div>d) Realizar regularmente cópias de segurança (backup’s) com o uso dos meios apropriados e mídias comumente utilizadas para este fim;</div>
   <div><br></div>
   <div>e) Controlar a qualidade das informações introduzidas e produzidas pelo SOFTWARE e a correta aplicação da legislação vigente, qual seja pertinente aos propósitos de uso do SOFTWARE;</div>
   <div><br></div>
   <div>f) Repassar somente informações corretas e completas à T2Ti;</div>
   <div><br></div>
   <div>g) Garantir a disponibilidade de profissionais para o esclarecimento de dúvidas, a resolução de problemas e executar todas as atividades previamente definidas, bem como, efetuar todos os esforços para o cumprimento dos prazos estabelecidos;</div>
   <div><br></div>
   <div>h) Resolver quaisquer problemas advindos do acesso via WEB, visto que as partes anuem que a T2Ti não tem controle e/ou responsabilidade sobre a estrutura do estabelecimento empresarial do USUÁRIO tampouco sobre as ferramentas de proteção contra invasões remotas, sendo que qualquer invasão ou acesso remoto a dados ou sob sua guarda não significará em hipótese alguma falha no SOFTWARE ou na prestação de serviços da T2Ti;</div>
   <div><br></div>
   <div>i) Tomar todas as medidas necessárias para que o Sistema seja utilizado com observância dos Termos Gerais e Condições de Uso e se responsabilizará por quaisquer violações à propriedade intelectual da T2Ti ou de qualquer terceiro.</div>

   <div><br></div>
   <div><br></div>
   <div>
      <b>
      <font style="color: #0000ff; font-size: 18px;">
      5. NÍVEL DE SERVIÇO
      </font>
      </b>
   </div>
   <div><br></div>

   <div><b>5.1. O SOFTWARE em sua versão gratuita, que não precisa entrar em contato com o servidor da T2Ti ou com os servidores da SEFAZ, garante 100% de disponibiliade no dispositivo do USUÁRIO.
   Na versão Fiscal, serão empreendidos esforços comercialmente razoáveis para tornar o SOFTWARE disponível, no mínimo, 99% (noventa e nove por cento) durante cada Mês de Serviço.</b></div>
   <div><br></div>
   <div>5.3. O compromisso de nível de serviço não se aplica caso as circunstâncias de indisponibilidade resultem:
   <br />(i) de uma interrupção do fornecimento de energia elétrica ou paradas emergenciais não superiores a 2 (duas) horas ou que ocorram no período das 24h às 6:00h (horário de Brasília); 
   <br />(ii) forem causadas por fatores que fujam ao razoável controle do SOFTWARE, inclusive casos de força maior ou de acesso à Internet e problemas correlatos; 
   <br />(iii) resultem de quaisquer atos ou omissões do USUÁRIO ou de terceiros; 
   <br />(iv) resultem do equipamento, SOFTWARE ou outras tecnologias que o USUÁRIO usar e que impeçam o acesso regular; 
   <br />(v) resultem de falhas de instâncias individuais não atribuíveis à indisponibilidade do USUÁRIO; 
   <br />(vi) resultem de alterações realizadas na forma de acesso às INFORMAÇÕES DE CONTA do USUÁRIO; 
   <br />(vii) resultem de práticas de gerenciamento da rede que possam afetar sua qualidade.</div>
   <br />(viii) problemas nos servidores da SEFAZ.</div>

   <div><br></div>
   <div><br></div>
   <div>
      <b>
      <font style="color: #0000ff; font-size: 18px;">
      6. NOTIFICAÇÃO SOBRE INFRAÇÕES
      </font>
      </b>
   </div>
   <div><br></div>

   <div>6.1.     Caso qualquer pessoa, USUÁRIO ou não, se sinta lesado em relação a qualquer problema gerado pelo SOFTWARE, poderá encaminhar à T2Ti uma notificação, por escrito, relatando a demanda, a qual notificará o USUÁRIO com as providências cabíveis, sem que lhe seja imputada qualquer responsabilidade.</div>
   <div><br></div>
   <div>6.2.     A retirada de qualquer conteúdo ou USUÁRIO pelo SOFTWARE, de forma unilateral, dependerá de efetiva comprovação ou forte evidência da ilegalidade ou infração à lei, direitos de terceiros e/ou aos Termos de Uso.</div>
   <div><br></div>
   <div>6.3.     As notificações deverão ainda conter a identificação do material que supostamente representa a infração ou informações necessárias para a devida identificação do Conteúdo e providências junto ao USUÁRIO.</div>
   <div><br></div>
   <div>6.3.1.  O notificante declarará que as informações contidas na notificação são precisas e verdadeiras, sob pena de incorrer nas consequentes responsabilidades cíveis e penais, e que o notificante está autorizado a agir em nome do titular do direito supostamente violado.</div>
   <div><br></div>
   <div>6.4.     As notificações deverão ser encaminhadas à PLATAFORMA para o seguinte e-mail: t2ti.com@gmail.com.</div>

   <div><br></div>
   <div><br></div>
   <div>
      <b>
      <font style="color: #0000ff; font-size: 18px;">
      7. VIGÊNCIA
      </font>
      </b>
   </div>
   <div><br></div>

   <div>7.1.     O presente contrato vigerá enquanto o USUÁRIO utilizar o SOFTWARE e/ou até que uma nova versão do Termo seja lançada e aceita pelo USUÁRIO.</div>

   <div><br></div>
   <div><br></div>
   <div>
      <b>
      <font style="color: #0000ff; font-size: 18px;">
      8. SUPORTE TÉCNICO
      </font>
      </b>
   </div>
   <div><br></div>

   <div>8.1. O SOFTWARE T2Ti Pegasus PDV funciona no esquema SUPORTLESS, ou seja, a T2Ti cobra um valor módico e não oferece suporte para a aplicação, sendo que o USUÁRIO deve assistir às vídeo aulas no canal da T2Ti no Youtube para compreender como utilizar o SOFTWARE.</div>
   <div><br></div>
   <div>8.2. O USUÁRIO poderá entrar em contato com a T2Ti para solicitar Suporte Técnico, assim como Assessoria Operacional. A T2Ti avaliará a
   necessidade do usuário e poderá oferecer um serviço personalizado cobrando o respectivo valor do USUÁRIO.
   Tal serviço poderá ser prestado por Acesso Remoto, solução que utiliza ferramentas de comunicação e conexão que permite acessar o computador do 
   CONTRATANTE para atividades de verificação, ajustes e demais atividades inerentes ao Suporte Técnico e Assessoria Operacional sobre o SOFTWARE licenciado.</div>

   <div><br></div>
   <div><br></div>
   <div>
      <b>
      <font style="color: #0000ff; font-size: 18px;">
      9. EXTINÇÃO DO CONTRATO
      </font>
      </b>
   </div>
   <div><br></div>

   <div>9.1. O USUÁRIO e a T2Ti poderão rescindir estes Termos e Condições a qualquer momento. No caso da T2Ti, deve existir notificação e o SOFTWARE deve ainda funcionar
   pelo tempo que foi contratado pelo USUÁRIO. No caso do USUÁRIO, basta que o mesmo deixe de utilizar a aplicação gratuita ou não realize mais
   os pagamentos do plano, sendo que, quando este expirar, não mais terá acesso aos serviços pagos. Assim sendo, o USUÁRIO não precisa notificar à T2Ti que deixará de utilizar o SOFTWARE.</div>
   <div><br></div>
   <div>9.2. A T2Ti reserva-se o direito de rescindir o contrato, restringir ou suspender o uso dos serviços por parte do USUÁRIO, mediante notificação, a qualquer tempo, sempre que a utilização dos serviços violar o presente Termo.</div>
   <div><br></div>
   <div>9.3. O USUÁRIO autoriza expressamente a T2Ti a manter em seu cadastro as informações fornecidas por ele, bem como autoriza a fornecer as informações constantes de referido cadastro a autoridades públicas que as solicitarem conforme permitido pela legislação em vigor e a seus parceiros estratégicos, comerciais ou técnicos, com a finalidade de oferecer melhores condições de promoções e/ou conteúdo, desde que não individualize os USUÁRIOs e estabelecimentos empresariais, nos termos da Política de Privacidade.</div>

   <div><br></div>
   <div><br></div>
   <div>
      <b>
      <font style="color: #0000ff; font-size: 18px;">
      10. UTILIZAÇÃO DA BASE DE DADOS
      </font>
      </b>
   </div>
   <div><br></div>

   <div>10.1.   O USUÁRIO expressamente aceita que a T2Ti e/ou qualquer de seus parceiros enviem mensagens de e-mail de caráter informativo, referentes a comunicações específicas sobre serviços disponibilizados ou que venham a ser disponibilizados, bem como outras mensagens de natureza comercial, nos Termos da Política de Privacidade. Caso o USUÁRIO não deseje mais receber referidas mensagens deverá solicitar o cancelamento do seu envio junto à T2Ti.</div>
   <div><br></div>
   <div>10.2. As informações referentes à data e hora de acesso e ao endereço de protocolo de internet utilizado pelo USUÁRIO para acessar o SOFTWARE permanecerão armazenadas por 6 (meses) a contar da data de cada acesso realizado, independentemente do término da relação jurídica e comercial entre as partes, em cumprimento ao disposto no Artigo 15 da Lei nº 12.965/2014, podendo ser armazenados por um período maior de tempo mediante ordem judicial.</div>

   <div><br></div>
   <div><br></div>
   <div>
      <b>
      <font style="color: #0000ff; font-size: 18px;">
      11. DIREITOS DE PROPRIEDADE INTELECTUAL
      </font>
      </b>
   </div>
   <div><br></div>

   <div>11.1. Todos os direitos e propriedade intelectual no tocante ao SOFTWARE e à tecnologia permanecerão na propriedade exclusiva da T2Ti, mesmo que esta venha a desenvolver novas funcionalidades a pedido e remuneração do USUÁRIO. Portanto, a tecnologia objeto do licenciamento pelo presente contrato, incluindo seus programas, fluxogramas, aperfeiçoamentos, adaptações e demais funcionalidades, assim como toda a documentação técnica são de propriedade total e definitiva da empresa supracitada, de forma que os direitos autorais e outros direitos de propriedade intelectual relativos ao mesmo são iguais aos conferidos às obras literárias, nos moldes da legislação de direitos autorais vigentes no país, conforme expressa determinação do Artigo 2º e Parágrafos da Lei 9.609/98.</div>
   <div><br></div>
   <div>11.2. O USUÁRIO, ao adquirir o direito de uso do SOFTWARE, estará apenas autorizado a atualizá-lo na forma estabelecida no presente instrumento, sendo a ele vedada à utilização de métodos tais como engenharia reversa, descompilação, ou qualquer outro, que possibilite o acesso ao código fonte do SOFTWARE.</div>
   <div><br></div>
   <div>11.3. O USUÁRIO não poderá ceder a terceiros o SOFTWARE e/ou documentação fornecidos pela T2Ti sob qualquer pretexto, comprometendo-se por seus empregados ou prepostos a manter em boa guarda os acessos do SOFTWARE e a documentação recebida.</div>
   <div><br></div>
   <div>11.4. O SOFTWARE é configurado em modo padronizado, tendo em vista a interpretação dominante acerca da aplicação da legislação a que este se propõe, sendo que em algumas hipóteses será possível alterar parâmetros, visando sua adaptação às situações específicas ou para que reflitam uma interpretação particular do próprio USUÁRIO acerca da legislação.</div>
   <div><br></div>
   <div><b>11.5. Sempre que os parâmetros do sistema forem alterados pelo USUÁRIO, a T2Ti será totalmente isenta de qualquer responsabilidade pela respectiva geração de dados, visto que o USUÁRIO é o responsável direto pela parametrização do SOFTWARE.</b></div>
   <div><br></div>
   <div>11.6. Através deste contrato, é cedido ao USUÁRIO apenas o direito de uso da tecnologia em questão, sem a necessidade da apresentação ou fornecimento do código fonte ou estrutura interna do produto.</div>
   <div><br></div>
   <div>11.7. O USUÁRIO também concorda que não utilizará nenhum robô ou outros dispositivos automatizados ou processos manuais para monitorar ou copiar conteúdo do serviço, sob pena de responder perante a T2Ti pelas perdas e danos que causar, incluindo honorários advocatícios, quando necessários para a defesa dos interesses da T2Ti.</div>
   <div><br></div>
   <div>11.8. A T2Ti reserva-se o direito de modificar, suspender, terminar ou descontinuar qualquer aspecto do SOFTWARE a qualquer tempo, incluindo a disponibilidade de quaisquer Serviços, informações, características ou funcionalidades, bem como de impor limitações a certas características, funcionalidades ou serviços ou restringir USUÁRIO a partes ou à totalidade do SOFTWARE, mediante prévia notificação.</div>
   <div><br></div>
   <div>11.9. A T2Ti reserva-se, também, o direito de, a qualquer tempo ou título, controlar e/ou alterar a aparência, o desenvolvimento e/ou operações do SOFTWARE a seu exclusivo critério, bem como estabelecer e modificar os procedimentos para o contato entre as partes, sem a necessidade de notificação prévia.</div>
   <div><br></div>
   <div>11.10. Qualquer violação ao direito do autor do SOFTWARE importará numa multa de acordo com a legistação vigente, independente de perdas e danos apuradas judicialmente e interpelações criminais.</div>

   <div><br></div>
   <div><br></div>
   <div>
      <b>
      <font style="color: #0000ff; font-size: 18px;">
      12. DA ASSESSORIA TÉCNICA E OPERACIONAL
      </font>
      </b>
   </div>
   <div><br></div>

   <div>12.1. O SOFTWARE T2Ti Pegasus PDV funciona no esquema SUPORTLESS, ou seja, a T2Ti cobra um valor módico e não oferece suporte para a aplicação.
   No entanto, o USUÁRIO poderá solicitar um serviço de Assessoria Técnica e/ou Operacional, onde a T2Ti, após prévia análise de requisitos e custos, poderá 
   disponibilizar um ou mais técnicos para atendimento, local ou remoto.</div>
   <div><br></div>
   <div>12.2. O tempo aplicado em consultas inerentes ao Sistema Operacional, Aplicativos de Terceiros ou utilitários e produtos não pertencentes à T2Ti será considerado como Assessoria Operacional.</div>
   <div><br></div>
   <div>12.3. A hora técnica da Assessoria Operacional será equivalente a 60 (sessenta) minutos e o serviço será prestado em horário comercial, considerado das 08h00min às 12h00min e 13h00min às 18h00min, conforme horário de Brasília/BR, de segunda-feira à sexta-feira.</div>
   <div><br></div>
   <div>12.4. Serviços prestados fora do horário supracitado serão acrescidos do percentual de hora extraordinária em 50% (cinquenta por cento), e quando prestados em sábados, domingos e feriados, o valor hora terá acréscimo de 100% (cem por cento).</div>
   <div><br></div>
   <div>12.5. Os valores dos honorários por hora técnica de Assessoria Técnica e/ou Operacional serão acertados pelo USUÁRIO e pela T2Ti previamente antes da realização do serviço.</div>
   <div><br></div>
   <div>12.6. Os tempos gastos em deslocamentos serão cobrados tomando-se como base a unidade da T2Ti mais próxima do USUÁRIO, mediante prévia negociação entre as partes.</div>
   <div><br></div>
   <div>12.7. Na hipótese do usuário solicitar modificações na aplicação, a T2Ti apresentará orçamento prévio para realização do trabalho, devendo ser firmado instrumento de contrato específico para tal finalidade.</div>
   <div><br></div>

   <div><br></div>
   <div><br></div>
   <div>
      <b>
      <font style="color: #0000ff; font-size: 18px;">
      13. DA IMPLANTAÇÃO DO SOFTWARE
      </font>
      </b>
   </div>
   <div><br></div>

   <div>13.1. O processo de implantação so SOFTWARE é simples e seguro e deverá ser seguido de acordo com a vídeo aula que mostra como realizar a implantação (instalação) na respectiva plataforma do USUÁRIO.</div>
   <div><br></div>
   <div>13.2. Caberá à T2Ti a disponibilização de vídeo aulas gratuitas online em ambiente de fácil utilização que ensinem o funcionamento do SOFTWARE. </div>
   <div><br></div>
   <div>13.3. Caberá ao USUÁRIO assistir às vídeo aulas para compreender como utilizar o SOFTWARE.</div>
   <div><br></div>
   <div>13.4. Caberá ao USUÁRIO realizar as devidas parametrizações e configurações para que o SOFTWARE funcione a contento de acordo com a necessidade do USUÁRIO.</div>

   <div><br></div>
   <div><br></div>
   <div>
      <b>
      <font style="color: #0000ff; font-size: 18px;">
      14. DA ATUALIZAÇÃO E DA CUSTOMIZAÇÃO DO SOFTWARE
      </font>
      </b>
   </div>
   <div><br></div>

   <div>14.1. A Atualização do SOFTWARE compreende todas as alterações de programas e de sua respectiva documentação que a T2Ti venha a criar e que torne necessária à sua atualização, complementação ou reprogramação, visando melhorias ou instalação de novas operações ou por alterações na legislação.</div>
   <div><br></div>
   <div>14.2. A interpretação legal das normas editadas pelo governo e a sua implementação no SOFTWARE serão efetuadas com base nas publicações especializadas e divulgadas sobre cada matéria em veículos de comunicação de domínio público. Contudo, a responsabilidade pela anuência dos parâmetros será sempre do estabelecimento empresarial contratante e do USUÁRIO.</div>
   <div><br></div>
   <div>14.3. As interpretações divergentes por parte do estabelecimento empresarial contratante e do USUÁRIO, quando implementadas, serão consideradas como Customizações do SOFTWARE, sendo que a T2Ti não será obrigada a implementar alterações única e exclusivamente baseada na avaliação de um USUÁRIO, mas se obrigará a fazê-lo segundo requerimento da maioria de seus estabelecimentos empresariais clientes.</div>
   <div><br></div>
   <div>14.4. As modificações impostas por Associações, Sindicatos ou outros grupos específicos poderão ser implementadas mediante aprovação de orçamento prévio.</div>
   <div><br></div>
   <div>14.5. As melhorias e as novas funções introduzidas pela T2Ti no SOFTWARE originalmente licenciado serão distribuídas visando dotar o USUÁRIO sempre com a última versão do SOFTWARE.</div>
   <div><br></div>
   <div>14.6. Poderão ser realizadas complementações no SOFTWARE pela T2Ti por solicitação escrita do USUÁRIO. Nesse caso, serão cobradas como Customizações as horas trabalhadas na sede do estabelecimento empresarial contratante para levantamentos, implantação e treinamento.</div>
   <div><br></div>
   <div>14.7. As atividades de análise, programação, testes, documentação e distribuição das alterações efetuadas na sede da T2Ti serão faturadas conforme orçamento prévio ou apresentação de relatórios e resultados de cada fase.</div>
   <div><br></div>
   <div>14.8. A garantia de atualização do SOFTWARE expressa nesta cláusula não abrange as Customizações feitas no SOFTWARE por solicitação do USUÁRIO.</div>
   <div><br></div>
   <div>14.9. A Propriedade Intelectual das customizações realizadas pela T2Ti no SOFTWARE, mesmo que por solicitação da USUÁRIO, será exclusiva da T2Ti e poderá ser incorporada às versões distribuídas a outros clientes desta, sem que caiba qualquer tipo de reembolso ou ressarcimento ao USUÁRIO ou ao estabelecimento empresarial contratante.</div>

   <div><br></div>
   <div><br></div>
   <div>
      <b>
      <font style="color: #0000ff; font-size: 18px;">
      15. DA CONFIDENCIALIDADE
      </font>
      </b>
   </div>
   <div><br></div>

   <div>15.1. A CONTRATADA declara que armazenará as informações do estabelecimento empresarial contratante e do USUÁRIO com a mesma segurança e dedicação para a respectiva proteção como se suas fossem, contratando equipamentos e SOFTWAREs adequados para a guarda de todas os documentos e informações que estiverem em sua posse.</div>
   <div><br></div>
   <div>15.2. As demais regulamentações a respeito da coleta, guarda e uso das informações estão devidamente tratadas na Política de Privacidade disponível no seguinte link: https://t2tisistemas.com/privacy-policy/br/.</div>

   <div><br></div>
   <div><br></div>
   <div>
      <b>
      <font style="color: #0000ff; font-size: 18px;">
      16. DAS DISPOSIÇÕES GERAIS
      </font>
      </b>
   </div>
   <div><br></div>

   <div>16.1. O USUÁRIO concorda que a T2Ti poderá divulgar a celebração deste instrumento para fins comerciais, fazendo menção ao nome e à marca do USUÁRIO em campanhas comerciais, podendo, inclusive, divulgar mensagens enviadas de forma escrita ou oral, por telefone, para uso em sites, jornais, revistas e outras campanhas, mesmo após a rescisão destes Termos.</div>
   <div><br></div>
   <div>16.2. Os casos omissos e quaisquer dúvidas relativas à execução deste Contrato serão resolvidos por meio de consultas e mútuos entendimentos entre as Partes, assinando-se termo de aditamento sempre que necessário.</div>
   <div><br></div>
   <div>16.3. As Partes expressamente declaram e concordam que a demora ou omissão no exercício de direitos que lhes sejam assegurados por lei ou pelo presente instrumento não constituirá novação ou renúncia a tais direitos, nem prejudicará seu eventual e oportuno exercício.</div>
   <div><br></div>
   <div>16.4. A renúncia a direitos que lhes assistam em razão de lei ou do presente Contrato somente será válida se formalizada por escrito.</div>
   <div><br></div>
   <div>16.5. A nulidade ou invalidade de qualquer das cláusulas do presente Contrato não prejudicará a validade e eficácia das demais, que permanecerão em pleno vigor e efeito, devendo as Partes, nesse caso, negociarem de boa-fé, a redação de nova cláusula em substituição à que for considerada nula ou inválida, refletindo a intenção das Partes no presente Contrato.</div>
   <div><br></div>
   <div>16.6. Todas as correspondências, notificações e comunicações entre as partes deverão ser feitas via e-mail, fac-símile, carta protocolada, notificação cartorária ou qualquer outro meio idôneo que permita confirmação de recebimento, direcionadas aos endereços constantes do preâmbulo do presente Contrato, devendo a Parte que tiver alteração de endereço, e-mail, telefone ou fax comunicar a outra imediatamente, por escrito.</div>
   <div><br></div>
   <div>16.7. O USUÁRIO não poderá ceder, sublicenciar, subcontratar, transferir ou dispor de quaisquer direitos e obrigações no âmbito destes Termos de Uso sem o consentimento prévio da T2Ti. A T2Ti poderá ceder o Contrato ou os direitos dele decorrentes a qualquer uma das sociedades do grupo econômico do qual faz parte ou que possa vir a fazer parte no futuro, ficando obrigada a comunicar ao USUÁRIO sua intenção.</div>
   <div><br></div>
   <div>16.8. Os tributos e demais encargos fiscais que forem devidos, direta ou indiretamente, em virtude dos valores pagos ou recebidos através deste Contrato ou em virtude de sua execução serão de responsabilidade do contribuinte assim definido na norma tributária, sem direito a reembolso.</div>
   <div><br></div>
   <div>16.9. Estes Termos de Uso (junto com quaisquer termos e condições firmadas entre as partes, incluindo a Proposta Comercial, a Política de Privacidade e o Contrato de Licenciamento) contém o acordo integral entre as partes e substituem todos os acordos anteriores.</div>
   <div><br></div>
   <div>16.10. Se em algum momento, qualquer disposição (ou parte de qualquer disposição) destes Termos de Uso é, ou tornar-se ilegal, inválida ou inexequível em qualquer aspecto, sob a lei de qualquer jurisdição, isto não afetará ou prejudicará a legalidade, validade ou execução nessa ou em qualquer outra jurisdição de qualquer outra disposição (ou qualquer outra parte da mesma disposição) destes Termos de Uso.</div>

 <div><br></div>
   <div><br></div>
   <div>
      <b>
      <font style="color: #0000ff; font-size: 18px;">
      17. DO FORO E DA LEGISLAÇÃO APLICÁVEL
      </font>
      </b>
   </div>
   <div><br></div>

   <div>17.1. O presente contrato será regido pela legislação brasileira, elegendo as partes o Foro de Brasília, Distrito Federal, 
   como único competente para conhecer e dirimir quaisquer questões oriundas do presente Contrato, com expressa renúncia a qualquer outro, 
   por mais privilegiado que seja.</div>
   <div><br></div>
   <div>17.2. Estes Termos de Uso e todas as relações dele decorrentes são submetidas às leis da República Federativa do Brasil.</div>
   <div><br></div>
   <div><br></div>
</div>

<p id='bottom'><a href='#top'>Navegar para o Início do Documento</a></p>
""";