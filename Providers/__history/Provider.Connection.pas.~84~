unit Provider.Connection;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Phys, FireDAC.Comp.Client, System.IOUtils, FireDAC.DApt,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL,FireDAC.Stan.Async;

type
  TProviderConnection = class(TDataModule)
    FDManager: TFDManager;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ProviderConnection: TProviderConnection;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TProviderConnection.DataModuleCreate(Sender: TObject);
var
  PathConnection, PathDrivers : String;
  LQuery : TFDQuery;
begin

  PathConnection := Format('%s%s%s%s%s',[ TPath.GetDirectoryName(ParamStr(0)),
                                        TPath.DirectorySeparatorChar,
                                        'Configs',
                                        TPath.DirectorySeparatorChar,
                                        'Connection.ini'] );

  PathDrivers := Format('%s%s%s%s%s',[ TPath.GetDirectoryName(ParamStr(0)),
                                        TPath.DirectorySeparatorChar,
                                        'Configs',
                                        TPath.DirectorySeparatorChar,
                                        'Drivers.ini'] );


  WriteLN('Carregando arquivos de configuração...');
  if not FileExists(PathConnection) then begin
    WriteLN(Format('Arquivo de configuração do BD não encontrado em: %s',
                    [PathConnection]));
    WriteLN('Não foi possível iniciar o servidor, aperte ENTER para sair.');

    Readln(PathConnection);
    System.Halt(0);
  end;

  if not FileExists(PathDrivers) then begin
    WriteLN(Format('Arquivo de configuração dos Drivers não encontrado em: %s',
                    [PathDrivers]));
    WriteLN('Não foi possível iniciar o servidor, aperte ENTER para sair.');

    Readln(PathDrivers);
    System.Halt(0);
  end;

  // Carrega as configurações para o Manager
  FDManager.ConnectionDefFileName := PathConnection;
  FDManager.DriverDefFileName     := PathDrivers;
  FDManager.LoadConnectionDefFile;
  WriteLN('Configuração do Banco de Dados carregadas com sucesso!');


  FDManager.Open;

  LQuery := TFDQuery.Create(nil);

  try
    LQuery.ConnectionName := 'MECA';
    try
      LQuery.Open('select now()');
      WriteLN(Format('Conexão testada às %s', [LQuery.Fields[0].AsString]));
    except
      on e : Exception do begin
        WriteLN('Conexão com o Banco de Dados não foi realizada com sucesso');
        WriteLN('Erro: ', e.Message);
        WriteLN('Encerrando servidor, pressione ENTER para prosseguir...');
        Readln(PathConnection);
        System.Halt(0);
      end;
    end;
  finally
    FreeAndNil(LQuery);
  end;


end;

end.
