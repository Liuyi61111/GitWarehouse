%%包含变化权重的main
%% 1 清空环境
clc 
clear all

%% 2 绘制目标函数曲线
x = 1:0.01:2;
y = sin(10*pi*x)./x;  %./即除法运算
figure 
plot(x,y)
hold on

%% 3 参数初始化
c1 = 1.49445;
c2 = 1.49445;


w_start = 0.9;  %从全局搜索到局部搜索0.9->0.4
w_end = 0.4;

maxgen = 50; %进化次数
sizepop = 10; %种群规模

Vmax = 0.5;%速度最大值
Vmin = -0.5

popmax = 2;%位置边界
popmin = 1;%根据x范围定义到1-2
%% 参数设置范围
% 种群数量：粒子群算法的最大特点就是速度快，因此初始种群取50-1000都是可以的，虽然初始种群越大收敛性会更好（搜索范围越大，越容易找到全局最优解）但是程序运行时间越长，影响速度；
% 迭代次数：一般取100~4000，太少解不稳定，太多浪费时间。对于复杂问题，进化代数可以相应地提高；
% 惯性权重w：该参数反映了个体历史成绩对现在的影响，一般取0.5~1；w值越大，粒子飞翔幅度越大，容易错失局部寻优能力，而全局搜索能力越强；反之，则局部能力越强，全局弱。通常的做法是在迭代开始时讲惯性因子设置得较大，然后在迭代过程中逐步减小;
% 学习因子c：一般取0~4，此处要根据自变量的取值范围来定，并且学习因子分为个体和群体两种； c1 代表自身经验 ,c2 代表群体经验;
% 位置限制：限制粒子搜索的空间，即自变量的取值范围，对于无约束问题此处可以省略;
% 速度限制：如果粒子飞行速度过快，很可能直接飞过最优解位置，但是如果飞行速度过慢，会使得收敛速度变慢，因此设置合理的速度限制就很有必要了。

%% 4 产生初始化粒子和速度
for i = 1:sizepop
    % 随机产生一个种群
    pop(i,:) = ( rands(1)+1 )/2 + 1;  %范围是x范围保持一致
    V(i,:) = 0.5 * rands(1);  %初始化速度，与定义的速度最大值和最小值一致
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
    w = (w_start - w_end)*((maxgen-i)/maxgen)+ w_end ;
    for j = 1:sizepop
        %速度更新公式
        V(j,:) = w*V(j,:) + c1*rand*(pbest(j,:) - pop(j,:)) + c2*rand*(gbest -pop(j,:));
        
        V(j,find(V(j,:)>Vmax)) = Vmax;%边界约束
        V(j,find(V(j,:)<Vmin)) = Vmin;
        
        %种群更新
        pop(j,:) = pop(j,:) + V(j,:);
        pop(j,find(pop(j,:)>popmax)) = popmax;
        pop(j,find(pop(j,:)<popmin)) = popmin;
        
        %适应度值更新
        fitness(j) = fun(pop(j,:));
    end
    %粒子位置全部更新；各个粒子适应度值全部更新
    
    for j = 1:sizepop
        %个体最优更新
        if fitness(j) > fitnesspbest(j)   %各个粒子与上一次进行对比和更新
            pbest(j,:) = pop(j,:);
            fitnesspbest(j) = fitness(j);
        end
            %更新局部最优解
        
        %群体最优更新
        if fitness(j) > fitnessgbest
            gbest = pop(j,:);
            fitnessgbest = fitness(j);
        end
    end
    result(i) = fitnessgbest;
       
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
        



        

