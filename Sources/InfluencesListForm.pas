unit InfluencesListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math;

type
  TInfluencesList = class(TForm)
    list: TListBox;
    btn_ok: TButton;
    btn_close: TButton;
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_closeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InfluencesList: TInfluencesList;

implementation
uses TextInput;

{$R *.dfm}

procedure TInfluencesList.FormHide(Sender: TObject);
begin
  if self.Owner is TForm then begin
    TForm(self.Owner).Enabled:=true;
  end;
end;

procedure TInfluencesList.FormShow(Sender: TObject);
begin
  if self.Owner is TForm then begin
    TForm(self.Owner).Enabled:=false;
  end;
end;

procedure TInfluencesList.FormCreate(Sender: TObject);
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

procedure TInfluencesList.btn_okClick(Sender: TObject);
var
  i:integer;
begin
  if self.Owner is TTextInputForm then begin
    for i:=0 to list.Items.Count-1 do begin
      if list.Selected[i] then begin
        TTextInputForm(self.Owner).AddKey(list.Items[i]);
      end;
      list.Selected[i]:=false;
    end; 
  end;
  self.close();
end;

procedure TInfluencesList.btn_closeClick(Sender: TObject);
begin
  self.close();
end;

end.
