unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, MMSystem;

type

  { TForm1 }

  TForm1 = class(TForm)
    buttonToggleLights: TBitBtn;
    buttonFaster: TButton;
    buttonSlower: TButton;
    buttonToggleDriving: TBitBtn;
    buttonToggleSound: TBitBtn;
    imagePatroulCar: TImage;
    labelTitleLights: TLabel;
    labelTitleDrivingSpeed: TLabel;
    labelTitleSound: TLabel;
    shapeLights: TShape;
    timerDrive: TTimer;
    timerLights: TTimer;
    procedure buttonFasterClick(Sender: TObject);
    procedure buttonSlowerClick(Sender: TObject);
    procedure buttonToggleDrivingClick(Sender: TObject);
    procedure buttonToggleLightsClick(Sender: TObject);
    procedure buttonToggleSoundClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure timerDriveTimer(Sender: TObject);
    procedure timerLightsTimer(Sender: TObject);
  private

  public
    speed: Integer;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.buttonToggleDrivingClick(Sender: TObject);
begin
  if(buttonToggleDriving.Caption = 'Fährt') then
  begin
    //PKW anhalten (sirene aus, sirenenbutton deaktiviren, timerDriving deaktiviren)
    timerDrive.Enabled := false;
    buttonToggleDriving.Kind:=bkNo;
    buttonToggleDriving.Caption:='Hält';
    buttonToggleSound.Enabled:=false;

    //sound aus & btn reset
    PlaySound(nil, 0, 0);
    buttonToggleSound.Kind:=bkNo;
    buttonToggleSound.Caption:='Aus';
  end
  else
  begin
    //PKW anhalten (sirenenbutton aktiviren, timerDriving aktiviren)
    if(buttonToggleLights.Caption = 'An') then
    begin
      buttonToggleSound.Enabled:=true;
    end;
    timerDrive.Enabled := true;
    buttonToggleDriving.Kind:=bkYes;
    buttonToggleDriving.Caption:='Fährt';
  end;
end;

procedure TForm1.buttonToggleLightsClick(Sender: TObject);
begin
  if(buttonToggleLights.Caption = 'An') then
  begin
    //Blaulicht aus (sirene aus, sirenenbutton deaktiviren, timerLights deaktiviren)
    timerLights.Enabled := false;
    buttonToggleLights.Kind:=bkNo;
    buttonToggleLights.Caption:='Aus';
    buttonToggleSound.Enabled:=false;  

    //sound aus & btn reset
    PlaySound(nil, 0, 0);
    buttonToggleSound.Kind:=bkNo;
    buttonToggleSound.Caption:='Aus';
  end
  else
  begin
    //Blaulicht an (sirenenbutton aktiviren, timerLights aktiviren)
    timerLights.Enabled := true;
    buttonToggleLights.Kind:=bkYes;
    buttonToggleLights.Caption:='An';
    shapeLights.Brush.Color:=clGray;
    if(buttonToggleDriving.Caption = 'Fährt') then
    begin
      buttonToggleSound.Enabled:=true;
    end;
  end;
end;

procedure TForm1.buttonToggleSoundClick(Sender: TObject);
begin
  if(buttonToggleSound.Caption = 'An') then
  begin
    //Blaulicht aus (sirene aus, sirenenbutton deaktiviren, timerLights deaktiviren)
    buttonToggleSound.Kind:=bkNo;
    buttonToggleSound.Caption:='Aus';
    PlaySound(nil, 0, 0);
  end
  else
  begin
    //Blaulicht an (sirenenbutton aktiviren, timerLights aktiviren)
    buttonToggleSound.Kind:=bkYes;
    buttonToggleSound.Caption:='An';
    PlaySound('assets/Martinshorn.wav', 0, SND_ASYNC or SND_LOOP);
  end;
end;

procedure TForm1.buttonFasterClick(Sender: TObject);
begin
  //macht das Auto scheller (maxSpeed: 25px/ms)
  if(speed <= 25) then
    begin
      speed := speed + 1;
    end
  else
    begin
      speed := 25;
    end;
end;

procedure TForm1.buttonSlowerClick(Sender: TObject);
begin
  //macht das Auto langsamer (minSpeed: 1px/ms)
  if(speed > 1) then
    begin
      speed := speed - 1;
    end
  else
    begin
      speed := 1;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //init all vars
  speed := 1;

  //reset all Objects to default
  buttonToggleLights.Kind:=bkNo;
  buttonToggleLights.Caption:='Aus';  
  buttonToggleSound.Kind:=bkNo;
  buttonToggleSound.Caption:='Aus';    
  buttonToggleDriving.Kind:=bkNo;
  buttonToggleDriving.Caption:='Hält';
end;

procedure TForm1.timerDriveTimer(Sender: TObject);
begin
  //bewegt das auto & poosition reset wenn es verschwidet
  if(imagePatroulCar.Left <= (0 - imagePatroulCar.Width)) then
  begin
    imagePatroulCar.Left := Form1.Width;
    shapeLights.Left := Form1.Width + 288;
  end;
    shapeLights.Left := shapeLights.Left - speed;
    imagePatroulCar.Left := imagePatroulCar.Left - speed;
end;

procedure TForm1.timerLightsTimer(Sender: TObject);
begin
  //blaulicht animation
  if(shapeLights.Brush.Color = clGray) then
  begin
    shapeLights.Brush.Color := clNavy;
  end
  else
  begin                
    shapeLights.Brush.Color := clGray;
  end;
end;

end.

