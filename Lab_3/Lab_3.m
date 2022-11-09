clear all;
close all;
%% First Parameters Configuration
sampleTime = 0.1;
% Configuration of FIR
FIR_Standard = [0       ;
                0.2     ;
                1       ;
                0.3     ;
                -0.4    ;
                -0.1    ;
                0.1     ;
                -0.05   ;
                -0.02   ;
                -0.01   ];
FIR = FIR_Standard;

% Configuration of Eco Canceler
mu = 0.03;

% Configuration of the Emitter
Emitter.Up      = 0.5;
Emitter.Amp     = 0;

% Configuration of the Reciever
Reciever.Up     = 0.5;
Reciever.Amp    = 0;
G               = 0;

%% 5.1

% For dead Reciever and Emitter
Reciever.Amp    = 0;
Emitter.Amp     = 0;
holder = sim('modelo_completo1');

figure();
stairs(holder.Emmiter_Data.time,holder.Emmiter_Data.signals.values);
xlim([0 5]);
% xticks(0:1:15);
ylabel("Amplitude da Saída [V]");
xlabel("Tempo [s]");

figure();
stairs(holder.Reciever_Data.time,holder.Reciever_Data.signals.values);
xlim([0 5]);
% xticks(0:1:15);
ylabel("Amplitude da Saída [V]");
xlabel("Tempo [s]");

figure();
stairs(holder.Emmiter_Data1.time,holder.Emmiter_Data1.signals.values);
xlim([0 5]);
% xticks(0:1:15);
ylabel("Amplitude da Entrada [V]");
xlabel("Tempo [s]");

figure();
stairs(holder.Receiver_Data2.time,holder.Receiver_Data2.signals.values);
xlim([0 5]);
% xticks(0:1:15);
ylabel("Amplitude da Entrada [V]");
xlabel("Tempo [s]");

% For live Reciever and Emitter

Reciever.Amp    = 1;
Emitter.Amp     = 1;

holder = sim('modelo_completo1');

figure();
stairs(holder.Emmiter_Data.time,holder.Emmiter_Data.signals.values);
xlim([0 5]);
ylim([min(holder.Emmiter_Data.signals.values)-0.2 max(holder.Emmiter_Data.signals.values)+0.2]);
ylabel("Amplitude da Saída [V]");
xlabel("Tempo [s]");

figure();
stairs(holder.Reciever_Data.time,holder.Reciever_Data.signals.values);
xlim([0 5]);
ylim([min(holder.Reciever_Data.signals.values)-0.2 max(holder.Reciever_Data.signals.values)+0.2]);
ylabel("Amplitude da Saída [V]");
xlabel("Tempo [s]");

figure();
stairs(holder.Emmiter_Data1.time,holder.Emmiter_Data1.signals.values);
xlim([0 5]);
ylim([-0.2 1.2]);
ylabel("Amplitude da Entrada [V]");
xlabel("Tempo [s]");

figure();
stairs(holder.Receiver_Data2.time,holder.Receiver_Data2.signals.values);
xlim([0 5]);
ylim([-0.2 1.2]);
ylabel("Amplitude da Entrada [V]");
xlabel("Tempo [s]");

%% 5.2
% sampleTime = 1;
% Emitter.Up      = 1;
% 
% holder = sim('testehibrido');
% 
% figure();
% stairs(holder.testehibrido.time,holder.testehibrido.signals.values);
% ylim([-0.2 1.8]);
% xticks(0:1:15);
% ylabel("Saída do Híbrido");
% xlabel("Amostra");
% sampleTime = 0.03;

%% 5.3
Reciever.Amp    = 1;
Emitter.Amp     = 1;
FIR = zeros(1,10);
FIR(5)=1;
mu = 0.03;

holder = sim('modelo_completo1'); 

%erle a=0.975
figure();
hold on;
erle = holder.ERLE_Data1.signals.values;
stairs(holder.ERLE_Data1.time, erle); 
ylim([0 max(erle)+15]);
xlabel("Tempo [s]");
ylabel("ERLE [dB]");

%coeficientes
figure();
hold on; 
coeficientes = holder.Cancelador_Eco_Data.signals.values;
for a=1:size(coeficientes,2)
    stairs(holder.Cancelador_Eco_Data.time, coeficientes(:,a));
    xlim([0 45]);
end   
xlabel("Tempo [s]");
ylabel("Coeficientes");
legend("c_0", "c_1","c_2", "c_3","c_4", "c_5","c_6", "c_7","c_8", "c_9",...                
       "c_{10}", "c_{11}","c_{12}", "c_{13}", "c_{14}", "c_{15}", 'Location', 'eastoutside');

