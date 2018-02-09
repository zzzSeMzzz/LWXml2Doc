unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataUnit, UserModel, UMonToStr,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, sSpeedButton, System.ImageList,
  Vcl.ImgList, acAlphaImageList, ComObj, UfrIfnsBook, UfrNalogBook, UfrAccountBook,
  UfrEditUsers, System.Generics.Collections, UfrBanksBook, DB, inifiles,
  Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, UReplaceModel, UfrDialogChoseOktmo,
  AboutUnit;

function gep:string;

type
  TfrMain = class(TForm)
    GroupBox1: TGroupBox;
    edXml: TLabeledEdit;
    Button1: TButton;
    odXml: TOpenDialog;
    sdDoc: TSaveDialog;
    edDoc: TLabeledEdit;
    Button2: TButton;
    GroupBox2: TGroupBox;
    cbIfns: TComboBox;
    Label1: TLabel;
    sAlphaImageList1: TsAlphaImageList;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    Label2: TLabel;
    cbNalog: TComboBox;
    sSpeedButton3: TsSpeedButton;
    sSpeedButton4: TsSpeedButton;
    cbAccount: TComboBox;
    sSpeedButton5: TsSpeedButton;
    sSpeedButton6: TsSpeedButton;
    Label3: TLabel;
    cbBank: TComboBox;
    Label4: TLabel;
    lbBik: TLabel;
    lbKS: TLabel;
    btnEditUsers: TsSpeedButton;
    sAlphaImageList2: TsAlphaImageList;
    sSpeedButton7: TsSpeedButton;
    sSpeedButton8: TsSpeedButton;
    Label5: TLabel;
    edAddress: TMemo;
    btnPasteToTemplate: TButton;
    XML: TXMLDocument;
    Memo1: TMemo;
    edAccountNumber: TEdit;
    Label6: TLabel;
    sSpeedButton9: TsSpeedButton;
  procedure CreateParams(var Params: TCreateParams); override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure sdDocTypeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure sSpeedButton2Click(Sender: TObject);
    procedure sSpeedButton3Click(Sender: TObject);
    procedure sSpeedButton4Click(Sender: TObject);
    procedure sSpeedButton5Click(Sender: TObject);
    procedure sSpeedButton6Click(Sender: TObject);
    procedure btnEditUsersClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sSpeedButton7Click(Sender: TObject);
    procedure sSpeedButton8Click(Sender: TObject);
    procedure cbBankSelect(Sender: TObject);
    procedure btnPasteToTemplateClick(Sender: TObject);
    procedure sSpeedButton9Click(Sender: TObject);
  private
    { Private declarations }
    function validXmlDocFields:boolean;
    procedure saveTemplate(fileName:string; model:TReplaceModel);
  public
    { Public declarations }
    CurrentUser:TUser;
    chosenPosSumCahs:integer;//��������� �������, ���� ����� �� ���� � ����� xml
    procedure loadIfns;
    procedure loadNalog;
    procedure loadAccounts;
    procedure loadBanks;
    procedure showBankInfo(bankName:string);
  end;

var
  frMain: TfrMain;
  i:integer;
  banks:TDictionary<String, Integer>;
  ini:TIniFile;

implementation

{$R *.dfm}

Uses UfrSett;

function gep:string;
var s:string;
begin
  s:=ExtractFilePath(Application.ExeName);
  if s[length(s)]<>'\' then  s:=s+'\';
  result:=s;
end;

function getAttrValue(ANode : IXMLNode;attrName:string):string;
var
  i:integer;
begin
result:='';
  for I := 0 to ANode.AttributeNodes.Count-1 do

    if(ANode.AttributeNodes[i].NodeName=attrName) then
    begin
      {showmessage(ANode.AttributeNodes[i].NodeName+chr(13)
          +ANode.AttributeNodes[i].NodeValue); }
      Result:=ANode.AttributeNodes[i].NodeValue;
      Break;
    end;
end;



procedure TfrMain.btnPasteToTemplateClick(Sender: TObject);
var
  model:TReplaceModel;
  i:integer;
  ANode : IXMLNode;
/////////////////////////////////////////
function EnumNodes(XNode : IXMLNode; m:TReplaceModel):boolean;
var
  i:integer;
  ANode : IXMLNode;
  name, temp:string;
