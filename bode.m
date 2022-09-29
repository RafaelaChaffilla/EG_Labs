clear all;
close all;

%Variáveis:

R1 = 51e3; 
R7 = 1e6; 
P1 = 100e3;
R2 = 100e3; 
R8 = 100e3; 
P2 = 10e3;
R3 = 10e3;
R9 = 51e3;
C1 = 4.7e-9;
R4 = 10e3;
R10 = 100e3; 
C2 = 4.7e-9;
R5 = 100e3;
R11 = 10e3; 
R6 = 10e3;
Ampops = 741;

%%  1.6 - Teórica
G = -1;
Q = 1;
w0=1/sqrt(C1*C2*R4*R11);
K= R4/P2;

n1 = [-K*w0 0];
d = [1 w0/Q -G*(w0)^2];

T1 = tf(n1, d);
figure;
bodemag(T1,{1e2,1e5});
title("|T1|");

n2 = K*(w0)^2;
T2 = tf(n2, d);
figure;
bodemag(T2,{1e2,1e5});
title("|T2|");

n3 = G*K*(w0)^2; 
T3 = tf(n3, d);
figure;
bodemag(T3,{1e2,1e5});
title("|T3|");