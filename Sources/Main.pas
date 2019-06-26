unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, Buttons, Upgrade, UpEditor, math,
  Menus, ActnList, helper, AboutForm, FileCtrl, texture_loader, strutils, registry, shlobj, dds_utils, helpform, ClipBrd;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    back: TImage;
    weapon_icon: TImage;
    scheme_rect: TShape;
    group_weapon_icon: TGroupBox;
    edit_upgr_icon_height: TEdit;
    btn_apply_wpn_icon: TButton;
    Label5: TLabel;
    Label4: TLabel;
    edit_upgr_icon_width: TEdit;
    edit_upgr_icon_y: TEdit;
    Label3: TLabel;
    Label2: TLabel;
    edit_upgr_icon_x: TEdit;
    group_up_control: TGroupBox;
    btn_add_up: TButton;
    btn_edit_up: TButton;
    group_visualization: TGroupBox;
    check_draw_back: TCheckBox;
    check_align: TCheckBox;
    btn_del_up: TButton;
    align_list: TListBox;
    group_std_icon: TGroupBox;
    edit_defsize_width: TEdit;
    edit_defsize_height: TEdit;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edit_defsize_radius: TEdit;
    check_freeze: TCheckBox;
    group_upgroups: TGroupBox;
    list_upgroups: TListBox;
    edit_upgroupname: TEdit;
    btn_changegroup: TButton;
    btn_addgroup: TButton;
    btn_removegroup: TButton;
    btn_register_up: TButton;
    btn_unregister_up: TButton;
    Label8: TLabel;
    list_effects: TListBox;
    mmenu: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    SaveAs: TMenuItem;
    Exit1: TMenuItem;
    Options1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    Newupgrade1: TMenuItem;
    Deleteupgrade1: TMenuItem;
    New1: TMenuItem;
    Export1: TMenuItem;
    opener: TOpenDialog;
    saver: TSaveDialog;
    Setweapontexture1: TMenuItem;
    SetUpgradetexture1: TMenuItem;
    texture_opener: TOpenDialog;
    Save1: TMenuItem;
    btn_pick_preview: TButton;
    Options2: TMenuItem;
    Assotiatemewithupr1: TMenuItem;
    Removeassotiation1: TMenuItem;
    Editupgrade1: TMenuItem;
    group_global: TGroupBox;
    Label9: TLabel;
    edit_wpn_name: TEdit;
    OpenRecent1: TMenuItem;
    rec11: TMenuItem;
    rec21: TMenuItem;
    rec31: TMenuItem;
    rec41: TMenuItem;
    Clearprogramsregistrysettings1: TMenuItem;
    Help2: TMenuItem;
    Calculatetreasures1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_apply_wpn_iconClick(Sender: TObject);
    procedure scheme_rectMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure scheme_rectMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure scheme_rectMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure check_draw_backClick(Sender: TObject);
    procedure check_alignClick(Sender: TObject);
    procedure align_listMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure align_listKeyPress(Sender: TObject; var Key: Char);
    procedure weapon_iconMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure check_freezeClick(Sender: TObject);
    procedure btn_addgroupClick(Sender: TObject);
    procedure btn_changegroupClick(Sender: TObject);
    procedure btn_removegroupClick(Sender: TObject);
    procedure btn_register_upClick(Sender: TObject);
    procedure btn_unregister_upClick(Sender: TObject);
    procedure list_upgroupsClick(Sender: TObject);
    procedure list_effectsClick(Sender: TObject);
    procedure Newupgrade1Click(Sender: TObject);
    procedure Deleteupgrade1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Export1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure SaveAsClick(Sender: TObject);
    procedure Setweapontexture1Click(Sender: TObject);
    procedure SetUpgradetexture1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure btn_pick_previewClick(Sender: TObject);
    procedure Assotiatemewithupr1Click(Sender: TObject);
    procedure Removeassotiation1Click(Sender: TObject);
    procedure Editupgrade1Click(Sender: TObject);
    procedure rec11Click(Sender: TObject);
    procedure rec21Click(Sender: TObject);
    procedure rec31Click(Sender: TObject);
    procedure rec41Click(Sender: TObject);
    procedure Clearprogramsregistrysettings1Click(Sender: TObject);
    procedure Help2Click(Sender: TObject);
    procedure Calculatetreasures1Click(Sender: TObject);

  private
    { Private declarations }
    _up_texture:TPicture;
    _wpn_texture:TPicture;

    _up_texture_name:string;
    _wpn_texture_name:string;

    _wpn_texture_rect:TRect;

    _upgrade_editor:TUpgradeEditor;
    _upgrades:array of TUpgrade;
    _groups:array of TUpgradeGroup;
    _about_form:TAbout;
    _help_form:THelp;
    _preview_selector:TTextureSelectorForm;

    _selected_index:integer;

    _lmouse_down:boolean;
    _last_mouse_point:TPoint;

    _startdir:string;

    procedure _UpdateWeaponIcon(const rect: TRect);
    function _UpgradeIndex(point:TPoint):integer;
    function _GetGroupPosInList(g:TUpgradeGroup):integer;
    procedure _DumpTextures(str:TFileStream);
    procedure _DumpUpgradeLTX(str:TFileStream; strings_str:TFileStream);
    procedure _DumpScheme(str, str16:TFileStream);
    procedure _DumpWeaponLTX(str:TFileStream);
    function _Validate():string;

    function _AdjustTreasureForUpgradesGroup(group:TUpgradeGroup; keyvalue: TMinMaxInfluenceContainer):boolean;
    function _RecurseTreasureCalc(root_group:TUpgradeGroup; keyvalue: TMinMaxInfluenceContainer):boolean;
    function _CalculateTreasures(keyvalue:TMinMaxInfluenceContainer):boolean;

    procedure _SaveProject(fname:string);
    procedure _LoadProject(fname:string);
    procedure _ResetScene();

    procedure _ActualizeRecentFiles(fname:string = '');
    procedure _AddRecentItem(str:string);
    procedure _ClearRecentItem(itm:TMenuItem);
    procedure _SetRecentItem(itm:TMenuItem; str: string);
  public
    procedure UpdateUpgrades();
    procedure NewUpgrade();
    procedure RemoveUpgrade(index:integer);
    function CheckGroupName(name:string; current:integer=-1):boolean;
    procedure NewGroup(name:string);
    procedure RenameGroup(name:string; index:integer);
    procedure RemoveGroup(index:integer);
    procedure DrawGroupsList();
    function upgrade_name(index:integer):string;
    function texture_name(index:integer):string;
    function IsRoot(g:TUpgradeGroup):boolean;
    function IsInCycle(g:TUpgradeGroup; scan_root: TUpgradeGroup = nil):boolean;

    function GenerateUpgradeName(base:string='upgrade'; current:integer = -1):string;
    function CheckUpgradeName(name:string; current:integer=-1):boolean;

    procedure SetWeaponTexture(fname:string);
    procedure SetUpgradeTexture(fname:string);

    function FindGroupByName(n:string):TUpgradeGroup;
    function FindUpgradeByName(n:string):TUpgrade;
    procedure SetNewWeaponPreviewParams(r:TRect);

    procedure OnRestore(Sender: TObject);
    procedure UpdateCaption();

    //укоротить полный путь к файлу, если файл уже в нашей папке.
    function ShorterPath(fname:string):string;
    procedure OpenFileWithPrompt(fname:string);

    { Public declarations }
  end;

var
  MainForm: TMainForm;

const
  sign_v100:integer = $72677075;
  sign:integer = $31307075;
  block_main:integer = 0;
  block_visualization:integer = 1;
  block_upgrade:integer = 2;
  block_group:integer = 3;
  block_group_upgrade:integer = 4;
  block_group_effects:integer = 5;
  block_finish:integer = -1;

const
  reg_key:string='STCOPGUE1.x';
  appname:string='Gunslinger'+chr(39)+'s Upgrades Editor 1.02';

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
var
  i:integer;
