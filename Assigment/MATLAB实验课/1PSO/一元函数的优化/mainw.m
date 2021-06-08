%% 一元函数的优化 y = sin(10 * pi *x) ./ x
% 1.学习使用自适应惯性权重——Linear decreasing inertia weight (LDIW) strategy（3.1）
%   
% 
%% 1 清空环境
clc 
clear all

%% 2 绘制目标函数曲线
x = 1:0.01:2;
y = sin(10*pi*x)./x; 
figure 
plot(x,y)
hold on

%% 3 参数初始化
c1 = 		;
c2 =        ;


w_start =        ;  %权重
w_end   =        ;

maxgen = 	; %进化次数
sizepop = 	; %种群规模

Vmax =      ;%速度最大值
Vmin =      ;

popmax = 	;%位置边界
popmin = 	;%根据x范围定义得到
%% 4 产生初始化粒子和速度
for i = 1:sizepop
    % 随机产生一个种群
    pop(i,:) =      ;  %范围是x范围保持一致
    V(i,:) =        ;  %初始化速度，与定义的速度最大值和最小值一致
    %计算适应度
    fitness(i) = fun(pop(i,:));
end

%% 5 个体极值和群体极值
[bestfitness bestindex] = max(fitness)
gbest = pop(bestindex,:)%全局最佳
pbest = pop;%个体最佳
fitnesspbest = fitness;%个体最佳适应度
fitnessgbest = bestfitness;%全局最佳适应度

%% 6 迭代寻优
for i = 1:maxgen
    w =                       ;%Linear decreasing inertia weight (LDIW) strategy
    for j = 1:sizepop
        %速度更新公式
        V(j,:) =                                                ;
        
        V(j,find(V(j,:)>Vmax)) = Vmax;%边界约束
        V(j,find(V(j,:)<Vmin)) = Vmin;
        
        %种群更新
        pop(j,:) = pop(j,:) + V(j,:);
        pop(j,find(pop(j,:)>popmax)) = popmax;
        pop(j,find(pop(j,:)<popmin)) = popmin;
        
        %适应度值更新
        fitness(j) =            ;
    end
    %粒子位置全部更新；各个粒子适应度值全部更新
    
    for j = 1:sizepop
        %个体最优更新
        %各个粒子与上一次进行对比和更新
        if                                 %if the fitness value is better than p_best_j
            pbest(j,:) = pop(j,:);
            fitnesspbest(j) = fitness(j);
        end 
            %更新局部最优解
        
        %群体最优更新
        if                                  %if the fitness value is better than g_best_j
            gbest = pop(j,:);
            fitnessgbest = fitness(j);
        end
    end
    result(i) = 	;output
       
end

%% 7 输出结果

[fitnessgbest gbest]

%绘图
plot(gbest,fitnessgbest,'r*')%把找到的点以星号的形式表达出来
figure
plot(result)
title('最优个体适应度','fontsize',12);
xlabel('进化代数','fontsize',12); 
ylabel('适应度','fontsize',12);
        



        

