unit view.message;

interface

uses
  FMX.Ani,
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Dialogs,
  FMX.Effects,
  FMX.Forms,
  FMX.Graphics,
  FMX.Layouts,
  FMX.Memo,
  FMX.Memo.Types,
  FMX.Objects,
  FMX.ScrollBox,
  FMX.StdCtrls,
  FMX.Types,

  System.Classes,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants;

type
  TMyButtons = (mbConfirmar, mbCancelar, mbOk);

type
  TviewMessage = class(TForm)
    retContent: TRectangle;
    retMessage: TRectangle;
    sheMessage: TShadowEffect;
    lytImagens: TLayout;
    lytFooter: TLayout;
    lytMessage: TLayout;
    cirInfo: TCircle;
    imgInfo: TPath;
    cirAlert: TCircle;
    imgAlert: TPath;
    cirSucess: TCircle;
    imgSucess: TPath;
    cirError: TCircle;
    imgError: TPath;
    mmoMessage: TMemo;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    btnOk: TButton;
    lytTitle: TLayout;
    lblTitle: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
  public
    class function Mensagem( aMessage: string; aTipo : char; aButton: array of TMyButtons) : boolean; overload;
    class function Mensagem( aMessage, aTitulo: string; aTipo : char; aButton: array of TMyButtons) : boolean; overload;
  end;

implementation

{$R *.fmx}

procedure TviewMessage.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  case key of
    vkEscape: Self.Close;           //esc
    vkReturn: ModalResult := mrOk;  //enter
  end;

end;

class function TviewMessage.Mensagem(aMessage, aTitulo: string;
  aTipo: char; aButton: array of TMyButtons): boolean;
var
  view  : TviewMessage;
  i     : integer;
begin
  Result := False;
  view  :=  TviewMessage.Create(Nil);
  try
    view.mmoMessage.Lines.Clear;
    view.mmoMessage.Lines.Add(aMessage);
    view.lblTitle.Text := aTitulo;

    for i := 0 to Length(aButton) - 1 do
    begin
      case (aButton[i]) of
        mbOk: begin
                view.btnOk.Visible := True;
              end;

        mbConfirmar : begin
                        view.btnConfirmar.Visible := True;
                      end;

        mbCancelar  : begin
                      view.btnCancelar.Visible := True;
                      end;

        else begin
          view.btnOk.Visible := True;
        end;

      end;
    end;

    case (aTipo) of
      'I':begin
            view.cirInfo.Visible  := True;
            view.retMessage.Stroke.Color := view.imgInfo.Fill.Color;
          end;

      'E':begin
            view.cirError.Visible  := True;
            view.retMessage.Stroke.Color := view.imgError.Fill.Color;
          end;

      'A':begin
            view.cirAlert.Visible  := True;
            view.retMessage.Stroke.Color := view.imgAlert.Fill.Color;
          end;

      'S':begin
            view.cirSucess.Visible  := True;
            view.retMessage.Stroke.Color := view.imgSucess.Fill.Color;
          end;

      else begin
        view.cirInfo.Visible  := True;
        view.retMessage.Stroke.Color := view.imgInfo.Fill.Color;
      end;
    end;

    view.ShowModal;

    if (view.ModalResult = mrOk) then
      Result := True;
  finally
    if (view <> nil) then
      FreeAndNil(view);
  end;
end;

class function TviewMessage.Mensagem(aMessage: string; aTipo: char;
  aButton: array of TMyButtons): boolean;
var
  view  : TviewMessage;
  i     : integer;
begin
  Result := False;
  view  :=  TviewMessage.Create(Nil);
  try
    view.mmoMessage.Lines.Clear;
    view.mmoMessage.Lines.Add(aMessage);

    for i := 0 to Length(aButton) - 1 do
    begin
      case (aButton[i]) of
        mbOk: begin
                view.btnOk.Visible := True;
              end;

        mbConfirmar : begin
                        view.btnConfirmar.Visible := True;
                      end;

        mbCancelar  : begin
                      view.btnCancelar.Visible := True;
                      end;

        else begin
          view.btnOk.Visible := True;
        end;

      end;
    end;

    case (aTipo) of
      'I':begin
            view.lblTitle.Text := 'INFORMAÇÃO';
            view.cirInfo.Visible  := True;
            view.retMessage.Stroke.Color := view.imgInfo.Fill.Color;
          end;

      'E':begin
            view.lblTitle.Text := 'ERROR';
            view.cirError.Visible  := True;
            view.retMessage.Stroke.Color := view.imgError.Fill.Color;
          end;

      'A':begin
            view.lblTitle.Text := 'ATENÇÃO';
            view.cirAlert.Visible  := True;
            view.retMessage.Stroke.Color := view.imgAlert.Fill.Color;
          end;

      'S':begin
            view.lblTitle.Text := 'SUCESSO';
            view.cirSucess.Visible  := True;
            view.retMessage.Stroke.Color := view.imgSucess.Fill.Color;
          end;

      else begin
        view.lblTitle.Text := 'INFORMAÇÃO';
        view.cirInfo.Visible  := True;
        view.retMessage.Stroke.Color := view.imgInfo.Fill.Color;
      end;
    end;

    view.ShowModal;

    if (view.ModalResult = mrOk) then
      Result := True;
  finally
    if (view <> nil) then
      FreeAndNil(view);
  end;
end;

end.
