unit UfrLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataUnit, UserModel,
  System.ImageList, Vcl.ImgList, acAlphaImageList, Vcl.Buttons, sSpeedButton,
  Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, MemDS, DBAccess, MyAccess, inifiles,
  EncryptUnit, UfrSett, MainUnit;



type
  TfrLogin = class(TForm)
    edLogin: TLabeledEdit;
    edPassword: TLabeledEdit;
    OK: TButton;
    sSpeedButton1: TsSpeedButton;
    sAlphaImageList1: TsAlphaImageList;
    chSave: TCheckBox;
    q: TMyQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



var
  frLogin: TfrLogin;
  ini:TIniFile;

const key:string='3082';

implementation

{$R *.dfm}


procedure TfrLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure TfrLogin.FormCreate(Sender: TObject);
var fn:string;
begin
fn:=getmys+settFolder+'\';
createdir(fn);
ini:=TIniFile.Create(fn+'sett.ini');
chSave.Checked:=ini.ReadBool('cred', 'save', true);
if(chSave.Checked) then
begin
  edLogin.Text:=ini.ReadString('cred', 'login', '');
  edPassword.Text:=xebi(ini.ReadString('cred', 'pass', ''), key);
end;

{q.sql.text:='CREATE TABLE IF NOT EXISTS user_roles('+
'id INT AUTO_INCREMENT NOT NULL,'+
'role VARCHAR(255) NOT NULL,'+
'name VARCHAR(255) NOT NULL,'+
'PRIMARY KEY (id)'+
');';
q.Execute;}
end;

procedure TfrLogin.OKClick(Sender: TObject);
var param:TParam;
    user:TUser;

procedure SetAsMainForm(aForm:TForm);
var
  P:Pointer;
begin
  P := @Application.Mainform;
  Pointer(P^) := aForm;
end;
begin
if(edLogin.Text='')or(edPassword.Text='') then exit;

ini.WriteBool('cred', 'save', chSave.Checked);

if(chSave.Checked) then
begin
  ini.WriteString('cred', 'login', edLogin.Text);
  ini.WriteString('cred','pass', xebi(edPassword.Text, key));
end;

q.ParamByName('login').AsString:=edLogin.text;
q.ParamByName('pass').AsString:=edPassword.Text;
q.Execute;
if(q.RecordCount=0) then
begin
  MessageDlg('Не верный лоигн или пароль', mtError, [mbok], 0);
  q.Close;
  exit;
end else
 begin
   user:=TUser.Create(q.FieldByName('id').AsInteger, q.FieldByName('login').AsString,
      q.FieldByName('pass').AsString, q.FieldByName('user_name').AsString,
      q.FieldByName('role').AsString);

   Application.CreateForm(TfrMain, frMain);
   frMain.CurrentUser:=user;
   frMain.Show;
   q.Close;
   SetAsMainForm(frMain);
   frLogin.hide;
 end;
end;

procedure TfrLogin.sSpeedButton1Click(Sender: TObject);
var frSett:TfrSett;
begin
frSett:=TfrSett.Create(application);
frSett.ShowModal;
end;

end.
