function y = fun(x)
% fun函数用于计算粒子适应度
%x   input     输入粒子
%y   output    粒子适应度值
y = sin(10 * pi *x) ./ x;