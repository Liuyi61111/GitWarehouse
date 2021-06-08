function y=fun(x,index)
% x���������index������Եĺ�����ѡ��
% �ò��Ժ���Ϊͨ�ò��Ժ�����������ֲ
% Ŀ¼
%  ������            λ��                   ����ֵ
% 1.Sphere             0                       0
% 2.Camel             ���      
% 3.Rosenbrock
switch index
    case 1 %Sphere����
        y=sum(x.^2);
    case 2 %Camel����,Dimֻ��ȡ2
        if length(x)>2
            error('x��ά�ȳ�����2');
        end
        xx=x(1);yy=x(2);y=(4-2.1*xx^2+xx^4/3)*xx^2+xx*yy+(-4+4*yy^2)*yy^2;
    case 3 %Rosenbrock����
        y=0;
        for i=2:length(x)
        	y=y+100*(x(i)-x(i-1)^2)^2+(x(i-1)-1)^2;
        end
    case 4 %Ackley����
        a = 20; b = 0.2; c = 2*pi;
        s1 = 0; s2 = 0;
        for i=1:length(x)
            s1 = s1+x(i)^2;
            s2 = s2+cos(c*x(i));
        end
        y = -a*exp(-b*sqrt(1/length(x)*s1))-exp(1/length(x)*s2)+a+exp(1);
    case 5 %Rastrigin����
        s = 0;
        for j = 1:length(x)
            s = s+(x(j)^2-10*cos(2*pi*x(j)));
        end
        y = 10*length(x)+s;
    case 6 %Griewank����
        fr = 4000;
        s = 0;
        p = 1;
        for j = 1:length(x); s = s+x(j)^2; end
        for j = 1:length(x); p = p*cos(x(j)/sqrt(j)); end
        y = s/fr-p+1;
    case 7 %Shubert����
        s1 = 0; 
        s2 = 0;
        for i = 1:5 
            s1 = s1+i*cos((i+1)*x(1)+i);
            s2 = s2+i*cos((i+1)*x(2)+i);
        end
        y = s1*s2;
    case 8 %beale����
        y = (1.5-x(1)*(1-x(2)))^2+(2.25-x(1)*(1-x(2)^2))^2+(2.625-x(1)*(1-x(2)^3))^2;
    case 9 %Schwefel����
        s = sum(-x.*sin(sqrt(abs(x))));
        y = 418.9829*length(x)+s;
    case 10 %Schaffer����
        temp=x(1)^2+x(2)^2;
        y=0.5-(sin(sqrt(temp))^2-0.5)/(1+0.001*temp)^2;
    otherwise
        disp('no such function, please choose another');
end