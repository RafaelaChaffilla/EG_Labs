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
limites = {2*pi*50, 2*pi*21000};

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

freqs = [100	200	500	1000	1250	1750	1900	2690	3800	5370	7600	7000	10000	15000	20000];

%T1
ganhos_db_v1 =[-30.16622682	-32.18493054	-28.03509169	-21.60965449	-18.41607609	-12.79410058	-10.68430176	-3.835098907	0.561114013	1.674840474	1.514649999	0.520635734	0.369819275	-0.10223731	0.520635734];

%T2
ganhos_db_v2 = [-30.88676465	-24.73748494	-17.57148162	-11.5358975	-9.398394197	-5.713376523	-5.130807661	-1.847557594	0.243152615	-1.378451412	-4.723290262	-3.937353119	-6.970906092	-11.40213187	-13.54289945];

%T3
ganhos_db_v3 = [0.217125954	0.217125954	0.217125954	0.217125954	0.217125954	0.818273246	0.815050916	1.387506821	0.815050916	-4.073399678	-10.17195491	-8.672467584	-14.71713216	-20.61228304	-24.41818956];


%% 1.5 - Gráficos 
%T1
[mag_t1, phase, w_t1] = bode(T1,limites);
freq_t1 = w_t1/(2*pi);
figure;
semilogx(freqs, ganhos_db_v1, '*');
hold on;
semilogx(freq_t1, mag2db(squeeze(mag_t1)), 'r');
%title("KHN - |T1|");
legend("Pontos Experimentais","Curva Teórica", 'Location', 'southeast');
xlabel("f [Hz]");
ylabel("A [dB]");

%T2
[mag_t2, phase, w_t2] = bode(T2,limites);
freq_t2 = w_t2/(2*pi);
figure;
semilogx(freqs, ganhos_db_v2, '*');
hold on;
semilogx(freq_t2, mag2db(squeeze(mag_t2)), 'r');
%title("KHN - |T2|");
legend("Pontos Experimentais","Curva Teórica", 'Location', 'southeast');
xlabel("f [Hz]");
ylabel("A [dB]");

%T3
[mag_t3, phase, w_t3] = bode(T3,limites);
freq_t3 = w_t3/(2*pi);
figure;
semilogx(freqs, ganhos_db_v3, '*');
hold on;
semilogx(freq_t3, mag2db(squeeze(mag_t3)), 'r');
%title("KHN - |T3|");
legend("Pontos Experimentais","Curva Teórica", 'Location', 'southwest');
xlabel("f [Hz]");
ylabel("A [dB]");

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

freqs = [500	1000	1750	2000	1900	2690	3800	5370	7600	7500	10000	15000	20000];

%T1
ganhos_db_v1 = [-18.48149854	-12.39415978	-5.592663787	-4.291181235	-5.501268965	-2.523726954	-0.263459394	-2.017729067	-4.909648066	-4.944761792	-7.572958089	-12.39839789	-13.52240582];

%T2
ganhos_db_v2 = [-0.214153321	-0.195985814	0.887213173	1.012532541	0.211652856	0.969686984	-0.438633709	-4.508590671	-11.30089383	-10.57668751	-15.23368426	-24.39256871	-28.66492968];

%T3
ganhos_db_v3 = [-0.431164127	-0.600554793	0.846099111	1.431532498	0.138774111	0.755972182	-0.021416363	-4.177385621	-10.43130317	-10.74992097	-15.29635105	-18.95327442	-22.68581302];

%% 1.6 - Gráficos 
limites = {2*pi*400, 2*pi*21000};
%T1
[mag_t1, phase, w_t1] = bode(T1,limites);
freq_t1 = w_t1/(2*pi);
figure;
semilogx(freqs, ganhos_db_v1, '*');
hold on;
semilogx(freq_t1, mag2db(squeeze(mag_t1)), 'r');
%title("TT - |T1|");
legend("Pontos Experimentais","Curva Teórica", 'Location', 'southeast');
xlabel("f [Hz]");
ylabel("A [dB]");

%T2
[mag_t2, phase, w_t2] = bode(T2,limites);
freq_t2 = w_t2/(2*pi);
figure;
semilogx(freqs, ganhos_db_v2, '*');
hold on;
semilogx(freq_t2, mag2db(squeeze(mag_t2)), 'r');
%title("TT - |T2|");
legend("Pontos Experimentais","Curva Teórica", 'Location', 'southeast');
xlabel("f [Hz]");
ylabel("A [dB]");

%T3
[mag_t3, phase, w_t3] = bode(T3,limites);
freq_t3 = w_t3/(2*pi);
figure;
semilogx(freqs, ganhos_db_v3, '*');
hold on;
semilogx(freq_t3, mag2db(squeeze(mag_t3)), 'r');
%title("TT - |T3|");
legend("Pontos Experimentais","Curva Teórica", 'Location', 'southwest');
xlabel("f [Hz]");
ylabel("A [dB]");

%% filtro butterworth
% limites bodeplot
limites = {2*pi*150, 2*pi*5050};
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
figure();
bode(T,limites);
freq_t = w_t1/(2*pi);
figure;
semilogx(freqs, ganhos_db_v, '*');
hold on;
semilogx(freq_t, mag2db(squeeze(mag_t)), 'r');
%title("");
legend("Pontos Experimentais","Curva Teórica", 'Location', 'northeast');
xlabel("f [Hz]");
ylabel("A [dB]");

