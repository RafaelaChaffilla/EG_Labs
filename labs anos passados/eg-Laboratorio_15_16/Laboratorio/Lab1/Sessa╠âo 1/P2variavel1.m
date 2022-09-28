

close all
clear all
clc


%Fitting do T2 para tirar Q para P2=5k ohm

filename='KHN.xlsx';
sheet=4;

disp 'a ler...'
f(1)=xlsread(filename,sheet,'A2');
xlRange = 'A5:A254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'C5:C254';
y = xlsread(filename,sheet,xlRange);
amp(1)=abs(max(y)-min(y))/2;
xlRange = 'B5:B254';
x2 = xlsread(filename,sheet,xlRange);
amp2(1)=(max(x2)-min(x2))/2;


f(2)=xlsread(filename,sheet,'M2');
xlRange = 'M5:M254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'O5:O254';
y = xlsread(filename,sheet,xlRange);
amp(2)=(max(y)-min(y))/2;
xlRange = 'N5:N254';
x2 = xlsread(filename,sheet,xlRange);
amp2(2)=(max(x2)-min(x2))/2;


f(3)=xlsread(filename,sheet,'X2');
xlRange = 'X5:X254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'Z5:Z254';
y = xlsread(filename,sheet,xlRange);
amp(3)=(max(y)-min(y))/2;
xlRange = 'Y5:Y254';
x2 = xlsread(filename,sheet,xlRange);
amp2(3)=(max(x2)-min(x2))/2;

f(4)=xlsread(filename,sheet,'AI2');
xlRange = 'AI5:AI254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'AK5:AK254';
y = xlsread(filename,sheet,xlRange);
amp(4)=(max(y)-min(y))/2;
xlRange = 'AJ5:AJ254';
x2 = xlsread(filename,sheet,xlRange);
amp2(4)=(max(x2)-min(x2))/2;

f(5)=xlsread(filename,sheet,'AT2');
xlRange = 'AT5:AT254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'AV5:AV254';
y = xlsread(filename,sheet,xlRange);
amp(5)=(max(y)-min(y))/2;
xlRange = 'AU5:AU254';
x2 = xlsread(filename,sheet,xlRange);
amp2(5)=(max(x2)-min(x2))/2;



%-Estes valores serve para tirar k a partir do T3 nas baixas frequencias

fk=xlsread(filename,sheet,'BE2');
xlRange = 'BE5:BE254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'BG5:BG254';
y = xlsread(filename,sheet,xlRange);
ampk=(max(y)-min(y))/2;
xlRange = 'BF5:BF254';
x2 = xlsread(filename,sheet,xlRange);
ampk2=(max(x2)-min(x2))/2;

disp 'Podes tratar a info'

%%
%-Vamos agora tratar a informação lida

w=(2*pi)*f;
amp_rel=amp./amp2;
amp_div=20*log10(amp_rel);

semilogx(w,amp_div,'ko');
axis([300,40*10^5,-50,5])

disp 'Terminado!'

%%
%cftool
clc
load('FitP25000.mat');
disp 'a entrar no ciclo'
w2=(1500:10:32000);
  for i=1:length(w2)
      aux=w2(i);
      VectorFit(i)=plo4(aux);
  end
disp 'A desenhar'
semilogx(w2,VectorFit,'r'), hold on
axis([300,40*10^5,-50,5])
semilogx(w,amp_div,'ko'), hold off
axis([300,40*10^5,-50,5])

%%
%-Tratamento de VectorFit para encontrar o ponto onde perde 3dB
[maximo, index]=max(VectorFit);

for i=index:-1:2
    if VectorFit(i+1)>maximo-3 && VectorFit(i)<=maximo-3
        index2=i;
    end
end

w_threshold=w2(index2);

w_0=w2(index)
d=w_0-w_threshold;
Q=abs(w_0/(2*d))
%Q=1.4349

%%
%-Tratamento de T3 para estimar k

wk=(2*pi)*fk;
ampk_rel=ampk/ampk2;
ampk_div=20*log10(ampk_rel);
k=10^(ampk_div/20)

%k=0.4533

disp 'Terminado!'

%%
%-Comportamento das caracteristicas variando k
P2vector=[10000 5000];
Kvector=[1.0426 0.4533];
Q=[1.2264 1.4349];

mil=1000;n=10^-9;
R1=51*mil;R2=100*mil;R3=10*mil;R4=R3;R5=R2;
R6=R3;R7=1000*mil;R8=R2;R9=R1;R10=R2;R11=R3;
P1=R2;P2=R3;C1=4.7*n;C2=C1;

%A=(1/R2)*(R2+R5)/(R3+P2);


P2_x=(0:5:10*1000);
for i=1:length(P2_x)
K_previsto(i)=P2_x(i)*(1/R2)*(R2+R5)/(R3+P2_x(i));
end

plot(P2_x, K_previsto), hold on
plot(P2vector,Kvector,'ko')





