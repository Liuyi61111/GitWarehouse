clc;clear;close all;

Dim = 10;      %ά��
index=6;      %���Ժ�������

c1 = 1.4;
c2 = 1.4;

maxgen = 1000;    %��������
sizepop = 20;   %��Ⱥ��ģ


popmax = 600;
popmin = -600;


Vmax = 1;
Vmin = -1;


w_start = 0.9;
w_end = 0.4;

record=zeros(1,maxgen);
%% ������ʼ���Ӻ��ٶ�
for i = 1:sizepop
    % �������һ����Ⱥ
    pop(i,:) = (popmax-popmin)*rand(1,Dim)+popmin;    %��ʼ��Ⱥ
    V(i,:) = (Vmax-Vmin)*rand(1,Dim)+Vmin;       %��ʼ���ٶ�
    % ������Ӧ��
    fitness(i) = fun(pop(i,:),index);   %������Ӧ��
end
%% ���弫ֵ��Ⱥ�弫ֵ
[bestfitness bestindex] = min(fitness); %bestindex:ȫ��������������
gbest = pop(bestindex,:);   %ȫ�����λ��
pbest = pop;    %�������
fitnesspbest = fitness;   %���������Ӧ��ֵ
fitnessgbest = bestfitness;   %ȫ�������Ӧ��ֵ
%% ����Ѱ��
for i = 1:maxgen       %��������
    w = (w_start - w_end)*((maxgen-i)/maxgen)+ w_end ;
    for j = 1:sizepop  %��������
        % �ٶȸ���
        V(j,:) = w*V(j,:) + c1*rand*(pbest(j,:) - pop(j,:)) + c2*rand*(gbest - pop(j,:));
        %�ٶȱ߽紦��
        V(j,find(V(j,:)>Vmax)) = Vmax;
        V(j,find(V(j,:)<Vmin)) = Vmin;
        
        % ��Ⱥ����
        pop(j,:) = pop(j,:) + V(j,:);
        %λ�ñ߽紦��
        pop(j,find(pop(j,:)>popmax)) = popmax;
        pop(j,find(pop(j,:)<popmin)) = popmin;
        
        % ��Ӧ��ֵ����
        fitness(j) = fun(pop(j,:),index);
    end
    
    for j = 1:sizepop
        % �������Ÿ���
        if fitness(j) < fitnesspbest(j)
            pbest(j,:) = pop(j,:);
            fitnesspbest(j) = fitness(j);
        end
        % Ⱥ�����Ÿ���
        if fitness(j) < fitnessgbest
            gbest = pop(j,:);
            fitnessgbest = fitness(j);
        end
    end
    record(1,i)=fitnessgbest;
    fprintf('%d      %f\n',i,fitnessgbest);  %������
    
    % ������ͼ���ƴ洢
    plot(pop(:,1),pop(:,2),'*b')
    axis([popmin popmax popmin popmax])
    pause(0.1)
    x1=xlabel('x1');
    x2=ylabel('x2');
    title(['��������=' num2str(i)]);
    drawnow;
    frame = getframe(1);
    im = frame2im(frame);
    [A,map] = rgb2ind(im,256);
    if i == 1
        imwrite(A,map,'D:\LiuYi\Matlab Project\test\1PSO\3demo\��׼PSO.gif','gif','LoopCount',Inf,'DelayTime',0.1);
    else
        imwrite(A,map,'D:\LiuYi\Matlab Project\test\1PSO\3demo\��׼PSO.gif','gif','WriteMode','append','DelayTime',0.1);
    end
end
%% ��Ӧ��ֵ�仯��ͼ
plot(record);
xlabel('gen');
ylabel('fitness');