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
  Dataset.Serialize,
  Horse.Jhonson,
  Horse.HandleException,
  Controller.Produto in 'Controllers\Controller.Produto.pas';

// Creates exceptions with status code

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

  // Register the controller for Produtos
  TControllerProduto.Registry;

  THorse.Listen(9000);
end.
