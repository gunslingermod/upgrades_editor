unit helpform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  THelp = class(TForm)
    btn_ok: TButton;
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Help: THelp;

implementation
uses math;

{$R *.dfm}

procedure THelp.FormShow(Sender: TObject);
begin
  if self.Owner is TForm then TForm(self.Owner).Enabled:=false;
end;

procedure THelp.FormHide(Sender: TObject);
begin
  if self.Owner is TForm then begin
    TForm(self.Owner).Enabled:=true;
  end;
end;

procedure THelp.FormCreate(Sender: TObject);
var
  sf:TForm;
begin
  if self.Owner is TForm then begin
    sf:=TForm(self.Owner);
    self.Top  := ceil( sf.Top  + (sf.Height - self.Height)/2 );
    self.Left := ceil( sf.Left + (sf.Width  - self.Width )/2 );
    if self.Top<0 then self.Top:=0;
    if self.Left<0 then self.Left:=0;
  end;
end;

procedure THelp.btn_okClick(Sender: TObject);
begin
  self.Close();
end;

end.