begin
  self.Top:=ceil((GetSystemMetrics(SM_CYSCREEN)-self.Height)/2);
  self.Left:=ceil((GetSystemMetrics(SM_CXSCREEN)-self.Width)/2);

  if self.Top<0 then self.Top:=0;
  if self.Left<0 then self.Left:=0;

  //_startdir:=GetCurrentDir();
  _startdir:=application.ExeName;
  for i:=length(_startdir) downto 1 do begin
    if _startdir[i]='\' then begin
      _startdir:=leftstr(_startdir, i-1);
      break;
    end;
  end;

  _up_texture:=TPicture.Create();
  _wpn_texture:=TPicture.Create();
  _wpn_texture_rect:=Rect(0,0,0,0);
  _up_texture_name:='';
  _wpn_texture_name:='';  


  _upgrade_editor:=TUpgradeEditor.Create(self);
  SetLength(_upgrades, 0);
  SetLength(_groups, 0);
  _selected_index:=-1;
  _lmouse_down:=false;

  Application.OnRestore:=OnRestore;
  Application.OnActivate:=OnRestore;  

  opener.FileName:='';
  saver.FileName:='';
  UpdateCaption();
  _about_form:=TAbout.Create(self);
  _help_form:=THelp.Create(self);
  _preview_selector:=TTextureSelectorForm.Create(self);

  if ParamCount>0 then begin
    _LoadProject(ParamStr(1));
  end;

  UpdateUpgrades;
  DrawGroupsList;
  _ActualizeRecentFiles();

end;

procedure TMainForm.FormDestroy(Sender: TObject);
var
  i:integer;
begin
  _ResetScene();
  _upgrade_editor.Free();
  _up_texture.Free();
  _wpn_texture.Free();
  _about_form.Free();
  _help_form.Free();
  _preview_selector.Free();
end;

procedure TMainForm.btn_apply_wpn_iconClick(Sender: TObject);
var
  r:TRect;
begin
  if _wpn_texture_name='' then begin
    if texture_opener.Execute() then begin
      SetWeaponTexture(texture_opener.FileName);
    end else begin
      exit;
    end;
  end;
  
  r.Left:=strtointdef(edit_upgr_icon_x.Text,0);
  r.Top:=strtointdef(edit_upgr_icon_y.Text,0);
  r.Right:=r.Left+strtointdef(edit_upgr_icon_width.Text,0);
  r.Bottom:=r.Top+strtointdef(edit_upgr_icon_height.Text,0);

  _UpdateWeaponIcon(r);
end;

procedure TMainForm._UpdateWeaponIcon(const rect: TRect);
var
  rect_dst:TRect;
const
  //координаты центра оружейной иконки - хардкод
  center_x:integer = 169;
  center_y:integer = 214;
begin
  _wpn_texture_rect:=rect;

  //скопируем регион
  weapon_icon.Picture.Bitmap.Width:=rect.Right-rect.Left;
  weapon_icon.Picture.Bitmap.Height:=rect.Bottom-rect.Top;
  weapon_icon.Width:=weapon_icon.Picture.Bitmap.Width;
  weapon_icon.Height:=weapon_icon.Picture.Bitmap.Height;

  rect_dst.Left:=0;
  rect_dst.Top:=0;
  rect_dst.Right:=weapon_icon.Picture.Bitmap.Width;
  rect_dst.Bottom:=weapon_icon.Picture.Bitmap.Height;
  weapon_icon.Picture.Bitmap.Canvas.CopyRect(rect_dst, _wpn_texture.Bitmap.Canvas, rect);

  //пересчитаем положение иконки
  weapon_icon.Top:=center_y-ceil(weapon_icon.Height/2);
  weapon_icon.Left:=center_x-ceil(weapon_icon.Width/2);

  UpdateUpgrades();
end;

procedure TMainForm.UpdateUpgrades;
var
  i:integer;
  sz:integer;
begin
  Repaint();
  for i:=0 to length(_upgrades)-1 do begin
    if (list_upgroups.ItemIndex>=0) and (_upgrades[i].GetGroup()=_groups[list_upgroups.ItemIndex]) then begin
      Canvas.Brush.Color:=clYellow;
      Canvas.Brush.Style:=bsSolid;
      Canvas.Pen.Color:=clYellow;
      Canvas.Pen.Style:=psSolid;
      Canvas.Rectangle(scheme_rect.Left+_upgrades[i].coords.X-2, scheme_rect.Top+_upgrades[i].coords.Y-2, scheme_rect.Left+_upgrades[i].coords.X+_upgrades[i].visual.GetWidth+2, scheme_rect.Top+_upgrades[i].coords.Y+_upgrades[i].visual.GetHeight+2);
    end;

    if i=_selected_index then begin
      continue; //отрисуем в последнюю очередь
    end;
    Canvas.Draw(scheme_rect.Left+_upgrades[i].coords.X, scheme_rect.Top+_upgrades[i].coords.Y, _upgrades[i].visual.GetPic().Graphic);
  end;

  if (_selected_index>=0) and (_selected_index<length(_upgrades))  then begin
      i:=_selected_index;

      if (list_upgroups.ItemIndex>=0) and (_upgrades[i].GetGroup()=_groups[list_upgroups.ItemIndex]) then begin
        Canvas.Brush.Color:=clPurple;
        Canvas.Pen.Color:=clPurple;
      end else begin
        Canvas.Brush.Color:=clBlue;
        Canvas.Pen.Color:=clBlue;
      end;
      Canvas.Brush.Style:=bsSolid;

      Canvas.Pen.Style:=psSolid;
      Canvas.Rectangle(scheme_rect.Left+_upgrades[i].coords.X-2, scheme_rect.Top+_upgrades[i].coords.Y-2, scheme_rect.Left+_upgrades[i].coords.X+_upgrades[i].visual.GetWidth+2, scheme_rect.Top+_upgrades[i].coords.Y+_upgrades[i].visual.GetHeight+2);
      Canvas.Draw(scheme_rect.Left+_upgrades[i].coords.X, scheme_rect.Top+_upgrades[i].coords.Y, _upgrades[i].visual.GetPic().Graphic);


      Canvas.Brush.Color:=clBlue;
      Canvas.Pen.Color:=clBlue;
      sz:=strtointdef(edit_defsize_radius.Text, 7);
      Canvas.MoveTo(_upgrades[i].point.x+sz,_upgrades[i].point.y);
      Canvas.LineTo(_upgrades[i].point.x+sz,_upgrades[i].point.y+2*sz);
      Canvas.MoveTo(_upgrades[i].point.x,_upgrades[i].point.y+sz);
      Canvas.LineTo(_upgrades[i].point.x+2*sz,_upgrades[i].point.y+sz);
  end;
end;

procedure TMainForm.NewUpgrade;
var
  i:integer;
begin
  i:=length(_upgrades);
  SetLength(_upgrades, i+1);
  _upgrades[i]:=TUpgrade.Create(Point(strtointdef(edit_defsize_width.Text, 0), strtointdef(edit_defsize_height.Text, 0)));
  _upgrades[i].name:=GenerateUpgradeName('upgrade', i);
  _upgrade_editor.SetUpgrade(_upgrades[i]);
  _upgrade_editor.Show();
  _selected_index:=i;
end;

function TMainForm._UpgradeIndex(point: TPoint): integer;
var
  i:integer;
begin
  result:=-1;
  if (_selected_index>=0) and (_upgrades[_selected_index].IsPointMy(point)) then begin
    result:=_selected_index;
    exit;
  end;

  for i:=length(_upgrades)-1 downto 0 do begin
    if _upgrades[i].IsPointMy(point) then begin
      result:=i;
      exit;
    end;
  end;
end;

procedure TMainForm.scheme_rectMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  _lmouse_down:=false;
  if ssLeft	in Shift then begin
    _selected_index:=_UpgradeIndex(Point(X,Y));

    _lmouse_down:=true;
    _last_mouse_point.X:=X;
    _last_mouse_point.Y:=Y;
  end else if ssRight	in Shift then begin
    _selected_index:=_UpgradeIndex(Point(X,Y));
    if _selected_index>=0 then begin
      //_upgrade_editor.SetUpgrade(_upgrades[_selected_index]);
      //_upgrade_editor.Show();
      Editupgrade1Click(self);
    end;
  end;
  if (_selected_index>=0) and (_upgrades[_selected_index].GetGroup()<>nil) then begin
    list_upgroups.ItemIndex:=_GetGroupPosInList(_upgrades[_selected_index].GetGroup());
  end else begin
    list_upgroups.ItemIndex:=-1;
  end;
  DrawGroupsList();
  UpdateUpgrades();
