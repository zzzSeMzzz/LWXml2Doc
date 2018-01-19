unit DataUnit;

interface

uses
  System.SysUtils, System.Classes, Data.DB, MemDS, DBAccess, MyAccess, dialogs,
  ShFolder, IniFiles;

function GetMyS:string;

type
  Tdm = class(TDataModule)
    cn: TMyConnection;
    usersQuery: TMyQuery;
    userDS: TMyDataSource;
    qIfns: TMyQuery;
    dsIfns: TMyDataSource;
    qNalog: TMyQuery;
    dsNalog: TMyDataSource;
    qAccount: TMyQuery;
    dsAccount: TMyDataSource;
    qBanks: TMyQuery;
    dsBanks: TMyDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    pk:TLocateOption;
    dstate, dstate_ins:TDATAsetState;
  end;

var
  dm: Tdm;
  ini:TIniFile;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses ufrsett;

function GetMyS:string;
var
  Buf:array[0..255] of Char;
  s:string;
begin
  Result:='';
  if SHGetFolderPath(0, CSIDL_APPDATA, 0, 0, Buf) = 0 then s:=Buf;
  if s[length(s)]<>'\' then  s:=s+'\';
  result:=s;
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
var fn:string;
begin
cn.Connected:=false;
fn:=getmys+settFolder+'\';
//ShowMessage(fn);
createdir(fn);
ini:=TIniFile.Create(fn+'sett.ini');

cn.Server:=ini.ReadString('connection', 'host', cn.Server);
cn.Username:=ini.ReadString('connection', 'user', cn.Username);
cn.password:=ini.ReadString('connection', 'password', cn.Password);
cn.Database:=ini.ReadString('connection', 'db', cn.Database);
cn.Port:=ini.ReadInteger('connection', 'port', cn.Port);
ini.Free;

//showmessage(cn.Password);

cn.Connected:=false;
pk:=loPartialKey;
dstate:=dsEdit ;
dstate_ins:=dsInsert;
end;

end.
