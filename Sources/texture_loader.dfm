object TextureSelectorForm: TTextureSelectorForm
  Left = 272
  Top = 402
  Width = 584
  Height = 462
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnHide = FormHide
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object img: TImage
    Left = 8
    Top = 16
    Width = 105
    Height = 105
    Cursor = crCross
    OnMouseDown = imgMouseDown
    OnMouseMove = imgMouseMove
    OnMouseUp = imgMouseUp
  end
  object viz_rect: TShape
    Left = 384
    Top = 120
    Width = 65
    Height = 65
    Brush.Style = bsClear
    Pen.Color = clRed
  end
end
