unit DW.UserDefaults.Mac;

{*******************************************************}
{                                                       }
{                      Kastri                           }
{                                                       }
{         Delphi Worlds Cross-Platform Library          }
{                                                       }
{    Copyright 2020 Dave Nottage under MIT license      }
{  which is located in the root folder of this library  }
{                                                       }
{*******************************************************}

{$I DW.GlobalDefines.inc}

interface

uses
  // MacOS
  Macapi.Foundation;

type
  TUserDefaults = record
  public
    class function GetValue(const AKey: string; const ADefault: string = ''): string; overload; static;
    class function GetValue(const AKey: NSString): NSString; overload; static;
    class procedure SetValue(const AKey, AValue: string); overload; static;
    class procedure SetValue(const AKey: NSString; const AValue: NSObject); overload; static;
    class procedure SetValue(const AKey: string; const AValue: NSObject); overload; static;
  end;

implementation

uses
  // macOS
  Macapi.Helpers, Macapi.ObjectiveC,
  // DW
  DW.Macapi.Helpers;

{ TUserDefaults }

class function TUserDefaults.GetValue(const AKey: string; const ADefault: string = ''): string;
var
  LValue: NSString;
begin
  LValue := TMacHelperEx.StandardUserDefaults.stringForKey(StrToNSStr(AKey));
  if LValue <> nil then
    Result := NSStrToStr(LValue)
  else
    Result := ADefault;
end;

class procedure TUserDefaults.SetValue(const AKey, AValue: string);
begin
  TMacHelperEx.StandardUserDefaults.setObject(StringToID(AValue), StrToNSStr(AKey));
end;

class function TUserDefaults.GetValue(const AKey: NSString): NSString;
begin
  Result := TMacHelperEx.StandardUserDefaults.stringForKey(AKey);
end;

class procedure TUserDefaults.SetValue(const AKey: string; const AValue: NSObject);
begin
  TMacHelperEx.StandardUserDefaults.setObject(NSObjectToID(AValue), StrToNSStr(AKey));
end;

class procedure TUserDefaults.SetValue(const AKey: NSString; const AValue: NSObject);
begin
  TMacHelperEx.StandardUserDefaults.setObject(NSObjectToID(AValue), AKey);
end;

end.
