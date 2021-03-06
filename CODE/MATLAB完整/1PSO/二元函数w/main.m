%% 清空环境
clc 
clear all

%%  绘制目标函数曲线
figure
[x,y] = meshgrid(-5:0.1:5,-5:0.1:5); %二维网格
z = x.^2 + y.^2 - 10*cos(2*pi*x) - 10*cos(2*pi*y) + 20;
mesh(x,y,z)
hold on

%% 参数初始化
c1 = 1.49445;
c2 = 1.49445;

w_start = 0.9;
w_end = 0.4;

maxgen = 1000; %进化次数
sizepop = 100; %种群规模

Vmax = 1;%速度最大值
Vmin = -1;

popmax = 5;  %根据x范围设置一致
popmin = -5;

%% 产生初始化粒子和速度
for i = 1:sizepop
    % 随机产生一个种群
    pop(i,:) = 5*rand(1,2);%初始种群，保持范围一致，由于是二元函数，所以随机产生的是两组
    V(i,:) = rand(1,2);%初始化速度，两组
    %计算适应度
    fitness(i) = fun(pop(i,:));  %适应度
end

%% 5 个体极值和群体极值
[bestfitness bestindex] = max(fitness);
zbest = pop(bestindex,:);%全局最佳
gbest = pop;%个体最佳
fitnessgbest = fitness;%个体最佳适应度
fitnesszbest = bestfitness;%全局最佳适应度

%% 6 迭代寻优
for i = 1:maxgen
    w = (w_start - w_end)*((maxgen-i)/maxgen)+ w_end ;
    
    for j = 1:sizepop
        %速度更新公式
        V(j,:) = w*V(j,:) + c1*rand*(gbest(j,:) - pop(j,:)) + c2*rand*(zbest -pop(j,:));
        V(j,find(V(j,:)>Vmax)) = Vmax;%边界约束
        V(j,find(V(j,:)<Vmin)) = Vmin;
        
        %种群更新
        pop(j,:) = pop(j,:) + V(j,:);
        pop(j,find(pop(j,:)>popmax)) = popmax;
        pop(j,find(pop(j,:)<popmin)) = popmin;
        
        %适应度值更新
        fitness(j) = fun(pop(j,:));
    end
    
    for j = 1:sizepop
        %个体最优更新
        if fitness(j) > fitnessgbest(j)
            gbest(j,:) = pop(j,:);
            fitnessgbest(j) = fitness(j);
        end
        
        %群体最优更新
        if fitness(j) > fitnesszbest
            zbest = pop(j,:);
            fitnesszbest = fitness(j);
        end
    end
    result(i) = fitnesszbest;
end

%% 7 输出结果并绘图
[fitnesszbest, zbest]
plot3(zbest(1),zbest(2),fitnesszbest,'bo','linewidth',1.5)

figure
plot(result)
title('最优个体适应度','fontsize',12);
xlabel('进化代数','fontsize',12); 
ylabel('适应度','fontsize',12);
        

