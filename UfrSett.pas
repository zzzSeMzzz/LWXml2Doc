unit UfrSett;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataUnit, Vcl.StdCtrls, sButton,
  sGroupBox, Vcl.ComCtrls, IniFiles;

const
   settFolder:string='LWXmlToDoc';
   dbName:string='lwxmltodoc';

type
  TfrSett = class(TForm)
    sButton1: TsButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    sGroupBox1: TsGroupBox;
    Label4: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    edHost: TEdit;
    edUser: TEdit;
    edDatabase: TEdit;
    edPassword: TEdit;
    edPort: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure sButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function IsAll:boolean;
  public
    { Public declarations }
  end;

var
  frSett: TfrSett;
  clb:boolean=false;
  ini:TIniFile;

implementation

{$R *.dfm}

Uses MainUnit;


function TfrSett.IsAll:boolean;
begin
 if(edhost.Text='')or(edUser.Text='')or(edPassword.Text='')or
   (edDatabase.Text='')or(edPort.Text='')
    then result:=false else result:=true;
end;

procedure TfrSett.sButton1Click(Sender: TObject);
begin
if not isall then begin
  showmessage('Заполниет все поля!');
  exit;
end;
clb:=true;
ini.WriteString('connection', 'host', edhost.Text);
ini.WriteString('connection', 'user', edUser.Text );
ini.WriteString('connection', 'password', edPassword.Text);
ini.WriteString('connection', 'db', edDatabase.Text);
ini.WriteString('connection', 'port', edPort.Text);
ini.WriteInteger('connection', 'ok', 1); //значит настройки сохранили


ini.WriteInteger('connection', 'ok', 1); //значит настройки сохранили
close;
showmessage('Изменения вступят в силу после перезапуска программы');
end;

procedure TfrSett.FormClose(Sender: TObject; var Action: TCloseAction);
begin
ini.Free;
Action:=caFree;
end;

procedure TfrSett.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if clb=true then exit;

if not isall then begin
  showmessage('Заполниет все поля!');
  canclose:=false;
end else sbutton1.Click;
end;

procedure TfrSett.FormCreate(Sender: TObject);
var fn:string;
begin
fn:=getmys+settFolder+'\';
createdir(fn);
ini:=TIniFile.Create(fn+'sett.ini');
end;

procedure TfrSett.FormShow(Sender: TObject);
begin
clb:=false;
  edhost.Text := ini.ReadString('connection', 'host', 'localhost');
  edUser.Text := ini.ReadString('connection', 'user', 'root');
  edPassword.Text := ini.ReadString('connection', 'password', 'root');
  edDatabase.Text := ini.ReadString('connection', 'db', dbName);
  edPort.Text := ini.ReadString('connection', 'port', '3306');
end;

end.
