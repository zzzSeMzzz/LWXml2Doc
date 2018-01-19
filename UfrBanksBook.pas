unit UfrBanksBook;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataUnit, Data.DB, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrBanksBook = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frBanksBook: TfrBanksBook;

implementation

{$R *.dfm}

uses MainUnit;

procedure TfrBanksBook.FormClose(Sender: TObject; var Action: TCloseAction);
begin
frMain.loadBanks;
Action:=caFree;
end;

end.
