unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    GroupBox2: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  s:string;
  i:integer;
  flag:boolean;
  ch:char;

implementation

{$R *.dfm}

procedure read_ch;
begin
 i:=i+1;
 ch:=s[i]
end;

procedure error;
begin
 flag:=true
end;

procedure A;
begin
 if ch='(' then read_ch else error;
 while ch='(' do A;
 if ch=')' then read_ch else error;
 while ch='(' do A;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 edit1.Text:='';
 label1.Caption:='Ожидание'
end;

procedure TForm1.Button1Click(Sender: TObject);
var
 s:string;
 i:integer;
 sch:integer;
 flag:boolean;
begin
 s:=edit1.Text;
 sch:=0;
 flag:=false;
 for i:=1 to length(s) do
  begin
   if s[i]='(' then sch:=sch+1 else sch:=sch-1;
   if sch<0 then flag:=true
  end;
 if sch<>0 then flag:=true;
 if flag then label1.Caption:='Неверно!' else label1.Caption:='Верно!'
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 i:=0;
 flag:=false;
 s:=edit1.Text+'@';
 read_ch;
 while (not flag)and(ch<>'@') do A;
 if flag then label1.Caption:='Неверно!' else label1.Caption:='Верно!'
end;

end.
