clc;
clear;
close all;

%% 1 Problem Definition

CostFunction = @(x) Sphere(x);        % Cost Function函数句柄，未知数是x，相当于建立了一个函数文件,类似在C语言中的函数定义。该方法在Sphere.m中定义

nVar = 5;             % Number of Decision Variables  

VarSize = [1,   ];   % Decision Variables Matrix Size  

VarMin = -10;         % Decision Variables Lower Bound 函数下限
VarMax = 10;         % Decision Variables Upper Bound  函数上限

%% 2 ABC Settings

MaxIt = 	;              % Maximum Number of Iterations

nPop = 100;               % Population Size (Colony Size)初始雇佣蜂数量

nOnlooker = 	;         % Number of Onlooker Bees 初始观察蜂数量

L = round(0.6*nVar*nPop); % Abandonment Limit Parameter (Trial Limit) round():四舍五入取整，表示蜜源试验次数上限，如果达到此上限，舍弃该蜜源，侦查蜂来做的这一步

a = 1;                    % Acceleration Coefficient Upper Bound 蜜源变换的加速系数的最大值

%% 3 Initialization

% Empty Bee Structure
empty_bee.Position = [];
empty_bee.Cost = [];

% Initialize Population Array
pop = repmat(empty_bee, nPop, 1);

% Initialize Best Solution Ever Found 因为是求函数的最小值，所以预定义最坏适应度是无穷大
BestSol.Cost = inf;    %inf为无穷大量+∞

% Create Initial Population
for i = 1:nPop
    pop(i).Position = unifrnd(VarMin, VarMax, VarSize);%随机生成VarMin到VarMax范围内的 尺寸为 VarSize 的矩阵
    pop(i).Cost = CostFunction(pop(i).Position);
    if pop(i).Cost <= BestSol.Cost
        BestSol = pop(i);
    end
end

% Abandonment Counter
C = zeros(nPop, 1);%%用来记录蜜源的试验限制，达到L次数，就舍弃蜜源，用新的替代这个蜜源

% Array to Hold Best Cost Values
BestCost = zeros(MaxIt, 1);  %%记录迄今为止最好的蜜源的适应度

%% 4 ABC Main Loop

for it = 1:MaxIt
    
% Recruited Bees
    for i = 1:nPop
        
        % Choose k randomly, not equal to i
        K =             ;%生成不包括i的1到10之间的数
        k = K(randi([1 numel(K)]));%从K的数组随机取一个数
        
        % Define Acceleration Coeff.
        phi = a*unifrnd(-1, +1, VarSize);%生成一个1×5的矩阵，数的范围是-1～1
        
        % New Bee Position
        newbee.Position =                                   ;%a矩阵的每一个元素乘以b矩阵对应位置的元素形成的一个新矩阵
        
        % Apply Bounds
        newbee.Position = max(newbee.Position , VarMin);
        newbee.Position = min(newbee.Position , VarMax);

        % Evaluation
        newbee.Cost = CostFunction(newbee.Position);
        
        % Comparision
        if newbee.Cost <= pop(i).Cost
            pop(i) = newbee;
        else
            C(i) =          ;%不好的蜜源，浏览该蜜源次数加一，浏览次数达到L次就舍弃该蜜源
        end
        
%         temp = pop(i).Position;
%         x(i) = temp(1);%pop(i).Position,Empty Bee i 的位置
%         y(i) = temp(2);%pop(i).Position，Empty Bee i 的位置
        
    end
%% 画图    
%     subplot(1,2,1)
%     scatter(x,y);
%     axis([-10 10 -10 10])
%     text(-9,5,int2str(it),'color','m','FontSize',10)
%     text(-9,7,'empleyed bee update food source','color','m','FontSize',10) 
%     drawnow;
%     pause(0.5)
%%    
% Calculate Fitness Values and Selection Probabilities
    F = zeros(nPop, 1);                %以下是公式去计算蜜源的选择概率
    MeanCost = mean([pop.Cost]);
    for i = 1:nPop
        F(i) = exp(-pop(i).Cost/MeanCost); % Convert Cost to Fitness
    end
    P = F/sum(F);                      %蜜源的选择概率
    
% Onlooker Bees
    for m = 1:nOnlooker
        
        % Select Source Site          根据选择概率 进行轮盘赌选择一个蜜源
        i = RouletteWheelSelection( );
        
        % Choose k randomly, not equal to i
        K = [1:i-1 i+1:nPop];
        k = K(randi([1 numel(K)]));
        
        % Define Acceleration Coeff.定义加速系数
        phi = a*unifrnd(-1, +1, VarSize);
        
        % New Bee Position  
        newbee.Position =                                    ;
        
        % Apply Bounds
        newbee.Position = max(newbee.Position, VarMin);
        newbee.Position = min(newbee.Position, VarMax);
        
        % Evaluation
        newbee.Cost = CostFunction(newbee.Position);
        
        % Comparision
        if newbee.Cost <= pop(i).Cost
            pop(i) = newbee;
        else
            C(i) = C(i) + 1;
        end
%% 画图        
%         temp = pop(i).Position;
%         x(i) = temp(1);%pop(i).Position,Empty Bee i 的位置
%         y(i) = temp(2);%pop(i).Position，Empty Bee i 的位置
%%        
    end
%% 画图    
%     subplot(1,2,1)
%     scatter(x,y);
%     axis([-10 10 -10 10])
%     text(-9,5,int2str(it),'color','b','FontSize',10)
%     text(-9,7,'onlooker bee update food source','color','b','FontSize',10) 
%     drawnow;
%     pause(0.5)
    
%% Scout Bees
    for i = 1:nPop
        if C(i) >= L %判断蜜源是否达到试验上限，达到了就丢弃蜜源
            pop(i).Position = unifrnd(VarMin, VarMax, VarSize);%重新建立一个蜜源替代原来的蜜源
            pop(i).Cost = CostFunction(pop(i).Position);
            C(i) = 0;
        end
    end
    
    % Update Best Solution Ever Found
    for i = 1:nPop
        if pop(i).Cost <= BestSol.Cost
            BestSol = pop(i);%寻找最佳蜜源
        end
    end
    
    % Store Best Cost Ever Found
    BestCost(it) = BestSol.Cost;%存储最佳蜜源
    
    % Display Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
%% 画图    
%     subplot(1,2,2)
%     semilogy(BestCost, 'LineWidth', 2);
%     xlabel('Iteration');
%     ylabel('Best Cost');

end
    
%% Results

BestSol.Position  %打印解的结果
                  %适应度值变换曲线图
plot(BestCost,'LineWidth',2);
semilogy(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;



