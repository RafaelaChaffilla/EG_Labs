

close all;
clear all;
clc;
disp 'limpo'
%-Nesta primeira seccao tiramos k, wp e Q para P2=5000

filename='TT.xlsx';
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

f(6)=xlsread(filename,sheet,'BE2');
xlRange = 'BE5:BE254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'BG5:BG254';
y = xlsread(filename,sheet,xlRange);
amp(6)=(max(y)-min(y))/2;
xlRange = 'BF5:BF254';
x2 = xlsread(filename,sheet,xlRange);
amp2(6)=(max(x2)-min(x2))/2;

f(7)=xlsread(filename,sheet,'BP2');
xlRange = 'BP5:BP254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'BR5:BR254';
y = xlsread(filename,sheet,xlRange);
amp(7)=(max(y)-min(y))/2;
xlRange = 'BQ5:BQ254';
x2 = xlsread(filename,sheet,xlRange);
amp2(7)=(max(x2)-min(x2))/2;

f(8)=xlsread(filename,sheet,'CA2');
xlRange = 'CA5:CA254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'CC5:CC254';
y = xlsread(filename,sheet,xlRange);
amp(8)=(max(y)-min(y))/2;
xlRange = 'CB5:CB254';
x2 = xlsread(filename,sheet,xlRange);
amp2(8)=(max(x2)-min(x2))/2;

f(9)=xlsread(filename,sheet,'CL2');
xlRange = 'CL5:CL254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'CN5:CN254';
y = xlsread(filename,sheet,xlRange);
amp(9)=(max(y)-min(y))/2;
xlRange = 'CM5:CM254';
x2 = xlsread(filename,sheet,xlRange);
amp2(9)=(max(x2)-min(x2))/2;

f1k=xlsread(filename,sheet,'CW2'); %-T2
xlRange = 'CW5:CW254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'CY5:CY254';
y = xlsread(filename,sheet,xlRange);
amp1k=(max(y)-min(y))/2;
xlRange = 'CX5:CX254';
x2 = xlsread(filename,sheet,xlRange);
amp1k2=(max(x2)-min(x2))/2;


f2k=xlsread(filename,sheet,'DH2'); %-T3
xlRange = 'DH5:DH254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'DJ5:DJ254';
y = xlsread(filename,sheet,xlRange);
amp2k=(max(y)-min(y))/2;
xlRange = 'DI5:DI254';
x2 = xlsread(filename,sheet,xlRange);
amp2k2=(max(x2)-min(x2))/2;


disp 'Podes tratar a info'

%-Vamos agora tratar a informação lida

w=(2*pi)*f;%-primeiro queremos fazer um fit a T1 para estimar Q e wp
amp_rel=amp./amp2;
amp_div=20*log10(amp_rel);
%figure()
%semilogx(w,amp_div,'ko');
%axis([300,40*10^5,-50,10])
disp 'fazer o fit agora'
%cftool
load('TTFitP25000.mat');
disp 'a entrar no ciclo'
w2=(1000:10:140000);
  for i=1:length(w2)
      VectorFit(i)=TTFitP25000(w2(i));
  end
disp 'A desenhar'
figure()
semilogx(w2,VectorFit,'r'), hold on
axis([300,40*10^5,-12,7])
semilogx(w,amp_div,'ko'), hold off
axis([300,40*10^5,-12,7])
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
%w_p=22840;
%Q=1.1810;

%-Tratamento de T2 para estimar k2
w1k=(2*pi)*f1k;
amp1k_rel=amp1k/amp1k2;
amp1k_div=20*log10(amp1k_rel);
k2=10^(amp1k_div/20)
%k=1.9556;
%-Tratamento de T3 para estimar k2
w2k=(2*pi)*f2k;
amp2k_rel=amp2k/amp2k2;
amp2k_div=20*log10(amp2k_rel);
k3=10^(amp2k_div/20)
%k=2.1333;
disp 'Terminado!'























%%
%-Agora repete-se o processo todo para P2=1k

%close all;
clear all;
clc;
disp 'limpo'

filename='TT.xlsx';
sheet=5;

disp 'a ler...'

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