begin
for i := 0 to XNode.ChildNodes.Count-1 do begin
  ANode := XNode.ChildNodes.Get(i);
  name:= ANode.NodeName;
  frmain.Memo1.Lines.Add(name);
  if(name='��������') then begin
    m.kodNo:=getAttrValue(anode, '�����');
    //showmessage(m.kodNo);
    m.reportYear:=getAttrValue(anode, '��������');
  end;
  if(name='�����') then begin
    temp:=getAttrValue(anode, '�������');
    temp:=temp + ' '+getAttrValue(anode, '���')+' ';
    temp:=temp + getAttrValue(anode, '��������');
    model.fio:=temp;
  end;
  if(name='������1') then m.inn:=getAttrValue(anode, '�����');
  if(name='������') then begin
    m.passportNumber:=getAttrValue(anode, '���������');
    m.passportFrom:=getAttrValue(anode, '������');
    m.passportDate:=getAttrValue(anode, '�������');
  end;
  if(name='����3') then m.phone:=getAttrValue(anode, '���');
  //� ��� ��� ����� ���� ����������
  if(name='��������') then  begin
    m.sumCashInfo.AddOrSetValue(getAttrValue(anode, '��������'),
              getAttrValue(anode, '�����'));
    m.KBK:=getAttrValue(anode, '���');
  end;

  EnumNodes(ANode, m);
end;
end;
/////////////////////////////////////////
begin
if not validXmlDocFields then exit;
if not CopyFile(pchar(gep+'������.doc'), pchar(edDoc.Text), False) then
begin
  MessageDlg('�� ������� ������� ���� '+edDoc.text+'. �������� �� ����� ������ ���������.',
      mtwarning, [mbok],0);
  exit;
end;


model:=TReplaceModel.Create;
xml.LoadFromFile(edXml.Text);
xml.Active:=true;

for i := 0 to xml.ChildNodes.Count-1 do begin
  ANode := xml.ChildNodes.Get(i);
  Memo1.Lines.Add(ANode.NodeName);
  EnumNodes(ANode, model);
end;

XML.Active:=false;

//ShowMessage(model.toString);
model.accountType:=cbAccount.Items[cbAccount.ItemIndex];
model.accountNumber:=edAccountNumber.Text;
model.BIK:=dm.qBanks.FieldByName('bik').AsString;
model.KS:=dm.qBanks.FieldByName('ks').AsString;
model.nalog:=cbNalog.Items[cbNalog.ItemIndex];
model.address:=edAddress.Text;
model.bank:=cbBank.Items[cbBank.ItemIndex];

if(model.sumCashInfo.Count<>1) then
 if not CopyFile(pchar(gep+'������2.doc'), pchar(edDoc.Text), False) then
 begin
   MessageDlg('�� ������� ������� ���� '+edDoc.text+'. �������� �� ����� ������ ���������.',
      mtwarning, [mbok],0);
   model.Free;
   exit;
 end;

saveTemplate(edDoc.Text, model);
end;

procedure TfrMain.Button1Click(Sender: TObject);
begin
if not odXml.Execute(handle) then exit;
edXml.Text:=odxml.FileName;
end;

procedure TfrMain.Button2Click(Sender: TObject);
begin
if not sdDoc.Execute(handle)then exit;
edDoc.Text:=sdDoc.FileName;
end;

function FindAndReplace(word:variant; const FindText,ReplaceText:string):boolean;
  const wdReplaceAll = 2;
begin
  Word.Selection.Find.MatchSoundsLike := False;
  Word.Selection.Find.MatchAllWordForms := False;
  Word.Selection.Find.MatchWholeWord := False;
  Word.Selection.Find.Format := False;
  Word.Selection.Find.Forward := True;
  Word.Selection.Find.ClearFormatting;
  Word.Selection.Find.Text:=FindText;
  Word.Selection.Find.Replacement.Text:=ReplaceText;
  FindAndReplace:=Word.Selection.Find.Execute(Replace:=wdReplaceAll);
end;

procedure TfrMain.cbBankSelect(Sender: TObject);
begin
showBankInfo(cbBank.Items[cbBank.ItemIndex]);
end;

procedure TfrMain.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TfrMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
ini.WriteString('main','xml', edXml.Text);
ini.WriteString('main', 'doc', edDoc.Text);
ini.Free;
Application.Terminate;
end;

procedure TfrMain.FormCreate(Sender: TObject);
begin
ini:=TIniFile.Create(GetMyS+settFolder+'conf.ini');
edXml.Text:=ini.ReadString('main','xml','');
edDoc.Text:=ini.ReadString('main','doc','');

