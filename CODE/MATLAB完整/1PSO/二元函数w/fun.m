function z = fun(a)
% 函数用于计算粒子适应度
%x   input     输入粒子
%y   output    粒子适应度值
x = a(1);
y = a(2);
z = x.^2 + y.^2 - 10*cos(2*pi*x) - 10*cos(2*pi*y) + 20;