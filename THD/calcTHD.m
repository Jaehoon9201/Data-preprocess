

clear all; clc;
data=[];
data = csvread('C3VI00001.csv',1);
single_prd = 1/60 * 200000; % sec
timeidx_start = 200; % start index
timeidx_end = timeidx_start+ floor(single_prd) ; % end index. 
data=data(timeidx_start:timeidx_end,2);

data_size = size(data);

YfreqDomain_list=[];   
YfreqDomain=[]; 
FFT_list_data = []; 
THD_list_data= [];  
THD_list=[];  

for i=1:data_size(1,2)    % ���� �����Ϳ� ���� iter ���鼭 THD ���. �� ���Ͽ����� �ϳ��� ����.
    y = data(:,i);
    Fs = length(y);
    
    [YfreqDomain,frequencyRange] = positiveFFT(y,Fs);   % FFT ����
    FFT_list=abs(YfreqDomain);   % FFT ũ�⸸ ���
    YfreqDomain_list=[YfreqDomain_list YfreqDomain];  % Re,Im Domain���� FFT ��� 
    FFT_list_data = [FFT_list_data FFT_list];  % FFT ũ�⸸ ��갪 ����
    
    ysquare=y.^2;    % THD ����ϱ� ���� ����
    y_base_rms=sqrt(sum(ysquare)/Fs);
    baseY=FFT_list(2)/sqrt(2);
    THD_list=sqrt(y_base_rms^2-baseY^2)/baseY*100;   % THD ��� ���� �� �Ҽ��� 4°�ڸ����� ���
    THD_list_data=[THD_list_data THD_list];   % THD ��갪 ����
end

    disp('============= THD =============');
    THD_list_data
    
    x = [0:1:size(FFT_list,1)-1];
    y1 = FFT_list_data(:,1);
    bar(x,y1)
    xlim([0 16]);
    grid on;
    % YfreqDomain_list : FFT ��� Re,Im Domain ��°�
    % FFT_list_data : FFT ��� Absolute �� ���
    % THD_list_data : THD ��� ���ʴ�� ���
