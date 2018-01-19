unit UfrEditUsers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataUnit, Data.DB, DBAccess, MyAccess,
  MemDS, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL,
  GridsEh, DBAxisGridsEh, DBGridEh, Vcl.ExtCtrls, Vcl.DBCtrls;

type
  TfrEditUser = class(TForm)
    q: TMyQuery;
    usersDs: TMyDataSource;
    DBGridEh1: TDBGridEh;
    roleQ: TMyQuery;
    qid: TIntegerField;
    qid_role: TIntegerField;
    qlogin: TStringField;
    qpass: TStringField;
    quser_name: TStringField;
    qrole: TStringField;
    DBNavigator1: TDBNavigator;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frEditUser: TfrEditUser;

implementation

{$R *.dfm}

procedure TfrEditUser.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
if(q.RecordCount=1)and(button=nbDelete) then begin
  MessageDlg('Должен быть как минимум 1 пользователь с правами администратора',
      mtwarning, [mbok], 0);
  exit;
end;
end;

procedure TfrEditUser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
q.Close;
roleQ.Close;
Action:=caFree;
end;

procedure TfrEditUser.FormShow(Sender: TObject);
begin
q.Open;
end;

end.