end;

procedure TMainForm.scheme_rectMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  _lmouse_down:=false;
end;

procedure TMainForm.scheme_rectMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  if _lmouse_down and (_selected_index>=0) then begin
    if (X<=0) or (X>=scheme_rect.Width) or (Y<=0) or (Y>=scheme_rect.Height) then begin
      _lmouse_down:=false;
      UpdateUpgrades();
      exit;
    end;
    if check_align.Checked then begin
      for i:=align_list.Items.Count-2 downto 0 do begin
        if strtointdef(align_list.Items[i], 0)<=X then begin
          _upgrades[_selected_index].coords.X:=strtointdef(align_list.Items[i], 0);
          break;
        end;
      end;
    end else begin;
      _upgrades[_selected_index].coords.X:=_upgrades[_selected_index].coords.X+(X-_last_mouse_point.X);
    end;
    _upgrades[_selected_index].coords.Y:=_upgrades[_selected_index].coords.Y+(Y-_last_mouse_point.Y);
    _last_mouse_point.X:=X;
    _last_mouse_point.Y:=Y;
    UpdateUpgrades();
  end;
end;

procedure TMainForm.check_draw_backClick(Sender: TObject);
begin
  back.Visible:=check_draw_back.Checked;
  UpdateUpgrades();
end;

procedure TMainForm.RemoveUpgrade(index: integer);
begin
  if (index<0) or (index>=length(_upgrades)) then exit;
  _upgrades[index].Free();
  if (index<>length(_upgrades)-1) then _upgrades[index]:=_upgrades[length(_upgrades)-1];
  SetLength(_upgrades, length(_upgrades)-1);
end;

procedure TMainForm.check_alignClick(Sender: TObject);
begin
  align_list.Visible:=check_align.Checked;
  align_list.Enabled:=check_align.Checked;
  align_list.ItemIndex:=-1;
end;

procedure TMainForm.align_listMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (ssLeft in Shift) then begin
    if (align_list.ItemIndex=align_list.Items.Count-1) then begin
      if align_list.Items.Count>1 then begin
        align_list.Items[align_list.ItemIndex]:=align_list.Items[align_list.Items.Count-2];
      end else begin
        align_list.Items[align_list.ItemIndex]:='0';
      end;
      align_list.Items.Add('[...]');
    end;
  end else if ssRight in Shift then begin
   if (align_list.ItemIndex<align_list.Items.Count-1) and (align_list.ItemIndex>=0) then begin
    align_list.Items.Delete(align_list.ItemIndex);
   end;
  end;
end;

procedure TMainForm.align_listKeyPress(Sender: TObject; var Key: Char);
var
  tmp:string;
begin
  if (align_list.ItemIndex<align_list.Items.Count-1) and (align_list.ItemIndex>=0) then begin
    if key = '+' then begin
      align_list.Items[align_list.ItemIndex]:=inttostr(strtointdef(align_list.Items[align_list.ItemIndex],0)+1);
    end else if key = '-' then begin
      align_list.Items[align_list.ItemIndex]:=inttostr(strtointdef(align_list.Items[align_list.ItemIndex],0)-1);    
    end;

    if (align_list.ItemIndex>0) and (strtointdef(align_list.Items[align_list.ItemIndex],0)<strtointdef(align_list.Items[align_list.ItemIndex-1],0)) then begin
      tmp:=align_list.Items[align_list.ItemIndex];
      align_list.Items[align_list.ItemIndex]:=align_list.Items[align_list.ItemIndex-1];
      align_list.Items[align_list.ItemIndex-1]:=tmp;
      align_list.ItemIndex:=align_list.ItemIndex-1;
    end else if (align_list.ItemIndex<align_list.Items.Count-2) and (strtointdef(align_list.Items[align_list.ItemIndex],0)>strtointdef(align_list.Items[align_list.ItemIndex+1],0)) then begin
      tmp:=align_list.Items[align_list.ItemIndex];
      align_list.Items[align_list.ItemIndex]:=align_list.Items[align_list.ItemIndex+1];
      align_list.Items[align_list.ItemIndex+1]:=tmp;
      align_list.ItemIndex:=align_list.ItemIndex+1;
    end;
  end;
end;
procedure TMainForm.weapon_iconMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (ssLeft in Shift) and (_selected_index>=0) then begin
    _upgrades[_selected_index].point.X:=weapon_icon.Left+X-strtointdef(edit_defsize_radius.Text, 7);
    _upgrades[_selected_index].point.Y:=weapon_icon.Top+Y-strtointdef(edit_defsize_radius.Text, 7);
  end;
  UpdateUpgrades();
end;

procedure TMainForm.check_freezeClick(Sender: TObject);
begin
  edit_defsize_width.Enabled:=not check_freeze.Checked;
  edit_defsize_height.Enabled:=not check_freeze.Checked;
  edit_defsize_radius.Enabled:=not check_freeze.Checked;
end;

function TMainForm.CheckGroupName(name: string; current: integer):boolean;
var
  i:integer;
begin
  result:=false;
  name:=trim(name);
  if length(name)<1 then exit;

  for i:=0 to length(_groups)-1 do begin
    if (current<>i) and (LowerCase(name)=LowerCase(_groups[i].GetName())) then exit;
  end;

  result:=true;
end;

procedure TMainForm.NewGroup(name: string);
var
  i:integer;
begin
  if not CheckGroupName(name) then exit;
  i:=length(_groups);
  SetLength(_groups, i+1);
  _groups[i]:=TUpgradeGroup.Create(name);
end;

procedure TMainForm.RemoveGroup(index: integer);
var
  i:integer;
begin
  if (index<0) or (index>=length(_groups)) then exit;
  for i:=0 to length(_groups)-1 do begin
    _groups[i].UnRegisterEffect( _groups[index]);
  end;

  _groups[index].Free();
  for i:=index+1 to length(_groups)-1 do begin
    _groups[i-1]:=_groups[i];
  end;
  SetLength(_groups, length(_groups)-1);
end;

procedure TMainForm.RenameGroup(name:string; index: integer);
begin
  if not CheckGroupName(name, index) then exit;
  if (index<0) or (index>=length(_groups)) then exit;
  _groups[index].SetName(name);
end;

procedure TMainForm.DrawGroupsList;
var
  i, index:integer;
begin
  index:=list_upgroups.ItemIndex;
  list_upgroups.Clear();
  list_effects.Clear();
  for i:=0 to length(_groups)-1 do begin
    list_upgroups.Items.Add(_groups[i].GetName());
    list_effects.Items.Add(_groups[i].GetName());    
  end;
  if index<list_upgroups.Count then list_upgroups.ItemIndex:=index else list_upgroups.ItemIndex:=-1;

  if list_upgroups.ItemIndex<0 then begin
    list_effects.Clear();
  end else begin
    for i:=0 to _groups[list_upgroups.ItemIndex].EffectsCnt()-1 do begin
      list_effects.Selected[_GetGroupPosInList(_groups[list_upgroups.ItemIndex].GetEffect(i))]:=true;
    end;
  end;
end;

procedure TMainForm.btn_addgroupClick(Sender: TObject);
var
  defname, name:string;
  i:integer;
begin
  edit_upgroupname.Text:=trim(edit_upgroupname.Text);
  if edit_upgroupname.Text<>'' then begin
    defname:=edit_upgroupname.Text;
  end else begin
    defname:='group';
  end;

  name:=defname;
  i:=0;
  while not CheckGroupName(name) do begin
    name:=defname+inttostr(i);
    i:=i+1;
  end;

  NewGroup(name);
  DrawGroupsList();
end;

procedure TMainForm.btn_changegroupClick(Sender: TObject);
begin
  if (list_upgroups.ItemIndex>=0) and CheckGroupName(edit_upgroupname.Text, list_upgroups.ItemIndex) then begin
    _groups[list_upgroups.ItemIndex].SetName(edit_upgroupname.Text);
  end;
  DrawGroupsList();
end;

procedure TMainForm.btn_removegroupClick(Sender: TObject);
begin
  RemoveGroup(list_upgroups.ItemIndex);
  DrawGroupsList();
  UpdateUpgrades();
end;

