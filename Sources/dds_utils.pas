unit dds_utils;

//Written by Sin! for Gunslinger's Upgrades Editor
//Description:
//LoadDDS - Loads DDS image to TBitmap ignoring alpha-channel


interface
uses Classes, Graphics;
type dds_pixelformat = packed record
  dwSize:cardinal;
  dwFlags:cardinal;
  dwFourCC:cardinal;
  dwRGBBitCount:cardinal;
  dwRBitmask:cardinal;
  dwGBitmask:cardinal;
  dwBBitmask:cardinal;
  dwABitmask:cardinal;
end;

type dds_header = packed record
  dwSize:cardinal;
  dwFlags:cardinal;
  dwHeight:cardinal;
  dwWidth:cardinal;
  dwPitchOrLinearSize:cardinal;
  dwDepth:cardinal;
  dwMipMapCount:cardinal;
  dwReserved1:array[0..10] of Cardinal;
  ddspf:dds_pixelformat;
  dwCaps:cardinal;
  dwCaps2:cardinal;
  dwCaps3:cardinal;
  dwCaps4:cardinal;
  dwReserved2:cardinal;
  
end;

procedure LoadDDS(fname:string; bmp:TBitmap);
implementation
uses math, SysUtils;

const
  MAGIC:cardinal = $20534444;

  DDPF_RGB:cardinal = $40;
  DDPF_FOURCC:cardinal = $4;

  DDPF_FOURCC_DXT5:cardinal =$35545844;
  DDPF_FOURCC_DXT3:cardinal =$33545844;
  DDPF_FOURCC_DXT1:cardinal =$31545844;

function _GetPixelChannelIntensity(pixel:cardinal; mask:cardinal):single;
var
  i:integer;
  w, sum, max:cardinal;
begin
  sum:=0; //сюда накапливаем уровень
  max:=0; //максимальный уровень пикселя
  w:=1;   //значение следующего разряда

  for i:=0 to (sizeof(pixel)*8-1) do begin
    if (mask and (1 shl i))>0 then begin
      if (pixel and (1 shl i))>0 then sum:=sum + w;
      max:=max+w;
      w:=w*2;
    end;
  end;
  if max=0 then
    result:=0
  else
    result:=sum/max;
end;

procedure _LoadUnCompressedDDS(str:TStream; bmp:TBitmap; const hdr:dds_header);
var
  pixel_size, y, x, pixel:cardinal;
  c:TColor;
  pix_arr:array [0..3] of byte;
begin
  bmp.FreeImage;
  bmp.Width:=hdr.dwWidth;
  bmp.Height:=hdr.dwHeight;
  pixel_size:=hdr.ddspf.dwRGBBitCount shr 3;

  if (hdr.ddspf.dwRBitmask=$00FF0000) and (hdr.ddspf.dwGBitmask=$0000FF00) and (hdr.ddspf.dwBBitmask=$000000FF) then begin
    //8888ARGB
    for y:=0 to hdr.dwHeight-1 do begin
      for x:=0 to hdr.dwWidth-1 do begin
        str.ReadBuffer(pix_arr[0], pixel_size);
        c:=(pix_arr[0] shl 16)+(pix_arr[1] shl 8)+pix_arr[2];
        bmp.Canvas.Pixels[x, y]:=c;
      end;
    end;
  end else begin
    for y:=0 to hdr.dwHeight-1 do begin
      for x:=0 to hdr.dwWidth-1 do begin
        str.ReadBuffer(pixel, pixel_size);
        c:= ceil(_GetPixelChannelIntensity(pixel, hdr.ddspf.dwRBitmask)*255) +
            (ceil(_GetPixelChannelIntensity(pixel, hdr.ddspf.dwGBitmask)*255) shl 8) +
            (ceil(_GetPixelChannelIntensity(pixel, hdr.ddspf.dwBBitmask)*255) shl 16);
            //(ceil(_GetPixelChannelIntensity(pixel, hdr.ddspf.dwABitmask)*255) shl 24);
        bmp.Canvas.Pixels[x, y]:=c;
      end;
    end;
  end;

end;

function _DecodeRGB565(c:word):TColor;
begin
  result:= floor(_GetPixelChannelIntensity(c, $F800)*255)+
          (floor(_GetPixelChannelIntensity(c, $07E0)*255) shl 8)+
          (floor(_GetPixelChannelIntensity(c, $001F)*255) shl 16);
end;

function _GetPixelIndex(indices:cardinal; pixel_number:cardinal):cardinal;
begin
  result:= (indices shr (pixel_number*2)) and 3;
end;

function _MulColor(c:TColor; f:single):TColor;
begin
  result:=(floor(((c and $FF) shr 0)*f) shl 0) + (floor(((c and $FF00) shr 8)*f) shl 8) + (floor(((c and $FF0000) shr 16)*f) shl 16);
end;

function _AddColor(c1, c2:TColor):TColor;
var
  r,g,b:cardinal;
