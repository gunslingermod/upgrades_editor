unit Upgrade;

interface
uses Graphics, Types, Sysutils, Classes;

type TTextureRect = class
private
  _picture:TPicture;
  _x:integer;
  _y:integer;
  _def:TPoint;
public
  constructor Create(def:TPoint);
  destructor Destroy; override;
  procedure Init(tex:TPicture; rect:TRect);
  function GetPic():TPicture;
  function GetTopLeft():TPoint;
  function GetBottomRight():TPoint;
  function GetRect():TRect;  
  function GetWidth():integer;
  function GetHeight():integer;
  procedure SetDefault();
  procedure SetupDefault(d:TPoint);
  function GetDefault():TPoint;
end;


type
TUpgradeGroup = class;

TUpgrade = class
private
  _my_group:TUpgradeGroup;
public
  visual:TTextureRect;
  point:TPoint;       //точка на экране апа
  coords:TPoint;      //координаты на экране апгрейда
  name:string;
  up_prop:string;
  cost:integer;
  value:string;

  inherited_section:string;

  precondition_functor:string;
  precondition_parameter:string;
  effect_functor:string;
  effect_parameter:string;
  prereq_functor:string;
  prereq_tooltip_functor:string;
  prereq_params:string;

  section_params:TStrings;

  inv_name:string;
  inv_descr:string;

  constructor Create(def_icon_size:TPoint);
  destructor Destroy; override;
  function IsPointMy(p:TPoint):boolean;
  function GetGroup():TUpgradeGroup;

  procedure Save(str:TStream);
  procedure Load(str:TStream; from_texture:TPicture; save_ver:integer);

end;

TUpgradeGroup = class
private
  _elements:array of TUpgrade;
  _effects:array of TUpgradeGroup;
  _name:string;

public
  constructor Create(name:string);
  destructor Destroy; override;
  procedure RegisterUpgrade(up:TUpgrade);
  procedure UnRegisterUpgrade(up:TUpgrade);
  procedure RegisterEffect(g:TUpgradeGroup);
  procedure UnRegisterEffect(g:TUpgradeGroup);
  procedure UnRegisterAllEffects();
  function IsEffectRegistered(g:TUpgradeGroup):boolean;
  function EffectsCnt():integer;
  function ElementsCnt():integer;  
  function GetEffect(index:integer):TUpgradeGroup;
  function GetElement(index:integer):TUpgrade;
  function GetName():string;
  procedure SetName(n:string);
  function GetEffectsString(wpn:string):string;
  function GetElementsString(prefix:string):string;

  function GetFullName(wpn:string):string;

  procedure Save(str:TStream);
  procedure Load(str:TStream);  
end;

TMinMaxInfluencePair = class
private
  _name:string;
  _max_increase:single;
  _max_decrease:single;
public
  constructor Create(name:string; delta:single); overload;
  constructor Create(p:TMinMaxInfluencePair); overload;

  destructor Destroy; override;

  procedure DoSum(p:TMinMaxInfluencePair);
  procedure DoUnion(p:TMinMaxInfluencePair);
  function GetUpperDelta():single;
  function GetLowDelta():single;
  function GetName():string;
end;

TMinMaxInfluenceContainer = class
private
  _parsed_groups:TStringList;
  _accumulator:array of TMinMaxInfluencePair;
  _tmp_influences:array of TMinMaxInfluencePair;

  procedure _ResetTmpInf();

public
  constructor Create;
  destructor Destroy; override;

  procedure RegisterInfluenceVariantInTmpBuf(name:string; value:single);
  procedure AccumulateTmpBuf(group_name:string);
  function ReportInfo():TStringList;
  procedure RegistedParsedGroup(name:string);
  function IsGroupAlreadyParsed(name:string):boolean;
end;

implementation
uses helper, Main;

{ TTextureRect }

