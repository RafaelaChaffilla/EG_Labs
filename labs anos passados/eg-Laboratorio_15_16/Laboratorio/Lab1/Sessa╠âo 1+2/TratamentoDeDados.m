clear all
clc

mil=1000;
n=10^-9;
R1=51*mil;
R2=100*mil;
R3=10*mil;
R4=R3;
R5=R2;
R6=R3;
R7=1000*mil;
R8=R2;
R9=R1;
R10=R2;
R11=R3;
P1=R2;
P2=R3;
C1=4.7*n;
C2=C1;
A=(1/R2)*(R2+R5)/(R3+P2);
k=P2*A;

wp=sqrt(R5/(R2*C1*C2*R6*R11))

Q=wp*(C1*R6*R2*(R3+P2))/(R3*(R2+R5))

Q=sqrt(C1*R6*R2*R5/(C2*R11))*(P2+R3)/(R2+R5)/R3


%%
close all

den= [1 A*R3/(C1*R6) R5/(C1*C2*R2*R6*R11)];
num1= [P2*A 0 0];
num2= [-P2*A/(C1*R6) 0];
num3=[P2*A/(C1*C2*R6*R11)];

T1=tf(num1,den);
T2=tf(num2,den);
T3=tf(num3,den);


opts = bodeoptions('cstprefs');
opts.XLim=[0 40*10^20];
opts2=opts;
opts2.YLim=[-50 5];

disp 'Aguarda leitura do EXCEL'

%%
BodeExperimental(T1,'KHN.xlsx',1,opts); 
%%
BodeExperimental(T2,'KHN.xlsx',2,opts2);
%%
BodeExperimental(T3,'KHN.xlsx',3,opts);


%%
%Cáluclo de w0

r=roots(den)