procedure TMainForm.btn_register_upClick(Sender: TObject);
begin
  if (list_upgroups.ItemIndex>=0) and (_selected_index>=0) then begin
    _groups[list_upgroups.ItemIndex].RegisterUpgrade(_upgrades[_selected_index]);
  end;
  UpdateUpgrades();
end;

procedure TMainForm.btn_unregister_upClick(Sender: TObject);
begin
  if (_selected_index>=0) and (_upgrades[_selected_index].GetGroup()<>nil) then begin
    _upgrades[_selected_index].GetGroup().UnRegisterUpgrade(_upgrades[_selected_index]);
  end;
  UpdateUpgrades();
end;

function TMainForm._GetGroupPosInList(g: TUpgradeGroup): integer;
var
  i:integer;
begin
  for i:=0 to length(_groups)-1 do begin
    if _groups[i]=g then begin
      result:=i;
      exit;
    end;
  end;
  result:=-1;
end;

procedure TMainForm.list_upgroupsClick(Sender: TObject);
begin
  if list_upgroups.ItemIndex>=0 then begin
    edit_upgroupname.Text:=list_upgroups.Items[list_upgroups.ItemIndex];
    DrawGroupsList();
    UpdateUpgrades();
  end;
end;

procedure TMainForm.list_effectsClick(Sender: TObject);
var
  i:integer;
begin
  if list_upgroups.ItemIndex>=0 then begin
    _groups[list_upgroups.ItemIndex].UnRegisterAllEffects();
    for i:=0 to list_effects.Count-1 do begin
      if list_effects.Selected[i] then begin
        _groups[list_upgroups.ItemIndex].RegisterEffect(_groups[i]);
        if IsInCycle(_groups[list_upgroups.ItemIndex]) then begin
          MessageBox(self.Handle, PChar('Cycle on "'+_groups[list_upgroups.ItemIndex].GetName()+'"'), '', MB_OK+MB_ICONERROR);
          _groups[list_upgroups.ItemIndex].UnRegisterEffect(_groups[i]);
        end;
      end;
    end;
  end;
  DrawGroupsList();
end;

function TMainForm.GenerateUpgradeName(base: string; current: integer): string;
var
  i:integer;
begin
  result:=base;
  i:=0;
  while not CheckUpgradeName(result, current) do begin
    result:=base+inttostr(i);
    i:=i+1;
  end;
end;

function TMainForm.CheckUpgradeName(name: string; current: integer): boolean;
var
  i:integer;
begin
  for i:=0 to length(_upgrades)-1 do begin
    if (i<>current) and (LowerCase(name)=LowerCase(_upgrades[i].name)) then begin
      result:=false;
      exit;
    end;
  end;
  result:=true;
end;

procedure TMainForm._DumpTextures(str: TFileStream);
var
  i:integer;
  itm:string;
  ptr:PChar;
begin
  for i:=0 to length(_upgrades)-1 do begin
    itm:=
      '<texture id="'+texture_name(i)
      +'" x="'+inttostr(_upgrades[i].visual.GetTopLeft.x)
      +'" y="'+inttostr(_upgrades[i].visual.GetTopLeft.y)
      +'" width="'+inttostr(_upgrades[i].visual.GetWidth)
      +'" height="'+inttostr(_upgrades[i].visual.GetHeight)
      +'" />'+chr($0d)+chr($0a);
    ptr:=PChar(itm);
    str.Write(ptr^, length(itm));
  end;
end;

function TMainForm.upgrade_name(index: integer): string;
begin
  if (index<0) or (index>=length(_upgrades)) then begin
    result:='';  
    exit;
  end;
  result:=edit_wpn_name.Text+'_'+_upgrades[index].name;
end;

procedure TMainForm._DumpUpgradeLTX(str: TFileStream; strings_str:TFileStream);
var
  i:integer;
  s, name:string;
  ptr:PChar;
const
  start_str:PChar = '<?xml version="1.0" encoding="windows-1251" ?>'+chr($0d)+chr($0a)+'<string_table>'+chr($0d)+chr($0a);
  end_str:PChar = '</string_table>'+chr($0d)+chr($0a);
begin
  strings_str.WriteBuffer(start_str^, length(start_str));

  for i:=0 to length(_upgrades)-1 do begin
    s:=';------------------------------------------'+upgrade_name(i)+'------------------------------------------'+chr($0d)+chr($0a);
    s:=s+'[up_sect_'+upgrade_name(i)+']';

    if _upgrades[i].inherited_section<>'' then begin
      s:=s+':'+_upgrades[i].inherited_section;
    end;

    s:=s+chr($0d)+chr($0a);
    s:=s+'cost = '+inttostr(_upgrades[i].cost)+chr($0d)+chr($0a);
    if _upgrades[i].value<>'' then begin
      s:=s+'value = '+_upgrades[i].value+chr($0d)+chr($0a);
    end;
    s:=s+_upgrades[i].section_params.GetText+chr($0d)+chr($0a);
    ptr:=PChar(s);
    str.Write(ptr^, length(s));

    s:='[up_'+upgrade_name(i)+']'+chr($0d)+chr($0a);
    s:=s+'scheme_index = 0, '+inttostr(i)+chr($0d)+chr($0a);
    s:=s+'known = 1'+chr($0d)+chr($0a);
    s:=s+'effects = '+_upgrades[i].GetGroup().GetEffectsString(edit_wpn_name.Text)+chr($0d)+chr($0a);
    s:=s+'section = '+'up_sect_'+upgrade_name(i)+chr($0d)+chr($0a);
    s:=s+'property = '+_upgrades[i].up_prop+chr($0d)+chr($0a);

    s:=s+'precondition_functor = '+_upgrades[i].precondition_functor+chr($0d)+chr($0a);
    s:=s+'precondition_parameter = '+_upgrades[i].precondition_parameter+chr($0d)+chr($0a);

    s:=s+'effect_functor = '+_upgrades[i].effect_functor+chr($0d)+chr($0a);
    s:=s+'effect_parameter  = '+_upgrades[i].effect_parameter+chr($0d)+chr($0a);

    s:=s+'prereq_functor  = '+_upgrades[i].prereq_functor+chr($0d)+chr($0a);
    s:=s+'prereq_tooltip_functor  = '+_upgrades[i].prereq_tooltip_functor+chr($0d)+chr($0a);
    s:=s+'prereq_params  = '+_upgrades[i].prereq_params+chr($0d)+chr($0a);    


    if _upgrades[i].inv_name='' then
      name:='gunsl_'+edit_wpn_name.Text+'_up_'+_upgrades[i].name+'_name'
    else
      name:=_upgrades[i].inv_name;
    s:=s+'name ='+name +chr($0d)+chr($0a);

    name:= '<string id="'+name+'">'+chr($0d)+chr($0a)+'     <text>'+_upgrades[i].name+'</text>'+chr($0d)+chr($0a)+'</string>'+chr($0d)+chr($0a);
    ptr:=PChar(name);
    strings_str.WriteBuffer(ptr^, length(name));

    if _upgrades[i].inv_descr='' then
      name:='gunsl_'+edit_wpn_name.Text+'_up_'+_upgrades[i].name+'_descr'
    else
      name:=_upgrades[i].inv_descr;

    s:=s+'description ='+name +chr($0d)+chr($0a);

    name:= '<string id="'+name+'">'+chr($0d)+chr($0a)+'     <text>'+_upgrades[i].name+'</text>'+chr($0d)+chr($0a)+'</string>'+chr($0d)+chr($0a);
    ptr:=PChar(name);
    strings_str.WriteBuffer(ptr^, length(name));

    s:=s+'icon = '+texture_name(i)+chr($0d)+chr($0a);

    ptr:=PChar(s);
    str.Write(ptr^, length(s));
  end;

  s:=';------------------------------------------------------------------------------------'+chr($0d)+chr($0a);
  ptr:=PChar(s);
  str.Write(ptr^, length(s));

  for i:=0 to length(_groups)-1 do begin
    if _groups[i].ElementsCnt=0 then continue;
    s:='['+_groups[i].GetFullName(edit_wpn_name.Text)+']'+chr($0d)+chr($0a);
    s:=s+'elements = '+_groups[i].GetElementsString('up_'+edit_wpn_name.Text+'_')+chr($0d)+chr($0a);
    ptr:=PChar(s);
    str.Write(ptr^, length(s));
  end;

  strings_str.WriteBuffer(end_str^, length(end_str));
