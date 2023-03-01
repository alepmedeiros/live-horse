unit utils;

interface

uses
  System.Types,
  System.Classes,
  FMX.Objects;

type
  TUtils = class
  private
  public
    class procedure ResourceImage(Resource: String; Image: TImage);
  end;

implementation

{ TUtils }

class procedure TUtils.ResourceImage(Resource: String; Image: TImage);
var
  lResource: TResourceStream;
begin
  lResource:= TResourceStream.Create(HInstance, Resource, RT_RCDATA);
  try
    Image.Bitmap.LoadFromStream(lResource);
  finally
    lResource.Free;
  end;
end;

end.
