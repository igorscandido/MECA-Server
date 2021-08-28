unit Controller.Produto;

interface

uses
  Horse, Service.Produto, System.JSON, Dataset.Serialize,System.SysUtils;

type
  TControllerProduto = class

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

class procedure TControllerProduto.Delete(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  LService : TServiceProduto;
  LID : Cardinal;
begin
  LService := TServiceProduto.Create(nil);
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

class procedure TControllerProduto.GetById(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  LService : TServiceProduto;
  LJson : TJSONArray;
  IDProduto : Integer;
begin
  LService := TServiceProduto.Create(nil);
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

class procedure TControllerProduto.Insert(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  LService : TServiceProduto;
  LBody : TJSONObject;
begin
  LService := TServiceProduto.Create(nil);
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

class procedure TControllerProduto.List(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  LService : TServiceProduto;
  LJson : TJSONArray;
begin
  LService := TServiceProduto.Create(nil);
  try
    LJson := LService.List(Req.Query).ToJSONArray();
  finally
    LService.Free;
  end;
  Res.Send<TJSONArray>(LJson);
end;

class procedure TControllerProduto.Update(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  LService : TServiceProduto;
  LBody : TJSONObject;
  LID : Cardinal;
begin
  LService := TServiceProduto.Create(nil);
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

class procedure TControllerProduto.Registry;
begin
  THorse.Get('/produtos',TControllerProduto.List);
  THorse.Get('/produtos/:id',TControllerProduto.GetById);
  THorse.Post('/produtos', TControllerProduto.Insert);
  THorse.Put('/produtos/:id', TControllerProduto.Update);
  THorse.Delete('/produtos/:id', TControllerProduto.Delete);
end;

end.
