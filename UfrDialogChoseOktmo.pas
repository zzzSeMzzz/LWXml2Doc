unit UfrDialogChoseOktmo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrChoseSumCash = class(TForm)
    Label1: TLabel;
    cbPodl: TComboBox;
    cbOktmo: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbPodlSelect(Sender: TObject);
    procedure cbOktmoSelect(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure setValuesCB(slPodl, slOktmo:TStringList);
  end;

var
  frChoseSumCash: TfrChoseSumCash;

implementation

{$R *.dfm}
Uses MainUnit;

{ TfrChoseSumCash }

procedure TfrChoseSumCash.Button1Click(Sender: TObject);
begin
frMain.chosenPosSumCahs:=cbPodl.ItemIndex;
close;
end;

procedure TfrChoseSumCash.cbOktmoSelect(Sender: TObject);
begin
cbPodl.ItemIndex:=cbOktmo.ItemIndex;
end;

procedure TfrChoseSumCash.cbPodlSelect(Sender: TObject);
begin
cbOktmo.ItemIndex:=cbPodl.ItemIndex;
end;

procedure TfrChoseSumCash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=caFree;
end;

procedure TfrChoseSumCash.setValuesCB(slPodl, slOktmo: TStringList);
begin
cbPodl.Items.Assign(slPodl);
cbOktmo.Items.Assign(slOktmo);
cbPodl.ItemIndex:=0;
cbOktmo.ItemIndex:=0;
end;

end.
