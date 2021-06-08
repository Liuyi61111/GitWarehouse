%% 1 清空环境
clc 
clear all

%% 2 绘制目标函数曲线
x = 1:0.01:2;
y = sin(10*pi*x)./x; %./即除法运算
figure 
plot(x,y)
hold on

%% 3 参数初始化
c1 = 1.49445;
c2 = 1.49445;

w = 0.9;
% ws = 0.9  %从全局搜索到局部搜索0.9->0.4
% we = 0.4

maxgen = 50; %进化次数
sizepop = 10; %种群规模

Vmax = 0.5;%速度最大值
Vmin = -0.5

popmax = 2;%位置边界
popmin = 1;%根据x范围定义到1-2
%% 参数设置范围
% 粒子数一般取值20-40,实验表明，对于大多数30个粒子就够用了。粒子数量越多，搜索范围越大，越容易找到全局最优解，但是程序运行时间越长

% 惯性因子w对于粒子群算法的收敛性起到很大作用，w值越大，粒子飞翔幅度越大，容易错失局部寻优能力，而全局搜索能力越强；反之，则局部能力越强，全局弱。
% 通常的做法是在迭代开始时讲惯性因子设置得较大，然后在迭代过程中逐步减小。w的取值是[0 1]，如果w取定值，那么建议取0.6-0.75.

% 一般情况下c1= c2=2.0 
% c1 代表自身经验
% c2 代表群体经验

% 如果Vmax不变，通常设置为没维变化范围的10%-20%
% 参数Vmax有利于防止搜索范围毫无意义的发散。
% 为了跳出局部最优，需要较大的寻优补偿，而在接近最优值时，采用更小的步长会更好。
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
    
    for j = 1:sizepop
        %速度更新   

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
        



        

