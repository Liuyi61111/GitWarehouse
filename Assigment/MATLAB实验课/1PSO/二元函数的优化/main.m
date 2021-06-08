%% 1 清空环境
clc 
clear all

%%  2 绘制目标函数曲线
figure
[x,y] = meshgrid(-5:0.1:5,-5:0.1:5);          
z =                                    ;%求解函数
mesh(x,y,z)
hold on

%% 3 参数初始化
c1 =  ;
c2 =  ;

w_start =  ;
w_end =    ;

maxgen =     ; %进化次数
sizepop =    ; %种群规模

Vmax =   ;%速度最大值
Vmin =   ;

popmax =  ;  
popmin =  ;%根据x范围设置一致

%% 4 产生初始化粒子和速度
for i = 1:sizepop
    % 随机产生一个种群
    pop(i,:) = 5*rands(1,2);%初始种群，随机产生两维的粒子信息  
    %*rands()生成[-1,1]之间的随机数据；rands(1，2)生成值为[-1,1]的一行两列数据
    V(i,:) =                ;%初始化速度
    %计算适应度
    fitness(i) = fun(pop(i,:));  %适应度
end

%% 5 个体极值和群体极值
[bestfitness bestindex] = max(fitness);
gbest = pop(bestindex,:);%全局最佳
pbest = pop;%个体最佳
fitnesspbest = fitness;%个体最佳适应度
fitnessgbest = bestfitness;%全局最佳适应度

%% 6 迭代寻优
for i = 1:maxgen
    w =                                   ;   %Linear decreasing inertia weight (LDIW) strategy
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
        fitness(j) =      ;%调用fun函数计算适应度值
    end
    
    for j = 1:sizepop
        %个体最优更新
        if fitness(j) > fitnesspbest(j)
            pbest(j,:) = pop(j,:);
            fitnesspbest(j) = fitness(j);
        end
        
        %群体最优更新
        if fitness(j) > fitnessgbest
            gbest = pop(j,:);
            fitnessgbest = fitness(j);
        end
    end
    
    result(i) =    ;%输出
    

end

%% 7 输出结果并绘图
[fitnessgbest, gbest]

plot3(gbest(1),gbest(2),fitnessgbest,'bo','linewidth',1.5)

figure
plot(result)
title('最优个体适应度','fontsize',12);
xlabel('进化代数','fontsize',12); 
ylabel('适应度','fontsize',12);
        

