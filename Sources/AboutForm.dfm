object About: TAbout
  Left = 870
  Top = 272
  BorderStyle = bsToolWindow
  Caption = 'About'
  ClientHeight = 284
  ClientWidth = 358
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
  object mod_ver: TLabel
    Left = 0
    Top = 0
    Width = 358
    Height = 284
    Align = alClient
    Alignment = taCenter
    Caption = '[from main module]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 136
    Top = 48
    Width = 75
    Height = 20
    Caption = 'Written by:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 80
    Top = 72
    Width = 191
    Height = 20
    Caption = 'Sin!, Gunslinger Mod Team'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 136
    Top = 96
    Width = 68
    Height = 20
    Caption = 'Feb 2015'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 72
    Top = 144
    Width = 213
    Height = 13
    Caption = 'If you like this tool, you can make a donation:'
  end
  object Label6: TLabel
    Left = 56
    Top = 174
    Width = 74
    Height = 13
    Caption = 'Yandex.Money:'
  end
  object Label7: TLabel
    Left = 48
    Top = 196
    Width = 91
    Height = 13
    Caption = 'WebMoney - WMZ'
  end
  object Label8: TLabel
    Left = 48
    Top = 220
    Width = 92
    Height = 13
    Caption = 'WebMoney - WMR'
  end
  object Button1: TButton
    Left = 136
    Top = 248
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 200
    Top = 168
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 1
    Text = '410011068965816'
  end
  object Edit2: TEdit
    Left = 200
    Top = 192
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 2
    Text = 'Z108779924036'
  end
  object Edit3: TEdit
    Left = 200
    Top = 216
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 3
    Text = 'R173271494216'
  end
end