constructor TTextureRect.Create(def:TPoint);
begin
//
  _picture:=TPicture.Create;
  _def:=def;
  if _def.X<10 then _def.X:=10;
  if _def.Y<10 then _def.Y:=10;
  SetDefault();
  _x:=0;
  _y:=0;
end;

destructor TTextureRect.Destroy;
begin
  _picture.Free;
end;

function TTextureRect.GetTopLeft: TPoint;
begin
  result.X:=_x;
  result.Y:=_y;
end;

function TTextureRect.GetPic: TPicture;
begin
  result:=_picture;
end;

function TTextureRect.GetBottomRight: TPoint;
begin
  result.X:=_x+_picture.Width;
  result.Y:=_y+_picture.Height;
end;

procedure TTextureRect.Init(tex: TPicture; rect: TRect);
var
  rect_dst:TRect;
begin
  _x:=rect.Left;
  _y:=rect.Top;

  _picture.Bitmap.Width:=rect.Right-rect.Left;
  _picture.Bitmap.Height:=rect.Bottom-rect.Top;

  if (_picture.Bitmap.Width<1) or (_picture.Bitmap.Height<1) then begin
    _picture.Bitmap.Width:=_def.X;
    _picture.Bitmap.Height:=_def.Y;
    rect.Right:=rect.Left+_def.X;
    rect.Bottom:=rect.Top+_def.Y;
  end;

  rect_dst.Left:=0;
  rect_dst.Top:=0;
  rect_dst.Right:=_picture.Bitmap.Width;
  rect_dst.Bottom:=_picture.Bitmap.Height;

  _picture.Bitmap.Canvas.CopyRect(rect_dst, tex.Bitmap.Canvas, rect);
end;

function TTextureRect.GetHeight: integer;
begin
  result:=_picture.Height;
end;

function TTextureRect.GetWidth: integer;
begin
  result:=_picture.Width;
end;

procedure TTextureRect.SetDefault();
begin
  _picture.Bitmap.Canvas.Brush.Color:=clWhite;
  _picture.Bitmap.Canvas.Brush.Style:=bsSolid;
  _picture.Bitmap.Canvas.Pen.Color:=clWhite;
  _picture.Bitmap.Canvas.Pen.Style:=psSolid;
  _picture.Bitmap.Height:=_def.Y;
  _picture.Bitmap.Width:=_def.X;
end;



function TTextureRect.GetDefault: TPoint;
begin
  result:=_def;
end;

function TTextureRect.GetRect: TRect;
begin
  result.TopLeft:=GetTopLeft();
  result.BottomRight:=GetBottomRight();
end;

procedure TTextureRect.SetupDefault(d: TPoint);
begin
  _def:=d;
end;

{ TUpgrade }

constructor TUpgrade.Create(def_icon_size:TPoint);
begin
  visual:=TTextureRect.Create(def_icon_size);
  coords.x:=0;
  coords.y:=0;
  name:='';
  _my_group:=nil;
  up_prop:='';
  inv_name:='';
  inv_descr:='';

  self.cost:=100;
  self.value:='0';
  self.precondition_functor:='inventory_upgrades.precondition_functor_a';
  self.precondition_parameter:='true';
  self.effect_functor:='inventory_upgrades.effect_functor_a';
  self.effect_parameter:='something_here';
  self.prereq_functor:='inventory_upgrades.prereq_functor_a';
  self.prereq_tooltip_functor:='inventory_upgrades.prereq_tooltip_functor_a';
  self.prereq_params:='';
  self.inherited_section:='';

  section_params:=TStringList.Create();
end;

destructor TUpgrade.Destroy;
begin
  if (_my_group<>nil) then begin
    _my_group.UnRegisterUpgrade(self);
  end;
  section_params.Free();
  visual.Free;
  inherited;
end;

function TUpgrade.GetGroup: TUpgradeGroup;
begin
  result:=_my_group;
end;

