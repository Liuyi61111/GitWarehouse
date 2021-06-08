%% 蚁群算法学习

clc;
clear all;    %清屏清除工作区
close all;

%% 取得要处理的城市的坐标,作出初始图
%position=load('景区经纬度.txt');
%这句可以读入所需要处理的数据，以下采用的是随机产生的坐标信息
t0=clock;

N=30;  %设置点数,后面其实有个n和它是一样的，为了理解我都留着

for i = 1 : N                           

    x(i) = rand * 100 ;                %生成正态分布的随机坐标点  
    y(i) = rand * 100 ;        %x当作近经度，y当作纬度
    
    scatter(x(i),y(i),'b');            %画出散点图
   hold on
   text(x(i)+1,y(i)+1,num2str(i))     %用text做好标记，
end

citys=[x;y]';
xlabel('经度');       %横坐标
ylabel('纬度');       %纵坐标
title('TSP蚁群算法优化');    %图片标题
grid on

%% 计算各个城市之间的距离

n = size(citys,1);
D = zeros(n,n);
for i = 1:n
    for j = 1:n
        if i ~= j
            D(i,j) = sqrt(sum((citys(i,:) - citys(j,:)).^2)); %矩阵里元素各自平方后求和
            %S(i,j) = sqrt((x(i)-x(j))^2 + (y(i)-y(j))^2);  %距离公式
        else
            D(i,j) = eps;      %这里不是零主要是为了之后去的取倒数，对角矩阵值浮点相对精度
        end
    end    
end

%% 种群初始化，参数的设置
m = 75;                              % 蚂蚁数量
alpha = 1;                           % 信息素重要程度因子
beta = 5;                            % 启发函数重要程度因子
vol = 0.2;                           % 信息素挥发(volatilization)因子
Q = 10;                              % 常系数
Heu_F = 1./D;                        % 启发函数(距离的倒数)
Tau = ones(n,n);                     % 信息素矩阵
Table = zeros(m,n);                  % 路径记录表（蚂蚁的数量是行数，列数是城市的数量）
%iter = 1;                            % 迭代次数初值
iter_max = 100;                      % 最大迭代次数 
Route_best = zeros(iter_max,n);      % 各代最佳路径（每一次迭代后的最佳路线）    
Length_best = zeros(iter_max,1);     % 各代最佳路径的长度  
Length_ave = zeros(iter_max,1);      % 各代路径的平均长度  

%% 迭代寻找最佳路径
for iter = 1:iter_max    %迭代开始，用for不用再设置加一（原程序是while）
    % 随机产生各个蚂蚁的起点城市（原程序）
      %start = zeros(m,1);
      %for i = 1:m
       %   temp = randperm(n);  %这里产生的是n以内的一个序列
        %  start(i) = temp(1);  %取了这个序列的第一个值，随机值
      %end
      for i=1:m
      Table(i,1) = unidrnd(n);  %这个直接产生的就是n以内的随机值
      end
      
      % 构建解空间
      citys_index = 1:n;
      
      % 逐个蚂蚁选择
      for i = 1:m 
          
          % 逐个城市路径选择
         for j = 2:n
             
             %table是路径记录表，每次j之前的城市都是被选择过的
             has_visited = Table(i,1:(j - 1));    % 已访问的城市集合(禁忌表)
             
             allow_index = ~ismember(citys_index,has_visited);    
             %citys_index中有元素属于禁忌表中元素的时候取1，取反后变成0,产生的是逻辑数组
             
             allow = citys_index(allow_index);  % 剩下待访问的城市集合
             P = allow;
             % 计算城市间转移概率
             for k = 1:length(allow)
                 P(k) = Tau(has_visited(end),allow(k))^alpha * Heu_F(has_visited(end),allow(k))^beta;
                 %Heu_F是距离的倒数矩阵，所以说越远概率就会越低
             end
             P = P/sum(P);
             % 轮盘赌法选择下一个访问城市
            Pc = cumsum(P);     %累加函数，把前几个累加到1
            target_index = find(Pc >= rand);
            target = allow(target_index(1));
            %这里和遗传算法不一样,没有采用二分法          
            
            Table(i,j) = target;
         end
      end
           
