unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.ComCtrls, Vcl.Themes;

type
  TForm1 = class(TForm)
    Panel2: TPanel;
    pnPadLeft: TPanel;
    pnPadTop: TPanel;
    pnContainer: TPanel;
    pnLogo: TPanel;
    Image1: TImage;
    lbl1: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    Image2: TImage;
    Panel4: TPanel;
    Image3: TImage;
    Panel5: TPanel;
    Image4: TImage;
    Panel6: TPanel;
    Image5: TImage;
    Image6: TImage;
    Panel7: TPanel;
    Label2: TLabel;
    Panel8: TPanel;
    Image7: TImage;
    Panel9: TPanel;
    Image8: TImage;
    Panel12: TPanel;
    Label3: TLabel;
    Panel13: TPanel;
    Image11: TImage;
    Panel14: TPanel;
    Image12: TImage;
    Panel15: TPanel;
    Image13: TImage;
    Panel16: TPanel;
    Image14: TImage;
    Panel17: TPanel;
    Label4: TLabel;
    Panel18: TPanel;
    Image15: TImage;
    Panel19: TPanel;
    Image16: TImage;
    Panel20: TPanel;
    Image17: TImage;
    Panel21: TPanel;
    Image18: TImage;
    RichEdit1: TRichEdit;
    RichEdit2: TRichEdit;
    Panel10: TPanel;
    Edit2: TEdit;
    Image9: TImage;
    procedure Image2Click(Sender: TObject);
  private
    fdefaultStyleName:String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Image2Click(Sender: TObject);
begin
  Image6.Picture := TImage(Sender).Picture;
end;

end.
