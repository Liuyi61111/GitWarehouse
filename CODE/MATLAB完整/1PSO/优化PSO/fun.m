function y=fun(x,index)
% x代表参数，index代表测试的函数的选择
% 该测试函数为通用测试函数，可以移植
% 目录
%  函数名            位置                   最优值
% 1.Sphere             0                       0
% 2.Camel             多个      
% 3.Rosenbrock
switch index
    case 1 %Sphere函数
        y=sum(x.^2);
    case 2 %Camel函数,Dim只能取2
        if length(x)>2
            error('x的维度超出了2');
        end
        xx=x(1);yy=x(2);y=(4-2.1*xx^2+xx^4/3)*xx^2+xx*yy+(-4+4*yy^2)*yy^2;
    case 3 %Rosenbrock函数
        y=0;
        for i=2:length(x)
        	y=y+100*(x(i)-x(i-1)^2)^2+(x(i-1)-1)^2;
        end
    case 4 %Ackley函数
        a = 20; b = 0.2; c = 2*pi;
        s1 = 0; s2 = 0;
        for i=1:length(x)
            s1 = s1+x(i)^2;
            s2 = s2+cos(c*x(i));
        end
        y = -a*exp(-b*sqrt(1/length(x)*s1))-exp(1/length(x)*s2)+a+exp(1);
    case 5 %Rastrigin函数
        s = 0;
        for j = 1:length(x)
            s = s+(x(j)^2-10*cos(2*pi*x(j)));
        end
        y = 10*length(x)+s;
    case 6 %Griewank函数
        fr = 4000;
        s = 0;
        p = 1;
        for j = 1:length(x); s = s+x(j)^2; end
        for j = 1:length(x); p = p*cos(x(j)/sqrt(j)); end
        y = s/fr-p+1;
    case 7 %Shubert函数
        s1 = 0; 
        s2 = 0;
        for i = 1:5 
            s1 = s1+i*cos((i+1)*x(1)+i);
            s2 = s2+i*cos((i+1)*x(2)+i);
        end
        y = s1*s2;
    case 8 %beale函数
        y = (1.5-x(1)*(1-x(2)))^2+(2.25-x(1)*(1-x(2)^2))^2+(2.625-x(1)*(1-x(2)^3))^2;
    case 9 %Schwefel函数
        s = sum(-x.*sin(sqrt(abs(x))));
        y = 418.9829*length(x)+s;
    case 10 %Schaffer函数
        temp=x(1)^2+x(2)^2;
        y=0.5-(sin(sqrt(temp))^2-0.5)/(1+0.001*temp)^2;
    otherwise
        disp('no such function, please choose another');
end