%% 5.4.1
FIR=FIR_Standard;
sampleTime= 0.1;
mu_chioser = [0.03 0.003];
G=0;
for i=1:size(mu_chioser,2)
    mu = mu_chioser(i);
    holder = sim('modelo_completo1'); 
    
    %erle a=0.975
    figure();
    hold on;
    erle = holder.ERLE_Data1.signals.values;
    stairs(holder.ERLE_Data1.time, erle); 
    ylim([0 max(erle)+20]);
    xlabel("Tempo [s]");
    ylabel("ERLE [dB]");
    
    %coeficientes
    figure();
    hold on; 
    coeficientes = holder.Cancelador_Eco_Data.signals.values;
    for a=1:size(coeficientes,2)
        stairs(holder.Cancelador_Eco_Data.time, coeficientes(:,a));
        xlim([0 30*2*(i-1)+30]);
    end   
    xlabel("Tempo [s]");
    ylabel("Coeficientes");
    legend("c_0", "c_1","c_2", "c_3","c_4", "c_5","c_6", "c_7","c_8", "c_9",...                
           "c_{10}", "c_{11}","c_{12}", "c_{13}", "c_{14}", "c_{15}", 'Location', 'eastoutside');
end

% miu máximo
mu_chioser = [0.053:0.0005:0.07];
G=0;
for i=1:size(mu_chioser,2)
    mu = mu_chioser(i);
    holder = sim('modelo_completo1'); 
    erle = holder.ERLE_Data1.signals.values;
    erle_max(i) = max(erle);
    if (abs(min(erle)) > max(erle))
       erle_max(i) = min(erle); 
    end
end

figure();
plot(mu_chioser, erle_max); 
xlabel("\mu");
ylabel("Valor para onde tende ERLE [dB]");

mu_chioser = [0.0625 0.063];

for i=1:size(mu_chioser,2)
    mu = mu_chioser(i);
    holder = sim('modelo_completo1'); 
    
    %erle a=0.975
    figure();
    hold on;
    erle = holder.ERLE_Data1.signals.values;
    stairs(holder.ERLE_Data1.time, erle); 
    %ylim([0 max(erle)+20]);
    xlim([0 100]);
    xlabel("Tempo [s]");
    ylabel("ERLE [dB]");
    
    %coeficientes
    figure();
    hold on; 
    coeficientes = holder.Cancelador_Eco_Data.signals.values;
    for a=1:size(coeficientes,2)
        stairs(holder.Cancelador_Eco_Data.time, coeficientes(:,a));
        xlim([0 100+(i-1)*900]);
    end   
    xlabel("Tempo [s]");
    ylabel("Coeficientes");
    legend("c_0", "c_1","c_2", "c_3","c_4", "c_5","c_6", "c_7","c_8", "c_9",...                
           "c_{10}", "c_{11}","c_{12}", "c_{13}", "c_{14}", "c_{15}", 'Location', 'eastoutside');
end

%% 5.4.2

G=0.1;

mu_chioser = [0.03];
for i=1:size(mu_chioser,2)
    mu = mu_chioser(i);
    holder = sim('modelo_completo1'); 
    
    %erle a=0.975
    figure();
    hold on;
    erle = holder.ERLE_Data1.signals.values;
    stairs(holder.ERLE_Data1.time, erle);
    xlim([0 100]);
    xlabel("Tempo [s]");
    ylabel("ERLE [dB]");
    
    %coeficientes
    figure();
    hold on; 
    coeficientes = holder.Cancelador_Eco_Data.signals.values;
    for a=1:size(coeficientes,2)
        stairs(holder.Cancelador_Eco_Data.time, coeficientes(:,a));
        xlim([0 60*2*(i-1)+60]);
    end   
    xlabel("Tempo [s]");
    ylabel("Coeficientes");
    legend("c_0", "c_1","c_2", "c_3","c_4", "c_5","c_6", "c_7","c_8", "c_9",...                
           "c_{10}", "c_{11}","c_{12}", "c_{13}", "c_{14}", "c_{15}", 'Location', 'eastoutside');
end

G=0.4;

mu_chioser = [0.0625];
for i=1:size(mu_chioser,2)
    mu = mu_chioser(i);
    holder = sim('modelo_completo1'); 
    
    %erle a=0.975
    figure();
    hold on;
    erle = holder.ERLE_Data1.signals.values;
    stairs(holder.ERLE_Data1.time, erle);
    xlabel("Tempo [s]");
    ylabel("ERLE [dB]");
    
    %coeficientes
    figure();
    hold on; 
    coeficientes = holder.Cancelador_Eco_Data.signals.values;
    for a=1:size(coeficientes,2)
        stairs(holder.Cancelador_Eco_Data.time, coeficientes(:,a));
%         xlim([0 40*2*(i-1)+40]);
    end   
    xlabel("Tempo [s]");
    ylabel("Coeficientes");
    legend("c_0", "c_1","c_2", "c_3","c_4", "c_5","c_6", "c_7","c_8", "c_9",...                
           "c_{10}", "c_{11}","c_{12}", "c_{13}", "c_{14}", "c_{15}", 'Location', 'eastoutside');
end

%}
