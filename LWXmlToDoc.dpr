program LWXmlToDoc;

uses
  Vcl.Forms,
  DataUnit in 'DataUnit.pas' {dm: TDataModule},
  UfrSett in 'UfrSett.pas' {frSett},
  UserModel in 'UserModel.pas',
  UfrLogin in 'UfrLogin.pas' {frLogin},
  EncryptUnit in 'EncryptUnit.pas',
  UfrEditUsers in 'UfrEditUsers.pas' {frEditUser},
  UMonToStr in 'UMonToStr.pas',
  MainUnit in 'MainUnit.pas' {frMain},
  UfrIfnsBook in 'UfrIfnsBook.pas' {frIfnsBook},
  UfrNalogBook in 'UfrNalogBook.pas' {frNalogBook},
  UfrAccountBook in 'UfrAccountBook.pas' {frAccountBook},
  UfrBanksBook in 'UfrBanksBook.pas' {frBanksBook},
  UReplaceModel in 'UReplaceModel.pas',
  UfrDialogChoseOktmo in 'UfrDialogChoseOktmo.pas' {frChoseSumCash},
  AboutUnit in 'AboutUnit.pas' {frAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrLogin, frLogin);
  //Application.CreateForm(TfrAbout, frAbout);
  //Aplication.CreateForm(TfrMain, frMain);
  //Application.CreateForm(TfrChoseSumCash, frChoseSumCash);
  //Application.CreateForm(TfrBanksBook, frBanksBook);
  //Application.CreateForm(TfrAccountBook, frAccountBook);
  //Application.CreateForm(TfrNalogBook, frNalogBook);
  //Application.CreateForm(TfrIfnsBook, frIfnsBook);
  Application.Run;
end.