end;



procedure TMainForm._DumpScheme(str, str16: TFileStream);
var
  i:integer;
  s:string;
  ptr:PChar;
begin
  s:='<template name="upgrade_scheme_'+edit_wpn_name.Text+'">'+chr($0d)+chr($0a)+'<column>'+chr($0d)+chr($0a);
  for i:=0 to length(_upgrades)-1 do begin
    s:=s
      +'<cell x="'+inttostr(_upgrades[i].coords.X)
      +'" y="'+inttostr(_upgrades[i].coords.Y)
      +'" point_x="'+inttostr(_upgrades[i].point.X)
      +'" point_y="'+inttostr(_upgrades[i].point.Y)
      +'" /> <!-- '+_upgrades[i].name
      +' -->'+chr($0d)+chr($0a);
  end;
  s:=s+'</column>'+chr($0d)+chr($0a)+'</template>';
  ptr:=PChar(s);
  str.Write(ptr^, length(s));


  s:='<template name="upgrade_scheme_'+edit_wpn_name.Text+'">'+chr($0d)+chr($0a)+'<column>'+chr($0d)+chr($0a);
  for i:=0 to length(_upgrades)-1 do begin
    s:=s
      +'<cell x="'+inttostr(ceil(_upgrades[i].coords.X*0.8))
      +'" y="'+inttostr(_upgrades[i].coords.Y)
      +'" point_x="'+inttostr(_upgrades[i].point.X)
      +'" point_y="'+inttostr(_upgrades[i].point.Y)
      +'" /> <!-- '+_upgrades[i].name
      +' -->'+chr($0d)+chr($0a);
  end;
  s:=s+'</column>'+chr($0d)+chr($0a)+'</template>';
  ptr:=PChar(s);
  str16.Write(ptr^, length(s));
end;

function TMainForm._Validate: string;
var
  i:integer;
begin
  if length(_upgrades)=0 then begin
    result:='Scene is empty!';
    exit;
  end;

  for i:=0 to length(_upgrades)-1 do begin
    if _upgrades[i].GetGroup()=nil then begin
      result:='Upgrade "'+_upgrades[i].name+'" has no group!';
      _selected_index:=i;
      UpdateUpgrades;
      DrawGroupsList;
      exit;
    end else if _upgrades[i].up_prop='' then begin
      result:='Upgrade "'+_upgrades[i].name+'" has no property!';
      _selected_index:=i;
      UpdateUpgrades;
      DrawGroupsList;
      exit;
    end;
  end;

  UpdateUpgrades;
  DrawGroupsList;
  result:='';
end;

procedure TMainForm._DumpWeaponLTX(str: TFileStream);
var
  s:string;
  d:string;
  ptr:PChar;
  i:integer;
begin
  s:='[wpn_'+edit_wpn_name.Text+']'+chr($0D)+chr($0A);

  d:=' ';
  s:=s+'upgrades =';
  for i:=0 to length(_groups)-1 do begin
    if IsRoot(_groups[i]) then begin
      s:=s+d+_groups[i].GetFullName(edit_wpn_name.Text);
      d:=', ';
    end;
  end;
  s:=s+chr($0D)+chr($0A)+'installed_upgrades = '+chr($0D)+chr($0A);
  s:=s+'upgrade_scheme = '+'upgrade_scheme_'+edit_wpn_name.Text+chr($0D)+chr($0A)+chr($0D)+chr($0A);
  s:=s+'upgr_icon_x = '+inttostr(_wpn_texture_rect.Left)+chr($0D)+chr($0A);
  s:=s+'upgr_icon_y = '+inttostr(_wpn_texture_rect.Top)+chr($0D)+chr($0A);
  s:=s+'upgr_icon_width = '+inttostr(_wpn_texture_rect.Right-_wpn_texture_rect.Left)+chr($0D)+chr($0A);
  s:=s+'upgr_icon_height = '+inttostr(_wpn_texture_rect.Bottom-_wpn_texture_rect.Top)+chr($0D)+chr($0A);
  ptr:=PChar(s);
  str.Write(ptr^, length(s));
end;

function TMainForm.texture_name(index: integer): string;
begin
  result:='ui_gunsl_up_'+upgrade_name(index);
end;

procedure TMainForm.Newupgrade1Click(Sender: TObject);
begin
  if _up_texture_name='' then begin
    if texture_opener.Execute() then begin
      SetUpgradeTexture(texture_opener.FileName);
    end else begin
      exit;
    end;
  end;
  NewUpgrade();
end;

procedure TMainForm.Deleteupgrade1Click(Sender: TObject);
begin
  if (_selected_index<0) then exit;
  RemoveUpgrade(_selected_index);
  _selected_index:=-1;
  DrawGroupsList();
  UpdateUpgrades();
end;

procedure TMainForm.OnRestore(Sender: TObject);
begin
  UpdateUpgrades();
  DrawGroupsList();
end;

procedure TMainForm._LoadProject(fname: string);
var
  str:TFileStream;
  i, j, blockid:integer;
  tmps:string;
  tmpi:integer;
  tmpc:cardinal;
  up:TUpgrade;
  up_gr, up_eff:TUpgradeGroup;

  file_ver:integer;
begin
  _ResetScene();
  fname:=trim(fname);
  str:=TFileStream.Create(fname, fmOpenRead);
  try
    try
      file_ver:=ReadInt(str);
      if (file_ver<>sign) and (file_ver<>sign_v100) then begin
        raise Exception.Create('Invalid file!');
      end;

      saver.FileName:=fname;

      blockid:=ReadInt(str);
      while blockid<>block_finish do begin
        if blockid=block_main then begin
          edit_wpn_name.Text:=ReadString(str);
          SetUpgradeTexture(ReadString(str));
          SetWeaponTexture(ReadString(str));

          str.ReadBuffer(_wpn_texture_rect, sizeof(_wpn_texture_rect));
          edit_upgr_icon_x.Text:=inttostr(_wpn_texture_rect.Left);
          edit_upgr_icon_y.Text:=inttostr(_wpn_texture_rect.Top);
          _UpdateWeaponIcon(_wpn_texture_rect);
          edit_upgr_icon_width.Text:=inttostr(_wpn_texture_rect.Right-_wpn_texture_rect.Left);
          edit_upgr_icon_height.Text:=inttostr(_wpn_texture_rect.Bottom-_wpn_texture_rect.Top);
        end else if blockid=block_visualization then begin
          check_draw_back.Checked:=ReadBool(str);
          back.Visible:=check_draw_back.Checked;
          check_align.Checked:=ReadBool(str);
          align_list.Clear;
          tmpi:=ReadInt(str);
          for i:=0 to tmpi-1 do begin
            align_list.Items.Add(inttostr(ReadInt(str)));
          end;
          align_list.Items.Add('[...]');
          align_list.ItemIndex:=-1;
          align_list.Visible:=check_align.Checked;
          align_list.Enabled:=check_align.Checked;          

          check_freeze.Checked:=ReadBool(str);
          edit_defsize_width.Enabled:= not check_freeze.Checked;
          edit_defsize_height.Enabled:= not check_freeze.Checked;
          edit_defsize_radius.Enabled:= not check_freeze.Checked;

          edit_defsize_width.Text:=inttostr(ReadInt(str));
          edit_defsize_height.Text:=inttostr(ReadInt(str));
          edit_defsize_radius.Text:=inttostr(ReadInt(str));
        end else if blockid=block_upgrade then begin
          i:=length(_upgrades);
          SetLength(_upgrades, i+1);
          _upgrades[i]:=TUpgrade.Create(Point(0,0));
          _upgrades[i].Load(str, _up_texture, file_ver);
        end else if blockid=block_group then begin
          i:=length(_groups);
          SetLength(_groups, i+1);
          _groups[i]:=TUpgradeGroup.Create('');
          _groups[i].Load(str);
        end else if blockid=block_group_upgrade then begin
          tmps:=ReadString(str);
          up:=FindUpgradeByName(tmps);
          tmps:=ReadString(str);
          up_gr:=FindGroupByName(tmps);
          if (up<>nil) and (up_gr<>nil) then begin
            up_gr.RegisterUpgrade(up);
          end;
        end else if blockid=block_group_effects then begin
          tmps:=ReadString(str);
          up_gr:=FindGroupByName(tmps);
          if up_gr<>nil then begin
            tmpi:=ReadInt(str);
            for i:=0 to tmpi-1 do begin
              tmps:=ReadString(str);
              up_eff:=FindGroupByName(tmps);
              if up_eff<>nil then begin
                up_gr.RegisterEffect(up_eff);
              end;
            end;
          end;
        end else begin
          raise exception.Create('Unexpected block in file, id='+inttostr(blockid));
        end;
        blockid:=ReadInt(str);
      end;
      _ActualizeRecentFiles(fname);

    except
      on e:exception do begin
        application.MessageBox(PChar(e.Message), 'Error!', MB_OK+MB_ICONERROR);
        _ResetScene();
        saver.FileName:='';
      end;
    end;
  finally
    str.Free();
  end;

  UpdateUpgrades();
  DrawGroupsList();
  UpdateCaption()
