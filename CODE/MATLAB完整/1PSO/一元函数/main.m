%% 1 ��ջ���
clc 
clear all

%% 2 ����Ŀ�꺯������
x = 1:0.01:2;
y = sin(10*pi*x)./x; %./����������
figure 
plot(x,y)
hold on

%% 3 ������ʼ��
c1 = 1.49445;
c2 = 1.49445;

w = 0.9;
% ws = 0.9  %��ȫ���������ֲ�����0.9->0.4
% we = 0.4

maxgen = 50; %��������
sizepop = 10; %��Ⱥ��ģ

Vmax = 0.5;%�ٶ����ֵ
Vmin = -0.5

popmax = 2;%λ�ñ߽�
popmin = 1;%����x��Χ���嵽1-2
%% �������÷�Χ
% ������һ��ȡֵ20-40,ʵ����������ڴ����30�����Ӿ͹����ˡ���������Խ�࣬������ΧԽ��Խ�����ҵ�ȫ�����Ž⣬���ǳ�������ʱ��Խ��

% ��������w��������Ⱥ�㷨���������𵽺ܴ����ã�wֵԽ�����ӷ������Խ�����״�ʧ�ֲ�Ѱ����������ȫ����������Խǿ����֮����ֲ�����Խǿ��ȫ������
% ͨ�����������ڵ�����ʼʱ�������������õýϴ�Ȼ���ڵ����������𲽼�С��w��ȡֵ��[0 1]�����wȡ��ֵ����ô����ȡ0.6-0.75.

% һ�������c1= c2=2.0 
% c1 ����������
% c2 ����Ⱥ�徭��

% ���Vmax���䣬ͨ������Ϊûά�仯��Χ��10%-20%
% ����Vmax�����ڷ�ֹ������Χ��������ķ�ɢ��
% Ϊ�������ֲ����ţ���Ҫ�ϴ��Ѱ�Ų��������ڽӽ�����ֵʱ�����ø�С�Ĳ�������á�
%% 4 ������ʼ�����Ӻ��ٶ�
for i = 1:sizepop
    % �������һ����Ⱥ
    pop(i,:) = ( rands(1)+1 )/2 + 1;  %��Χ��x��Χ����һ��
    V(i,:) = 0.5 * rands(1);  %��ʼ���ٶȣ��붨����ٶ����ֵ����Сֵһ��
    %������Ӧ��
    fitness(i) = fun(pop(i,:));
end

%% 5 ���弫ֵ��Ⱥ�弫ֵ
[bestfitness bestindex] = max(fitness)
gbest = pop(bestindex,:)%ȫ�����
pbest = pop;%�������
fitnesspbest = fitness;%���������Ӧ��
fitnessgbest = bestfitness;%ȫ�������Ӧ��

%% 6 ����Ѱ��
for i = 1:maxgen
    
    for j = 1:sizepop
        %�ٶȸ���   

        V(j,:) = w*V(j,:) + c1*rand*(pbest(j,:) - pop(j,:)) + c2*rand*(gbest -pop(j,:));
        
        V(j,find(V(j,:)>Vmax)) = Vmax;%�߽�Լ��
        V(j,find(V(j,:)<Vmin)) = Vmin;
        
        %��Ⱥ����
        pop(j,:) = pop(j,:) + V(j,:);
        pop(j,find(pop(j,:)>popmax)) = popmax;
        pop(j,find(pop(j,:)<popmin)) = popmin;
        
        %��Ӧ��ֵ����
        fitness(j) = fun(pop(j,:));
    end
    %����λ��ȫ�����£�����������Ӧ��ֵȫ������
    
    for j = 1:sizepop
        %�������Ÿ���
        if fitness(j) > fitnesspbest(j)   %������������һ�ν��жԱȺ͸���
            pbest(j,:) = pop(j,:);
            fitnesspbest(j) = fitness(j);
        end
            %���¾ֲ����Ž�
        
        %Ⱥ�����Ÿ���
        if fitness(j) > fitnessgbest
            gbest = pop(j,:);
            fitnessgbest = fitness(j);
        end
    end
    result(i) = fitnessgbest;
       
end

%% 7 ������

[fitnessgbest gbest]

%��ͼ
plot(gbest,fitnessgbest,'r*')%���ҵ��ĵ����Ǻŵ���ʽ������
figure
plot(result)
title('���Ÿ�����Ӧ��','fontsize',12);
xlabel('��������','fontsize',12); 
ylabel('��Ӧ��','fontsize',12);
        



        

