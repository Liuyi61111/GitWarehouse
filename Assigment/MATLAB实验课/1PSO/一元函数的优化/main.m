%% 一元函数的优化 y = sin(10 * pi *x) ./ x
% 1.补全代码,找到(0.9525,1.049)附近的最优解，迭代多少次求最优解？。
% 2.添加权重参数w=0.9.对比实验结果（在第几代求得最优解）。
%   修改w数值进行实验对比，思考w对实验结果的影响。

% 提醒：*rands()生成[-1,1]之间的随机数据；rands(1，2)生成值为[-1,1]的一行两列数据
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
c1 = 
c2 = 

maxgen =      %进化次数
sizepop =     %种群规模

Vmax =        %速度最大值
Vmin =        %速度最小值

popmin = 
popmax =      %位置边界

%% 4 产生初始化粒子和速度
for i = 1:sizepop
    % rand 随机产生一个种群[注意范围] 
    pop(i,:) =              %随机初始化位置
    V(i,:) =                %随机初始化速度
    %计算适应度
    
    fitness(i) =            %计算各个粒子的适应度
end

%% 5 个体极值和群体极值
[bestfitness bestindex] = max(fitness)
gbest = pop(bestindex,:)%全局最佳
pbest = pop;%个体最佳
fitnesspbest = fitness;%个体最佳适应度
fitnessgbest = bestfitness;%全局最佳适应度

%% 6 迭代寻优
for i = 1:maxgen
    for j = 1:sizepop
        %速度更新
        V(j,:) =                      ;          %速度更新公式                                      
        V(j,find(V(j,:)>Vmax)) = Vmax;          %速度边界约束
        V(j,find(V(j,:)<Vmin)) = Vmin;
        
        %种群更新
        pop(j,:) =                           ;   %位置更新公式
        pop(j,find(pop(j,:)>popmax)) = popmax;  %位置边界约束
        pop(j,find(pop(j,:)<popmin)) = popmin;
        
        %适应度值更新
        fitness(j) =     ;%调用fun函数计算适应度值
    end
    
    for j = 1:sizepop
        %个体最优更新
        %各个粒子与上一次进行对比和更新
        if                           %if the fitness value is better than p_best_j
            pbest(j,:) = pop(j,:);
            fitnesspbest(j) = fitness(j);
        end
        
        %群体最优更新
        if                           %if the fitness value is better than g_best_j
            gbest = pop(j,:);
            fitnessgbest = fitness(j);
        end
    end
    
    result(i) =     ;%Output
end

%% 7 输出结果并绘图
[fitnessgbest gbest]
plot(gbest,fitnesszbest,'r*')

figure
plot(result)
title('最优个体适应度','fontsize',12);
xlabel('进化代数','fontsize',12); 
ylabel('适应度','fontsize',12);
        