end;



procedure TMainForm._SaveProject(fname: string);
var
  str:TFileStream;
  i, j:integer;

begin
  str:=TFileStream.Create(fname, fmCreate);

  try
    //блок
    str.WriteBuffer(sign, sizeof(sign)); //заголовок

    SaveInt(block_main, str);
    SaveString(edit_wpn_name.Text, str);
    SaveString(_up_texture_name, str);
    SaveString(_wpn_texture_name, str);
    str.WriteBuffer(_wpn_texture_rect, sizeof(_wpn_texture_rect));

    SaveInt(block_visualization, str);
    SaveBool(check_draw_back.Checked, str);
    SaveBool(check_align.Checked, str);
    SaveInt(align_list.Items.Count-1, str);
    for i:=0 to align_list.Items.Count-2 do begin
      SaveInt(strtointdef(align_list.Items[i], 0), str);
    end;
    SaveBool(check_freeze.Checked, str);
    SaveInt(strtointdef(edit_defsize_width.Text, 0), str);
    SaveInt(strtointdef(edit_defsize_height.Text, 0), str);
    SaveInt(strtointdef(edit_defsize_radius.Text, 0), str);

    for i:=0 to length(_upgrades)-1 do begin
      SaveInt(block_upgrade, str);
      _upgrades[i].Save(str);
    end;

    for i:=0 to length(_groups)-1 do begin
      SaveInt(block_group, str);
      _groups[i].Save(str);
    end;

    for i:=0 to length(_upgrades)-1 do begin
      if _upgrades[i].GetGroup()=nil then continue;
      SaveInt(block_group_upgrade, str);
      SaveString(_upgrades[i].name, str);
      SaveString(_upgrades[i].GetGroup().GetName, str);
    end;

    for i:=0 to length(_groups)-1 do begin
      SaveInt(block_group_effects, str);
      SaveString(_groups[i].GetName(), str);
      SaveInt(_groups[i].EffectsCnt(), str);
      for j:=0 to _groups[i].EffectsCnt()-1 do begin
        SaveString(_groups[i].GetEffect(j).GetName(), str);
      end;
    end;

    SaveInt(block_finish, str);
    
    _ActualizeRecentFiles(fname);
  finally
    str.Free();
  end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := (IDYES	= MessageBox(self.Handle, 'Do you really want to exit?', '', MB_YESNO+MB_ICONQUESTION));
end;

procedure TMainForm.Export1Click(Sender: TObject);
var
  dir:string;
  up_cfg:TFileStream;
  wpn_cfg:TFileStream;
  textures_xml:TFileStream;
  visual_xml:TFileStream;
  visual_xml_16:TFileStream;
  strings_xml:TFileStream;
begin
  dir:=_Validate();
  if dir<>'' then begin
    MessageBox(self.Handle, PChar(dir), 'Validation failed!', MB_OK+MB_ICONERROR);
    exit;
  end;

  if ID_YES=MessageBox(self.Handle, 'Use application'+chr(39)+'s directory?', '', MB_YESNO+MB_ICONQUESTION) then begin
    dir:=_startdir
  end else begin
    if not SelectDirectory('Export to:', '', dir) then exit;
  end;
  dir:=dir+'\'+'upgrades_'+edit_wpn_name.Text;

  try
    if not DirectoryExists(dir) and not CreateDir(dir) then raise Exception.Create('dir');
    textures_xml:=nil;
    up_cfg:=nil;
    wpn_cfg:=nil;
    visual_xml:=nil;
    visual_xml_16:=nil;
    try
      textures_xml:=TFileStream.Create(dir+'\textures_descr.xml',fmCreate);
      up_cfg:=TFileStream.Create(dir+'\upgrades.ltx',fmCreate);
      wpn_cfg:=TFileStream.Create(dir+'\base.ltx',fmCreate);
      visual_xml:=TFileStream.Create(dir+'\inventory_upgrade.xml',fmCreate);
      visual_xml_16:=TFileStream.Create(dir+'\inventory_upgrade_16.xml',fmCreate);
      strings_xml:=TFileStream.Create(dir+'\gunsl_up_'+edit_wpn_name.Text+'.xml',fmCreate);

      _DumpTextures(textures_xml);
      _DumpUpgradeLTX(up_cfg, strings_xml);
      _DumpWeaponLTX(wpn_cfg);
      _DumpScheme(visual_xml, visual_xml_16);
    finally
      up_cfg.Free();
      wpn_cfg.Free();
      textures_xml.Free();
      visual_xml.Free();
      visual_xml_16.Free();
      strings_xml.Free();
    end;
    Messagebox(self.Handle, 'Export completed!', '', MB_OK+MB_ICONINFORMATION);

  except
    messagebox(self.Handle, PChar('Cannot access directory '+dir+'!'), 'Error!', MB_OK+MB_ICONERROR);
  end;
end;

procedure TMainForm.Open1Click(Sender: TObject);
begin
  if (opener.Execute) then begin
    OpenFileWithPrompt(opener.FileName);
  end;
end;

procedure TMainForm.SaveAsClick(Sender: TObject);
var
  tmp:string;
begin
  tmp:=saver.FileName;
  if saver.Execute then
    _SaveProject(saver.FileName)
  else
    saver.FileName:=tmp;

  UpdateCaption();
end;

procedure TMainForm.Setweapontexture1Click(Sender: TObject);
begin
  if texture_opener.Execute() then begin
    SetWeaponTexture(texture_opener.FileName);
  end;
  UpdateUpgrades();
end;

procedure TMainForm.SetUpgradetexture1Click(Sender: TObject);
var i:integer;
begin
  if texture_opener.Execute() then begin
    SetUpgradeTexture(texture_opener.FileName);
  end;
  UpdateUpgrades();
end;

procedure TMainForm.Save1Click(Sender: TObject);
begin
  if saver.FileName<>'' then
    _SaveProject(saver.FileName)
  else
    SaveAs.Click;

  UpdateCaption();
end;

procedure TMainForm.Exit1Click(Sender: TObject);
begin
  self.Close;
end;

procedure TMainForm.New1Click(Sender: TObject);
begin
  if ((length(_upgrades)>0) or (length(_groups)>0)) and (ID_YES<>MessageBox(self.Handle, 'Are you sure you want to reset scene?','', MB_YESNO+MB_ICONQUESTION)) then exit;

  _ResetScene();


  UpdateUpgrades;
  DrawGroupsList;
end;

procedure TMainForm._ResetScene;
var
  i:integer;
begin

  saver.FileName:='';
  UpdateCaption();
  SetCurrentDir(_startdir);

  for i:=0 to length(_groups)-1 do begin
    _groups[i].Free();
  end;
  SetLength(_groups, 0);

  for i:=0 to length(_upgrades)-1 do begin
    _upgrades[i].Free();
  end;
  SetLength(_upgrades, 0);

  align_list.Clear;
  align_list.Items.Add('0');
  align_list.Items.Add('100');
  align_list.Items.Add('200');
  align_list.Items.Add('[...]');

  _selected_index:=-1;
  _lmouse_down:=false;

  _up_texture.Free();
  _wpn_texture.Free();
  _up_texture:=TPicture.Create();
  _wpn_texture:=TPicture.Create();
  _up_texture_name:='';
  _wpn_texture_name:='';     

  edit_wpn_name.Text:='xxx';
  edit_upgr_icon_x.Text :='0';
  edit_upgr_icon_y.Text :='0';
  edit_upgr_icon_width.Text :='0';
  edit_upgr_icon_height.Text :='0';
  _UpdateWeaponIcon(Rect(0,0,0,0));
