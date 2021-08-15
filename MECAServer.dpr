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
  Horse.Jhonson;

var
  DBConnection : TProviderConnection;

  procedure Init;
  begin

    DBConnection := TProviderConnection.Create(nil);

  end;

begin

  Init;

  THorse.Use(Jhonson); // Imports Jhonson module to use JSON in Response

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

  THorse.Listen(9000);
end.
