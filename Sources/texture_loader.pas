unit texture_loader;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Upgrade;

type
  TTextureSelectorForm = class(TForm)
    img: TImage;
    viz_rect: TShape;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    _src:TPicture;
    _dst:TTextureRect;
    _ispicking:boolean;
    _need_repaint:boolean;

    _rect:TRect; //это текстурные координаты! Экранные - с учетом текущего смещения img

    { Private declarations }
  public
    { Public declarations }
    procedure Init(src:TPicture; dst: TTextureRect; rect:TRect);
    procedure CorrectRect();

    procedure VisualizeRect();
  end;

implementation
uses UpEditor, Main;

{$R *.dfm}

{ TTextureSelectorForm }

procedure TTextureSelectorForm.Init(src:TPicture; dst:TTextureRect; rect:TRect);
begin
  _src:=src;
  _dst:=dst;
  _rect:=rect;
end;

procedure TTextureSelectorForm.FormShow(Sender: TObject);
begin
  self.Caption:='Select Texture Rectangle';
  if (_src=nil) then begin
    MessageBox(self.Handle, 'Init me first!', 'Error!', MB_OK+MB_ICONERROR);
    exit;
  end;
  if self.Owner is TForm then TForm(self.Owner).Enabled:=false;
  self.img.Top:=0;
  self.img.Left:=0;
  self.img.Picture.Assign(_src);
  self.img.Height:=_src.Height;
  self.img.Width:=_src.Width;
  _ispicking:=false;
  _need_repaint:=false;
  VisualizeRect();
end;

procedure TTextureSelectorForm.FormHide(Sender: TObject);
begin
  if self.Owner is TForm then TForm(self.Owner).Enabled:=true;
  _ispicking:=false;
  CorrectRect();
  if _dst<>nil then _dst.Init(_src, _rect);

  if self.Owner is TUpgradeEditor then begin
    TUpgradeEditor(self.Owner).UpdatePreview;
  end else if self.Owner is TMainForm then begin
    TMainForm(Owner).SetNewWeaponPreviewParams(_rect);
  end;
  _src :=nil;

end;

procedure TTextureSelectorForm.FormCreate(Sender: TObject);
begin
  self.Top:=0;
  self.Left:=0;
  self._src:=nil;
end;

procedure TTextureSelectorForm.imgMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if _ispicking then exit;
  _ispicking:=true;
  _rect.Top:=Y;
  _rect.Left:=X;

  _rect.Right:=X;
  _rect.Bottom:=Y;
  VisualizeRect();
end;

procedure TTextureSelectorForm.imgMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin

  if _ispicking then begin
    _rect.Right:=X;
    _rect.Bottom:=Y;
    VisualizeRect();
    self.Caption:='SzX='+inttostr(_rect.Right-_rect.Left)+', SzY='+inttostr(_rect.Bottom-_rect.Top);
  end else begin
    self.Caption:='X='+inttostr(X)+', Y='+inttostr(Y);
  end;
end;

procedure TTextureSelectorForm.imgMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  _ispicking:=false;
  CorrectRect();

  VisualizeRect();

end;


procedure SwapArgs(var x:integer; var y:integer);
var
  tmp:integer;
begin
  tmp:=x;
  x:=y;
  y:=tmp;
end;

procedure TTextureSelectorForm.CorrectRect;
begin
  //не допускаем отрицательных длины/ширины!
  if _rect.Left>_rect.Right then begin
    SwapArgs(_rect.Left, _rect.Right);
  end;

  if _rect.Bottom<_rect.Top then begin
    SwapArgs(_rect.Bottom, _rect.Top);
  end;

  if _rect.Top<0 then begin
    _rect.Top:=0;
  end else if _rect.Top>img.Height then begin
    _rect.Top:=img.Height;
  end;

  if _rect.Bottom<0 then begin
    _rect.Bottom:=0;
  end else if _rect.Bottom>img.Height then begin
    _rect.Bottom:=img.Height;
  end;

  if _rect.Left<0 then begin
    _rect.Left:=0;
  end else if _rect.Left>img.Width then begin
    _rect.Left:=img.Width;
  end;

  if _rect.Right<0 then begin
    _rect.Right:=0;
  end else if _rect.Right>img.Width then begin
    _rect.Right:=img.Width;
  end;
end;

procedure TTextureSelectorForm.VisualizeRect;
begin
  //
    if _need_repaint then begin
      Repaint();
      _need_repaint:=false;
    end;

  if (_rect.Top=_rect.Bottom) and (_rect.Left=_rect.Right) then begin
    viz_rect.Height:=0;
    viz_rect.Width:=0;

    self.Canvas.Pen.Color:=clRed;
    self.Canvas.Pen.Style:=psSolid;
    self.Canvas.MoveTo(img.Left+_rect.Left-20, img.Top+_rect.Top);
    self.Canvas.LineTo(img.Left+_rect.Left+20, img.Top+_rect.Top);
    self.Canvas.MoveTo(img.Left+_rect.Left, img.Top+_rect.Top-20);
    self.Canvas.LineTo(img.Left+_rect.Left, img.Top+_rect.Top+20);
    _need_repaint:=true;
  end else begin
    viz_rect.Top:=_rect.Top + img.Top;
    viz_rect.Left:=_rect.Left + img.Left;

    viz_rect.Height:=_rect.Bottom - _rect.Top;
    viz_rect.Width:=_rect.Right-_rect.Left;
  end;
end;

procedure TTextureSelectorForm.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if _ispicking then exit;

  if Key = chr(27) then Close;

  Key:=AnsiLowerCase(key)[1];
  case Key of
    'g': _rect.Top:=_rect.Top+1;
    't': _rect.Top:=_rect.Top-1;
    'f': _rect.Left:=_rect.Left-1;
    'h': _rect.Left:=_rect.Left+1;

    'k': _rect.Bottom:=_rect.Bottom+1;
    'i': _rect.Bottom:=_rect.Bottom-1;
    'j': _rect.Right:=_rect.Right-1;
    'l': _rect.Right:=_rect.Right+1;

    'w':
      begin
        _rect.Top:=_rect.Top-1;
        _rect.Bottom:=_rect.Bottom-1;
      end;
    's':
      begin
        _rect.Top:=_rect.Top+1;
        _rect.Bottom:=_rect.Bottom+1;
      end;
    'a':
      begin
        _rect.Left:=_rect.Left-1;
        _rect.Right:=_rect.Right-1;
      end;
    'd':
      begin
        _rect.Left:=_rect.Left+1;
        _rect.Right:=_rect.Right+1;
      end;
  end;
  CorrectRect();
  VisualizeRect();
  self.Caption:='X='+inttostr(_rect.Left)+', Y='+inttostr(_rect.Top)+', SzX='+inttostr(_rect.Right-_rect.Left)+', SzY='+inttostr(_rect.Bottom-_rect.Top);
end;

end.