function TUpgrade.IsPointMy(p: TPoint): boolean;
begin
  result:= (p.X>=coords.X) and (p.X<=coords.X+visual.GetWidth()) and (p.Y>=coords.Y) and (p.Y<=coords.Y+visual.GetHeight());
end;

procedure TUpgrade.Load(str: TStream; from_texture:TPicture; save_ver:integer);
var
  tmp:TRect;
  def_p:TPoint;
begin
  name:=ReadString(str);
  up_prop:=ReadString(str);
  value:=ReadString(str);
  str.ReadBuffer(coords, sizeof(coords));
  str.ReadBuffer(point, sizeof(point));
  str.ReadBuffer(def_p, sizeof(def_p));
  visual.SetupDefault(def_p);
  cost:=ReadInt(str);
  inv_descr:=ReadString(str);
  inv_name:=ReadString(str);

  effect_functor:=ReadString(str);
  effect_parameter:=ReadString(str);
  precondition_functor:=ReadString(str);
  precondition_parameter:=ReadString(str);
  prereq_functor:=ReadString(str);
  prereq_params:=ReadString(str);
  prereq_tooltip_functor:=ReadString(str);
  section_params.DelimitedText:=ReadString(str);
  if (save_ver=sign_v100) then begin
    inherited_section:='';
  end else begin
    inherited_section:=ReadString(str);
  end;


  str.ReadBuffer(tmp, sizeof(tmp));
  visual.Init(from_texture, tmp);
end;

procedure TUpgrade.Save(str: TStream);
var
  tmp:TRect;
  def_p:TPoint;
begin
  SaveString(name, str);
  SaveString(up_prop, str);
  SaveString(value, str);
  str.WriteBuffer(coords, sizeof(coords));
  str.WriteBuffer(point, sizeof(point));
  def_p:=visual.GetDefault;
  str.WriteBuffer(def_p, sizeof(def_p));

  SaveInt(cost, str);
  SaveString(inv_descr, str);
  SaveString(inv_name, str);

  SaveString(effect_functor, str);
  SaveString(effect_parameter, str);
  SaveString(precondition_functor, str);
  SaveString(precondition_parameter, str);
  SaveString(prereq_functor, str);
  SaveString(prereq_params, str);
  SaveString(prereq_tooltip_functor, str);
  SaveString(section_params.DelimitedText, str);
  SaveString(inherited_section, str);

  tmp:=visual.GetRect;
  str.WriteBuffer(tmp, sizeof(tmp));
end;

{ TUpgradeGroup }

constructor TUpgradeGroup.Create(name:string);
begin
  SetLength(self._elements, 0);
  SetLength(self._effects, 0);
  _name:=name;
end;

destructor TUpgradeGroup.Destroy;
var
  i:integer;
begin
  for i:=0 to length(self._elements)-1 do begin
    self._elements[i]._my_group:=nil;
  end;
  SetLength(self._elements, 0);
  SetLength(self._effects, 0);
  inherited;
end;

function TUpgradeGroup.EffectsCnt: integer;
begin
  result:=length(_effects);
end;

function TUpgradeGroup.GetEffect(index: integer): TUpgradeGroup;
begin
  if (index<0) or (index>=length(_effects)) then begin
    result:=nil;
    exit;
  end;
  result:=_effects[index];
end;

function TUpgradeGroup.GetEffectsString(wpn:string): string;
var
  i:integer;
begin
  result:='';
  for i:=0 to length(_effects)-1 do begin
    if i>0 then result:=result+', ';
    result:=result+_effects[i].GetFullName(wpn);
  end;
end;


function TUpgradeGroup.GetElementsString(prefix: string): string;
var
  i:integer;
begin
  result:='';
  for i:=0 to length(_elements)-1 do begin
    if i>0 then result:=result+', ';
    result:=result+prefix+_elements[i].name;
  end;
end;

