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
    case 2 %Rosenbrock函数
        y=0;
        for i=2:length(x)
        	y=y+100*(x(i)-x(i-1)^2)^2+(x(i-1)-1)^2;
        end
    case 3 %Ackley函数
        a = 20; b = 0.2; c = 2*pi;
        s1 = 0; s2 = 0;
        for i=1:length(x)
            s1 = s1+x(i)^2;
            s2 = s2+cos(c*x(i));
        end
        y = -a*exp(-b*sqrt(1/length(x)*s1))-exp(1/length(x)*s2)+a+exp(1);
    case 4 %Rastrigin函数
        s = 0;
        for j = 1:length(x)
            s = s+(x(j)^2-10*cos(2*pi*x(j)));
        end
        y = 10*length(x)+s;
    case 5 %Griewank函数
        fr = 4000;
        s = 0;
        p = 1;
        for j = 1:length(x); s = s+x(j)^2; end
        for j = 1:length(x); p = p*cos(x(j)/sqrt(j)); end
        y = s/fr-p+1;
 
    otherwise
        disp('no such function, please choose another');
end