unit UfrIfnsBook;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, dataunit,
  Vcl.ExtCtrls, Vcl.DBCtrls;

type
  TfrIfnsBook = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frIfnsBook: TfrIfnsBook;

implementation

{$R *.dfm}

uses MainUnit;

procedure TfrIfnsBook.FormClose(Sender: TObject; var Action: TCloseAction);
begin
dm.qIfns.Close;
frMain.loadIfns;
Action:=caFree;
end;

procedure TfrIfnsBook.FormCreate(Sender: TObject);
begin
DBGrid1.Columns.Items[0].Width:=550;
end;

procedure TfrIfnsBook.FormShow(Sender: TObject);
begin
dm.qIfns.Open;
end;

end.
