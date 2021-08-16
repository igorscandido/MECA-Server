program MECAServer;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Provider.Connection in 'Providers\Provider.Connection.pas' {ProviderConnection: TDataModule},
  Provider.Utils in 'Providers\Provider.Utils.pas',
  Service.Module in 'Services\Service.Module.pas' {ServiceModule: TDataModule},
  Service.Produto in 'Services\Service.Produto.pas' {ServiceProduto: TDataModule},
  System.JSON,
  Dataset.Serialize, // Help works with conversion from Dataset to Json
  Horse.Jhonson,
  Horse.HandleException; // Creates exceptions with status code

var
  DBConnection : TProviderConnection;

  procedure Init;
  begin

    DBConnection := TProviderConnection.Create(nil);

  end;

begin

  Init;

  THorse.Use(Jhonson); // Imports Jhonson module to use JSON in Response
  THorse.Use(HandleException); // Imports Exception Handler for Horse

  THorse.Get('/produtos',
  procedure(Req : THorseRequest; Res : THorseResponse; Next: TProc)
  var
    LService : TServiceProduto;
    LJson : TJSONArray;
  begin
    LService := TServiceProduto.Create(nil);
    try
      LJson := LService.List.ToJSONArray();
    finally
      LService.Free;
    end;
    Res.Send<TJSONArray>(LJson);
  end);

  THorse.Get('/produtos/:id',
  procedure(Req : THorseRequest; Res : THorseResponse; Next: TProc)
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
  end);

  THorse.Listen(9000);
end.
