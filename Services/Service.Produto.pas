unit Service.Produto;

interface

uses
  System.SysUtils, System.Classes, Service.Module, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TServiceProduto = class(TServiceModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function List: TDataset; // Retrieves all items from Produto Table
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServiceModule1 }

function TServiceProduto.List: TDataset;
begin
  Result:= Query;
  Query.Open;
end;

end.
