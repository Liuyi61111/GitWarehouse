%% һԪ�������Ż� y = sin(10 * pi *x) ./ x
% 1.ѧϰʹ������Ӧ����Ȩ�ء���Linear decreasing inertia weight (LDIW) strategy��3.1��
%   
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
c1 = 		;
c2 =        ;


w_start =        ;  %Ȩ��
w_end   =        ;

maxgen = 	; %��������
sizepop = 	; %��Ⱥ��ģ

Vmax =      ;%�ٶ����ֵ
Vmin =      ;

popmax = 	;%λ�ñ߽�
popmin = 	;%����x��Χ����õ�
%% 4 ������ʼ�����Ӻ��ٶ�
for i = 1:sizepop
    % �������һ����Ⱥ
    pop(i,:) =      ;  %��Χ��x��Χ����һ��
    V(i,:) =        ;  %��ʼ���ٶȣ��붨����ٶ����ֵ����Сֵһ��
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
    w =                       ;%Linear decreasing inertia weight (LDIW) strategy
    for j = 1:sizepop
        %�ٶȸ��¹�ʽ
        V(j,:) =                                                ;
        
        V(j,find(V(j,:)>Vmax)) = Vmax;%�߽�Լ��
        V(j,find(V(j,:)<Vmin)) = Vmin;
        
        %��Ⱥ����
        pop(j,:) = pop(j,:) + V(j,:);
        pop(j,find(pop(j,:)>popmax)) = popmax;
        pop(j,find(pop(j,:)<popmin)) = popmin;
        
        %��Ӧ��ֵ����
        fitness(j) =            ;
    end
    %����λ��ȫ�����£�����������Ӧ��ֵȫ������
    
    for j = 1:sizepop
        %�������Ÿ���
        %������������һ�ν��жԱȺ͸���
        if                                 %if the fitness value is better than p_best_j
            pbest(j,:) = pop(j,:);
            fitnesspbest(j) = fitness(j);
        end 
            %���¾ֲ����Ž�
        
        %Ⱥ�����Ÿ���
        if                                  %if the fitness value is better than g_best_j
            gbest = pop(j,:);
            fitnessgbest = fitness(j);
        end
    end
    result(i) = 	;output
       
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
        



        

