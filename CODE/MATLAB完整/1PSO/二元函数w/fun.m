function z = fun(a)
% �������ڼ���������Ӧ��
%x   input     ��������
%y   output    ������Ӧ��ֵ
x = a(1);
y = a(2);
z = x.^2 + y.^2 - 10*cos(2*pi*x) - 10*cos(2*pi*y) + 20;