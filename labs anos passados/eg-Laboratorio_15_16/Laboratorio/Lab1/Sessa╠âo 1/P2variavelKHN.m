

close all
clear all
clc

filename='dados.xlsx';
sheet=4;

%-Estes valores serve para tirar k a partir do T3 nas baixas frequencias

fk=xlsread(filename,sheet,'BP2');
xlRange = 'BP5:BP54';
x = xlsread(filename,sheet,xlRange);
xlRange = 'BR5:BR254';
y = xlsread(filename,sheet,xlRange);
ampk=(max(y)-min(y))/2;
xlRange = 'BQ5:BQ54';
x2 = xlsread(filename,sheet,xlRange);
ampk2=(max(x2)-min(x2))/2;

sheet=5

f2k=xlsread(filename,sheet,'A2');
xlRange = 'A5:A254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'C5:C254';
y = xlsread(filename,sheet,xlRange);
amp2k=(max(y)-min(y))/2;
xlRange = 'B5:B254';
x2 = xlsread(filename,sheet,xlRange);
amp2k2=(max(x2)-min(x2))/2;

disp 'Podes tratar a info'

%-Tratamento de T3 para estimar k

wk=(2*pi)*fk;
w2k=(2*pi)*f2k;
ampk_rel=ampk/ampk2;
amp2k_rel=amp2k/amp2k2;
ampk_div=20*log10(ampk_rel);
amp2k_div=20*log10(amp2k_rel);
k=10^(ampk_div/20)%=0.4773
k2=10^(amp2k_div/20)%=0.3182
disp 'Terminado!'

%-Comportamento das caracteristicas variando k
P2vector=[5000 2000 7600 8300 10^4-872];
Kvector=[k k2 0.353 0.294 0.172];

mil=1000;n=10^-9;
R1=51*mil;R2=100*mil;R3=10*mil;R4=R3;R5=R2;
R6=R3;R7=1000*mil;R8=R2;R9=R1;R10=R2;R11=R3;
P1=R2;C1=4.7*n;C2=C1;

P2_x=(0:5:10*1000);
%-Com divisor de tensão
for i=1:length(P2_x)
K_previsto(i)=P2_x(i)/R2*((P2_x(i)-10*mil)*(R2+R5))/(P2_x(i)*(P2_x(i)-10*mil)-10*mil*R3);
end

% %-Com P2 variavel apenas
% for i=1:length(P2_x)
% K_previsto2(i)=P2_x(i)/R2*(R2+R5)/(P2_x(i)+R3);
% end

plot(P2_x, K_previsto), hold on
%plot(P2_x, K_previsto2), hold on
plot(P2vector,Kvector,'ko')
axis([0,max(P2_x),0,2])
title('Resultados para K');
   xlabel('P_2');
   ylabel('K'); 



%--------------------------------------------------------------------
%--------------------------------------------------------------------
%--------------------------------------------------------------------
%--------------------------------------------------------------------
%--------------------------------------------------------------------
%--------------------------------------------------------------------
%--------------------------------------------------------------------
%--------------------------------------------------------------------

%%
%-agora para estimar Q e wp

close all;
clear all;
clc;
disp 'limpo'

filename='dados.xlsx';
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
disp 'Podes tratar a info'
%-Vamos agora tratar a informação lida

w=(2*pi)*f;%-primeiro queremos fazer um fit a T2 para estimar Q e wp
amp_rel=amp./amp2;
amp_div=20*log10(amp_rel);
disp 'fazer o fit agora'
%cftool
load('KHNFitP25000.mat');
disp 'a entrar no ciclo'
w2=(2*pi*1200:10:2*pi*5000);
  for i=1:length(w2)
      VectorFit(i)=KHNFitP25000(w2(i));
  end
disp 'A desenhar'
figure()
semilogx(w2,VectorFit,'r'), hold on
semilogx(w,amp_div,'ko'), hold off
axis([1700*2*pi,5002*2*pi,-12,-3])
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
%w_p=24010;
%Q=1.9909;

%%
%-agora repetimos o processo de leitura para P2=2000

close all;
clear all;
clc;
disp 'limpo'

filename='dados.xlsx';
sheet=5;

disp 'a ler...'
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

f(1)=xlsread(filename,sheet,'BP2');
xlRange = 'BP5:BP254';
x = xlsread(filename,sheet,xlRange);
xlRange = 'BR5:BR254';
y = xlsread(filename,sheet,xlRange);
amp(1)=(max(y)-min(y))/2;
xlRange = 'BQ5:BQ254';
x2 = xlsread(filename,sheet,xlRange);
amp2(1)=(max(x2)-min(x2))/2;
disp 'Podes tratar a info'
%%
%-Vamos agora tratar a informação lida

w=(2*pi)*f;%-primeiro queremos fazer um fit a T2 para estimar Q e wp
amp_rel=amp./amp2;
amp_div=20*log10(amp_rel);
disp 'fazer o fit agora'
%cftool
%%
load('KHNFitP22000.mat');
disp 'a entrar no ciclo'
w2=(2*pi*1700:10:2*pi*4801);
  for i=1:length(w2)
      VectorFit(i)=KHNFitP22000(w2(i));
  end
disp 'A desenhar'
% figure()
% semilogx(w2,VectorFit,'r'), hold on
% semilogx(w,amp_div,'ko'), hold off
% axis([2*pi*1700,2*pi*5002,-17,-11])
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
%w_p=22781;
%Q=1.1940;



%%
%- agora tratamos a informaçao de ambos os valores de P2
P2vector=[5000 2000 7600 8300 (10^4-872)];
Qvector=[1.9909 1.1940 3.142 4.51 8.32];
wpvector=[24010 22781 23010 22095 23350];

%w_p=24010;
%Q=1.9909;

%w_p=22781;
%Q=1.1940;

mil=1000;n=10^-9;
R1=51*mil;R2=100*mil;R3=10*mil;R4=R3;R5=R2;
R6=R3;R7=1000*mil;R8=R2;R9=R1;R10=R2;R11=R3;
P1=R2;C1=4.7*n;C2=C1;

P2_x=(0:5:10*1000);
%-Com divisor de tensão
for i=1:length(P2_x)
wp_previsto(i)=sqrt(R5/(C1*C2*R2*R6*R11));
end

% %-Com P2 variavel apenas
% for i=1:length(P2_x)
% wp2_previsto(i)=sqrt(R5/(C1*C2*R2*R6*R11));
% end

figure(2)
plot(P2_x, wp_previsto), hold on
%plot(P2_x, wp2_previsto), hold on
plot(P2vector,wpvector,'ko')
axis([0,max(P2_x),0,4*10^4])
title('Resultados para w_p');
   xlabel('P_2');
   ylabel('w_p'); 

%-Com divisor de tensão
for i=1:length(P2_x)
Q_previsto(i)=sqrt(R5/(C1*C2*R2*R6*R11))*C1*R2*R6/(R2+R5)*(10*mil*(P2_x(i)+R3)-P2_x(i))/(10*mil*(R3-P2_x(i)));
end

% %-Com P2 variavel apenas
% for i=1:length(P2_x)
% Q2_previsto(i)=sqrt(C1*R2*R6*R5/(C2*R11))*(P2_x(i)+R3)/((R2+R5)*R3);
% end

figure(3)
plot(P2_x, Q_previsto), hold on
%plot(P2_x, Q2_previsto), hold on
plot(P2vector,Qvector,'ko'), hold on
axis([0,max(P2_x),0,10])
title('Resultados para Q');
   xlabel('P_2');
   ylabel('Q'); 