end;

procedure TMainForm.SetWeaponTexture(fname: string);
begin
  SetCurrentDir(_startdir);
  try
    fname:=trim(fname);
    fname:=ShorterPath(fname);
    if _wpn_texture_name = fname then exit;
    _wpn_texture_name:=fname;
    if fname = '' then begin
      _wpn_texture.Bitmap.FreeImage;
      _wpn_texture.Bitmap.Height:=0;
      _wpn_texture.Bitmap.Width:=0;
    end else if rightstr(fname, 4)='.bmp' then begin
      _wpn_texture.LoadFromFile(fname);
    end else if rightstr(fname, 4)='.dds' then begin
      LoadDDS(fname, _wpn_texture.Bitmap);
    end else begin
      raise Exception.Create('Unknown file format: '+fname);
    end;
  except
    on E:Exception do begin
      _wpn_texture_name:='';
      _wpn_texture.Bitmap.FreeImage;
      _wpn_texture.Bitmap.Height:=0;
      _wpn_texture.Bitmap.Width:=0;      
      Application.MessageBox(PChar(e.Message+fname), 'Error loading preview texture', MB_OK+MB_ICONWARNING+MB_SYSTEMMODAL);
    end;
  end;
  _UpdateWeaponIcon(_wpn_texture_rect);
end;

procedure TMainForm.SetUpgradeTexture(fname: string);
var
  i:integer;
begin
    SetCurrentDir(_startdir);
    try
      fname:=trim(fname);
      fname:=ShorterPath(fname);
      if _up_texture_name = fname then exit;
      _up_texture_name:=fname;
      if fname = '' then begin
        _up_texture.Bitmap.FreeImage;
        _up_texture.Bitmap.Height:=0;
        _up_texture.Bitmap.Width:=0;
      end else if rightstr(fname, 4)='.bmp' then begin
        _up_texture.LoadFromFile(fname);
      end else if rightstr(fname, 4)='.dds' then begin
        LoadDDS(fname, _up_texture.Bitmap);
      end else begin
        raise Exception.Create('Unknown file format: '+fname);
      end;
      _upgrade_editor.SetBaseTexture(_up_texture);
    except
       on E:Exception do begin
          _up_texture_name:='';
          _up_texture.Bitmap.FreeImage;
          _up_texture.Bitmap.Height:=0;
          _up_texture.Bitmap.Width:=0;
          Application.MessageBox(PChar(e.Message+fname), 'Error loading upgrades texture', MB_OK+MB_ICONWARNING+MB_SYSTEMMODAL);
       end;
    end;
    for i:=0 to length(_upgrades)-1 do begin
      _upgrades[i].visual.Init(_up_texture, _upgrades[i].visual.GetRect());
    end;
    UpdateUpgrades;
end;

function TMainForm.FindGroupByName(n: string):TUpgradeGroup;
var
  i:integer;
begin
  for i:=0 to length(_groups)-1 do begin
    if _groups[i].GetName()=n then begin
      result:=_groups[i];
      exit;
    end;
  end;
  result:=nil;
end;

function TMainForm.FindUpgradeByName(n: string):TUpgrade;
var
  i:integer;
begin
  for i:=0 to length(_upgrades)-1 do begin
    if _upgrades[i].name=n then begin
      result:=_upgrades[i];
      exit;
    end;
  end;
  result:=nil;
end;

procedure TMainForm.About1Click(Sender: TObject);
begin
  _about_form.Show();
end;

procedure TMainForm.SetNewWeaponPreviewParams(r: TRect);
begin
  edit_upgr_icon_x.Text:=inttostr(r.Left);
  edit_upgr_icon_y.Text:=inttostr(r.Top);

  edit_upgr_icon_width.Text:=inttostr(r.Right-r.Left);
  edit_upgr_icon_height.Text:=inttostr(r.Bottom-r.Top);

  _UpdateWeaponIcon(r);

end;

procedure TMainForm.btn_pick_previewClick(Sender: TObject);
begin
  if _wpn_texture_name='' then begin
    if texture_opener.Execute() then begin
      SetWeaponTexture(texture_opener.FileName);
    end else begin
      exit;
    end;
  end;
  _preview_selector.Init(_wpn_texture, nil, _wpn_texture_rect);
  _preview_selector.Show();
end;

function TMainForm.IsRoot(g: TUpgradeGroup): boolean;
var i, j:integer;
begin
  for i:=0 to length(_groups)-1 do begin
    for j:=0 to _groups[i].EffectsCnt() do begin
      if g=_groups[i].GetEffect(j) then begin
        result:=false;
        exit;
      end;
    end;
  end;
  result:=true;
end;

function TMainForm.IsInCycle(g: TUpgradeGroup; scan_root: TUpgradeGroup = nil): boolean;
var
  i:integer;
begin
  if (scan_root=nil) then begin
    scan_root:=g;
  end else if g=scan_root then begin
      result:=true;
      exit;
  end;
  for i:=0 to scan_root.EffectsCnt()-1 do begin
    if IsInCycle(g, scan_root.GetEffect(i)) then begin
      result:=true;
      exit;
    end;
  end;
  result:=false;
end;

procedure TMainForm.Assotiatemewithupr1Click(Sender: TObject);
var
  reg:TRegistry;
begin
 if ID_YES<>MessageBox(self.Handle, 'All previous data about assotiations with .upr files will be lost. Continue?', '', MB_YESNO+MB_ICONWARNING) then exit;

  reg:=TRegistry.Create();
  try
    try
      reg.RootKey:=HKEY_CLASSES_ROOT;
      reg.OpenKey('.upr', true);
      reg.WriteString('', reg_key);
      reg.CloseKey;

      reg.OpenKey(reg_key, true);
      reg.WriteString('', 'Guslinger'+chr(39)+'s Upgrades Project');
      reg.CloseKey;

      reg.OpenKey(reg_key+'\DefaultIcon', true);
      reg.WriteString('', '"'+Application.ExeName+'",0');
      reg.CloseKey;

      reg.OpenKey(reg_key+'\shell\open\command', true);
      reg.WriteString('', '"'+Application.ExeName+'" "%1"');
      reg.CloseKey;

      reg.RootKey:=HKEY_CURRENT_USER;
      reg.DeleteKey('Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.upr');

      MessageBox(self.Handle, '.upr files successfully assotiated.', '', MB_OK+MB_ICONINFORMATION)
    except
      on E:Exception do begin
        MessageBox(self.Handle, 'Operation failed. Try to run the program as Administrator.', '', MB_OK+MB_ICONERROR)
      end;
    end;
  finally
    reg.Free;
  end;
  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);  
end;

procedure TMainForm.Removeassotiation1Click(Sender: TObject);
var
  reg:TRegistry;
begin
if ID_YES<>MessageBox(self.Handle, 'All data about assotiations with .upr files will be lost. Continue?', '', MB_YESNO+MB_ICONWARNING) then exit;
  reg:=TRegistry.Create();
  try
    try
      reg.RootKey:=HKEY_CURRENT_USER;
      reg.DeleteKey('Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.upr');

      reg.RootKey:=HKEY_CLASSES_ROOT;
      reg.DeleteKey('.upr');
      reg.DeleteKey(reg_key);
      MessageBox(self.Handle, '.upr files successfully unassotiated.', '', MB_OK+MB_ICONINFORMATION)
    except
      on E:Exception do begin
        MessageBox(self.Handle, 'Operation failed. Try to run the program as Administrator.', '', MB_OK+MB_ICONERROR)
      end;
    end;
  finally
    reg.Free;
  end;
  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;


procedure TMainForm.UpdateCaption;
begin
  if saver.FileName<>'' then
    self.Caption:=saver.FileName
  else
    self.Caption:=appname;
end;

procedure TMainForm.Editupgrade1Click(Sender: TObject);
begin
  if _up_texture_name='' then begin
    if texture_opener.Execute() then begin
      SetUpgradeTexture(texture_opener.FileName);
    end else begin
      exit;
    end;
  end;
  
  if _selected_index>=0 then begin
    _upgrade_editor.SetUpgrade(_upgrades[_selected_index]);
    _upgrade_editor.Show();
  end;
end;