begin
  r:= (c1 and $FF) + (c2 and $FF);
  g:= ((c1 shr 8) and $FF) + ((c2 shr 8) and $FF);
  b:= ((c1 shr 16) and $FF) + ((c2 shr 16) and $FF);

  if r>$FF then r:=$FF;
  if g>$FF then g:=$FF;
  if b>$FF then b:=$FF;

  result:= (b shl 16) + (g shl 8) + r;
end;

procedure _LoadCompressedDDS(str:TStream; bmp:TBitmap; const hdr:dds_header);
var
  y, x, i_x, i_y, indices, current, index:cardinal;
  c1, c2:word;
  palette: array[0..3] of TColor;

begin
  if (hdr.ddspf.dwFourCC=DDPF_FOURCC_DXT5) or (hdr.ddspf.dwFourCC=DDPF_FOURCC_DXT3) then begin
    bmp.FreeImage;
    bmp.Width:=hdr.dwWidth;
    bmp.Height:=hdr.dwHeight;

    for y:=0 to floor(hdr.dwHeight/4)-1 do begin
      for x:=0 to floor(hdr.dwWidth/4)-1 do begin
        //игнорируем альфаканал
        str.ReadBuffer(indices, sizeof(indices));
        str.ReadBuffer(indices, sizeof(indices));

        //посмотрим используемую палитру
        str.ReadBuffer(c1, sizeof(c1));
        str.ReadBuffer(c2, sizeof(c2));

        palette[0]:=_DecodeRGB565(c1);
        palette[1]:=_DecodeRGB565(c2);
        palette[2]:= _AddColor(_MulColor(palette[0], 2/3),_MulColor(palette[1], 1/3));
        palette[3]:= _AddColor(_MulColor(palette[0], 1/3),_MulColor(palette[1], 2/3));

        //теперь читаем 4*4 двухбитных индекса цвета пикселя в палитре
        str.ReadBuffer(indices, sizeof(indices));
        //и заполняем карту
        current:=0;
        for i_y:=0 to 3 do begin
          for i_x:=0 to 3 do begin
            index:=_GetPixelIndex(indices, current);
            bmp.Canvas.Pixels[x*4+i_x, y*4+i_y]:=palette[index];
            current:=current+1;
          end;
        end;
      end;
    end;
  end else if (hdr.ddspf.dwFourCC=DDPF_FOURCC_DXT1) then begin
    bmp.FreeImage;
    bmp.Width:=hdr.dwWidth;
    bmp.Height:=hdr.dwHeight;
    for y:=0 to floor(hdr.dwHeight/4)-1 do begin
      for x:=0 to floor(hdr.dwWidth/4)-1 do begin
        str.ReadBuffer(c1, sizeof(c1));
        str.ReadBuffer(c2, sizeof(c2));
        palette[0]:=_DecodeRGB565(c1);
        palette[1]:=_DecodeRGB565(c2);
        if (c1>c2) then begin
          palette[2]:= _AddColor(_MulColor(palette[0], 2/3),_MulColor(palette[1], 1/3));
          palette[3]:= _AddColor(_MulColor(palette[0], 1/3),_MulColor(palette[1], 2/3));
        end else begin
          palette[2]:= _AddColor(_MulColor(palette[0], 1/2),_MulColor(palette[1], 1/2));
          palette[3]:= $5555FF;//transparent
        end;

        //теперь читаем 4*4 двухбитных индекса цвета пикселя в палитре
        str.ReadBuffer(indices, sizeof(indices));
        //и заполняем карту
        current:=0;
        for i_y:=0 to 3 do begin
          for i_x:=0 to 3 do begin
            index:=_GetPixelIndex(indices, current);
            bmp.Canvas.Pixels[x*4+i_x, y*4+i_y]:=palette[index];
            current:=current+1;
          end;
        end;
      end;
    end;
  end else begin
    raise EStreamError.Create('Unsupported DDS Format!');
  end;
end;

procedure LoadDDS(fname:string; bmp:TBitmap);
var
  tmp:cardinal;
  hdr:dds_header;
  str:TFileStream;
begin
  str:=TFileStream.Create(fname, fmOpenRead);
  try
    str.ReadBuffer(tmp, sizeof(tmp));
    if MAGIC<>tmp then raise EStreamError.Create('Invalid Magic in DDS Header!');

    str.ReadBuffer(hdr, sizeof(hdr));
    if hdr.dwSize<>124 then raise EStreamError.Create('Invalid dds_header.dwSize!');
    if hdr.ddspf.dwSize<>32 then raise EStreamError.Create('Invalid dds_pixelformat.dwSize!');

    if (hdr.ddspf.dwFlags and DDPF_RGB)>0 then begin
      _LoadUnCompressedDDS(str, bmp, hdr);
    end else if (hdr.ddspf.dwFlags and DDPF_FOURCC)>0 then begin
      _LoadCompressedDDS(str, bmp, hdr);
    end else begin
      raise EStreamError.Create('Unsupported DDS Format!');
    end;
  finally
    str.Free();
  end;

end;

end.
