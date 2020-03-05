addpath(pwd)
1;
hold on;
l = 0; 
r = 10;
L = r-l;
epsilon = 10^(-4);
x = l:0.1:r;

title ("Dalijimo pusiau metodas", "fontsize", 24);
plot(x,f(x));
axis([-1 10 -1 10])
a = 2*epsilon;

n = 0;
xm = 0.5*(l+r);
fxm =f(xm);
while(L>epsilon)
  L = r-l;

  x1 = l + L*0.25;
  x2 = r - L*0.25;
fx1 = f(x1); fx2 = f(x2);
  if(fx1<fxm)
    r = xm;
    xm = x1;
    fxm=fx1;
  elseif(fx2<fxm)
    l = xm;
    xm = x2;
    fxm=fx2;
  else
    l = x1;
    r = x2;
  endif
  disp(xm);
  #disp("f(xm):"), disp(0.5*(x1+x2));
  plot(x1, fx1, "r", "markersize", 20);
  plot(x2, fx2, "g", "markersize", 17);
  plot(xm, fxm, "b", "markersize", 14);
  n = n+1;
endwhile
disp("The number of iterations: "),disp(n);
disp("The optimum point: "),disp(0.5*(x1+x2));
disp("The function value at optimum point: "), disp(0.5*(f(x1)+f(x2)));