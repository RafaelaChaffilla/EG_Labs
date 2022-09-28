%-Neste ficheiro obtemos os diagramas de bode esperado sobrepostos
%pelos
%pontos experimentais e, para além disso, calculamos os valores
%experimentais de K, wp e Q para P2=10k;

clear all
clc

k=1000;
n=10^-9;
R1=51*k;
R2=100*k;
R3=10*k;
R4=R3;
R5=R2;
R6=R3;
R7=1000*k;
R8=R2;
R9=R1;
R10=R2;
R11=R3;
P1=R2;
P2=R3;
C1=4.7*n;
C2=C1;
A=(1/R2)*(R2+R5)/(R3+P2);

K=1/P2*sqrt(R2*R4*R11*C2/(R5*C1))

disp 'Valores das resistência prontos...'

%%
close all

den= [1 1/(C1*R6) R5/(C1*C2*R2*R4*R11)];
num1= [-1/(C1*P2) 0];
num2= [1/(C1*C2*R11*P2)];
num3=-R5/R2*num2;

T1=tf(num1,den);
T2=tf(num2,den);
T3=tf(num3,den);


opts = bodeoptions('cstprefs');
opts.XLim=[300 40*10^5];
opts2=opts;
opts2.YLim=[-50 5];

disp 'Aguarda leitura do EXCEL'



%%
[w,amp_div]=BodeExperimental(T1,'TT.xlsx',1,opts2); %passa-banda
%%
[~,amp_div1k]=BodeExperimental(T2,'TT.xlsx',2,opts); %-passa baixo
%%
[~,amp_div2k]=BodeExperimental(T3,'TT.xlsx',3,opts); %-passa baixo em oposiçao de fase
%%
%-Agora aqui estima-se Q e wp a partir de T1
%cftool
load('TTFitP210k.mat');
disp 'a entrar no ciclo'
w2=(1000:10:260000);
  for i=1:length(w2)
      VectorFit(i)=TTFitP210k(w2(i));
  end
disp 'A desenhar'
figure()
semilogx(w2,VectorFit,'r'), hold on
axis([300,40*10^5,-30,10])
semilogx(w,amp_div,'ko'), hold off
axis([300,40*10^5,-30,10])
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
%w_p=22700;
%Q=1.1860;

%-E agora estimamos k a partir de T2 e de T3
%-Tratamento de T2 para estimar k2
k2=10^(amp_div1k(1)/20)
%k=0.9341;
%-Tratamento de T3 para estimar k2
k3=10^(amp_div2k(1)/20)
%k=0.9556;
disp 'Terminado'
