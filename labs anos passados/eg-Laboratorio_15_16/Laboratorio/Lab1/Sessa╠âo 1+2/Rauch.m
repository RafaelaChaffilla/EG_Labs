clear all
clc
close all
%%
B=250*2*pi;
w0=2000*pi;
K=-15.85;
a=sqrt(2);

den= [1 a*B 2*w0^2+B^2 a*B*w0^2 w0^4];
num= [K*B^2 0 0];

T=tf(num,den);
opts = bodeoptions('cstprefs');
opts.XLim=[1000 10^5];
opts.YLim=[-10 30];

disp 'Aguarda leitura do EXCEL'
%%
%Bode do Rauch
disp 'a ler...'
filename='dados.xlsx';
sheet=1;
f(1)=xlsread(filename,sheet,'X2');
xlRange = 'X5:X254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'Z5:Z254';
y = xlsread(filename,sheet,xlRange);
amp(1)=abs(max(y)-min(y))/2;
xlRange = 'Y5:Y254';
x2 = xlsread(filename,sheet,xlRange);
amp2(1)=(max(x2)-min(x2))/2;

f(2)=xlsread(filename,sheet,'AI2');
xlRange = 'AI5:AI254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'AK5:AK254';
y = xlsread(filename,sheet,xlRange);
amp(2)=(max(y)-min(y))/2;
xlRange = 'AJ5:AJ254';
x2 = xlsread(filename,sheet,xlRange);
amp2(2)=(max(x2)-min(x2))/2;


f(3)=xlsread(filename,sheet,'AT2');
xlRange = 'AT5:AT254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'AV5:AV254';
y = xlsread(filename,sheet,xlRange);
amp(3)=(max(y)-min(y))/2;
xlRange = 'AU5:AU254';
x2 = xlsread(filename,sheet,xlRange);
amp2(3)=(max(x2)-min(x2))/2;

f(4)=xlsread(filename,sheet,'BE2');
xlRange = 'BE5:BE254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'BG5:BG254';
y = xlsread(filename,sheet,xlRange);
amp(4)=(max(y)-min(y))/2;
xlRange = 'BF5:BF254';
x2 = xlsread(filename,sheet,xlRange);
amp2(4)=(max(x2)-min(x2))/2;

f(5)=xlsread(filename,sheet,'BP2');
xlRange = 'BP5:BP254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'BR5:BR254';
y = xlsread(filename,sheet,xlRange);
amp(5)=(max(y)-min(y))/2;
xlRange = 'BQ5:BQ254';
x2 = xlsread(filename,sheet,xlRange);
amp2(5)=(max(x2)-min(x2))/2;

f(6)=xlsread(filename,sheet,'CA2');
xlRange = 'CA5:CA254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'CC5:CC254';
y = xlsread(filename,sheet,xlRange);
amp(6)=(max(y)-min(y))/2;
xlRange = 'CB5:CB254';
x2 = xlsread(filename,sheet,xlRange);
amp2(6)=(max(x2)-min(x2))/2;

f(7)=xlsread(filename,sheet,'CL2');
xlRange = 'CL5:CL254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'CN5:CN254';
y = xlsread(filename,sheet,xlRange);
amp(7)=(max(y)-min(y))/2;
xlRange = 'CM5:CM254';
x2 = xlsread(filename,sheet,xlRange);
amp2(7)=(max(x2)-min(x2))/2;

f(8)=xlsread(filename,sheet,'CW2');
xlRange = 'CW5:CW254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'CY5:CY254';
y = xlsread(filename,sheet,xlRange);
amp(8)=(max(y)-min(y))/2;
xlRange = 'CX5:CX254';
x2 = xlsread(filename,sheet,xlRange);
amp2(8)=(max(x2)-min(x2))/2;

f(9)=xlsread(filename,sheet,'DH2');
xlRange = 'DH5:DH254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'DI5:DI254';
y = xlsread(filename,sheet,xlRange);
amp(9)=(max(y)-min(y))/2;
xlRange = 'DJ5:DJ254';
x2 = xlsread(filename,sheet,xlRange);
amp2(9)=(max(x2)-min(x2))/2;
%%
w=(2*pi)*f;
amp_div=20*log10(amp./amp2);
bodemag(T,opts), hold on
plot(w,amp_div,'ko');
disp 'Terminado!'