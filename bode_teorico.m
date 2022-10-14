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

% limites bodeplot
limites = {2*pi*400, 2*pi*21000};

%%  1.5 - Teórica
K = 1;
w0 = 1/sqrt(C1*C2*R6*R11);
Q = 1;

d  = [1 -R3/(P2+R3)*(1+R5/R2)*(1/(R6*C1)) R5/R2*(1/(R6*R11*C1*C2))];

n1 = [P2/(R3+P2)*(1+R5/R2) 0 0];
T1 = tf(n1, d);

n2 = [-1/(R6*C1)*P2/(R3+P2)*(1+R5/R2) 0];
T2 = tf(n2, d);

n3 = 1/(R6*C1*R11*C2)*P2/(R3+P2)*(1+R5/R2);
T3 = tf(n3, d);

%% 1.5 - Valores experimentais

freqs = [500	1000	1750	1900	2000	3800	4000	7000	7600	10000	15000	20000];

%T1
ganhos_db_v1 = 2*[-14.01754585	-10.80482725	-6.397050291	-5.658002232	-5.125281065	-0.069579783	0.260317867	0.260317867	0.604087841	0.184909637	-0.051118655	0.260317867];

%T2
ganhos_db_v2 = 2*[-8.785740809	-5.767948749	-2.856688261	-2.27891877	-2.200515773	0.46591201	0.172725321	-1.968676559	-2.144803328	-3.485453046	-5.701065935	-6.771449726];

%T3
ganhos_db_v3 = 2*[0.108562977	0.108562977	0.409136623	0.715514928	0.489246286	0.361844799	0.139419397	-4.336233792	-5.311326322	-7.358566081	-10.30614152	-12.20909478];


%% 1.5 - Gráficos 
%T1
[mag_t1, phase, w_t1] = bode(T1,limites);
freq_t1 = w_t1/(2*pi);
figure;
semilogx(freqs, ganhos_db_v1, '*');
hold on;
semilogx(freq_t1, mag2db(squeeze(mag_t1)), 'r');
title("KHN - |T1|");
legend("Pontos Experimentais","Curva Teórica", 'Location', 'southeast');

%T2
[mag_t2, phase, w_t2] = bode(T2,limites);
freq_t2 = w_t2/(2*pi);
figure;
semilogx(freqs, ganhos_db_v2, '*');
hold on;
semilogx(freq_t2, mag2db(squeeze(mag_t2)), 'r');
title("KHN - |T2|");
legend("Pontos Experimentais","Curva Teórica", 'Location', 'southeast');

%T3
[mag_t3, phase, w_t3] = bode(T3,limites);
freq_t3 = w_t3/(2*pi);
figure;
semilogx(freqs, ganhos_db_v3, '*');
hold on;
semilogx(freq_t3, mag2db(squeeze(mag_t3)), 'r');
title("KHN - |T3|");
legend("Pontos Experimentais","Curva Teórica", 'Location', 'southwest');


%%  1.6 - Teórica
G = -1;
Q = 1;
w0 = 1/sqrt(C1*C2*R4*R11);
K= R4/P2;

d = [1 w0/Q -G*(w0)^2];

%T1
n1 = [-K*w0 0];
T1 = tf(n1, d);

%T2
n2 = K*(w0)^2;
T2 = tf(n2, d);

%T3
n3 = G*K*(w0)^2; 
T3 = tf(n3, d);

%% 1.6 - Valores experimentais

freqs = [500	1000	1750	2000	4000	7500	8000	10000	15000	20000];

%T1
ganhos_db_v1 = 2*[-9.240749272	-6.197079891	-3.41884408	-2.765533382	-0.39978056	-2.472380896	-3.079915577	-3.786479045	-6.197079891	-7.344080184];

%T2
ganhos_db_v2 = 2*[-0.10707666	-0.10707666	0.209932043	0.505366866	-0.070419449	-5.288343753	-5.790455315	-7.61684213	-11.30706509	-12.19369315];

%T3
ganhos_db_v3 = 2*[-0.215582064	-0.300277397	0.109154056	0.109154056	-0.223977655	-5.374960484	-5.689878211	-7.648175524	-10.38665735	-11.39735908];

%% 1.6 - Gráficos 
%T1
[mag_t1, phase, w_t1] = bode(T1,limites);
freq_t1 = w_t1/(2*pi);
figure;
semilogx(freqs, ganhos_db_v1, '*');
hold on;
semilogx(freq_t1, mag2db(squeeze(mag_t1)), 'r');
title("TT - |T1|");
legend("Pontos Experimentais","Curva Teórica", 'Location', 'southeast');

%T2
[mag_t2, phase, w_t2] = bode(T2,limites);
freq_t2 = w_t2/(2*pi);
figure;
semilogx(freqs, ganhos_db_v2, '*');
hold on;
semilogx(freq_t2, mag2db(squeeze(mag_t2)), 'r');
title("TT - |T2|");
legend("Pontos Experimentais","Curva Teórica", 'Location', 'southeast');

%T3
[mag_t3, phase, w_t3] = bode(T3,limites);
freq_t3 = w_t3/(2*pi);
figure;
semilogx(freqs, ganhos_db_v3, '*');
hold on;
semilogx(freq_t3, mag2db(squeeze(mag_t3)), 'r');
title("TT - |T3|");
legend("Pontos Experimentais","Curva Teórica", 'Location', 'southwest');

%% filtro butterworth
% limites bodeplot
limites = {2*pi*400, 2*pi*21000};
%teoricos
w0 = 2*pi*1000;
B  = 2*pi*250;
w1 = (sqrt(B^2 + 4*w0^2) - B)/2;
w2 = B + w1;
gain = 15.85;

d = [1 B (w0)^2];
n = gain*[B 0];
T = tf(n, d);

%experimentais
freqs = [200 400	500	800	850	900	965	1050	1100	1500	2000	3000];

%T1
ganhos_db_v = [-0.340665127	6.48307755	9.201759968	19.1587731	20.75577122	22.82658306	23.79328298	22.74054472	21.21395681	13.24906618	8.493486898	4.436976652];

%T1
[mag_t, phase, w_t1] = bode(T,limites);
freq_t = w_t1/(2*pi);
figure;
semilogx(freqs, ganhos_db_v, '*');
hold on;
semilogx(freq_t, mag2db(squeeze(mag_t)), 'r');
title("Butterworth");
legend("Pontos Experimentais","Curva Teórica", 'Location', 'southeast');


