unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataUnit, UserModel, UMonToStr,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, sSpeedButton, System.ImageList,
  Vcl.ImgList, acAlphaImageList, ComObj, UfrIfnsBook, UfrNalogBook, UfrAccountBook,
  UfrEditUsers, System.Generics.Collections, UfrBanksBook, DB, inifiles,
  Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, UReplaceModel, UfrDialogChoseOktmo,
  AboutUnit, Generics.Defaults, Generics.Collections;

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
    Button3: TButton;
    rbDox: TRadioButton;
    rbExcel: TRadioButton;
    edExcel: TLabeledEdit;
    Button4: TButton;
    sdExel: TSaveDialog;
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
    procedure rbExcelClick(Sender: TObject);
    procedure rbDoxClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure sdExelTypeChange(Sender: TObject);
  private
    { Private declarations }
    function validXmlDocFields:boolean;
    procedure saveTemplate(fileName:string; model:TReplaceModel);
    procedure saveTemplateToEXEL(fileName:string; model:TReplaceModel);
  public
    { Public declarations }
    CurrentUser:TUser;
    chosenPosSumCahs:integer;//выбранаая позиция, если ОКТМО не одно в файле xml
    procedure loadIfns;
    procedure loadNalog;
    procedure loadAccounts;
    procedure loadBanks;
    procedure showBankInfo(bankName:string);
  end;

const ranges:array[0..25] of string =
    ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
    );

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
  if(name='Документ') then begin
    m.kodNo:=getAttrValue(anode, 'КодНО');
    //showmessage(m.kodNo);
    m.reportYear:=getAttrValue(anode, 'ОтчетГод');
  end;
  if(name='ФИОФЛ') then begin
    temp:=getAttrValue(anode, 'Фамилия');
    temp:=temp + ' '+getAttrValue(anode, 'Имя')+' ';
    temp:=temp + getAttrValue(anode, 'Отчество');
    model.fio:=temp;
  end;
  if(name='СведФЛ1') then m.inn:=getAttrValue(anode, 'ИННФЛ');
  if(name='УдЛичн') then begin
    m.passportNumber:=getAttrValue(anode, 'СерНомДок');
    m.passportFrom:=getAttrValue(anode, 'ВыдДок');
    m.passportDate:=getAttrValue(anode, 'ДатаДок');
  end;
  if(name='НПФЛ3') then m.phone:=getAttrValue(anode, 'Тлф');
  //а вот тут могут быть повторения
  if(name='СумНалПу') then  begin
    m.sumCashInfo.AddOrSetValue(getAttrValue(anode, 'ПодлВозв'),
              getAttrValue(anode, 'ОКТМО'));
    m.KBK:=getAttrValue(anode, 'КБК');
  end;

  EnumNodes(ANode, m);
end;
end;
/////////////////////////////////////////
begin
if not validXmlDocFields then exit;
if(rbDox.Checked) then begin
if not CopyFile(pchar(gep+'Шаблон.doc'), pchar(edDoc.Text), False) then
begin
  MessageDlg('Не удается создать файл '+edDoc.text+'. Возможно он занят другим процессом.',
      mtwarning, [mbok],0);
  exit;
end;
end else begin
 if not CopyFile(pchar(gep+'Шаблон3.xls'), pchar(edExcel.Text), False) then
begin
  MessageDlg('Не удается создать файл '+edExcel.Text+'. Возможно он занят другим процессом.',
      mtwarning, [mbok],0);
  exit;
end;
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

if(model.sumCashInfo.Count<>1)and(rbDox.Checked) then
 if not CopyFile(pchar(gep+'Шаблон2.doc'), pchar(edDoc.Text), False) then
 begin
   MessageDlg('Не удается создать файл '+edDoc.text+'. Возможно он занят другим процессом.',
      mtwarning, [mbok],0);
   model.Free;
   exit;
 end;

if(rbDox.Checked) then
saveTemplate(edDoc.Text, model) else saveTemplateToEXEL(edexcel.Text, model);
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


procedure TfrMain.Button4Click(Sender: TObject);
begin
if not sdExel.Execute(handle)then exit;
edExcel.Text:=sdExel.FileName;
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

