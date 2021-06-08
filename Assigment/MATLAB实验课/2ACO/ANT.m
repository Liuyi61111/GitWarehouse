%% ����
%  ���������⣨TSP�����⣬��20������֮��ʹ����Ⱥ�㷨�ҵ����·����
% 1.�ο�����Ant System:Optimization by a colony of cooperating agents������д���
% 2.�ص��½� II THE THE ANT SYSTEM  �� IV EXPERIMENTAL STUDY 1:PARAMETER SETING AND BASIC PROPERTIES
% 3.���Ը�д�ɿ����������20�����е��㷨
%
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
   2.682,6.072];    %20�����о�γ��
%--------------------------------------------------------------------------
%% TSP���������м��໥����
n = size(citys,1); %size(A,n)����A���л�����
                    %size��A������һ�������� [r,s] = size(A),r�õ�A��������s�õ�A������
                    %[A,2],��ȡ���������������
D = zeros(n,n);     %��¼���о������tabu list
for i = 1:n
    for j = 1:n
            D(i,j) =                                ;%the Euclidean distance between i and j 
    end    
end
%--------------------------------------------------------------------------
%% ��ʼ������
m =  ;                              % ��������
alpha = 	;                           % ��Ϣ����Ҫ�̶�����
beta = 	;                            % ����������Ҫ�̶�����
vol = 	;                           % ��Ϣ�ػӷ�(volatilization)����
Q = 	;                               % ��ϵ��
Heu_F = 1./D;                        % ��������(heuristic function)
Tau = ones(n,n);                     % ��Ϣ�ؾ���
Table = zeros(m,n);                  % ·����¼��
iter = 1;                            % ����������ֵ
iter_max = 	;                      % ���������� 
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
          temp = randperm(n);%��1��n��Щ��������ҵõ���һ����������
          start(i) = temp(1);
      end
      Table(:,1) = start; %��ֵÿ�����ϵĳ�ʼ����
      % ��ʼλ��
      citys_index = 1:n;   
      %��������ȡ����
      % �������·��ѡ��
      for i = 1:m          %������
          % �������·��ѡ��
         for j = 2:n
             has_visited = Table(i,1:(j - 1));           % �ѷ��ʵĳ��м���(���ɱ�)
             allow_index = ~ismember(citys_index,has_visited); %û�з��ʹ��ĳ���ȡ����
             %ismember(a,b)������a�е����ǲ��Ǿ���b�еĳ�Ա���ǵĻ��������1�����Ƿ���0
             allow = citys_index(allow_index);  % �����ʵĳ��м���
             P = allow;
             % ������м�ת�Ƹ���
             for k = 1:length(allow)
                 P(k) =                          ;
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
              Delta_Tau(Table(i,j),Table(i,j+1)) =                                      ;%�����mֻ������ÿ��·�������µ���Ϣ��
                                                                                         %�ʼDelta_Tau��0��iter=2�Ժ�ʼ����
          end
          Delta_Tau(Table(i,n),Table(i,1)) =                                            ;% �������һ�����е���һ�����еĻ�·
		  
      end
      Tau = (1-vol) * Tau + Delta_Tau;
   
    iter = iter + 1;      % ����������1 �� ���·����¼��
                    ;  %���·����¼��
end
%--------------------------------------------------------------------------
%% �����ʾ
[Shortest_Length,index] = min(Length_best);
Shortest_Route = Route_best(index,:);
Time_Cost=etime(clock,t0);
disp(['��̾���:' num2str(Shortest_Length)]);	
                                             	
                                             	
disp(['���·��:' num2str([Shortest_Route Shortest_Route(1)])]);
disp(['������������:' num2str(Limit_iter)]);
disp(['����ִ��ʱ��:' num2str(Time_Cost) '��']);
%--------------------------------------------------------------------------
%% ��ͼ
figure(1)
plot([citys(Shortest_Route,1);citys(Shortest_Route(1),1)],...  	
     [citys(Shortest_Route,2);citys(Shortest_Route(1),2)],'o-');
grid on   	

for i = 1:size(citys,1)
    text(citys(i,1),citys(i,2),['   ' num2str(i)]);
end

text(citys(Shortest_Route(1),1),citys(Shortest_Route(1),2),'       ���');
text(citys(Shortest_Route(end),1),citys(Shortest_Route(end),2),'       �յ�');

xlabel('����λ�ú�����')
ylabel('����λ��������')
title(['ACA���Ż�·��(��̾���:' num2str(Shortest_Length) ')'])

figure(2)
plot(1:iter_max,Length_best,'b')	
legend('��̾���')
xlabel('��������')
ylabel('����')
title('�㷨�����켣')