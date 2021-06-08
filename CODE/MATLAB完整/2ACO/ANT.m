%% 问题
%  旅行商问题（TSP）问题，在20个城市之间使用蚁群算法找到最短路径
%%
clear;
clc;
%%
% 程序运行计时开始
t0 = clock;
%导入数据
citys=[5.326,2.558;
   4.276,3.452; 
   4.819,2.624; 
   3.165,2.457;
   0.915,3.921;
   4.637,6.026; 
   1.524,2.261;
   3.447,2.111;
   3.548,3.665; 
   2.649,2.556;
   4.399,1.194;
   4.660,2.949; 
   1.479,4.440; 
   5.036,0.244;
   2.830,3.140;
   1.072,3.454;
   5.845,6.203;
   0.194,1.767;
   1.660,2.395;
   2.682,6.072];%20个城市经纬度
%--------------------------------------------------------------------------
%% TSP问题计算城市间相互距离
n = size(citys,1); %size(A,n)返回A的行或列数
                    %size（A）返回一个行向量 [r,s] = size(A),r得到A的行数，s得到A的列数
                    %[A,2],获取矩阵的行数和列数
D = zeros(n,n); %记录城市距离矩阵，tabu list

for i = 1:n
    for j = 1:n
            D(i,j) = sqrt(sum((citys(i,:) - citys(j,:)).^2));%两矩阵相减，各位平方，求和，开根求距离
    end    
end
%--------------------------------------------------------------------------
%% 初始化参数
m = 75;                              % 蚂蚁数量
alpha = 1;                           % 信息素重要程度因子
beta = 5;                            % 启发函数重要程度因子
vol = 0.2;                           % 信息持久度；（1-vol）信息素蒸发量
Q = 10;                              % 常系数
Heu_F = 1./D;                        % visibility
Tau = ones(n,n);                     % 信息素矩阵
Table = zeros(m,n);                  % 路径记录表
iter = 1;                            % 迭代次数初值
iter_max = 100;                      % 最大迭代次数 
Route_best = zeros(iter_max,n);      % 各代最佳路径       
Length_best = zeros(iter_max,1);     % 各代最佳路径的长度  
Length_ave = zeros(iter_max,1);      % 各代路径的平均长度  
Limit_iter = 0;                      % 程序收敛时迭代次数
%-------------------------------------------------------------------------
%% 迭代寻找最佳路径
while iter <= iter_max
    % 随机产生各个蚂蚁的起点城市
      start = zeros(m,1);
      for i = 1:m
          temp = randperm(n);      %把1到n这些数随机打乱得到的一个数字序列
          start(i) = temp(1);
      end
      Table(:,1) = start; %赋值每个蚂蚁的初始城市
      citys_index = 1:n;  %城市索引取出来

     %逐个蚂蚁路径选择
      for i = 1:m          %蚂蚁数
         % 逐个城市路径选择
         for j = 2:n
             has_visited = Table(i,1:(j - 1));           % 已访问的城市集合(禁忌表)
             allow_index = ~ismember(citys_index,has_visited);  %没有访问过的城市取出来
                                                                %ismember(a,b)看矩阵a中的数是不是矩阵b中的成员，是的话结果返回1，不是返回0
             allow = citys_index(allow_index);  % 待访问的城市集合
             P = allow;
             % 计算城市间转移概率
             for k = 1:length(allow)
                 P(k) = Tau(has_visited(end),allow(k))^alpha * Heu_F(has_visited(end),allow(k))^beta;
             end
             P = P/sum(P);
             % 轮盘赌法选择下一个访问城市
            Pc = cumsum(P);  
            target_index = find(Pc >= rand);%返回向量中非零元素的位置
            target = allow(target_index(1));
            Table(i,j) = target;
         end
      end
      
      % 计算iter代各个蚂蚁的走的路径距离
      Length = zeros(m,1);
      for i = 1:m
          Route = Table(i,:);
          for j = 1:(n - 1)
              Length(i) = Length(i) + D(Route(j),Route(j + 1));
          end
          Length(i) = Length(i) + D(Route(n),Route(1));
      end
      
      % 计算最短路径距离及平均距离
      if iter == 1
          [min_Length,min_index] = min(Length);
          Length_best(iter) = min_Length;  
          Length_ave(iter) = mean(Length);
          Route_best(iter,:) = Table(min_index,:);
          Limit_iter = 1; 
          
      else
          [min_Length,min_index] = min(Length);
          Length_best(iter) = min(Length_best(iter - 1),min_Length);  % 比较当前代数与前一代的距离
          Length_ave(iter) = mean(Length);
          if Length_best(iter) == min_Length   % 当前代就是最短路径
              Route_best(iter,:) = Table(min_index,:);
              Limit_iter = iter; 
          else                            % 上一代是最短路径
              Route_best(iter,:) = Route_best((iter-1),:);
          end
      end
      
      % 更新信息素
      Delta_Tau = zeros(n,n);
      % 逐个蚂蚁计算
      for i = 1:m
          % 逐个城市计算
          for j = 1:(n - 1)
              Delta_Tau(Table(i,j),Table(i,j+1)) = Delta_Tau(Table(i,j),Table(i,j+1)) + Q/Length(i);%计算第m只蚂蚁在每段路径上留下的delta信息素
                                                  %最开始Delta_Tau是0，iter=2以后开始叠加
          end
          Delta_Tau(Table(i,n),Table(i,1)) = Delta_Tau(Table(i,n),Table(i,1)) + Q/Length(i);%Q/Length(i) 第m只蚂蚁在 这条路径上留下的信息素
		  % 加上最后一个城市到第一个城市的回路
      end
      Tau = vol * Tau + Delta_Tau;
    % 迭代次数加1，清空路径记录表
    iter = iter + 1;
    Table = zeros(m,n);
end
%--------------------------------------------------------------------------
%% 结果显示
[Shortest_Length,index] = min(Length_best);
Shortest_Route = Route_best(index,:);
Time_Cost=etime(clock,t0);
disp(['最短距离:' num2str(Shortest_Length)]);% disp 显示变量 X 的值，而不打印变量名称
                                             %使用 []
                                             %运算符将多个字符向量串联在一起;在同一行上显示多个变量
disp(['最短路径:' num2str([Shortest_Route Shortest_Route(1)])]);
disp(['收敛迭代次数:' num2str(Limit_iter)]);
disp(['程序执行时间:' num2str(Time_Cost) '秒']);
%--------------------------------------------------------------------------
%% 绘图
figure(1)
plot([citys(Shortest_Route,1);citys(Shortest_Route(1),1)],...  %三点省略符为Matlab续行符
     [citys(Shortest_Route,2);citys(Shortest_Route(1),2)],'o-');
grid on    % grid on是打开网格，grid off是关闭网格

for i = 1:size(citys,1)
    text(citys(i,1),citys(i,2),['   ' num2str(i)]);
end

text(citys(Shortest_Route(1),1),citys(Shortest_Route(1),2),'       起点');
text(citys(Shortest_Route(end),1),citys(Shortest_Route(end),2),'       终点');

xlabel('城市位置横坐标')
ylabel('城市位置纵坐标')
title(['ACA最优化路径(最短距离:' num2str(Shortest_Length) ')'])

figure(2)
plot(1:iter_max,Length_best,'b') %plot(X,Y) 创建 Y 中数据对 X 中对应值的二维线图
legend('最短距离')
xlabel('迭代次数')
ylabel('距离')
title('算法收敛轨迹')