procedure TfrMain.rbDoxClick(Sender: TObject);
begin
edDoc.Enabled:=not rbExcel.Checked;
Button2.Enabled:=not rbExcel.Checked;
Button4.Enabled:=rbExcel.Checked;
edExcel.Enabled:=rbExcel.Checked;
end;

procedure TfrMain.rbExcelClick(Sender: TObject);
begin
edDoc.Enabled:=not rbExcel.Checked;
Button2.Enabled:=not rbExcel.Checked;
Button4.Enabled:=rbExcel.Checked;
edExcel.Enabled:=rbExcel.Checked;
end;


function getRangeName(pos:integer):string;
var i, k:integer;
begin
//k:=pos div 26;
 if(pos<=26)then Result:=ranges[pos-1]
  else begin
  k:=0;
  while(pos>26) do begin
                     pos:=pos-26;
                     k:=k+1;
                   end;

    Result:=ranges[k-1]+ranges[pos-1];
  end;
end;

function getRangeNum(rangeName:string):integer;
var i, FoundIndex, l:integer;
begin
FoundIndex:=-1;
result:=0;
l:=Length(rangeName);
if(l=1) then begin
 TArray.BinarySearch<String>(ranges, rangeName[1], FoundIndex, TStringComparer.Ordinal);
 Result:=FoundIndex+1;
end else
begin
  TArray.BinarySearch<String>(ranges, rangeName[1], FoundIndex, TStringComparer.Ordinal);
  Result:=26*(FoundIndex+1);
  TArray.BinarySearch<String>(ranges, rangeName[2], FoundIndex, TStringComparer.Ordinal);
  Result:=Result+FoundIndex+1;
end;
end;

procedure printToChar(sheet: OleVariant;  text:string; startColumn, stepRange,
    rowNum:integer; newLine: boolean = false; stepRow:integer=1) overload;
var i, l, j, currentColumnt, space:integer;
    sl:TStringList;
    s:string;
begin

sl:=TStringList.Create;
sl.DelimitedText:=text;
sl.Delimiter:=' ';

currentColumnt:=startColumn;
space:=0;
  for j := 0 to sl.Count-1 do begin
    s:=sl[j];
    l:=Length(s);
    for I := 0 to l-1 do begin
     currentColumnt:= startColumn+stepRange*i+space;
     //showmessage(IntToStr(currentColumnt)+' место='+getRangeName(currentColumnt)+inttostr(rowNum)+ '_буква='+s[i+1]);
     sheet.Range[getRangeName(currentColumnt)+inttostr(rowNum)]:=s[i+1];
    end;
    if(newLine=false) then
      space:=currentColumnt+stepRange-1+stepRange
    else rowNum:=rowNum+stepRow;
  end;
sl.Free;
end;


procedure printText(sheet: OleVariant;  text, rangeNam:string);
begin
  sheet.Range[rangeNam]:=text;
end;

procedure printSumToExcel(sheet: OleVariant; sum:string);
var l:integer;
    sI, sF:string;
begin
  if(pos('.', sum)=0)then begin
    l:=Length(sum)-1;
    printToChar(sheet, sum, getRangeNum('AT')-l*3, 3, 36);
    printToChar(sheet, '00', getRangeNum('AZ'), 3, 36);
  end else begin
    l:=Length(sum)-3;
    sI:=copy(sum, 1,l);
    sF:= copy(sum, l+2,2);
    l:=l-1;
    printToChar(sheet, sI, getRangeNum('AT')-l*3, 3, 36);
    printToChar(sheet, sF, getRangeNum('AZ'), 3, 36);
  end;
end;

function getWordByNum(text:string; delimetr:char; num:integer):string;
var sl:TStringList;
begin
sl:=TStringList.Create;
sl.DelimitedText:=text;
sl.Delimiter:=delimetr;
if(num-1>sl.Count) then
result:='' else result:=sl[num-1];
sl.Free;
end;

procedure TfrMain.saveTemplateToEXEL(fileName: string; model: TReplaceModel);
const ExcelApp = 'Excel.Application';
var Excel, exSh: OleVariant;
    frChooseSum:TfrChoseSumCash;
    i:integer;