function TUpgradeGroup.GetFullName(wpn:string): string;
begin
  result:='vartree_'+wpn+'_'+_name;
end;

function TUpgradeGroup.GetName: string;
begin
  result:=_name;
end;

function TUpgradeGroup.IsEffectRegistered(g: TUpgradeGroup): boolean;
var i:integer;
begin
  for i:=0 to length(self._effects)-1 do begin
    if (g=_effects[i]) then begin
      result:=true;
      exit;
    end;
  end;
  result:=false;
end;

procedure TUpgradeGroup.Load(str: TStream);
begin
  _name:=ReadString(str);
end;

procedure TUpgradeGroup.RegisterEffect(g: TUpgradeGroup);
var
  i:integer;
begin
  for i:=0 to length(self._effects)-1 do begin
    if (g=_effects[i]) then begin
      exit;
    end;
  end;

  i:=length(self._effects);
  SetLength(_effects, i+1);
  _effects[i]:=g;
end;

procedure TUpgradeGroup.RegisterUpgrade(up: TUpgrade);
var
  i:integer;
begin
  for i:=0 to length(self._elements)-1 do begin
    if (up=_elements[i]) then begin
      exit;
    end;
  end;

  if (up._my_group<>nil) then begin
    up._my_group.UnRegisterUpgrade(up);
  end;

  i:=length(self._elements);
  SetLength(_elements, i+1);
  _elements[i]:=up;
  up._my_group:=self;
end;

procedure TUpgradeGroup.Save(str: TStream);
begin
  SaveString(_name, str);
end;

procedure TUpgradeGroup.SetName(n: string);
begin
  _name:=n
end;

procedure TUpgradeGroup.UnRegisterAllEffects;
begin
  SetLength(_effects, 0)
end;

procedure TUpgradeGroup.UnRegisterEffect(g: TUpgradeGroup);
var
  i:integer;
begin
  for i:=0 to length(self._effects)-1 do begin
    if (g=_effects[i]) then begin
      _effects[i]:=_effects[length(self._effects)-1];
      SetLength(_effects, length(self._effects)-1);
      exit;
    end;
  end;
end;

procedure TUpgradeGroup.UnRegisterUpgrade(up: TUpgrade);
var
  i:integer;
begin
  for i:=0 to length(self._elements)-1 do begin
    if (up=_elements[i]) then begin
      _elements[i]._my_group:=nil;
      _elements[i]:=_elements[length(self._elements)-1];
      SetLength(_elements, length(self._elements)-1);
      break;
    end;
  end;
end;
function TUpgradeGroup.ElementsCnt: integer;
begin
  result:=length(_elements);
end;

function TUpgradeGroup.GetElement(index: integer): TUpgrade;
begin
  if (index<0) or (index>=length(_elements)) then begin
    result:=nil;
    exit;
  end;
  result:=_elements[index];
end;

{ TMinMaxInfluencePair }

constructor TMinMaxInfluencePair.Create(name: string; delta: single);
begin
  _name:=name;
  if delta > 0 then begin
    _max_increase:=delta;
    _max_decrease:=0;
  end else begin
    _max_decrease:=delta;
    _max_increase:=0;
  end;
end;

constructor TMinMaxInfluencePair.Create(p: TMinMaxInfluencePair);
begin
  _name:=p._name;
  _max_increase:=p._max_increase;
  _max_decrease:=p._max_decrease;
end;

destructor TMinMaxInfluencePair.Destroy;
begin
  inherited;
end;

procedure TMinMaxInfluencePair.DoSum(p: TMinMaxInfluencePair);
begin
  assert(_name = p._name);
  _max_increase:=_max_increase+p._max_increase;
  _max_decrease:=_max_decrease+p._max_decrease;
end;

procedure TMinMaxInfluencePair.DoUnion(p: TMinMaxInfluencePair);
begin
  assert(_name = p._name);
  if _max_increase < p._max_increase then _max_increase:=p._max_increase;
  if _max_decrease > p._max_decrease then _max_decrease:=p._max_decrease;