f(6)=xlsread(filename,sheet,'BE2');
xlRange = 'BE5:BE254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'BG5:BG254';
y = xlsread(filename,sheet,xlRange);
amp(6)=(max(y)-min(y))/2;
xlRange = 'BF5:BF254';
x2 = xlsread(filename,sheet,xlRange);
amp2(6)=(max(x2)-min(x2))/2;

f(7)=xlsread(filename,sheet,'BP2');
xlRange = 'BP5:BP254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'BR5:BR254';
y = xlsread(filename,sheet,xlRange);
amp(7)=(max(y)-min(y))/2;
xlRange = 'BQ5:BQ254';
x2 = xlsread(filename,sheet,xlRange);
amp2(7)=(max(x2)-min(x2))/2;

f(1)=xlsread(filename,sheet,'CA2');
xlRange = 'CA5:CA254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'CC5:CC254';
y = xlsread(filename,sheet,xlRange);
amp(1)=(max(y)-min(y))/2;
xlRange = 'CB5:CB254';
x2 = xlsread(filename,sheet,xlRange);
amp2(1)=(max(x2)-min(x2))/2;

f(2)=xlsread(filename,sheet,'CL2');
xlRange = 'CL5:CL254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'CN5:CN254';
y = xlsread(filename,sheet,xlRange);
amp(2)=(max(y)-min(y))/2;
xlRange = 'CM5:CM254';
x2 = xlsread(filename,sheet,xlRange);
amp2(2)=(max(x2)-min(x2))/2;

%------------------------------
%------------------------------

f1k=xlsread(filename,sheet,'A2'); %-T2
xlRange = 'A5:A254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'C5:C254';
y = xlsread(filename,sheet,xlRange);
amp1k=(max(y)-min(y))/2;
xlRange = 'B5:B254';
x2 = xlsread(filename,sheet,xlRange);
amp1k2=(max(x2)-min(x2))/2;


f2k=xlsread(filename,sheet,'M2'); %-T3
xlRange = 'M5:M254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'O5:O254';
y = xlsread(filename,sheet,xlRange);
amp2k=(max(y)-min(y))/2;
xlRange = 'N5:N254';
x2 = xlsread(filename,sheet,xlRange);
amp2k2=(max(x2)-min(x2))/2;


disp 'Podes tratar a info'

%-Vamos agora tratar a informação lida
w=(2*pi)*f;%-primeiro queremos fazer um fit a T1 para estimar Q e wp
amp_rel=amp./amp2;
amp_div=20*log10(amp_rel);
disp 'fazer o fit agora'
%cftool
load('TTFitP21k.mat');
disp 'a entrar no ciclo'
w2=(8000:10:51000);
  for i=1:length(w2)
      VectorFit(i)=TTFitP21k(w2(i));
  end
disp 'A desenhar'
figure()
semilogx(w2,VectorFit,'r'), hold on
axis([1000,60*10^4,10,22])
semilogx(w,amp_div,'ko'), hold off
axis([1000,60*10^4,10,22])
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
%w_p=22370;
%Q=1.1975;

%-Tratamento de T2 para estimar k2
w1k=(2*pi)*f1k;
amp1k_rel=amp1k/amp1k2;
amp1k_div=20*log10(amp1k_rel);
k2=10^(amp1k_div/20)
%k=10.2326;
%-Tratamento de T3 para estimar k2
w2k=(2*pi)*f2k;
amp2k_rel=amp2k/amp2k2;
amp2k_div=20*log10(amp2k_rel);
k3=10^(amp2k_div/20)
%k=10.2326;
disp 'Terminado!'

































%%
%-Agora repete-se o processo todo para P2=0.5k

%close all;
clear all;
clc;
disp 'limpo'

filename='TT.xlsx';
sheet=6;

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

f(6)=xlsread(filename,sheet,'BE2');
xlRange = 'BE5:BE254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'BG5:BG254';
y = xlsread(filename,sheet,xlRange);
amp(6)=(max(y)-min(y))/2;
xlRange = 'BF5:BF254';
x2 = xlsread(filename,sheet,xlRange);
amp2(6)=(max(x2)-min(x2))/2;



%------------------------------
%------------------------------

