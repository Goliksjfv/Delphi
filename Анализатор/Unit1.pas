unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    GroupBox2: TGroupBox;
    Edit1: TEdit;
    GroupBox3: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    ListBox1: TListBox;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  ch:char;
  i:integer;
  flag:boolean;
  s,ch1:string;
  mes:string;

implementation

{$R *.dfm}

procedure error(n:integer);
begin
 flag:=true;
 if n=1 then mes:=mes+'Переменная начинается не с буквы'+chr(13);
 if n=2 then mes:=mes+'Неверное имя переменной'+chr(13);
 if n=3 then mes:=mes+'Ошибка в отрицании'+chr(13);
 if n=4 then mes:=mes+'Ошибка в орасставлении скобок'+chr(13);
 if n=5 then mes:=mes+'Ошибка в условии'+chr(13);
 if n=6 then mes:=mes+'Ошибка в логической связке'+chr(13);
 if n=7 then mes:=mes+'Ошибка в слове if'+chr(13);
 if n=8 then mes:=mes+'Ошибка в слове then'+chr(13);
 if n=9 then mes:=mes+'Ошибка в действии1 или начале оператора'+chr(13);
 if n=10 then mes:=mes+'Ошибка в слове else'+chr(13);
 if n=11 then mes:=mes+'Ошибка в действии2 или начале оператора'+chr(13)
end;

procedure read_ch;
begin
 i:=i+1;
 ch:=s[i]
end;

procedure read_ch1;
begin
 i:=i+1;
 ch1:=form1.listbox1.items.strings[i]
end;

function var1 : boolean;
var j:integer;
begin
 var1:=false;
 for j:=0 to form1.Memo1.Lines.Count-1 do
  if ch1=form1.Memo1.Lines.Strings[j]then var1:=true
end;

procedure V;
begin
 if ch in ['a'..'z','A'..'Z'] then read_ch else error(1);
 while ch in ['a'..'z','A'..'Z', '0'..'9', '_'] do
  if ch in ['a'..'z','A'..'Z'] then read_ch else
   if ch in ['0'..'9'] then read_ch else
    if ch='_' then read_ch else error(2);
end;

procedure E;
 begin
  if var1 then read_ch1 else
   if ch1='not' then
    begin
     if ch1='not' then read_ch1 else error(3);
     E
    end else
    if ch1='(' then
     begin
      if ch1='(' then read_ch1 else error(4);
      E;
      if ch1=')' then read_ch1 else error(4)
     end else error(5);
   while (ch1='and') or (ch1='or') do
    begin
     if ch1='and' then read_ch1 else
      if ch1='or' then read_ch1 else error(6);
     E
    end
 end;

procedure O;
 begin
  if ch1='if' then read_ch1 else error(7);
  E;
  if ch1='then' then read_ch1 else error(8);
  if ch1='$$$' then read_ch1 else
   if ch1='if' then O else error(9);
  if ch1='@@@' then begin end else
   if ch1='else' then
    begin
     if ch1='else' then read_ch1 else error(10);
     if ch1='$$$' then read_ch1 else
      if ch1='if' then O else error(11);
    end
   else error(10);
 end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 memo1.Clear;
 edit1.Text:='';
 label1.Caption:='Ожидание'
end;

procedure razb;
var
 s1:string;

begin
 form1.ListBox1.Clear;
 s1:='';
 s:=form1.Edit1.Text+' ';
 for i:=1 to length(s) do
  if not (s[i] in ['(',')',' ']) then s1:=s1+s[i]
  else
   begin
    if s[i] in ['(',')'] then
     begin
      if s1<>'' then begin form1.ListBox1.Items.Add(s1); s1:='' end;
      form1.ListBox1.Items.Add(s[i])
     end;
    if s[i]=' ' then
     begin
      if s1<>'' then form1.ListBox1.Items.Add(s1);
      s1:=''
     end
   end;
 form1.ListBox1.Items.Add('@@@')
end;

procedure TForm1.Button1Click(Sender: TObject);
var j:integer;
begin
 flag:=false;
 mes:='';
 
 for j:=0 to memo1.Lines.Count-1 do
  if not flag then
   begin
    s:=memo1.Lines.Strings[j]+'@';
    if (s='and@')or(s='or@')or(s='not@')or(s='if@')or(s='then@')or(s='else@') then flag:=true;
    i:=0;
    read_ch;
    while(not flag) and (ch<>'@') do V;
   end;

 if not flag then
  begin
   razb;
   i:=-1;
   read_ch1;
   while(not flag) and (ch1<>'@@@') do O;
  end;

 if flag then label1.Caption:='Ошибка'+chr(13)+mes else label1.Caption:='Верно!'

end;

end.
