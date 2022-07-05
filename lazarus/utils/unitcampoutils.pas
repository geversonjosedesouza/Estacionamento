unit unitCampoUtils;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TCampoUtils }

  TCampoUtils = class
  private

  public
    function SomenteNumeros(Key: char; Texto: string; EhDecimal: boolean = False): char;

  end;

implementation

{ TCampoUtils }

function TCampoUtils.SomenteNumeros(Key: char; Texto: string; EhDecimal: boolean
  ): char;
begin
  if not EhDecimal then
  begin
    { Chr(8) = Back Space }
    if not (Key in ['0'..'9', Chr(8)]) then
      Key := #0;
  end
  else
  begin
    if Key = #46 then
      Key := DecimalSeparator;
    if not (Key in ['0'..'9', Chr(8), DecimalSeparator]) then
      Key := #0
    else
    if (Key = DecimalSeparator) and (Pos(Key, Texto) > 0) then
      Key := #0;
  end;
  Result := Key;
end;

end.

