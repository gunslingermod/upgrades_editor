object Help: THelp
  Left = 326
  Top = 268
  BorderStyle = bsToolWindow
  Caption = 'Help'
  ClientHeight = 320
  ClientWidth = 440
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
    Left = 176
    Top = 288
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = btn_okClick
  end
  object Memo1: TMemo
    Left = 16
    Top = 8
    Width = 409
    Height = 273
    Lines.Strings = (
      'Usage:'
      
        '1) Set the textures you want to use for preview and upgrades'#39' ic' +
        'ons (Options '
      
        'menu). The program supports BMP and DDS images. All upgrades'#39' ic' +
        'ons in the '
      'project should use one texture.'
      
        '2) Configure weapon preview icon. Manually enter data in "Previe' +
        'w parameters" '
      
        'group and press "Apply" button or press "Pick" button and select' +
        ' region on the '
      'texture.'
      
        '3) Create upgrades by pressing the "New upgrade" button. Assign ' +
        'icons and '
      
        'properties. Field "Value" is used ONLY for in-game UI and has no' +
        ' effect for real '
      
        'weapon'#39's parameters. To eliminate this issue, press "Setup influ' +
        'ence" button '
      
        'and enter to the editor all affected parameters (using LTX-synta' +
        'x).'
      
        '4) Confugure points for visualization on the preview. To do this' +
        ', select each upgrade '
      'and perform click on the preview icon.'
      
        '5) Create groups and assign every upgrade to appropriate group. ' +
        'Groups are used '
      
        'for restrictions - only one upgrade in the group can be installe' +
        'd on the weapon at '
      'the same time.'
      
        '6) Assign effects for groups. Upgrades from groups in "Effects" ' +
        'list become '
      'available only after installing upgrade from selected group.'
      '7) Export data and copy parameters into game configs.')
    ReadOnly = True
    TabOrder = 1
  end
end
