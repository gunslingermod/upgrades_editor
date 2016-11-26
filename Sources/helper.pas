unit helper;

interface
uses Classes;
    procedure SaveInt(i: integer; str: TStream);
    procedure SaveString(s:string; str:TStream);
    procedure SaveBool(b: boolean; str: TStream);

    function ReadString(str:TStream):string;
    function ReadInt(str:TStream):integer;
    function ReadBool(str:TStream):boolean;

implementation

procedure SaveString(s: string; str: TStream);
var
  tmp:cardinal;
  ptr:PChar;
begin
  tmp:=length(s);
  str.WriteBuffer(tmp, sizeof(tmp));
  ptr:=PChar(s);
  str.WriteBuffer(ptr^, tmp);
end;

procedure SaveBool(b: boolean; str: TStream);
var
  tmp:byte;
begin
  if b then tmp:=1 else tmp:=0;
  str.WriteBuffer(b, sizeof(b));
end;

procedure SaveInt(i: integer; str: TStream);
begin
  str.WriteBuffer(i, sizeof(i));
end;

function ReadString(str:TStream):string;
var
  l, i:cardinal;
  b:char;
begin
  result:='';
  str.ReadBuffer(l, sizeof(l));
  for i:=1 to l do begin
    str.ReadBuffer(b, 1);
    result:=result+b;
  end;
end;

function ReadInt(str:TStream):integer;
begin
  str.ReadBuffer(result, sizeof(result));
end;

function ReadBool(str:TStream):boolean;
var
  b:byte;
begin
  str.ReadBuffer(b, sizeof(b));
  result:=(b>0);
end;

end.
