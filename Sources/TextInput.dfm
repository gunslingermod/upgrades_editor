object TextInputForm: TTextInputForm
  Left = 220
  Top = 476
  BorderStyle = bsToolWindow
  Caption = 'Editor'
  ClientHeight = 278
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btn_ok: TButton
    Left = 288
    Top = 248
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = btn_okClick
  end
  object memo: TMemo
    Left = 0
    Top = 0
    Width = 449
    Height = 241
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object btn_cancel: TButton
    Left = 368
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btn_cancelClick
  end
  object btn_add: TButton
    Left = 8
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Add...'
    TabOrder = 3
    OnClick = btn_addClick
  end
end
