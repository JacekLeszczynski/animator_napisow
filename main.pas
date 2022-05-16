unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Spin, XMLPropStorage, Buttons, ColorBox, ExtMessage,
  uETilePanel, ueled;

type

  { TcForm }

  TcForm = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CheckBox1: TCheckBox;
    cPauseEnd: TSpinEdit;
    cShowText: TCheckBox;
    cInterval: TSpinEdit;
    cFontTitle: TComboBox;
    cFontText: TComboBox;
    cFontTitleSize: TSpinEdit;
    cFontTextSize: TSpinEdit;
    cBackColor: TColorBox;
    cAddLines: TSpinEdit;
    cPauseStart: TSpinEdit;
    cMargUp: TSpinEdit;
    cMargOr: TSpinEdit;
    cMargDown: TSpinEdit;
    cAnimationOnlyOne: TCheckBox;
    cTitle: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    mess: TExtMessage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cText: TMemo;
    cMargLeft: TSpinEdit;
    cMargRight: TSpinEdit;
    Splitter1: TSplitter;
    autorun: TTimer;
    timer_ending: TTimer;
    uELED1: TuELED;
    uETilePanel1: TuETilePanel;
    uETilePanel2: TuETilePanel;
    propstorage: TXMLPropStorage;
    procedure autorunTimer(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure timer_endingTimer(Sender: TObject);
  private
    C_SCREEN: boolean;
  public
    procedure _Ending;
  end;

var
  cForm: TcForm;

implementation

uses
  ecode, unit_screen, Process, AsyncProcess;

{$R *.lfm}

{ TcForm }

procedure TcForm.FormCreate(Sender: TObject);
begin
  C_SCREEN:=false;
  SetConfDir('PiStudio');
  cFontTitle.Items.Assign(screen.Fonts);
  cFontText.Items.Assign(screen.Fonts);
  propstorage.FileName:=MyConfDir('AnimatorNapisow.xml');
  propstorage.Active:=true;
  autorun.Enabled:=true;
end;

procedure TcForm.timer_endingTimer(Sender: TObject);
begin
  timer_ending.Enabled:=false;
  BitBtn2.Click;
end;

procedure TcForm._Ending;
begin
  timer_ending.Enabled:=true;
end;

procedure TcForm.autorunTimer(Sender: TObject);
var
  i,a: integer;
begin
  autorun.Enabled:=false;
  for i:=0 to cFontTitle.Items.Count-1 do if cFontTitle.Items[i]='Arial' then
  begin
    a:=i;
    break;
  end;
  if cFontTitle.ItemIndex=-1 then cFontTitle.ItemIndex:=a;
  if cFontText.ItemIndex=-1 then cFontText.ItemIndex:=a;
end;

procedure TcForm.BitBtn1Click(Sender: TObject);
begin
  BitBtn1.Enabled:=false;
  BitBtn2.Enabled:=not BitBtn1.Enabled;
  FScreen:=TFScreen.Create(self);
  FScreen.io_obs:=CheckBox1.Checked;
  FScreen.PauseMS:=cPauseStart.Value;
  FScreen.PauseEND:=cPauseEnd.Value;
  FScreen.BackColor:=cBackColor.Selected;
  FScreen.MargLeft:=cMargLeft.Value;
  FScreen.MargRight:=cMargRight.Value;
  FScreen.MargUp:=cMargUp.Value;
  FScreen.MargOr:=cMargOr.Value;
  FScreen.MargDown:=cMargDown.Value;
  FScreen.cTitle.Caption:=cTitle.Caption;
  FScreen.cTitle.Font.Name:=cFontTitle.Text;
  FScreen.cTitle.Font.Size:=cFontTitleSize.Value;
  FScreen.cText.StartTextShow:=cShowText.Checked;
  FScreen.cText.Interval:=cInterval.Value;
  FScreen.cText.Loop:=not cAnimationOnlyOne.Checked;
  FScreen.cText.AddingNullLines:=cAddLines.Value;
  FScreen.cText.Lines.Assign(cText.Lines);
  FScreen.cText.Font.Name:=cFontText.Text;
  FScreen.cText.Font.Size:=cFontTextSize.Value;
  FScreen.Show;
  C_SCREEN:=true;
end;

procedure TcForm.BitBtn2Click(Sender: TObject);
begin
  BitBtn1.Enabled:=true;
  BitBtn2.Enabled:=not BitBtn1.Enabled;
  C_SCREEN:=false;
  FScreen.Close;
end;

end.

