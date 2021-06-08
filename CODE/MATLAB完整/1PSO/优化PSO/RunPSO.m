clc;clear;close all;

Dim = 10;      %维度
index=6;      %测试函数索引

c1 = 1.4;
c2 = 1.4;

maxgen = 1000;    %进化次数
sizepop = 20;   %种群规模


popmax = 600;
popmin = -600;


Vmax = 1;
Vmin = -1;


w_start = 0.9;
w_end = 0.4;

record=zeros(1,maxgen);
%% 产生初始粒子和速度
for i = 1:sizepop
    % 随机产生一个种群
    pop(i,:) = (popmax-popmin)*rand(1,Dim)+popmin;    %初始种群
    V(i,:) = (Vmax-Vmin)*rand(1,Dim)+Vmin;       %初始化速度
    % 计算适应度
    fitness(i) = fun(pop(i,:),index);   %计算适应度
end
%% 个体极值和群体极值
[bestfitness bestindex] = min(fitness); %bestindex:全局最优粒子索引
gbest = pop(bestindex,:);   %全局最佳位置
pbest = pop;    %个体最佳
fitnesspbest = fitness;   %个体最佳适应度值
fitnessgbest = bestfitness;   %全局最佳适应度值
%% 迭代寻优
for i = 1:maxgen       %代数更迭
    w = (w_start - w_end)*((maxgen-i)/maxgen)+ w_end ;
    for j = 1:sizepop  %遍历个体
        % 速度更新
        V(j,:) = w*V(j,:) + c1*rand*(pbest(j,:) - pop(j,:)) + c2*rand*(gbest - pop(j,:));
        %速度边界处理
        V(j,find(V(j,:)>Vmax)) = Vmax;
        V(j,find(V(j,:)<Vmin)) = Vmin;
        
        % 种群更新
        pop(j,:) = pop(j,:) + V(j,:);
        %位置边界处理
        pop(j,find(pop(j,:)>popmax)) = popmax;
        pop(j,find(pop(j,:)<popmin)) = popmin;
        
        % 适应度值更新
        fitness(j) = fun(pop(j,:),index);
    end
    
    for j = 1:sizepop
        % 个体最优更新
        if fitness(j) < fitnesspbest(j)
            pbest(j,:) = pop(j,:);
            fitnesspbest(j) = fitness(j);
        end
        % 群体最优更新
        if fitness(j) < fitnessgbest
            gbest = pop(j,:);
            fitnessgbest = fitness(j);
        end
    end
    record(1,i)=fitnessgbest;
    fprintf('%d      %f\n',i,fitnessgbest);  %输出结果
    
    % 收敛动图绘制存储
    plot(pop(:,1),pop(:,2),'*b')
    axis([popmin popmax popmin popmax])
    pause(0.1)
    x1=xlabel('x1');
    x2=ylabel('x2');
    title(['进化次数=' num2str(i)]);
    drawnow;
    frame = getframe(1);
    im = frame2im(frame);
    [A,map] = rgb2ind(im,256);
    if i == 1
        imwrite(A,map,'D:\LiuYi\Matlab Project\test\1PSO\3demo\标准PSO.gif','gif','LoopCount',Inf,'DelayTime',0.1);
    else
        imwrite(A,map,'D:\LiuYi\Matlab Project\test\1PSO\3demo\标准PSO.gif','gif','WriteMode','append','DelayTime',0.1);
    end
end
%% 适应度值变化绘图
plot(record);
xlabel('gen');
ylabel('fitness');