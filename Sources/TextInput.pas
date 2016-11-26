unit TextInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, InfluencesListForm, math;

type
  TTextInputForm = class(TForm)
    btn_ok: TButton;
    memo: TMemo;
    btn_cancel: TButton;
    btn_add: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    _target:TStrings;
    _list:TInfluencesList;
  public
    { Public declarations }
    procedure Init(target:TStrings; list:TInfluencesList);
    procedure AddKey(key:string; def:string = '');
  end;

implementation

{$R *.dfm}

{ TTextInputForm }

procedure TTextInputForm.Init(target: TStrings; list:TInfluencesList);
begin
  _target:=target;
  _list:=list;
  memo.Lines.DelimitedText:=target.DelimitedText;
end;

procedure TTextInputForm.FormShow(Sender: TObject);
begin
  if self.Owner is TForm then begin
    TForm(self.Owner).Enabled:=false;
  end;
end;

procedure TTextInputForm.FormHide(Sender: TObject);
begin
  if self.Owner is TForm then begin
    TForm(self.Owner).Enabled:=true;
  end;
end;

procedure TTextInputForm.btn_okClick(Sender: TObject);
begin
  _target.DelimitedText:=memo.Lines.DelimitedText;
  self.Hide();
end;

procedure TTextInputForm.btn_cancelClick(Sender: TObject);
begin
  self.Hide();
end;

procedure TTextInputForm.AddKey(key, def: string);
begin
  self.memo.Lines.Add(key+' = '+def);
end;
procedure TTextInputForm.btn_addClick(Sender: TObject);
begin
  _list.Show();
end;

procedure TTextInputForm.FormCreate(Sender: TObject);
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

end.
