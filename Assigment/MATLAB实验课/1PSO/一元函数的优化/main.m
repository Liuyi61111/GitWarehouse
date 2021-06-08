%% һԪ�������Ż� y = sin(10 * pi *x) ./ x
% 1.��ȫ����,�ҵ�(0.9525,1.049)���������Ž⣬�������ٴ������Ž⣿��
% 2.���Ȩ�ز���w=0.9.�Ա�ʵ�������ڵڼ���������Ž⣩��
%   �޸�w��ֵ����ʵ��Աȣ�˼��w��ʵ������Ӱ�졣

% ���ѣ�*rands()����[-1,1]֮���������ݣ�rands(1��2)����ֵΪ[-1,1]��һ����������
%      
%% 1 ��ջ���
clc 
clear all

%% 2 ����Ŀ�꺯������
x = 1:0.01:2;
y = sin(10*pi*x)./x;

figure 
plot(x,y)
hold on

%% 3 ������ʼ��
c1 = 
c2 = 

maxgen =      %��������
sizepop =     %��Ⱥ��ģ

Vmax =        %�ٶ����ֵ
Vmin =        %�ٶ���Сֵ

popmin = 
popmax =      %λ�ñ߽�

%% 4 ������ʼ�����Ӻ��ٶ�
for i = 1:sizepop
    % rand �������һ����Ⱥ[ע�ⷶΧ] 
    pop(i,:) =              %�����ʼ��λ��
    V(i,:) =                %�����ʼ���ٶ�
    %������Ӧ��
    
    fitness(i) =            %����������ӵ���Ӧ��
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
        V(j,:) =                      ;          %�ٶȸ��¹�ʽ                                      
        V(j,find(V(j,:)>Vmax)) = Vmax;          %�ٶȱ߽�Լ��
        V(j,find(V(j,:)<Vmin)) = Vmin;
        
        %��Ⱥ����
        pop(j,:) =                           ;   %λ�ø��¹�ʽ
        pop(j,find(pop(j,:)>popmax)) = popmax;  %λ�ñ߽�Լ��
        pop(j,find(pop(j,:)<popmin)) = popmin;
        
        %��Ӧ��ֵ����
        fitness(j) =     ;%����fun����������Ӧ��ֵ
    end
    
    for j = 1:sizepop
        %�������Ÿ���
        %������������һ�ν��жԱȺ͸���
        if                           %if the fitness value is better than p_best_j
            pbest(j,:) = pop(j,:);
            fitnesspbest(j) = fitness(j);
        end
        
        %Ⱥ�����Ÿ���
        if                           %if the fitness value is better than g_best_j
            gbest = pop(j,:);
            fitnessgbest = fitness(j);
        end
    end
    
    result(i) =     ;%Output
end

%% 7 ����������ͼ
[fitnessgbest gbest]
plot(gbest,fitnesszbest,'r*')

figure
plot(result)
title('���Ÿ�����Ӧ��','fontsize',12);
xlabel('��������','fontsize',12); 
ylabel('��Ӧ��','fontsize',12);
        

