object FPrincipal: TFPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Gerador Objeto JSON - DER'
  ClientHeight = 578
  ClientWidth = 994
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox4: TGroupBox
    Left = 281
    Top = 8
    Width = 425
    Height = 441
    Caption = 'Cliente'
    TabOrder = 1
    object Label5: TLabel
      Left = 11
      Top = 189
      Width = 45
      Height = 13
      Caption = 'Valida'#231#227'o'
    end
    object Label6: TLabel
      Left = 11
      Top = 392
      Width = 140
      Height = 13
      Caption = 'Tipo Controle (Persiste Page)'
    end
    object Label3: TLabel
      Left = 11
      Top = 349
      Width = 158
      Height = 13
      Caption = 'Campo de Lookup - Tipo de Dado'
    end
    object EditLabel: TLabeledEdit
      Left = 11
      Top = 35
      Width = 406
      Height = 21
      EditLabel.Width = 85
      EditLabel.Height = 13
      EditLabel.Caption = 'Label [DataTable]'
      TabOrder = 0
    end
    object EditLabelText: TLabeledEdit
      Left = 11
      Top = 75
      Width = 406
      Height = 21
      EditLabel.Width = 136
      EditLabel.Height = 13
      EditLabel.Caption = 'LabelText [InputDecoration]'
      TabOrder = 1
      TextHint = 'Tamb'#233'm para subtitle da ListTile em DetalhePage'
    end
    object ComboBoxValidacao: TComboBox
      Left = 11
      Top = 204
      Width = 318
      Height = 21
      TabOrder = 4
      Items.Strings = (
        'Numerico'
        'Alfanumerico'
        'Decimal'
        'CPF'
        'CNPJ'
        'DIA'
        'MES')
    end
    object EditToolTip: TLabeledEdit
      Left = 11
      Top = 119
      Width = 406
      Height = 21
      EditLabel.Width = 94
      EditLabel.Height = 13
      EditLabel.Caption = 'ToolTip [DataTable]'
      TabOrder = 2
    end
    object EditHintText: TLabeledEdit
      Left = 11
      Top = 164
      Width = 406
      Height = 21
      EditLabel.Width = 130
      EditLabel.Height = 13
      EditLabel.Caption = 'HintText [InputDecoration]'
      TabOrder = 3
    end
    object ComboBoxTipoControle: TComboBox
      Left = 11
      Top = 408
      Width = 406
      Height = 21
      TabOrder = 11
      Items.Strings = (
        'TextFormField'
        'DropDownButton'
        'DatePickerItem')
    end
    object EditCampoLookup: TLabeledEdit
      Left = 11
      Top = 319
      Width = 406
      Height = 21
      EditLabel.Width = 85
      EditLabel.Height = 13
      EditLabel.Caption = 'Campo de Lookup'
      TabOrder = 8
      TextHint = 'Use o padr'#227'o camelCase. Ex: nomeAgencia'
    end
    object CheckBoxObrigatorio: TCheckBox
      Left = 343
      Top = 206
      Width = 74
      Height = 17
      Caption = 'Obrigat'#243'rio'
      TabOrder = 5
    end
    object ComboBoxCampoLookupTipoDado: TComboBox
      Left = 11
      Top = 365
      Width = 166
      Height = 21
      TabOrder = 9
      Items.Strings = (
        'int'
        'varchar'
        'decimal'
        'char'
        'text'
        'date')
    end
    object EditTabelaLookup: TLabeledEdit
      Left = 11
      Top = 274
      Width = 406
      Height = 21
      EditLabel.Width = 84
      EditLabel.Height = 13
      EditLabel.Caption = 'Tabela de Lookup'
      TabOrder = 7
      TextHint = 'Conforme banco de dados. Ex: pessoa_endereco'
    end
    object CheckBoxReadOnly: TCheckBox
      Left = 12
      Top = 232
      Width = 197
      Height = 17
      Caption = 'Campo Somente Leitura (readOnly)'
      TabOrder = 6
    end
    object EditValorPadraoLookup: TLabeledEdit
      Left = 183
      Top = 365
      Width = 234
      Height = 21
      EditLabel.Width = 175
      EditLabel.Height = 13
      EditLabel.Caption = 'Lookup - Valor Padr'#227'o para Pesquisa'
      TabOrder = 10
      TextHint = '% - traz todos os registros'
    end
  end
  object MemoObjetoJson: TMemo
    Left = 712
    Top = 51
    Width = 274
    Height = 359
    TabOrder = 5
  end
  object Button1: TButton
    Left = 712
    Top = 416
    Width = 274
    Height = 33
    Caption = 'Gerar JSON'
    TabOrder = 6
    OnClick = Button1Click
  end
  object GroupBox1: TGroupBox
    Left = 281
    Top = 454
    Width = 331
    Height = 116
    Caption = 'TextFormField'
    TabOrder = 3
    object Label7: TLabel
      Left = 10
      Top = 19
      Width = 73
      Height = 13
      Caption = 'Keyboard Type'
    end
    object Label11: TLabel
      Left = 10
      Top = 65
      Width = 40
      Height = 13
      Caption = 'M'#225'scara'
    end
    object ComboBoxMascara: TComboBox
      Left = 10
      Top = 81
      Width = 310
      Height = 21
      TabOrder = 1
      Items.Strings = (
        'CPF'
        'CNPJ'
        'CEP'
        'TELEFONE'
        'HORA'
        'DIA'
        'ANO'
        'MES_ANO'
        'TAXA'
        'VALOR'
        'QUANTIDADE')
    end
    object ComboBoxKeyboardType: TComboBox
      Left = 10
      Top = 38
      Width = 310
      Height = 21
      TabOrder = 0
      Items.Strings = (
        'text'
        'multiline'
        'number'
        'phone'
        'datetime'
        'emailAddress'
        'url'
        'visiblePassword')
    end
  end
  object GroupBox2: TGroupBox
    Left = 618
    Top = 454
    Width = 368
    Height = 116
    Caption = 'DatePickerItem'
    TabOrder = 4
    object EditMascaraData: TLabeledEdit
      Left = 10
      Top = 81
      Width = 330
      Height = 21
      EditLabel.Width = 40
      EditLabel.Height = 13
      EditLabel.Caption = 'M'#225'scara'
      TabOrder = 2
      Text = 'EEE, d / MMM / yyyy'
    end
    object EditFirstDate: TLabeledEdit
      Left = 10
      Top = 39
      Width = 159
      Height = 21
      EditLabel.Width = 47
      EditLabel.Height = 13
      EditLabel.Caption = 'First Date'
      TabOrder = 0
      TextHint = 'Data (yyyy-mm-dd) | now'
    end
    object EditLastDate: TLabeledEdit
      Left = 181
      Top = 39
      Width = 159
      Height = 21
      EditLabel.Width = 46
      EditLabel.Height = 13
      EditLabel.Caption = 'Last Date'
      TabOrder = 1
      TextHint = 'Data (yyyy-mm-dd) | now'
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 8
    Width = 268
    Height = 301
    Caption = 'Servidor'
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 19
      Width = 65
      Height = 13
      Caption = 'Cardinalidade'
    end
    object Label2: TLabel
      Left = 11
      Top = 107
      Width = 20
      Height = 13
      Caption = 'Side'
    end
    object EditCrud: TLabeledEdit
      Left = 11
      Top = 80
      Width = 249
      Height = 21
      EditLabel.Width = 28
      EditLabel.Height = 13
      EditLabel.Caption = 'CRUD'
      TabOrder = 1
      TextHint = 'Insira as letras CRUD conforme requisitos'
    end
    object ComboBoxCardinalidade: TComboBox
      Left = 11
      Top = 37
      Width = 249
      Height = 21
      TabOrder = 0
      Items.Strings = (
        '@OneToOne'
        '@OneToMany')
    end
    object ComboBoxSide: TComboBox
      Left = 11
      Top = 126
      Width = 248
      Height = 21
      TabOrder = 2
      Items.Strings = (
        'Local'
        'Inverse'
        'Both')
    end
    object CheckBoxCascade: TCheckBox
      Left = 12
      Top = 166
      Width = 74
      Height = 17
      Caption = 'Cascade'
      TabOrder = 3
    end
    object CheckBoxOrphanRemoval: TCheckBox
      Left = 132
      Top = 166
      Width = 125
      Height = 17
      Caption = 'Orphan Removal'
      TabOrder = 4
    end
  end
  object GroupBox5: TGroupBox
    Left = 8
    Top = 315
    Width = 268
    Height = 255
    Caption = 'DropDownButton'
    TabOrder = 2
    object Label8: TLabel
      Left = 12
      Top = 16
      Width = 42
      Height = 13
      Caption = 'Persiste:'
    end
    object Label9: TLabel
      Left = 12
      Top = 58
      Width = 29
      Height = 13
      Caption = 'Itens:'
    end
    object Label10: TLabel
      Left = 139
      Top = 16
      Width = 65
      Height = 13
      Caption = 'Valor Padr'#227'o:'
    end
    object ComboBoxPersiste: TComboBox
      Left = 12
      Top = 31
      Width = 120
      Height = 21
      TabOrder = 0
      TextHint = 'Persiste'
      Items.Strings = (
        'indice'
        'char'
        'valor')
    end
    object MemoDropDownItens: TMemo
      Left = 12
      Top = 73
      Width = 248
      Height = 168
      TabOrder = 2
    end
    object EditDropDownValorPadrao: TEdit
      Left = 139
      Top = 31
      Width = 121
      Height = 21
      TabOrder = 1
      TextHint = 'Valor Padr'#227'o'
    end
  end
  object EditComentario: TLabeledEdit
    Left = 712
    Top = 24
    Width = 274
    Height = 21
    EditLabel.Width = 125
    EditLabel.Height = 13
    EditLabel.Caption = 'Coment'#225'rio para o Campo'
    TabOrder = 7
    TextHint = 'Insira o coment'#225'rio explicativo para esse campo'
  end
end