begin
  //save to xls
chosenPosSumCahs:=0;
Excel := CreateOleObject('Excel.Application');
//showmessage(fileName);
Excel.Workbooks.Open(fileName);
exSh := Excel.Worksheets[1];

//Надо ли это???
printText(exSh, '1','V17');
printToChar(exSh, '78', getRangeNum('V'), 3, 30);
printText(exSh, '3','A32');
printText(exSh, '1','A34');
printToChar(exSh, 'ГД', getRangeNum('AK'), 3, 39);
printToChar(exSh, '00', getRangeNum('AT'), 3, 39);


printToChar(exSh, model.fio, 1, 3, 19, true, 2); //фио
//printToChar(exSh, cbifns.Items[cbIfns.ItemIndex], 94, 3, 17); //IFSN !!!!!!!!!!!
printToChar(exSh, model.inn, 37, 3, 2);//inn
printToChar(exSh, model.reportYear, getRangeNum('BC'), 3, 39);
printToChar(exSh, model.phone, 2, 3, 65);
//printText(exSh, model.phone, 'K68');
printToChar(exSh, model.kodNo, getRangeNum('CP'), 3, 17);


if(model.sumCashInfo.Count=1) then begin
  printToChar(exSh, model.getSumValues.Strings[0], 85, 3, 39); //oktmo
  printSumToExcel(exSh, model.getSumKeys.Strings[0]); //sum vozvrat
  //printToChar(exSh, model.getSumKeys.Strings[0], 13, 3, 36);

end else
begin
  printToChar(exSh, model.getSumValues.Strings[0], 85, 3, 39);//oktmo
  printSumToExcel(exSh, model.getSumKeys.Strings[0]); //sum vozvrat
end;

exSh := excel.WorkSheets.Item['Лист2'];
printText(exSh, getWordByNum(model.fio, ' ', 1), 'S10');
printText(exSh, getWordByNum(model.fio, ' ', 2)[1], 'CN10');
printText(exSh, getWordByNum(model.fio, ' ', 3)[1], 'CX10');
printToChar(exSh, model.bank, 1, 3, 18);
printToChar(exSh, model.BIK, 1, 3, 30);
printToChar(exSh, model.accountNumber, 1, 3, 34);
printToChar(exSh, model.accountNumber, 1, 3, 60);
printToChar(exSh, model.fio, 1, 3, 40, true, 2);
printToChar(exSh, model.KBK, 1, 3, 56);


exSh := excel.WorkSheets.Item['Лист3'];
printToChar(exSh, getWordByNum(model.passportNumber, ' ', 1), getRangeNum('AB'), 3, 18);
printToChar(exSh, getWordByNum(model.passportNumber, ' ', 2), getRangeNum('AK'), 3, 18);
printToChar(exSh, getWordByNum(model.passportNumber, ' ', 3), getRangeNum('AT'), 3, 18);
printToChar(exSh, model.passportFrom, getRangeNum('AB'), 3, 20);

//Excel.Application.Workbooks[1].saveas(edexcel.Text);
Excel.visible:=true;
Excel:=unassigned;
end;

procedure TfrMain.saveTemplate(fileName: string; model: TReplaceModel);
var Word: variant;
    frChooseSum:TfrChoseSumCash;
    i:integer;
begin
chosenPosSumCahs:=0;
Word:=CreateOleObject('Word.Application');
Word.Documents.Open(fileName);

FindAndReplace(Word, '{ИННФЛ}', model.inn);
FindAndReplace(Word, '{ФИО}', model.fio);
FindAndReplace(Word, '{Ифнс}', cbifns.Items[cbIfns.ItemIndex]); //model.kodNo);
FindAndReplace(Word, '{СерНомДок}', model.passportNumber);
FindAndReplace(Word, '{ВыдДок}', model.passportFrom);
FindAndReplace(Word, '{УдЛичнДатаДок}', model.passportDate);
FindAndReplace(Word, '{Адрес}', model.address);
FindAndReplace(Word, '{Тлф}', model.phone);
FindAndReplace(Word, '{ОтчетГод}', model.reportYear);
FindAndReplace(Word, '{НалВычет}', model.nalog);

