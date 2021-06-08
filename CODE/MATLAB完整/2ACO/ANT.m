%% ����
%  ���������⣨TSP�����⣬��20������֮��ʹ����Ⱥ�㷨�ҵ����·��
%%
clear;
clc;
%%
% �������м�ʱ��ʼ
t0 = clock;
%��������
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
   2.682,6.072];%20�����о�γ��
%--------------------------------------------------------------------------
%% TSP���������м��໥����
n = size(citys,1); %size(A,n)����A���л�����
                    %size��A������һ�������� [r,s] = size(A),r�õ�A��������s�õ�A������
                    %[A,2],��ȡ���������������
D = zeros(n,n); %��¼���о������tabu list

for i = 1:n
    for j = 1:n
            D(i,j) = sqrt(sum((citys(i,:) - citys(j,:)).^2));%�������������λƽ������ͣ����������
    end    
end
%--------------------------------------------------------------------------
%% ��ʼ������
m = 75;                              % ��������
alpha = 1;                           % ��Ϣ����Ҫ�̶�����
beta = 5;                            % ����������Ҫ�̶�����
vol = 0.2;                           % ��Ϣ�־öȣ���1-vol����Ϣ��������
Q = 10;                              % ��ϵ��
Heu_F = 1./D;                        % visibility
Tau = ones(n,n);                     % ��Ϣ�ؾ���
Table = zeros(m,n);                  % ·����¼��
iter = 1;                            % ����������ֵ
iter_max = 100;                      % ���������� 
Route_best = zeros(iter_max,n);      % �������·��       
Length_best = zeros(iter_max,1);     % �������·���ĳ���  
Length_ave = zeros(iter_max,1);      % ����·����ƽ������  
Limit_iter = 0;                      % ��������ʱ��������
%-------------------------------------------------------------------------
%% ����Ѱ�����·��
while iter <= iter_max
    % ��������������ϵ�������
      start = zeros(m,1);
      for i = 1:m
          temp = randperm(n);      %��1��n��Щ��������ҵõ���һ����������
          start(i) = temp(1);
      end
      Table(:,1) = start; %��ֵÿ�����ϵĳ�ʼ����
      citys_index = 1:n;  %��������ȡ����

     %�������·��ѡ��
      for i = 1:m          %������
         % �������·��ѡ��
         for j = 2:n
             has_visited = Table(i,1:(j - 1));           % �ѷ��ʵĳ��м���(���ɱ�)
             allow_index = ~ismember(citys_index,has_visited);  %û�з��ʹ��ĳ���ȡ����
                                                                %ismember(a,b)������a�е����ǲ��Ǿ���b�еĳ�Ա���ǵĻ��������1�����Ƿ���0
             allow = citys_index(allow_index);  % �����ʵĳ��м���
             P = allow;
             % ������м�ת�Ƹ���
             for k = 1:length(allow)
                 P(k) = Tau(has_visited(end),allow(k))^alpha * Heu_F(has_visited(end),allow(k))^beta;
             end
             P = P/sum(P);
             % ���̶ķ�ѡ����һ�����ʳ���
            Pc = cumsum(P);  
            target_index = find(Pc >= rand);%���������з���Ԫ�ص�λ��
            target = allow(target_index(1));
            Table(i,j) = target;
         end
      end
      
      % ����iter���������ϵ��ߵ�·������
      Length = zeros(m,1);
      for i = 1:m
          Route = Table(i,:);
          for j = 1:(n - 1)
              Length(i) = Length(i) + D(Route(j),Route(j + 1));
          end
          Length(i) = Length(i) + D(Route(n),Route(1));
      end
      
      % �������·�����뼰ƽ������
      if iter == 1
          [min_Length,min_index] = min(Length);
          Length_best(iter) = min_Length;  
          Length_ave(iter) = mean(Length);
          Route_best(iter,:) = Table(min_index,:);
          Limit_iter = 1; 
          
      else
          [min_Length,min_index] = min(Length);
          Length_best(iter) = min(Length_best(iter - 1),min_Length);  % �Ƚϵ�ǰ������ǰһ���ľ���
          Length_ave(iter) = mean(Length);
          if Length_best(iter) == min_Length   % ��ǰ���������·��
              Route_best(iter,:) = Table(min_index,:);
              Limit_iter = iter; 
          else                            % ��һ�������·��
              Route_best(iter,:) = Route_best((iter-1),:);
          end
      end
      
      % ������Ϣ��
      Delta_Tau = zeros(n,n);
      % ������ϼ���
      for i = 1:m
          % ������м���
          for j = 1:(n - 1)
              Delta_Tau(Table(i,j),Table(i,j+1)) = Delta_Tau(Table(i,j),Table(i,j+1)) + Q/Length(i);%�����mֻ������ÿ��·�������µ�delta��Ϣ��
                                                  %�ʼDelta_Tau��0��iter=2�Ժ�ʼ����
          end
          Delta_Tau(Table(i,n),Table(i,1)) = Delta_Tau(Table(i,n),Table(i,1)) + Q/Length(i);%Q/Length(i) ��mֻ������ ����·�������µ���Ϣ��
		  % �������һ�����е���һ�����еĻ�·
      end
      Tau = vol * Tau + Delta_Tau;
    % ����������1�����·����¼��
    iter = iter + 1;
    Table = zeros(m,n);
end
%--------------------------------------------------------------------------
%% �����ʾ
[Shortest_Length,index] = min(Length_best);
Shortest_Route = Route_best(index,:);
Time_Cost=etime(clock,t0);
disp(['��̾���:' num2str(Shortest_Length)]);% disp ��ʾ���� X ��ֵ��������ӡ��������
                                             %ʹ�� []
                                             %�����������ַ�����������һ��;��ͬһ������ʾ�������
disp(['���·��:' num2str([Shortest_Route Shortest_Route(1)])]);
disp(['������������:' num2str(Limit_iter)]);
disp(['����ִ��ʱ��:' num2str(Time_Cost) '��']);
%--------------------------------------------------------------------------
%% ��ͼ
figure(1)
plot([citys(Shortest_Route,1);citys(Shortest_Route(1),1)],...  %����ʡ�Է�ΪMatlab���з�
     [citys(Shortest_Route,2);citys(Shortest_Route(1),2)],'o-');
grid on    % grid on�Ǵ�����grid off�ǹر�����

for i = 1:size(citys,1)
    text(citys(i,1),citys(i,2),['   ' num2str(i)]);
end

text(citys(Shortest_Route(1),1),citys(Shortest_Route(1),2),'       ���');
text(citys(Shortest_Route(end),1),citys(Shortest_Route(end),2),'       �յ�');

xlabel('����λ�ú�����')
ylabel('����λ��������')
title(['ACA���Ż�·��(��̾���:' num2str(Shortest_Length) ')'])

figure(2)
plot(1:iter_max,Length_best,'b') %plot(X,Y) ���� Y �����ݶ� X �ж�Ӧֵ�Ķ�ά��ͼ
legend('��̾���')
xlabel('��������')
ylabel('����')
title('�㷨�����켣')