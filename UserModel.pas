unit UserModel;

interface

Uses
  TypInfo, Generics.Collections, System.Classes;

type
  TUserRole = (urAdmin, urUser);

type
  TUser = class(TObject)
    private
     FId:Integer;
     FLogin:String;
     FUserName:String;
     FPassword:String;
     FRole:TUserRole;
     FRoleNames: TDictionary<TUserRole, String>;

     procedure initRoleNames;

    public
      constructor Create; overload;
      constructor Create(Login, Password:String); overload;
      constructor Create(id: integer; Login, Password, UserName:String; Role:TUserRole); overload;
      constructor Create(id: integer; Login, Password, UserName, roleName:String); overload;

      destructor Destroy; override;

      property id:Integer read FId write FId;
      property Login:String read FLogin write FLogin;
      property Password:String read FPassword write FPassword;
      property UserName:String read FUserName write FUserName;
      property Role:TUserRole read  FRole write FRole;

      function roleToString(role: TUserRole):string;
      function getRoleName(role:TUserRole):string;
      function getAllRoleNames:TStringList;
      procedure setRoleFromString(role:String);

  end;

implementation

constructor TUser.Create;
begin
  inherited;
  initRoleNames;
end;

constructor TUser.Create(Login: string; Password: string);
begin
inherited Create;
initRoleNames;
self.FLogin:=login;
Self.FPassword:=Password;
end;

constructor TUser.Create(id: integer; Login: string; Password: string; UserName: string; Role: TUserRole);
begin
inherited Create;
initRoleNames;
self.FLogin:=login;
Self.FPassword:=Password;
Self.FUserName:=UserName;
Self.FRole:=Role;
Self.FId:=id;
end;

constructor TUser.Create(id: Integer; Login: string; Password: string; UserName: string; roleName: string);
begin
initRoleNames;
self.FLogin:=login;
Self.FPassword:=Password;
Self.FUserName:=UserName;
Self.setRoleFromString(roleName);
Self.FId:=id;
end;

destructor TUser.Destroy;
begin
  inherited;
  FRoleNames.Free;
end;

procedure TUser.initRoleNames;
begin
FRoleNames:= TDictionary<TUserRole, String>.Create;
FRoleNames.Add(urAdmin, 'Администратор');
FRoleNames.Add(urUser, 'Пользователь');
end;

function TUser.roleToString(role: TUserRole):string;//Для сохранения в БД
var i:TUserRole;
    s, amp:string;
begin
{s:='';
amp:='';
  for i := Low(FRoles) to High(FRoles) do begin
    if(i=High(FRoles)) then amp:='' else amp:=', ';
    s:=s+GetEnumName(TypeInfo(TUserRole), ord(i))+amp;
  end; }

Result:=GetEnumName(TypeInfo(TUserRole), ord(role));
end;

procedure TUser.setRoleFromString(role: string);//Для загрузки из БД
begin
  self.FRole:=TUserrole(GetEnumValue(TypeInfo(TUserrole), role));
end;


function TUser.getRoleName(role: TUserRole):string;//Для отображения имен ролей пользователю
begin
 Result:=FRoleNames.ExtractPair(role).Value;
end;


function TUser.getAllRoleNames:TStringList;
var i:TUserRole;
sl:TstringList;
begin
 sl:=TStringList.Create;
 for i := Low(TUserRole) to High(TUserRole) do begin
    sl.Add(getRoleName(i));
 end;
Result:=sl;
end;

end.

