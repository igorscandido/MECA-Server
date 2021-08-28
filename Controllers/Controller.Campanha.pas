unit Controller.Campanha;

interface

uses
  Horse, Service.Campanha, System.JSON, Dataset.Serialize,System.SysUtils;

type
  TControllerCampanha = class

  public
    class procedure List(Req : THorseRequest; Res : THorseResponse; Next: TProc);
    class procedure GetById(Req : THorseRequest; Res : THorseResponse; Next: TProc);
    class procedure Update(Req : THorseRequest; Res : THorseResponse; Next: TProc);
    class procedure Insert(Req : THorseRequest; Res : THorseResponse; Next: TProc);
    class procedure Delete(Req : THorseRequest; Res : THorseResponse; Next: TProc);

    class procedure Registry;

  end;

implementation

{ TControllerProduto }

class procedure TControllerCampanha.Delete(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  LService : TServiceCampanha;
  LID : Cardinal;
begin
  LService := TServiceCampanha.Create(nil);
  try

    LID := Req.Params['id'].ToInt64;

    if LService.GetByID(LID).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound,'Registro não foi encontrado');

    if LService.Delete then
      Res.Status(THTTPStatus.NoContent)
    else
      raise EHorseException.Create(THTTPStatus.NotModified,'Não foi possível deletar!');

  finally
    LService.Free;
  end;
end;

class procedure TControllerCampanha.GetById(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  LService : TServiceCampanha;
  LJson : TJSONArray;
  IDProduto : Integer;
begin
  LService := TServiceCampanha.Create(nil);
  try
    IDProduto := Req.Params['id'].ToInt64;
    if LService.GetByID(IDProduto).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound,'O registro não foi encontrado!');

    LJson := LService.qUpdate.ToJSONArray();
  finally
    LService.Free;
  end;
  Res.Send<TJSONArray>(LJson);
end;

class procedure TControllerCampanha.Insert(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  LService : TServiceCampanha;
  LBody : TJSONObject;
begin
  LService := TServiceCampanha.Create(nil);
  try
    LBody := Req.Body<TJSONObject>;

    if LService.Insert(LBody) then
      Res.Send<TJSONObject>(LService.qUpdate.ToJSONObject).Status(THTTPStatus.Created)
    else
      raise EHorseException.Create(THTTPStatus.NotModified,'Não foi criado');

  finally
    LService.Free;
  end;
end;

class procedure TControllerCampanha.List(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  LService : TServiceCampanha;
  LJson : TJSONArray;
begin
  LService := TServiceCampanha.Create(nil);
  try
    LJson := LService.List(Req.Query).ToJSONArray();
  finally
    LService.Free;
  end;
  Res.Send<TJSONArray>(LJson);
end;

class procedure TControllerCampanha.Update(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  LService : TServiceCampanha;
  LBody : TJSONObject;
  LID : Cardinal;
begin
  LService := TServiceCampanha.Create(nil);
  try

    LID := Req.Params['id'].ToInt64;

    if LService.GetByID(LID).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound,'Registro não foi encontrado');

    LBody := Req.Body<TJSONObject>;

    if LService.Update(LBody) then
      Res.Status(THTTPStatus.NoContent)
    else
      raise EHorseException.Create(THTTPStatus.NotModified,'Não foi modificado');

  finally
    LService.Free;
  end;
end;

class procedure TControllerCampanha.Registry;
begin
  THorse.Get('/campanha',TControllerCampanha.List);
  THorse.Get('/campanha/:id',TControllerCampanha.GetById);
  THorse.Post('/campanha', TControllerCampanha.Insert);
  THorse.Put('/campanha/:id', TControllerCampanha.Update);
  THorse.Delete('/campanha/:id', TControllerCampanha.Delete);
end;

end.


