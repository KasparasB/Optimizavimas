hold on;

a = 0:0.1:10;
g = (a.^4)./5 - 1;
dg = (4*a.^3)/5;
ddg =(12*a.^2)/5;

plot(a, g, 'r');
plot(a, dg, 'g');
plot(a, ddg,'b');
title ("Niutono metodas", "fontsize", 24);
axis([0 10 -2 100])

result = 0;
x0 = 5;
xi = 0;
eps = 10^(-4);

s1 = s2 = k = 0;

function y = f(x)
  y = (x.^4)./5 - 1;
endfunction

function dy = df(x)
  dy = (4*x.^3)/5;
endfunction

function ddy = ddf(x)
  ddy = (12*x.^2)/5;
endfunction

while 1

  xi = x0;
  x0 = x0 - df(x0)/ddf(x0);

  disp(x0);
  plot(x0, f(x0), 'b', 'markersize', 15);
  if(abs(xi-x0) <= eps)
    break;
  endif
  
  k = k + 1;
endwhile

disp("The number of iterations: "),disp(k);
disp("The optimum point: "),disp(x0);
disp("The function value at optimum point: "), disp(f(x0));






