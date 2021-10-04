unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.JSON.Writers, System.JSON.Types, Clipbrd, Vcl.CheckLst;

type
  TFPrincipal = class(TForm)
    MemoObjetoJson: TMemo;
    Button1: TButton;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    ComboBoxKeyboardType: TComboBox;
    GroupBox2: TGroupBox;
    EditMascaraData: TLabeledEdit;
    EditFirstDate: TLabeledEdit;
    EditLastDate: TLabeledEdit;
    GroupBox3: TGroupBox;
    EditCrud: TLabeledEdit;
    ComboBoxCardinalidade: TComboBox;
    Label1: TLabel;
    ComboBoxSide: TComboBox;
    Label2: TLabel;
    GroupBox4: TGroupBox;
    EditLabel: TLabeledEdit;
    EditLabelText: TLabeledEdit;
    ComboBoxValidacao: TComboBox;
    Label5: TLabel;
    EditToolTip: TLabeledEdit;
    EditHintText: TLabeledEdit;
    ComboBoxTipoControle: TComboBox;
    Label6: TLabel;
    GroupBox5: TGroupBox;
    ComboBoxPersiste: TComboBox;
    Label8: TLabel;
    MemoDropDownItens: TMemo;
    EditDropDownValorPadrao: TEdit;
    EditCampoLookup: TLabeledEdit;
    Label9: TLabel;
    Label10: TLabel;
    CheckBoxObrigatorio: TCheckBox;
    Label11: TLabel;
    ComboBoxMascara: TComboBox;
    CheckBoxCascade: TCheckBox;
    CheckBoxOrphanRemoval: TCheckBox;
    EditComentario: TLabeledEdit;
    ComboBoxCampoLookupTipoDado: TComboBox;
    Label3: TLabel;
    EditTabelaLookup: TLabeledEdit;
    CheckBoxReadOnly: TCheckBox;
    EditValorPadraoLookup: TLabeledEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}

procedure TFPrincipal.Button1Click(Sender: TObject);
var
  StringWriter: TStringWriter;
  Writer: TJSONTextWriter;
  I: Integer;
begin
  StringWriter := TStringWriter.Create();
  Writer := TJsonTextWriter.Create(StringWriter);
  try
    Writer.Formatting := TJsonFormatting.None;// .Indented;

    // Objeto Principal
    Writer.WriteStartObject;

    // Servidor
    Writer.WritePropertyName('cardinalidade');
    Writer.WriteValue(ComboBoxCardinalidade.Text);
    Writer.WritePropertyName('crud');
    Writer.WriteValue(EditCrud.Text);
    Writer.WritePropertyName('side');
    Writer.WriteValue(ComboBoxSide.Text);
    Writer.WritePropertyName('cascade');
    Writer.WriteValue(CheckBoxCascade.Checked);
    Writer.WritePropertyName('orphanRemoval');
    Writer.WriteValue(CheckBoxOrphanRemoval.Checked);

    // Cliente
    Writer.WritePropertyName('label');
    Writer.WriteValue(EditLabel.Text);
    Writer.WritePropertyName('labelText');
    Writer.WriteValue(EditLabelText.Text);
    Writer.WritePropertyName('tooltip');
    Writer.WriteValue(EditToolTip.Text);
    Writer.WritePropertyName('hintText');
    Writer.WriteValue(EditHintText.Text);
    Writer.WritePropertyName('validacao');
    Writer.WriteValue(ComboBoxValidacao.Text);
    Writer.WritePropertyName('tabelaLookup');
    Writer.WriteValue(EditTabelaLookup.Text);
    Writer.WritePropertyName('campoLookup');
    Writer.WriteValue(EditCampoLookup.Text);
    Writer.WritePropertyName('campoLookupTipoDado');
    Writer.WriteValue(EditValorPadraoLookup.Text);
    Writer.WritePropertyName('valorPadraoLookup');
    Writer.WriteValue(ComboBoxCampoLookupTipoDado.Text);
    Writer.WritePropertyName('obrigatorio');
    Writer.WriteValue(CheckBoxObrigatorio.Checked);
    Writer.WritePropertyName('readOnly');
    Writer.WriteValue(CheckBoxReadOnly.Checked);

    // comentário explicativo para o campo
    Writer.WritePropertyName('comentario');
    Writer.WriteValue(EditComentario.Text);

    // Objeto Tipo Controle
    Writer.WritePropertyName('tipoControle');
    if ComboBoxTipoControle.Text = 'TextFormField' then
    begin
      Writer.WriteStartObject;
      Writer.WritePropertyName('tipo');
      Writer.WriteValue('textFormField');
      Writer.WritePropertyName('keyboardType');
      Writer.WriteValue(ComboBoxKeyboardType.Text);
      Writer.WritePropertyName('mascara');
      Writer.WriteValue(ComboBoxMascara.Text);
      Writer.WriteEndObject;
    end
    else if ComboBoxTipoControle.Text = 'DropDownButton' then
    begin
      Writer.WriteStartObject;
      Writer.WritePropertyName('tipo');
      Writer.WriteValue('dropDownButton');
      Writer.WritePropertyName('persiste');
      Writer.WriteValue(ComboBoxPersiste.Text);
      Writer.WritePropertyName('valorPadrao');
      Writer.WriteValue(EditDropDownValorPadrao.Text);

      // Array com os itens do DropDownButton
      Writer.WritePropertyName('itens');
      Writer.WriteStartArray;
      for I := 0 to MemoDropDownItens.Lines.Count - 1 do
      begin
        Writer.WriteStartObject;
        Writer.WritePropertyName('dropDownButtonItem');
        Writer.WriteValue(MemoDropDownItens.Lines[I]);
        Writer.WriteEndObject;
      end;
      Writer.WriteEndArray;
      Writer.WriteEndObject;
    end
    else if ComboBoxTipoControle.Text = 'DatePickerItem' then
    begin
      Writer.WriteStartObject;
      Writer.WritePropertyName('tipo');
      Writer.WriteValue('datePickerItem');
      Writer.WritePropertyName('firstDate');
      Writer.WriteValue(EditFirstDate.Text);
      Writer.WritePropertyName('lastDate');
      Writer.WriteValue(EditLastDate.Text);
      Writer.WritePropertyName('mascara');
      Writer.WriteValue(EditMascaraData.Text);
      Writer.WriteEndObject;
    end;
    // Finaliza o objeto principal
    Writer.WriteEndObject;
  finally
    MemoObjetoJson.Lines.Clear;
    MemoObjetoJson.Lines.Add(StringWriter.ToString);
    Clipboard.AsText := MemoObjetoJson.Text;
    Writer.Free;
    StringWriter.Free;
  end;
end;

end.