function TMainForm.ShorterPath(fname: string): string;
begin
  if leftstr(fname, length(_startdir))=_startdir then begin
    result:=rightstr(fname, length(fname)-length(_startdir)-1);
  end else begin
    result:=fname;
  end;
end;


procedure TMainForm.rec11Click(Sender: TObject);
begin
  OpenFileWithPrompt(rec11.Hint);
end;

procedure TMainForm.rec21Click(Sender: TObject);
begin
  OpenFileWithPrompt(rec21.Hint);
end;

procedure TMainForm.rec31Click(Sender: TObject);
begin
  OpenFileWithPrompt(rec31.Hint);
end;

procedure TMainForm.rec41Click(Sender: TObject);
begin
  OpenFileWithPrompt(rec41.Hint);
end;



procedure TMainForm._ActualizeRecentFiles(fname: string);
var
  reg:TRegistry;
  i, j:integer;
  tmp1, tmp2:string;
begin
  //если fname='' - значит, перерисовываем список, иначе - открываем новый файл
  _ClearRecentItem(rec11);
  _ClearRecentItem(rec21);
  _ClearRecentItem(rec31);
  _ClearRecentItem(rec41);
  OpenRecent1.Enabled:=false;

  reg:=TRegistry.Create();
  try
    reg.RootKey:=HKEY_CURRENT_USER;
    reg.OpenKey('Software\Sin!\'+reg_key, true);

    if fname <> '' then begin
      tmp1:=reg.ReadString('Recent1');
      if tmp1 <> fname then begin;
        tmp1:=fname;
        for i:=1 to 4 do begin
          tmp2:=reg.ReadString('Recent'+inttostr(i));
          reg.WriteString('Recent'+inttostr(i), tmp1);
          tmp1:=tmp2;
        end;
      end;
    end;

      //просто загружаем данные из реестра и отображаем их
    _AddRecentItem(reg.ReadString('Recent1'));
    _AddRecentItem(reg.ReadString('Recent2'));
    _AddRecentItem(reg.ReadString('Recent3'));
    _AddRecentItem(reg.ReadString('Recent4'));

    reg.CloseKey;
  finally
    reg.Free;
  end;
end;

procedure TMainForm.Clearprogramsregistrysettings1Click(Sender: TObject);
var
  reg:TRegistry;
begin
  reg:=TRegistry.Create();
  try
    reg.RootKey:=HKEY_CURRENT_USER;
    reg.DeleteKey('Software\Sin!\'+reg_key);
  finally
    reg.Free;
  end;
end;

procedure TMainForm._AddRecentItem(str: string);
begin
  if str='' then exit;
  OpenRecent1.Enabled:=true;

  if not rec11.Visible then begin
    _SetRecentItem(rec11, str);
  end else if not rec21.Visible then begin
    _SetRecentItem(rec21, str);
  end else if not rec31.Visible then begin
    _SetRecentItem(rec31, str);
  end else if not rec41.Visible then begin
    _SetRecentItem(rec41, str);  
  end;
end;

procedure TMainForm._ClearRecentItem(itm: TMenuItem);
begin
  itm.Enabled:=false;
  itm.Visible:=false;
  itm.Caption:='';
  itm.Hint:='';
end;


procedure TMainForm._SetRecentItem(itm: TMenuItem; str: string);
begin
  itm.Enabled:=true;
  itm.Visible:=true;
  itm.Caption:=str;
  itm.Hint:=str;  
end;

procedure TMainForm.OpenFileWithPrompt(fname: string);
begin
  if ((length(_upgrades)>0) or (length(_groups)>0)) and (ID_YES<>MessageBox(self.Handle, 'Do you really want to load scene from file? All current data will be lost.', '', MB_YESNO+MB_ICONQUESTION)) then begin
    exit;
  end;
  _LoadProject(fname);
end;

procedure TMainForm.Help2Click(Sender: TObject);
begin
  _help_form.Show();
end;

procedure TMainForm.Calculatetreasures1Click(Sender: TObject);
var
  tmpstr:string;
  keyvalue:TMinMaxInfluenceContainer;
  res:TStringList;
begin
  tmpstr:=_Validate();
  if tmpstr<>'' then begin
    MessageBox(self.Handle, PChar(tmpstr), 'Validation failed!', MB_OK+MB_ICONERROR);
    exit;
  end;


  keyvalue:=TMinMaxInfluenceContainer.Create();
  try
    if _CalculateTreasures(keyvalue) then begin
      res:=keyvalue.ReportInfo();
      if MessageBox(self.Handle, res.GetText(), 'Press OK to copy to clipboard', MB_OKCANCEL) = ID_OK then begin
        Clipboard.AsText:=res.GetText();
      end;
    end else begin
      MessageBox(self.Handle, 'Can''t calculate, please double-check all your upgrades', 'Error', MB_OK or MB_ICONERROR);
    end;
  finally
    keyvalue.Free();
    res.Free();
  end;    
end;


function TMainForm._AdjustTreasureForUpgradesGroup(group: TUpgradeGroup; keyvalue: TMinMaxInfluenceContainer): boolean;
var
  i,j:integer;
  group_treasures, upgrade_values:TStringList;
  up:TUpgrade;
  tmpstr, key, value:string;
  value_f:single;
  p:integer;
  format_settings:TFormatSettings;
begin
  result:=true;
  group_treasures:=TStringList.Create();
  upgrade_values:=TStringList.Create();
  format_settings.DecimalSeparator:='.';
  format_settings.ThousandSeparator:= ' ';
  try
    for i:=0 to group.ElementsCnt()-1 do begin
      up:=group.GetElement(i);
      if length(up.inherited_section) > 0 then begin
        //TODO: draw memo for manual input?
        MessageBox(self.Handle, PChar('Upgrade "'+up.name+'" inherits section(s) "'+up.inherited_section+'". Please apply values from the specified section(s) manually.'), 'Information', MB_OK or MB_ICONINFORMATION);
      end;

      //Parse all influences' strings to temp stringlist
      upgrade_values.Clear();
      for j:=0 to up.section_params.Count-1 do begin
        tmpstr:=Trim(up.section_params[j]);

        //Remove comments
        p:=pos(';', tmpstr);
        if p>0 then begin
          tmpstr:=midstr(tmpstr, 1, p-1)
        end;

        //check for key-value separator
        p:=pos('=', tmpstr);
        if p=0 then continue;
        key:=lowercase(trim(midstr(tmpstr, 1, p-1)));
        value:=trim(midstr(tmpstr, p+1, length(tmpstr)));

        //Collect to temp parameters list
        upgrade_values.Values[key]:=value;
      end;

      //Apply parsed values from stringlist to container
      for j:=0 to upgrade_values.Count-1 do begin
        tmpstr:=upgrade_values.Names[j];
        value_f:=strtofloatdef(upgrade_values.Values[tmpstr], 0, format_settings);
        if value_f <> 0 then begin
          keyvalue.RegisterInfluenceVariantInTmpBuf(tmpstr, value_f);
        end;
      end;
    end;

    keyvalue.AccumulateTmpBuf();    
  finally
    upgrade_values.Free();  
    group_treasures.Free();
  end;
end;

function TMainForm._RecurseTreasureCalc(root_group:TUpgradeGroup; keyvalue: TMinMaxInfluenceContainer):boolean;
var
  i:integer;

begin
  result:=_AdjustTreasureForUpgradesGroup(root_group, keyvalue);

  for i:=0 to root_group.EffectsCnt()-1 do begin
    if result then result := _RecurseTreasureCalc(root_group.GetEffect(i), keyvalue);
  end;
end;

function TMainForm._CalculateTreasures(keyvalue: TMinMaxInfluenceContainer): boolean;
var
  i, j, k:integer;
  is_root:boolean;
begin
  result:=true;

  //Iterate over all groups, find root groups (without parents) and calc
  for i:=0 to length(_groups)-1 do begin
    is_root:=true;
    for j:=0 to length(_groups)-1 do begin
      for k:=0 to _groups[j].EffectsCnt()-1 do begin
        if _groups[i] = _groups[j].GetEffect(k) then begin
          is_root:=false;
          break;
        end;
      end;

      if not is_root then break;
    end;

    if is_root then begin
      result:=_RecurseTreasureCalc(_groups[i], keyvalue);
    end;      
  end;
end;

end.
