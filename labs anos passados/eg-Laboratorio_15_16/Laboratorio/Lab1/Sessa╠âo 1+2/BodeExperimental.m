function [w,amp_div]=BodeExperimental(T1,filename,sheet,opts)

close all
clc


%Bode do T1
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


w=(2*pi)*f;
amp_div=20*log10(amp./amp2)
bodemag(T1,opts), hold on
plot(w,amp_div,'ko');
disp 'Terminado!'

end