%% 首先记录上一次迭代之后的最佳路线放在第一个位置(类似一个学习的效果)
    
    if iter>=2
      Table(1,:) = Route_best(iter-1,:);      
    end 
      %% 计算各个蚂蚁的路径距离
      Length = zeros(m,1);
      for i = 1:m
          Route = Table(i,:); %取出一条路径
          
          %for循环累加后是第一个点———》最后一个点之间的距离
          for j = 1:(n - 1)
              Length(i) = Length(i) + D(Route(j),Route(j + 1));
          end
          %加上最后一个点回到起点的距离
          Length(i) = Length(i) + D(Route(n),Route(1));
      end
      
      %% 计算最短路径距离及平均距离(这是原程序的代码，感觉冗长。而且我们一般不把判断和选择放在一起)
     % if iter == 1
          
          %这部分其实和之前说过的遗传算法best函数的做法类似，先假定第一次产生的就是最佳
          %找到最短距离的值的大小和位置
      %    [min_Length,min_index] = min(Length);
      %    Length_best(iter) = min_Length;  %最佳值先记录下这个最小值
      %    Length_ave(iter) = mean(Length); %最佳平均值先记录下来这次迭代的平均长度
      %    Route_best(iter,:) = Table(min_index,:);  %记录下这条最优路线
       %   Limit_iter = 1; 
          
     % else
     %     [min_Length,min_index] = min(Length); %找出最小值和最小值的位置
      %    Length_best(iter) = min(Length_best(iter - 1),min_Length);
         %这个最小值和上个最小值比较，记录最小的那个
      %    Length_ave(iter) = mean(Length);   %求出平均值
          
          %如果下一次迭代值比之前的小，则记录下这条路线，终止迭代次数加一
      %    if Length_best(iter) == min_Length   
        %      Route_best(iter,:) = Table(min_index,:);
        %      Limit_iter = Limit_iter+1; 
        %  else
              %否则的话路线记录的还是上一条
        %      Route_best(iter,:) = Route_best((iter-1),:);
        %  end
      % end
      [min_Length,min_index] = min(Length);      %找到最短距离的值的大小和位置
      Length_best(iter,:)= min_Length;           %此次迭代的路线最小值记录
      Route_best(iter,:) = Table(min_index,:);   %此次迭代的路线最小值记录
      Length_ave(iter) = mean(Length);       %此次迭代的路线平均值记录
      
      %% 更新信息素
      Delta_Tau = zeros(n,n);
      % 逐个蚂蚁计算
      for i = 1:m
          % 逐个城市计算
          for j = 1:(n - 1)
              Delta_Tau(Table(i,j),Table(i,j+1)) = Delta_Tau(Table(i,j),Table(i,j+1)) + Q/Length(i);
              %这里可以理解成每只蚂蚁带着等量Q的信息素，均匀撒在路线上 
          end
          %路线最后一个点和起点的信息素
          Delta_Tau(Table(i,n),Table(i,1)) = Delta_Tau(Table(i,n),Table(i,1)) + Q/Length(i);
      end
      Tau = (1-vol)* Tau + Delta_Tau;   %信息素挥发一部分再加上增加的
    % 迭代次数加1，清空路径记录表
    %iter = iter + 1;
    Table = zeros(m,n);  %清空路线表
end

%% 命令窗口的结果显示
[Shortest_Length,index] = min(Length_best);   %找到每次迭代之后记录下来中最小值里面的最小值
Shortest_Route = Route_best(index,:);
Time_Cost=etime(clock,t0);   %调用windows系统的时钟进行时间差计算
disp(['环游城市的最短距离:' num2str(Shortest_Length)]);
disp(['最短路径:' num2str([Shortest_Route Shortest_Route(1)])]);
%disp(['收敛迭代次数:' num2str(Limit_iter)]);
disp(['程序执行时间:' num2str(Time_Cost) '秒']);

%% 绘图
plot([citys(Shortest_Route,1);citys(Shortest_Route(1),1)],...  %三点省略符为Matlab续行符
     [citys(Shortest_Route,2);citys(Shortest_Route(1),2)],'bo-');
%注意最后还要加上起点
text(citys(Shortest_Route(1),1),citys(Shortest_Route(1),2),'       起点');
text(citys(Shortest_Route(end),1),citys(Shortest_Route(end),2),'       终点');

figure(3)
subplot(1,2,1)
plot(Length_best)
xlabel('迭代次数')
ylabel('最短距离收敛轨迹')
subplot(1,2,2)
plot(Length_ave)
xlabel('迭代次数')
ylabel('平均距离收敛轨迹')