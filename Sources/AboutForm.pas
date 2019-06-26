unit AboutForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, math, StdCtrls;

type
  TAbout = class(TForm)
    mod_ver: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  About: TAbout;

implementation
uses main;

{$R *.dfm}

procedure TAbout.FormCreate(Sender: TObject);
var
  sf:TForm;
begin
  mod_ver.Caption:=appname;
  mod_ver.Alignment:=taCenter;
  if self.Owner is TForm then begin
    sf:=TForm(self.Owner);
    self.Top  := ceil( sf.Top  + (sf.Height - self.Height)/2 );
    self.Left := ceil( sf.Left + (sf.Width  - self.Width )/2 );
    if self.Top<0 then self.Top:=0;
    if self.Left<0 then self.Left:=0;
  end;
end;

procedure TAbout.FormShow(Sender: TObject);
begin
  if self.Owner is TForm then TForm(self.Owner).Enabled:=false;
end;

procedure TAbout.FormHide(Sender: TObject);
begin
  if self.Owner is TForm then begin
    TForm(self.Owner).Enabled:=true;
  end;
end;

procedure TAbout.Button1Click(Sender: TObject);
begin
  self.Close;
end;

end.
