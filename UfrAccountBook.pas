unit UfrAccountBook;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, DataUnit;

type
  TfrAccountBook = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frAccountBook: TfrAccountBook;

implementation

{$R *.dfm}
uses mainunit;
procedure TfrAccountBook.FormClose(Sender: TObject; var Action: TCloseAction);
begin
dm.qAccount.Close;
frMain.loadAccounts;
Action:=caFree;
end;

procedure TfrAccountBook.FormCreate(Sender: TObject);
begin
DBGrid1.Columns.Items[0].Width:=550;
end;

procedure TfrAccountBook.FormShow(Sender: TObject);
begin
dm.qAccount.Open;
end;

end.