//dm.qIfns.Active:=true;

loadIfns;
loadNalog;
loadAccounts;
banks:=TDictionary<String, Integer>.Create();
loadBanks;
end;

procedure TfrMain.FormShow(Sender: TObject);
begin
if(CurrentUser.Role<>UserModel.urAdmin) then begin
  btnEditUsers.OnClick:=nil;
  btnEditUsers.Enabled:=false;
end;

Caption:='LWXml2Doc - '+CurrentUser.UserName;
end;

procedure TfrMain.loadAccounts;
begin
dm.qAccount.Active:=false;
cbAccount.Items.Clear;

dm.qAccount.Open;

 dm.qAccount.First;
 for I := 0 to dm.qAccount.RecordCount-1 do begin
   cbAccount.Items.Add(dm.qAccount.FieldByName('name').AsString);
   dm.qAccount.Next;
 end;

 if(cbAccount.Items.Count<>0)then cbAccount.ItemIndex:=0;

dm.qAccount.Close;
end;

procedure TfrMain.loadBanks;
begin
banks.Clear;
if not dm.qBanks.Active then dm.qBanks.Open;
cbBank.Items.Clear;

dm.qBanks.First;

for I := 0 to dm.qBanks.RecordCount-1 do begin
  banks.Add(dm.qBanks.FieldByName('name').AsString,
                  dm.qBanks.FieldByName('id').AsInteger);
  cbBank.items.add(dm.qBanks.FieldByName('name').AsString);
  dm.qBanks.Next;
end;

if(cbBank.Items.Count<>0) then begin
  cbBank.ItemIndex:=0;
  showBankInfo(cbBank.Items[0]);
end;
end;

procedure TfrMain.loadIfns;
begin
dm.qIfns.Active:=false;
cbIfns.Items.Clear;

dm.qIfns.Open;

 dm.qIfns.First;
 for I := 0 to dm.qIfns.RecordCount-1 do begin
   cbIfns.Items.Add(dm.qIfns.FieldByName('name').AsString);
   dm.qIfns.Next;
 end;

 if(cbIfns.Items.Count<>0)then cbIfns.ItemIndex:=0;

dm.qIfns.Close;
end;

procedure TfrMain.loadNalog;
begin
dm.qNalog.Active:=false;
cbNalog.Items.Clear;

dm.qNalog.Open;

 dm.qNalog.First;
 for I := 0 to dm.qNalog.RecordCount-1 do begin
   cbNalog.Items.Add(dm.qNalog.FieldByName('name').AsString);
   dm.qNalog.Next;
 end;

 if(cbNalog.Items.Count<>0)then cbNalog.ItemIndex:=0;

dm.qNalog.Close;
end;

procedure TfrMain.saveTemplate(fileName: string; model: TReplaceModel);
var Word: variant;
    frChooseSum:TfrChoseSumCash;
    i:integer;
begin
chosenPosSumCahs:=0;
Word:=CreateOleObject('Word.Application');
Word.Documents.Open(fileName);

FindAndReplace(Word, '{�����}', model.inn);
FindAndReplace(Word, '{���}', model.fio);
FindAndReplace(Word, '{����}', cbifns.Items[cbIfns.ItemIndex]); //model.kodNo);
FindAndReplace(Word, '{���������}', model.passportNumber);
FindAndReplace(Word, '{������}', model.passportFrom);
FindAndReplace(Word, '{�������������}', model.passportDate);
FindAndReplace(Word, '{�����}', model.address);
FindAndReplace(Word, '{���}', model.phone);
FindAndReplace(Word, '{��������}', model.reportYear);
FindAndReplace(Word, '{��������}', model.nalog);

if(model.sumCashInfo.Count=1) then
begin
  FindAndReplace(Word, '{��������}', model.getSumKeys.Strings[0]);
  FindAndReplace(Word, '{�����}', model.getSumValues.Strings[0]);
  FindAndReplace(Word, '{������������}',
      MoneyToString(strtofloat(model.getSumKeys.Strings[0])));
end else
begin

