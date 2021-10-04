/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe DetalhePage relacionada à tabela [PESSOA_ENDERECO] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2020 T2Ti.COM                                          
                                                                                
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
*******************************************************************************/
import 'package:flutter/material.dart';

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'pessoa_endereco_persiste_page.dart';

class PessoaEnderecoDetalhePage extends StatefulWidget {
  final Pessoa pessoa;
  final PessoaEndereco pessoaEndereco;

  const PessoaEnderecoDetalhePage({Key key, this.pessoa, this.pessoaEndereco})
      : super(key: key);

  @override
  _PessoaEnderecoDetalhePageState createState() =>
      _PessoaEnderecoDetalhePageState();
}

class _PessoaEnderecoDetalhePageState extends State<PessoaEnderecoDetalhePage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ViewUtilLib.getThemeDataDetalhePage(context),
        child: Scaffold(
          appBar: AppBar(title: Text('Pessoa Endereco'), actions: <Widget>[
            IconButton(
              icon: ViewUtilLib.getIconBotaoExcluir(),
              onPressed: () {
                return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                  widget.pessoa.listaPessoaEndereco.remove(widget.pessoaEndereco);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                });
              },
            ),
            IconButton(
              icon: ViewUtilLib.getIconBotaoAlterar(),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PessoaEnderecoPersistePage(
                                pessoa: widget.pessoa,
                                pessoaEndereco: widget.pessoaEndereco,
                                title: 'Pessoa Endereco - Editando',
                                operacao: 'A')))
                    .then((_) {
                  setState(() {});
                });
              },
            ),
          ]),
          body: SingleChildScrollView(
            child: Theme(
              data: ThemeData(fontFamily: 'Raleway'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
				  ViewUtilLib.getPaddingDetalhePage('Detalhes de Pessoa'),
                  Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: Column(
                      children: <Widget>[
						ViewUtilLib.getListTileDataDetalhePage(
							widget.pessoaEndereco.logradouro ?? '', 'Logradouro'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.pessoaEndereco.numero ?? '', 'Número'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.pessoaEndereco.bairro ?? '', 'Bairro'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.pessoaEndereco.municipioIbge ?? '', 'Município IBGE'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.pessoaEndereco.uf ?? '', 'UF'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.pessoaEndereco.cep ?? '', 'CEP'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.pessoaEndereco.cidade ?? '', 'Cidade'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.pessoaEndereco.complemento ?? '', 'Complemento'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.pessoaEndereco.principal ?? '', 'É Endereço Principal'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.pessoaEndereco.entrega ?? '', 'É Endereço de Entrega'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.pessoaEndereco.cobranca ?? '', 'É Endereço de Cobrança'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.pessoaEndereco.correspondencia ?? '', 'É Endereço de Correspondência'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
