object UpgradeEditor: TUpgradeEditor
  Left = 276
  Top = 224
  BorderStyle = bsToolWindow
  Caption = 'Edit Upgrade'
  ClientHeight = 254
  ClientWidth = 296
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object group_general: TGroupBox
    Left = 8
    Top = 0
    Width = 281
    Height = 145
    Caption = 'General'
    TabOrder = 0
    object Label6: TLabel
      Left = 8
      Top = 42
      Width = 39
      Height = 13
      Caption = 'Property'
    end
    object Label5: TLabel
      Left = 8
      Top = 20
      Width = 28
      Height = 13
      Caption = 'Name'
    end
    object Cost: TLabel
      Left = 8
      Top = 90
      Width = 21
      Height = 13
      Caption = 'Cost'
    end
    object Label8: TLabel
      Left = 8
      Top = 114
      Width = 27
      Height = 13
      Caption = 'Value'
    end
    object Label16: TLabel
      Left = 8
      Top = 68
      Width = 34
      Height = 13
      Caption = 'Inherits'
    end
    object edit_name: TEdit
      Left = 64
      Top = 16
      Width = 209
      Height = 21
      TabOrder = 0
    end
    object combo_property: TComboBox
      Left = 64
      Top = 40
      Width = 209
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        'prop_weight'
        'prop_silencer'
        'prop_underbarrel_slot'
        'prop_reliability'
        'prop_bullet_speed'
        'prop_recoil'
        'prop_ammo_size'
        'prop_grenade_launcher'
        'prop_scope_4x'
        'prop_scope_1.6x'
        'prop_rpm'
        'prop_calibre'
        'prop_dispersion'
        'prop_inertion'
        'prop_autolockscope'
        'prop_scope_1.5x'
        'prop_scope_5x'
        'prop_scope_6x '
        'prop_scope_attach'
        'prop_scope'
        'prop_contrast'
        'prop_autofire'
        'prop_3xfire'
        'prop_nightvision'
        'prop_no_buck'
        'prop_laser'
        'prop_torch'
        'prop_lightingsights'
        'prop_rail'
        'prop_shortstock'
        'prop_shortbarrel'
        'prop_tacticalhandle'
        'prop_bayonet'
        'prop_short_barrel'
        'prop_long_barrel'
        'prop_short_stock'
        'prop_long_stock'
        'prop_tactic_handle'
        'prop_new_scope'
        'prop_armor'
        'prop_damage'
        'prop_durability'
        'prop_restore_bleeding'
        'prop_restore_health'
        'prop_night_vision'
        'prop_night_vision_2'
        'prop_night_vision_3'
        'prop_power'
        'prop_tonnage'
        'prop_chem'
        'prop_radio'
        'prop_thermo'
        'prop_electro'
        'prop_psy'
        'prop_artefact'
        'prop_weightoutfit'
        'prop_autolock'
        'prop_sprint'
        'prop_scanner'
        'prop_headlamp')
    end
    object edit_cost: TEdit
      Left = 64
      Top = 88
      Width = 89
      Height = 21
      TabOrder = 2
      OnKeyPress = edit_costKeyPress
    end
    object edit_value: TEdit
      Left = 64
      Top = 112
      Width = 89
      Height = 21
      TabOrder = 3
      OnChange = edit_valueChange
    end
    object btn_stringeditor: TButton
      Left = 160
      Top = 96
      Width = 113
      Height = 25
      Caption = 'Setup Influence...'
      TabOrder = 4
      OnClick = btn_stringeditorClick
    end
    object edit_inherits: TEdit
      Left = 64
      Top = 64
      Width = 209
      Height = 21
      TabOrder = 5
    end
  end
  object btn_adv: TButton
    Left = 288
    Top = 110
    Width = 9
    Height = 25
    Caption = '>'
    TabOrder = 2
    OnClick = btn_advClick
  end
  object group_adv: TGroupBox
    Left = 298
    Top = 0
    Width = 289
    Height = 249
    Caption = 'Advanced configuration'
    Enabled = False
    TabOrder = 3
    object Label7: TLabel
      Left = 8
      Top = 72
      Width = 97
      Height = 13
      Caption = 'precondition_functor'
    end
    object label_pp: TLabel
      Left = 8
      Top = 96
      Width = 111
      Height = 13
      Caption = 'precondition_parameter'
    end
    object Label9: TLabel
      Left = 8
      Top = 120
      Width = 66
      Height = 13
      Caption = 'effect_functor'
    end
    object Label10: TLabel
      Left = 8
      Top = 144
      Width = 80
      Height = 13
      Caption = 'effect_parameter'
    end
    object Label11: TLabel
      Left = 8
      Top = 168
      Width = 69
      Height = 13
      Caption = 'prereq_functor'
    end
    object Label12: TLabel
      Left = 8
      Top = 192
      Width = 103
      Height = 13
      Caption = 'prereq_tooltip_functor'
    end
    object Label13: TLabel
      Left = 8
      Top = 216
      Width = 70
      Height = 13
      Caption = 'prereq_params'
    end
    object Label14: TLabel
      Left = 8
      Top = 24
      Width = 73
      Height = 13
      Caption = 'Inventory name'
    end
    object Label15: TLabel
      Left = 8
      Top = 48
      Width = 98
      Height = 13
      Caption = 'Inventory description'
    end
    object edit_inv_name: TEdit
      Left = 136
      Top = 21
      Width = 145
      Height = 21
      TabOrder = 0
    end
    object edit_inv_descr: TEdit
      Left = 136
      Top = 45
      Width = 145
      Height = 21
      TabOrder = 1
    end
    object edit_precond_f: TEdit
      Left = 136
      Top = 69
      Width = 145
      Height = 21
      TabOrder = 2
    end
    object edit_precond_param: TEdit
      Left = 136
      Top = 93
      Width = 145
      Height = 21
      TabOrder = 3
    end
    object edit_effect_f: TEdit
      Left = 136
      Top = 117
      Width = 145
      Height = 21
      TabOrder = 4
    end
    object edit_effect_param: TEdit
      Left = 136
      Top = 141
      Width = 145
      Height = 21
      TabOrder = 5
    end
    object edit_prereq_f: TEdit
      Left = 136
      Top = 165
      Width = 145
      Height = 21
      TabOrder = 6
    end
    object edit_prereq_tooltip_f: TEdit
      Left = 136
      Top = 189
      Width = 145
      Height = 21
      TabOrder = 7
    end
    object edit_prereq_params: TEdit
      Left = 136
      Top = 213
      Width = 145
      Height = 21
      TabOrder = 8
    end
  end
  object group_visualization: TGroupBox
    Left = 8
    Top = 144
    Width = 281
    Height = 105
    Caption = 'Visualization'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 60
      Width = 52
      Height = 13
      Caption = 'Scheme X:'
    end
    object Label2: TLabel
      Left = 8
      Top = 80
      Width = 52
      Height = 13
      Caption = 'Scheme Y:'
    end
    object Label3: TLabel
      Left = 8
      Top = 20
      Width = 37
      Height = 13
      Caption = 'Point X:'
    end
    object Label4: TLabel
      Left = 8
      Top = 40
      Width = 37
      Height = 13
      Caption = 'Point Y:'
    end
    object preview_bevel: TBevel
      Left = 144
      Top = 15
      Width = 100
      Height = 50
    end
    object preview: TImage
      Left = 144
      Top = 15
      Width = 100
      Height = 50
      OnClick = previewClick
    end
    object edit_sch_x: TEdit
      Left = 64
      Top = 56
      Width = 73
      Height = 21
      TabOrder = 2
      Text = '0'
    end
    object edit_sch_y: TEdit
      Left = 64
      Top = 76
      Width = 73
      Height = 21
      TabOrder = 3
      Text = '0'
    end
    object edit_point_x: TEdit
      Left = 64
      Top = 16
      Width = 73
      Height = 21
      TabOrder = 0
      Text = '0'
    end
    object edit_point_y: TEdit
      Left = 64
      Top = 36
      Width = 73
      Height = 21
      TabOrder = 1
      Text = '0'
    end
  end
end
