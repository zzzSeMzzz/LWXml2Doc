unit AboutUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, shellapi, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrAbout = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frAbout: TfrAbout;

implementation

{$R *.dfm}

procedure TfrAbout.Button1Click(Sender: TObject);
begin
close;
end;

procedure TfrAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=caFree;
end;

procedure TfrAbout.Label2Click(Sender: TObject);
begin
shellexecute(0,0,pchar('mailto:AlexSoft2@bk.ru'),0,0,sw_show);
end;

end.
