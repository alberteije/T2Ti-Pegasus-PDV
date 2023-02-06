/*
Title: T2Ti ERP 3.0                                                                
Description: Arquivo com widgets e métodos necessários para carregar imagens
                                                                                
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
*******************************************************************************/
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

import 'biblioteca.dart';

class CarregaImagem extends StatefulWidget {
  final Widget widgetFilho;
  final Function exibirImagemCallBack;

  const CarregaImagem({Key? key, required this.widgetFilho, required this.exibirImagemCallBack})
      : super(key: key);

  @override
  CarregaImagemState createState() => CarregaImagemState();
}

class CarregaImagemState extends State<CarregaImagem> {

  final ImagePicker _pickerImagem = ImagePicker();
  final _imagemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _exibirImagemPicker(context);
      },                            
      child: widget.widgetFilho,
    );
  }

  void _exibirImagemPicker(context) {
    _imagemController.text = '';
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: _getOpcoesImportacaoImagem(),
          ),
        );
      }
    );
  }

  List<Widget> _getOpcoesImportacaoImagem() {
    List<Widget> listaRetorno = [];
    listaRetorno.add(
      ListTile(
        leading: const Padding( 
          padding: EdgeInsets.all(5),
          child: Icon(Icons.cloud_download),
        ),
        title: _getEditUrl(), 
        onTap: () async {
          final ByteData imageData = await NetworkAssetBundle(Uri.parse(_imagemController.text)).load('');
          widget.exibirImagemCallBack(imageData);
        }
      ),
    );
    listaRetorno.add(
      ListTile(
        leading: const Icon(Icons.file_copy),
        title: const Text('Carregar Imagem'),
        onTap: () async {
          FilePickerResult? arquivoSelecionado = 
            await FilePicker.platform.pickFiles(
              dialogTitle: 'Selecione a imagem desejada'
            );
            if(arquivoSelecionado != null) {
              File file = File(arquivoSelecionado.files.first.path!);
              await widget.exibirImagemCallBack(file.readAsBytesSync());
            }                          
        },
      ),        
    );

    if (Biblioteca.isMobile()) {
      listaRetorno.add(
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Galeria de Imagens'),
          onTap: () {
            _getImagemGaleria();
            Navigator.of(context).pop();
          }
        ),       
      );
      listaRetorno.add(
        ListTile(
          leading: const Icon(Icons.photo_camera),
          title: const Text('Câmera'),
          onTap: () {
            _getImagemCamera();
            Navigator.of(context).pop();
          },
        ),        
      );
    }
    return listaRetorno;
  }
  
  _getImagemCamera() async {
    final pickedFile = await _pickerImagem.pickImage(
      source: ImageSource.camera, imageQuality: 50
    );
    widget.exibirImagemCallBack(await pickedFile?.readAsBytes());
  }

  _getImagemGaleria() async {
    final pickedFile = await _pickerImagem.pickImage(
      source: ImageSource.gallery, imageQuality: 50
    );
    if (pickedFile != null) {
      widget.exibirImagemCallBack(await pickedFile.readAsBytes());
    }
  }

  Widget _getEditUrl() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
          child: TextFormField(
            controller: _imagemController,
            decoration: getInputDecoration(
              'Informe a URL para a imagem',
              'URL da Imagem',
              true),
            onChanged: (text) {
            },
          ),
        ),
      ],
    );   
  }

 }
