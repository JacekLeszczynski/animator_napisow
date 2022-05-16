unit unit_screen;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Process, AsyncProcess, ScrollingText;

type

  { TFScreen }

  TFScreen = class(TForm)
    cTitle: TLabel;
    pause1: TTimer;
    cText: TScrollingText;
    pause2: TTimer;
    pause3: TTimer;
    timer_rec_start: TTimer;
    procedure cTextAfterActivate(Sender: TObject);
    procedure cTextBeforeDeactivate(Sender: TObject);
    procedure cTextPause(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure pause1Timer(Sender: TObject);
    procedure pause2Timer(Sender: TObject);
    procedure pause3Timer(Sender: TObject);
    procedure timer_rec_startTimer(Sender: TObject);
  private
    procedure obs_rec_start;
    procedure obs_rec_stop;
  public
    io_obs: boolean;
    BackColor: TColor;
    MargLeft,MargRight,MargUp,MargOr,MargDown: integer;
    PauseMS,PauseEND: integer;
  end;

var
  FScreen: TFScreen;

implementation

uses
  main;

{$R *.lfm}

{ TFScreen }

procedure TFScreen.pause1Timer(Sender: TObject);
begin
  pause1.Enabled:=false;
  cText.BackColor:=BackColor;
  Color:=BackColor;

  if cTitle.Caption<>'' then
  begin
    cTitle.Left:=MargLeft;
    cTitle.Top:=MargUp;
    cText.Top:=cTitle.Height+cTitle.Top+MargOr;
  end else cText.Top:=MargUp+MargOr;
  cText.Left:=MargLeft;
  cText.Height:=Height-cText.Top-MargDown;
  cText.Width:=Width-MargLeft-MargRight;
  cText.Sleep:=false;
  if PauseMS=0 then cText.Active:=true else
  begin
    cText.Sleep:=true;
    cText.Active:=true;
    pause2.Interval:=PauseMS;
    pause2.Enabled:=true;
  end;
end;

procedure TFScreen.cTextPause(Sender: TObject);
begin
  if PauseEND>0 then
  begin
    pause3.Interval:=PauseEND;
    pause3.Enabled:=true;
  end;
end;

procedure TFScreen.cTextAfterActivate(Sender: TObject);
begin
  timer_rec_start.Enabled:=true;
end;

procedure TFScreen.cTextBeforeDeactivate(Sender: TObject);
begin
  obs_rec_stop;
end;

procedure TFScreen.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  cText.Active:=false;
  sleep(500);
  CloseAction:=caFree;
end;

procedure TFScreen.pause2Timer(Sender: TObject);
begin
  pause2.Enabled:=false;
  cText.Start;
end;

procedure TFScreen.pause3Timer(Sender: TObject);
begin
  pause3.Enabled:=false;
  cForm._Ending;
end;

procedure TFScreen.timer_rec_startTimer(Sender: TObject);
begin
  timer_rec_start.Enabled:=false;
  obs_rec_start;
end;

procedure TFScreen.obs_rec_start;
var
  p: TAsyncProcess;
begin
  if not io_obs then exit;
  cForm.uELED1.Active:=true;
  //obs-cli --password 123ikpd recording start
  p:=TAsyncProcess.Create(self);
  try
    p.ShowWindow:=swoHIDE;
    p.Options:=[poWaitOnExit,poNoConsole];
    p.CommandLine:='obs-cli --password 123ikpd recording start';
    p.Execute;
    if p.Running then p.Terminate(0);
  finally
    p.Free;
  end;
end;

procedure TFScreen.obs_rec_stop;
var
  p: TAsyncProcess;
begin
  if not io_obs then exit;
  cForm.uELED1.Active:=false;
  //obs-cli --password 123ikpd recording stop
  p:=TAsyncProcess.Create(self);
  try
    p.ShowWindow:=swoHIDE;
    p.Options:=[poWaitOnExit,poNoConsole];
    p.CommandLine:='obs-cli --password 123ikpd recording stop';
    p.Execute;
    if p.Running then p.Terminate(0);
  finally
    p.Free;
  end;
end;

end.

