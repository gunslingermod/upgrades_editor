object InfluencesList: TInfluencesList
  Left = 336
  Top = 234
  BorderStyle = bsToolWindow
  Caption = 'Select Influences To Add:'
  ClientHeight = 436
  ClientWidth = 192
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
  object list: TListBox
    Left = 8
    Top = 8
    Width = 177
    Height = 361
    ExtendedSelect = False
    ItemHeight = 13
    Items.Strings = (
      'inv_weight'
      'hit_power'
      'hit_impulse'
      'fire_distance'
      'bullet_speed'
      'rpm'
      'misfire_start_condition'
      'misfire_end_condition'
      'misfire_start_prob'
      'misfire_end_prob'
      'condition_shot_dec'
      'condition_queue_shot_dec'
      'ammo_mag_size'
      'fire_modes'
      'ammo_class'
      'fire_dispersion_base'
      'control_inertion_factor'
      'crosshair_inertion'
      'cam_return'
      'cam_relax_speed'
      'cam_dispersion'
      'cam_dispersion_inc'
      'cam_dispersion_frac'
      'cam_max_angle'
      'cam_max_angle_horz'
      'cam_step_angle_horz'
      'zoom_cam_relax_speed'
      'zoom_cam_dispersion'
      'zoom_cam_dispersion_inc'
      'zoom_cam_dispersion_frac'
      'zoom_cam_max_angle'
      'zoom_cam_max_angle_horz'
      'zoom_cam_step_angle_horz'
      'PDM_disp_base'
      'PDM_disp_vel_factor'
      'PDM_disp_accel_factor'
      'PDM_disp_crouch'
      'PDM_disp_crouch_no_acc'
      'scope_status '
      'scopes_sect'
      'grenade_launcher_status'
      'grenade_launcher_name'
      'grenade_launcher_x'
      'grenade_launcher_y'
      'grenade_class'
      'launch_speed'
      'silencer_status'
      'silencer_name'
      'silencer_x'
      'silencer_y'
      'hud'
      'visual'
      'show_bones'
      'hide_bones'
      'hide_bones_override'
      'laser_installed'
      'torch_installed'
      'torch_available'
      'can_explose'
      'alter_zoom_allowed'
      'supports_detector'
      'disable_pda_show_anim'
      'disable_pda_hide_anim'
      'disable_nv_anim'
      'disable_headlamp_anim'
      'disable_kick_anim'
      'flame_particles'
      'smoke_particles'
      'shell_particles'
      'actor_camera_speed_factor'
      'permanent_lens_render'
      'lens_factor_levels_count'
      'min_lens_factor'
      'max_lens_factor'
      '')
    MultiSelect = True
    TabOrder = 0
  end
  object btn_ok: TButton
    Left = 16
    Top = 400
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = btn_okClick
  end
  object btn_close: TButton
    Left = 104
    Top = 400
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btn_closeClick
  end
end
