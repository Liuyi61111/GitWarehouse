%% ��ջ���
clc 
clear all

%%  ����Ŀ�꺯������
figure
[x,y] = meshgrid(-5:0.1:5,-5:0.1:5); %��ά����
z = x.^2 + y.^2 - 10*cos(2*pi*x) - 10*cos(2*pi*y) + 20;
mesh(x,y,z)
hold on

%% ������ʼ��
c1 = 1.49445;
c2 = 1.49445;

w_start = 0.9;
w_end = 0.4;

maxgen = 1000; %��������
sizepop = 100; %��Ⱥ��ģ

Vmax = 1;%�ٶ����ֵ
Vmin = -1;

popmax = 5;  %����x��Χ����һ��
popmin = -5;

%% ������ʼ�����Ӻ��ٶ�
for i = 1:sizepop
    % �������һ����Ⱥ
    pop(i,:) = 5*rand(1,2);%��ʼ��Ⱥ�����ַ�Χһ�£������Ƕ�Ԫ�������������������������
    V(i,:) = rand(1,2);%��ʼ���ٶȣ�����
    %������Ӧ��
    fitness(i) = fun(pop(i,:));  %��Ӧ��
end

%% 5 ���弫ֵ��Ⱥ�弫ֵ
[bestfitness bestindex] = max(fitness);
zbest = pop(bestindex,:);%ȫ�����
gbest = pop;%�������
fitnessgbest = fitness;%���������Ӧ��
fitnesszbest = bestfitness;%ȫ�������Ӧ��

%% 6 ����Ѱ��
for i = 1:maxgen
    w = (w_start - w_end)*((maxgen-i)/maxgen)+ w_end ;
    
    for j = 1:sizepop
        %�ٶȸ��¹�ʽ
        V(j,:) = w*V(j,:) + c1*rand*(gbest(j,:) - pop(j,:)) + c2*rand*(zbest -pop(j,:));
        V(j,find(V(j,:)>Vmax)) = Vmax;%�߽�Լ��
        V(j,find(V(j,:)<Vmin)) = Vmin;
        
        %��Ⱥ����
        pop(j,:) = pop(j,:) + V(j,:);
        pop(j,find(pop(j,:)>popmax)) = popmax;
        pop(j,find(pop(j,:)<popmin)) = popmin;
        
        %��Ӧ��ֵ����
        fitness(j) = fun(pop(j,:));
    end
    
    for j = 1:sizepop
        %�������Ÿ���
        if fitness(j) > fitnessgbest(j)
            gbest(j,:) = pop(j,:);
            fitnessgbest(j) = fitness(j);
        end
        
        %Ⱥ�����Ÿ���
        if fitness(j) > fitnesszbest
            zbest = pop(j,:);
            fitnesszbest = fitness(j);
        end
    end
    result(i) = fitnesszbest;
end

%% 7 ����������ͼ
[fitnesszbest, zbest]
plot3(zbest(1),zbest(2),fitnesszbest,'bo','linewidth',1.5)

figure
plot(result)
title('���Ÿ�����Ӧ��','fontsize',12);
xlabel('��������','fontsize',12); 
ylabel('��Ӧ��','fontsize',12);
        

