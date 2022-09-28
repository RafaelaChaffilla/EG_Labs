close all; clear all; clc

filename='lab2.xlsx'; %-leitura dos dados do ficheiro excel
sheet=3;
xlRange = 'B5:B254';
time = xlsread(filename,sheet,xlRange);
xlRange = 'C5:C254';
A = xlsread(filename,sheet,xlRange);
xlRange = 'D5:D254';
v0 = xlsread(filename,sheet,xlRange);
disp 'terminada a leitura'
%%
j=1;
%-Deteccao dos instantes em que se inicia a variacao em A
for i=1:length(time)-1
    if abs(A(i)-A(i+1))>2
        index(j)=i;
        v0_1(j)=v0(i);
        j=j+1;
    end  
end

%-Daqui resultam quatro variacoes mas temos de descartar a ultima
index=index(1:3);
v0_1=v0_1(1:3);
%tempo de inicio da variacao
t_delta=time(index);

%Procurar agora quando e que v0 estabiliza
j=1;
for i=1:length(index)
    index(end+1)=length(time)-1;
    for k=index(i):index(i+1)
        %-Estabiliza quando varia menos que 1%
        if abs(v0(k+1)-v0(k))<0.01*abs(v0(k)) && abs(v0(k)-v0(k-1))<0.01*abs(v0(k))
            index_t_e(j)=k;
            t_e(j)=time(k);
            j=j+1;
        end
    end
end
indices = TiraRepetidos (index_t_e,20);%-tempos em que v0 estabilizou
%-tensao de saida estabilizada e tempo correspondente
for i=1:length(indices)
v0_2(i)=v0(indices(i));
tempos(i)=time(indices(i));
end

Vector_ts=tempos-t_delta'; %-tempos de estabelecimento
%Estimativa de Ts como a media
Ts_exp=mean(Vector_ts)*10^6 %em us
%-Utilizacao de Ts_exp para estimar SR_exp
delta_v0=abs(v0_2-v0_1);
Delta_v0_max=mean(delta_v0);%-media das variacoes maximas de saida
%-SR_exp em volt/us
SR_exp=Delta_v0_max/Ts_exp

%-Erros relativos para Ts_exp e SR_exp
Ts_teo=6.25 %us
SR_teo=0.5 %volt/us
e_Ts=abs(Ts_teo-Ts_exp)/abs(Ts_teo)*100
e_SR=abs(SR_teo-SR_exp)/abs(SR_teo)*100


%-Guardar resultados num ficheiro .txt
fileID = fopen('ResultadosPonto6.txt','wt');
fprintf(fileID,'Tempo de estabelecimento: %8.3f us\n',Ts_exp);
fprintf(fileID,'Slew Rate: %8.3f \n',SR_exp);
fprintf(fileID,'Erro relativo do Tempo de estabelecimento: %8.3f %% \n',e_Ts);
fprintf(fileID,'Erro relativo do Slew Rate: %8.3f %% \n',e_SR);
fclose(fileID);
