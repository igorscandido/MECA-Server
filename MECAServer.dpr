program MECAServer;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Provider.Connection in 'Providers\Provider.Connection.pas' {ProviderConnection: TDataModule};

var
  DBConnection : TProviderConnection;

  function Init : boolean;
  begin

    DBConnection := TProviderConnection.Create(nil);

  end;

begin

  Init;

  THorse.Get('/ping',
  procedure(Req : THorseRequest; Res : THorseResponse; Next: TProc)
  begin
    Res.Send('Ol�!');
  end);

  THorse.Listen(9000);
end.