{frChooseSum:=TfrChoseSumCash.Create(Application);
frChooseSum.setValuesCB(model.getSumKeys, model.getSumValues);
frChooseSum.ShowModal;}
//showmessage(inttostr(chosenPosSumCahs));

  FindAndReplace(Word, '{��������}', model.getSumKeys.Strings[0]);
  FindAndReplace(Word, '{�����}', model.getSumValues.Strings[0]);
  FindAndReplace(Word, '{������������}',
      MoneyToString(strtofloat(model.getSumKeys.Strings[0])));

  FindAndReplace(Word, '{��������2}', model.getSumKeys.Strings[1]);
  FindAndReplace(Word, '{�����2}', model.getSumValues.Strings[1]);
  FindAndReplace(Word, '{������������2}',
      MoneyToString(strtofloat(model.getSumKeys.Strings[1])));
  FindAndReplace(Word, '{���2}', model.KBK);
end;

FindAndReplace(Word, '{���}', model.KBK);
FindAndReplace(Word, '{����}', model.bank);
FindAndReplace(Word, '{���}', model.BIK);
FindAndReplace(Word, '{��}', model.KS);
FindAndReplace(Word, '{��������}', model.accountType);
FindAndReplace(Word, '{����������}', model.accountNumber);


word.ActiveDocument.saveas(edDoc.Text);
Word.visible:=true;
Word:=unassigned;
end;

procedure TfrMain.sdDocTypeChange(Sender: TObject);
begin
case (Sender as TSaveDialog).FilterIndex of
    0: (Sender as TSaveDialog).DefaultExt := 'doc';
    1: (Sender as TSaveDialog).DefaultExt := '';
  end;
end;

procedure TfrMain.showBankInfo(bankName: string);
var id:integer;
begin
//showmessage(inttostr(banks.Count)+'=count banks');
//ShowMessage(bankName);
if not banks.TryGetValue(bankName, id) then begin
  if MessageDlg('� �� �� ������ ���� '+bankName+chr(13)+
      '������ �������� ������?', mtWarning, [mbYes, mbNo], 0)=mrYes then
          loadBanks;
  exit;
end;
//ShowMessage(inttostr(id));

with dm.qBanks do begin
 Locate('id', id, [loPartialKey]);
 lbBik.Caption:='���: '+FieldByName('bik').AsString;
 lbKS.Caption:='��: '+FieldByName('ks').AsString;
end;
end;

procedure TfrMain.sSpeedButton1Click(Sender: TObject);
begin
loadIfns;
end;

procedure TfrMain.sSpeedButton2Click(Sender: TObject);
var frIfns:TfrIfnsBook;
begin
frIfns:=TfrIfnsBook.Create(application);
frIfns.ShowModal;
end;

procedure TfrMain.sSpeedButton3Click(Sender: TObject);
begin
loadNalog;
end;

procedure TfrMain.sSpeedButton4Click(Sender: TObject);
var frNalog:TfrNalogBook;
begin
frNalog:=TfrNalogBook.Create(Application);
frNalog.ShowModal;
end;

procedure TfrMain.sSpeedButton5Click(Sender: TObject);
begin
loadAccounts;
end;

procedure TfrMain.sSpeedButton6Click(Sender: TObject);
var frAccount:TfrAccountBook;
begin
frAccount:=TfrAccountBook.Create(Application);
frAccount.ShowModal;
end;

procedure TfrMain.sSpeedButton7Click(Sender: TObject);
begin
loadBanks;
end;

procedure TfrMain.sSpeedButton8Click(Sender: TObject);
var frBanks:TfrBanksBook;
begin
frBanks:=TfrBanksBook.Create(Application);
frBanks.ShowModal;
end;

procedure TfrMain.sSpeedButton9Click(Sender: TObject);
var frAbout:TfrAbout;
begin
frAbout:=TfrAbout.Create(Application);
frAbout.ShowModal;
end;

function TfrMain.validXmlDocFields: boolean;
begin
Result:=false;
if(edDoc.Text='') or (edXml.Text='') then
begin
  MessageDlg('��������� ��� ����',mtwarning,[mbok],0);
  exit;
end;
if not (FileExists(gep+'������.doc')) then
begin
  MessageDlg('���� ������� �� ������',mterror,[mbok],0);
  exit;
end;
if not (FileExists(edXml.Text)) then
begin
  MessageDlg('���� xml �� ������',mterror,[mbok],0);
  exit;
end;
if(edDoc.Text=gep+'������.doc') then
begin
  MessageDlg('������ ������������ ������. �������� ������ ����� ��� ����������',mterror,[mbok],0);
  exit;
end;
Result:=true;
end;

procedure TfrMain.btnEditUsersClick(Sender: TObject);
var frEditUsers:TfrEditUser;
begin
frEditUser:=TfrEditUser.Create(Application);
frEditUser.ShowModal;
end;

end.
