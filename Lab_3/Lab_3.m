%% First Parameters Configuration

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

holder = sim('modelo_completo');

figure();

figure();


% For live Reciever and Emitter

Reciever.Amp    = 1;
Emitter.Amp     = 1;

holder = sim('modelo_completo');

figure();

figure();

%% 5.2

Emitter.Up      = 1;

holder = sim('modelo_completo');

figure();


%% 5.3

Emitter.Up   = 0.5;
FIR          = [0;
                0;
                0;
                1;
                0;
                0;
                0;
                0;
                0;
                0];
mu_chioser    = 0.03;

%% 5.4.1

for i=1:size(mu_chioser,2)
    holder = sim('modelo_completo');  
    
end
