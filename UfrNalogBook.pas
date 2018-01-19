unit UfrNalogBook;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, dataunit;

type
  TfrNalogBook = class(TForm)
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
  frNalogBook: TfrNalogBook;

implementation

{$R *.dfm}

uses mainunit;

procedure TfrNalogBook.FormClose(Sender: TObject; var Action: TCloseAction);
begin
dm.qNalog.Close;
frMain.loadNalog;
Action:=caFree;
end;

procedure TfrNalogBook.FormCreate(Sender: TObject);
begin
DBGrid1.Columns.Items[0].Width:=550;
end;

procedure TfrNalogBook.FormShow(Sender: TObject);
begin
dm.qNalog.Open;
end;

end.