if(model.sumCashInfo.Count=1) then
begin
  FindAndReplace(Word, '{ПодлВозв}', model.getSumKeys.Strings[0]);
  FindAndReplace(Word, '{ОКТМО}', model.getSumValues.Strings[0]);
  FindAndReplace(Word, '{ПодлВозвПроп}',
      MoneyToString(strtofloat(model.getSumKeys.Strings[0])));
end else
begin

{frChooseSum:=TfrChoseSumCash.Create(Application);
frChooseSum.setValuesCB(model.getSumKeys, model.getSumValues);
frChooseSum.ShowModal;}
//showmessage(inttostr(chosenPosSumCahs));

  FindAndReplace(Word, '{ПодлВозв}', model.getSumKeys.Strings[0]);
  FindAndReplace(Word, '{ОКТМО}', model.getSumValues.Strings[0]);
  FindAndReplace(Word, '{ПодлВозвПроп}',
      MoneyToString(strtofloat(model.getSumKeys.Strings[0])));

  FindAndReplace(Word, '{ПодлВозв2}', model.getSumKeys.Strings[1]);
  FindAndReplace(Word, '{ОКТМО2}', model.getSumValues.Strings[1]);
  FindAndReplace(Word, '{ПодлВозвПроп2}',
      MoneyToString(strtofloat(model.getSumKeys.Strings[1])));
  FindAndReplace(Word, '{КБК2}', model.KBK);
end;

FindAndReplace(Word, '{КБК}', model.KBK);
FindAndReplace(Word, '{Банк}', model.bank);
FindAndReplace(Word, '{Бик}', model.BIK);
FindAndReplace(Word, '{Кс}', model.KS);
FindAndReplace(Word, '{ТипСчета}', model.accountType);
FindAndReplace(Word, '{НомерСчета}', model.accountNumber);


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

procedure TfrMain.sdExelTypeChange(Sender: TObject);
begin
case (Sender as TSaveDialog).FilterIndex of
    0: (Sender as TSaveDialog).DefaultExt := 'xsl';
    1: (Sender as TSaveDialog).DefaultExt := '';
  end;
end;

procedure TfrMain.showBankInfo(bankName: string);
var id:integer;
begin
//showmessage(inttostr(banks.Count)+'=count banks');
//ShowMessage(bankName);
if not banks.TryGetValue(bankName, id) then begin
  if MessageDlg('В БД не найден банк '+bankName+chr(13)+
      'Хотите обновить список?', mtWarning, [mbYes, mbNo], 0)=mrYes then
          loadBanks;
  exit;
end;
//ShowMessage(inttostr(id));

with dm.qBanks do begin
 Locate('id', id, [loPartialKey]);
 lbBik.Caption:='БИК: '+FieldByName('bik').AsString;
 lbKS.Caption:='КС: '+FieldByName('ks').AsString;
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
var currEd:TLabeledEdit;
    currTemplate:string;
begin
Result:=false;
if(rbDox.Checked) then
begin
  currEd:=edDoc;
  currTemplate:=gep+'Шаблон.doc';
end else begin
  currEd:=edExcel;
  currTemplate:=gep+'Шаблон3.xls';
end;

if(currEd.Text='') or (edXml.Text='') then
begin
  MessageDlg('Заполните все поля',mtwarning,[mbok],0);
  exit;
end;
if not (FileExists(currTemplate)) then
begin
  MessageDlg('Файл шаблона не найден',mterror,[mbok],0);
  exit;
end;
if not (FileExists(edXml.Text)) then
begin
  MessageDlg('Файл xml не найден',mterror,[mbok],0);
  exit;
end;
if(currEd.Text=currTemplate) then
begin
  MessageDlg('Нельзя перезаписать шаблон. Выбирете другое место для сохранения',mterror,[mbok],0);
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

procedure TfrMain.Button3Click(Sender: TObject);
begin
showmessage(getrangename(strtoint(edAddress.Text)));
end;

end.