f1k=xlsread(filename,sheet,'BP2'); %-T2
xlRange = 'BP5:BP254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'BR5:BR254';
y = xlsread(filename,sheet,xlRange);
amp1k=(max(y)-min(y))/2;
xlRange = 'BQ5:BQ254';
x2 = xlsread(filename,sheet,xlRange);
amp1k2=(max(x2)-min(x2))/2;


f2k=xlsread(filename,sheet,'CA2'); %-T3
xlRange = 'CA5:CA254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'CC5:CC254';
y = xlsread(filename,sheet,xlRange);
amp2k=(max(y)-min(y))/2;
xlRange = 'CB5:CB254';
x2 = xlsread(filename,sheet,xlRange);
amp2k2=(max(x2)-min(x2))/2;


disp 'Podes tratar a info'

%-Vamos agora tratar a informação lida
w=(2*pi)*f;%-primeiro queremos fazer um fit a T1 para estimar Q e wp
amp_rel=amp./amp2;
amp_div=20*log10(amp_rel);
disp 'fazer o fit agora'
%cftool
load('TTFitP2500.mat');
disp 'a entrar no ciclo'
w2=(8000:10:51000);
  for i=1:length(w2)
      VectorFit(i)=TTFitP2500(w2(i));
  end
disp 'A desenhar'
figure()
semilogx(w2,VectorFit,'r'), hold on
axis([1000,60*10^4,19,26])
semilogx(w,amp_div,'ko'), hold off
axis([1000,60*10^4,19,26])
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
%w_p=21300;
%Q=1.2007;

%-Tratamento de T2 para estimar k2
w1k=(2*pi)*f1k;
amp1k_rel=amp1k/amp1k2;
amp1k_div=20*log10(amp1k_rel);
k2=10^(amp1k_div/20)
%k=20.4878;
%-Tratamento de T3 para estimar k2
w2k=(2*pi)*f2k;
amp2k_rel=amp2k/amp2k2;
amp2k_div=20*log10(amp2k_rel);
k3=10^(amp2k_div/20)
%k=20;
disp 'Terminado!'




















































%%
%-Comportamento das caracteristicas variando P2

%close all

P2vector=[10000 5000 1000 500];
K2vector=[0.9341 1.9556 10.2326 20.4878];
K3vector=[0.9556 2.1333 10.2326 20];
wpvector=[22700 22840 22370 21300];
Qvector=[1.1860 1.1810 1.1975 1.2007];

%w_p=2270;
%Q=1.1860;
%k=0.9341;
%k=0.9556;

%w_p=22840;
%Q=1.1810;
%k=1.9556;
%k=2.1333;

%w_p=22370;
%Q=1.1975;
%k=10.2326;
%k=10.2326;

%w_p=21300;
%Q=1.2007;
%k=20.4878;
%k=20;


mil=1000;n=10^-9;
R1=51*mil;R2=100*mil;R3=10*mil;R4=R3;R5=R2;
R6=R3;R7=1000*mil;R8=R2;R9=R1;R10=R2;R11=R3;
P1=R2;P2=R3;C1=4.7*n;C2=C1;




P2_x=(0:5:12*1000);
for i=1:length(P2_x)
K_previsto(i)=1/P2_x(i)*sqrt(R2*R4*R11*C2/(R5*C1));
wp_previsto(i)=sqrt(R5/(R2*R4*R11*C1*C2));
Q_previsto(i)=R6*C1*wp_previsto(i);
end

figure()
plot(P2_x, K_previsto), hold on
axis([0 12000 0.5 30]);
plot(P2vector,K2vector,'ko'), hold off
   title('Resultados de K para T2');
   xlabel('P_2');
   ylabel('K');   
figure()
plot(P2_x, K_previsto), hold on
axis([0 12000 0.5 30]);
plot(P2vector,K3vector,'ko'), hold off
   title('Resultados de K para T3');
   xlabel('P_2');
   ylabel('K');   
   figure()
plot(P2_x, wp_previsto), hold on
axis([0 12000 10000 40000]);
plot(P2vector,wpvector,'ko'), hold off
   title('Resultados de w_p');
   xlabel('P_2');
   ylabel('w_p');   
figure()
plot(P2_x, Q_previsto), hold on
axis([0 12000 0 5]);
plot(P2vector,Qvector,'ko'), hold off
   title('Resultados de Q');
   xlabel('P_2');
   ylabel('Q');   






