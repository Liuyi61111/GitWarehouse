%
% Copyright (c) 2015, Mostapha Kalami Heris & Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "LICENSE" file for license terms.
%
% Project Code: YPEA114
% Project Title: Implementation of Artificial Bee Colony in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Cite as:
% Mostapha Kalami Heris, Artificial Bee Colony in MATLAB (URL: https://yarpiz.com/297/ypea114-artificial-bee-colony), Yarpiz, 2015.
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

clc;
clear;
close all;

%% Problem Definition

CostFunction = @(x) Sphere(x);        % Cost Function���������δ֪����x���൱�ڽ�����һ�������ļ�,������C�����еĺ������塣�÷�����Sphere.m�ж���

nVar = 2;             % Number of Decision Variables ����ά��

VarSize = [1 nVar];   % Decision Variables Matrix Size ����һ������ά�ȴ�С�ľ��� 1 x nVar

VarMin = -10;         % Decision Variables Lower Bound ��������
VarMax = 10;         % Decision Variables Upper Bound  ��������

%% ABC Settings

MaxIt = 200;              % Maximum Number of Iterations

nPop = 100;               % Population Size (Colony Size)��ʼ��Ӷ������

nOnlooker = nPop;         % Number of Onlooker Bees ��ʼ�۲������

L = round(0.6*nVar*nPop); % Abandonment Limit Parameter (Trial Limit) round():��������ȡ������ʾ��Դ����������ޣ�����ﵽ�����ޣ���������Դ��������������һ��

a = 1;                    % Acceleration Coefficient Upper Bound ��Դ�任�ļ���ϵ�������ֵ

%% Initialization

% Empty Bee Structure
empty_bee.Position = [];
empty_bee.Cost = [];

% Initialize Population Array
pop = repmat(empty_bee, nPop, 1);

% Initialize Best Solution Ever Found ��Ϊ����������Сֵ������Ԥ�������Ӧ���������
BestSol.Cost = inf;    %infΪ�������+��

x = [];
% Create Initial Population
for i = 1:nPop
    pop(i).Position = unifrnd(VarMin, VarMax, VarSize);%�������VarMin��VarMax��Χ�ڵ� �ߴ�Ϊ VarSize �ľ���
    pop(i).Cost = CostFunction(pop(i).Position);
    if pop(i).Cost <= BestSol.Cost
        BestSol = pop(i);
    end
end

% Abandonment Counter
C = zeros(nPop, 1);%%������¼��Դ���������ƣ��ﵽL��������������Դ�����µ���������Դ

% Array to Hold Best Cost Values
BestCost = zeros(MaxIt, 1);  %%��¼����Ϊֹ��õ���Դ����Ӧ��

%% ABC Main Loop

for it = 1:MaxIt
    
    % Recruited Bees
    for i = 1:nPop
        
        % Choose k randomly, not equal to i
        K = [1:i-1 i+1:nPop];%���ɲ�����i��1��10֮�����
        k = K(randi([1 numel(K)]));%��K���������ȡһ����
        
        % Define Acceleration Coeff.
        phi = a*unifrnd(-1, +1, VarSize);%����һ��1��5�ľ������ķ�Χ��-1��1
        
        % New Bee Position
        newbee.Position = pop(i).Position+phi.*(pop(i).Position-pop(k).Position);%a�����ÿһ��Ԫ�س���b�����Ӧλ�õ�Ԫ���γɵ�һ���¾���
        
        % Apply Bounds
        newbee.Position = max(newbee.Position, VarMin);
        newbee.Position = min(newbee.Position, VarMax);

        % Evaluation
        newbee.Cost = CostFunction(newbee.Position);
        
        % Comparision
        if newbee.Cost <= pop(i).Cost
            pop(i) = newbee;
        else
            C(i) = C(i)+1;%���õ���Դ���������Դ������һ����������ﵽL�ξ���������Դ
        end
        temp = pop(i).Position;
        x(i) = temp(1);%pop(i).Position,Empty Bee i ��λ��
        y(i) = temp(2);%pop(i).Position��Empty Bee i ��λ��
    end
    subplot(1,2,1)
    scatter(x,y);
    axis([-10 10 -10 10])
    text(-9,5,int2str(it),'color','m','FontSize',15)
    text(-9,7,'empleyed bee update food source','color','m','FontSize',15) 
    drawnow;
    pause(2)
    
    % Calculate Fitness Values and Selection Probabilities
    F = zeros(nPop, 1);%�����ǹ�ʽȥ������Դ��ѡ�����
    MeanCost = mean([pop.Cost]);
    for i = 1:nPop
        F(i) = exp(-pop(i).Cost/MeanCost); % Convert Cost to Fitness
    end
    P = F/sum(F);%��Դ��ѡ�����
    
    % Onlooker Bees
    for m = 1:nOnlooker
        
        % Select Source Site ����ѡ����� �������̶�ѡ��һ����Դ
        i = RouletteWheelSelection(P);
        
        % Choose k randomly, not equal to i
        K = [1:i-1 i+1:nPop];
        k = K(randi([1 numel(K)]));
        
        % Define Acceleration Coeff.�������ϵ��
        phi = a*unifrnd(-1, +1, VarSize);
        
        % New Bee Position��������Դ
        newbee.Position = pop(i).Position+phi.*(pop(i).Position-pop(k).Position);
        
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
        temp = pop(i).Position;
        x(i) = temp(1);%pop(i).Position,Empty Bee i ��λ��
        y(i) = temp(2);%pop(i).Position��Empty Bee i ��λ��
        
    end
    subplot(1,2,1)
    scatter(x,y);
    axis([-10 10 -10 10])
    text(-9,5,int2str(it),'color','m','FontSize',15)
    text(-9,7,'onlooker bee update food source','color','m','FontSize',15) 
    drawnow;
    pause(1)
    
    % Scout Bees
    for i = 1:nPop
        if C(i) >= L %�ж���Դ�Ƿ�ﵽ�������ޣ��ﵽ�˾Ͷ�����Դ
            pop(i).Position = unifrnd(VarMin, VarMax, VarSize);%���½���һ����Դ���ԭ������Դ
            pop(i).Cost = CostFunction(pop(i).Position);
            C(i) = 0;
        end
    end
    
    % Update Best Solution Ever Found
    for i = 1:nPop
        if pop(i).Cost <= BestSol.Cost
            BestSol = pop(i);%Ѱ�������Դ
        end
    end
    
    % Store Best Cost Ever Found
    BestCost(it) = BestSol.Cost;%�洢�����Դ
    
    % Display Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    %% Results
    subplot(1,2,2)
    %figure;
    %plot(BestCost, 'LineWidth', 2);
    semilogy(BestCost, 'LineWidth', 2);
    xlabel('Iteration');
    ylabel('Best Cost');
    %grid on;
    
end
    


