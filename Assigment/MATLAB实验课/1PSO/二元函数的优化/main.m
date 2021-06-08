%% 1 ��ջ���
clc 
clear all

%%  2 ����Ŀ�꺯������
figure
[x,y] = meshgrid(-5:0.1:5,-5:0.1:5);          
z =                                    ;%��⺯��
mesh(x,y,z)
hold on

%% 3 ������ʼ��
c1 =  ;
c2 =  ;

w_start =  ;
w_end =    ;

maxgen =     ; %��������
sizepop =    ; %��Ⱥ��ģ

Vmax =   ;%�ٶ����ֵ
Vmin =   ;

popmax =  ;  
popmin =  ;%����x��Χ����һ��

%% 4 ������ʼ�����Ӻ��ٶ�
for i = 1:sizepop
    % �������һ����Ⱥ
    pop(i,:) = 5*rands(1,2);%��ʼ��Ⱥ�����������ά��������Ϣ  
    %*rands()����[-1,1]֮���������ݣ�rands(1��2)����ֵΪ[-1,1]��һ����������
    V(i,:) =                ;%��ʼ���ٶ�
    %������Ӧ��
    fitness(i) = fun(pop(i,:));  %��Ӧ��
end

%% 5 ���弫ֵ��Ⱥ�弫ֵ
[bestfitness bestindex] = max(fitness);
gbest = pop(bestindex,:);%ȫ�����
pbest = pop;%�������
fitnesspbest = fitness;%���������Ӧ��
fitnessgbest = bestfitness;%ȫ�������Ӧ��

%% 6 ����Ѱ��
for i = 1:maxgen
    w =                                   ;   %Linear decreasing inertia weight (LDIW) strategy
    for j = 1:sizepop
        %�ٶȸ���
        V(j,:) = w*V(j,:) + c1*rand*(pbest(j,:) - pop(j,:)) + c2*rand*(gbest -pop(j,:));
        V(j,find(V(j,:)>Vmax)) = Vmax;%�߽�Լ��
        V(j,find(V(j,:)<Vmin)) = Vmin;
        
        %��Ⱥ����
        pop(j,:) = pop(j,:) + V(j,:);
        pop(j,find(pop(j,:)>popmax)) = popmax;
        pop(j,find(pop(j,:)<popmin)) = popmin;
        
        %��Ӧ��ֵ����
        fitness(j) =      ;%����fun����������Ӧ��ֵ
    end
    
    for j = 1:sizepop
        %�������Ÿ���
        if fitness(j) > fitnesspbest(j)
            pbest(j,:) = pop(j,:);
            fitnesspbest(j) = fitness(j);
        end
        
        %Ⱥ�����Ÿ���
        if fitness(j) > fitnessgbest
            gbest = pop(j,:);
            fitnessgbest = fitness(j);
        end
    end
    
    result(i) =    ;%���
    

end

%% 7 ����������ͼ
[fitnessgbest, gbest]

plot3(gbest(1),gbest(2),fitnessgbest,'bo','linewidth',1.5)

figure
plot(result)
title('���Ÿ�����Ӧ��','fontsize',12);
xlabel('��������','fontsize',12); 
ylabel('��Ӧ��','fontsize',12);
        

