unit UReplaceModel;

interface

uses
  System.Generics.Collections, System.SysUtils, System.Classes;

  type
    TReplaceModel = class(TObject)
    private
      FkodNO:string;
      FFioFl:string;
      FInn:string;
      FPassportNumber:String;
      FPassportFrom:string;
      FPassportDate:string;
      FPhone:string;
      FRepoertYear:string;
      FSumCashInfo:TDictionary<String, String>;
      FKbk:string;
      Faddress:string;
      fNalog:string;
      Fbank, FBik, FKs, FAccountType, FAccountNumber:string;
    protected


    public
      constructor Create;
      destructor Destroy;
      function toString:string; override;
      property kodNo:string read FkodNO write FkodNO;
      property fio:string read FFioFl write FFioFl;
      property inn:string read FInn write FInn;
      property passportNumber:string read FPassportNumber write FPassportNumber;
      property passportFrom:string read FPassportFrom write FPassportFrom;
      property passportDate:string read FPassportDate write FPassportDate;
      property phone:string read FPhone write FPhone;
      property reportYear:string read FRepoertYear write FRepoertYear;
      property sumCashInfo:TDictionary<String, String> read FSumCashInfo write FSumCashInfo;
      property KBK:string read FKbk write FKbk;
      property nalog:string read fNalog write fNalog;
      property address:string read Faddress write Faddress;
      property bank:string read Fbank write Fbank;
      property BIK:string read FBik write FBik;
      property KS:string read FKs write FKs;
      property accountType:string read FAccountType write FAccountType;
      property accountNumber:string read FAccountNumber write FAccountNumber;
      function getSumKeys:TStringList;
      function getSumValues:TStringList;
  end;

implementation


constructor TReplaceModel.Create;
begin
  inherited;
  FSumCashInfo:=TDictionary<String, String>.Create();;
end;

destructor TReplaceModel.Destroy;
begin
  inherited;
  FSumCashInfo.Free;
end;

function TReplaceModel.getSumKeys: TStringList;
var key:string;
begin
result:=TStringList.Create;
for key in sumCashInfo.Keys do
  Result.Add(key);

end;

function TReplaceModel.getSumValues: TStringList;
var value:string;
begin
result:=TStringList.Create;
for value in sumCashInfo.Values do
  Result.Add(value);
end;

function TReplaceModel.toString: string;
begin
result:=kodNo+' '+fio+' '+inn+ ' '+passportNumber+' '+ passportFrom+
    ' '+passportDate+' '+phone+' '+reportYear+' sumCashInfoCount='
    +inttostr(sumCashInfo.Count)+ ' ' +KBK;
end;



end.