end;

function TMinMaxInfluencePair.GetLowDelta: single;
begin
  result:=_max_decrease;
end;

function TMinMaxInfluencePair.GetName: string;
begin
  result:=_name;
end;

function TMinMaxInfluencePair.GetUpperDelta: single;
begin
  result:=_max_increase;
end;

{ TMinMaxInfluenceContainer }

constructor TMinMaxInfluenceContainer.Create;
begin
  setlength(_accumulator, 0);
  setlength(_tmp_influences, 0);
  _parsed_groups:=TStringList.Create();
end;

destructor TMinMaxInfluenceContainer.Destroy;
var
  i:integer;
begin
  _ResetTmpInf();
  FreeAndNil(_parsed_groups);
  for i:=0 to length(_accumulator)-1 do begin
    _accumulator[i].Free();
  end;
  setlength(_accumulator, 0);
  inherited;
end;

procedure TMinMaxInfluenceContainer.AccumulateTmpBuf(group_name:string);
var
  i,j:integer;
  already_accumulated:boolean;
begin
  for i:=0 to length(_tmp_influences)-1 do begin
    already_accumulated:=false;
    for j:=0 to length(_accumulator)-1 do begin
      if _tmp_influences[i].GetName() = _accumulator[j].GetName() then begin
        _accumulator[j].DoSum(_tmp_influences[i]);
        already_accumulated:=true;
        break;
      end;
    end;
    
    if not already_accumulated then begin
      j:=length(_accumulator);
      setlength(_accumulator, j+1);
      _accumulator[j]:=_tmp_influences[i];
      _tmp_influences[i]:=nil;
    end;
  end;

  _ResetTmpInf();

  if length(group_name) > 0 then begin
    RegistedParsedGroup(group_name);
  end;
end;

procedure TMinMaxInfluenceContainer.RegisterInfluenceVariantInTmpBuf(name: string; value: single);
var
  i:integer;
  pair:TMinMaxInfluencePair;
begin
  if value = 0 then exit;
  pair:=TMinMaxInfluencePair.Create(name, value);

  for i:=0 to length(_tmp_influences)-1 do begin
    if _tmp_influences[i].GetName() = name then begin
      _tmp_influences[i].DoUnion(pair);
      value:=0;
      break;
    end;
  end;

  if value <> 0 then begin
    i:=length(_tmp_influences);
    setlength(_tmp_influences, i+1);
    _tmp_influences[i]:=pair;
  end else begin
    pair.Free();
  end;
end;

procedure TMinMaxInfluenceContainer._ResetTmpInf;
var
  i:integer;
begin
  for i:=0 to length(_tmp_influences)-1 do begin
    _tmp_influences[i].Free();
  end;
  setlength(_tmp_influences, 0);
end;

function TMinMaxInfluenceContainer.ReportInfo: TStringList;
var
  i:integer;
  format_settings:TFormatSettings;
begin
  result:=TStringList.Create();
  format_settings.DecimalSeparator:='.';
  format_settings.ThousandSeparator:= ' ';  
  for i:=0 to length(_accumulator)-1 do begin
    result.Add(_accumulator[i]._name+' = ['+floattostrf(_accumulator[i]._max_decrease, ffFixed, 8, 4, format_settings)+', +'+floattostrf(_accumulator[i]._max_increase, ffFixed, 6, 4, format_settings)+']');
  end;
end;

function TMinMaxInfluenceContainer.IsGroupAlreadyParsed(name: string): boolean;
begin
  result:=(_parsed_groups.IndexOf(name) >= 0);
end;

procedure TMinMaxInfluenceContainer.RegistedParsedGroup(name: string);
begin
  if not IsGroupAlreadyParsed(name) then begin
    _parsed_groups.Append(name);
  end;
end;

end.

