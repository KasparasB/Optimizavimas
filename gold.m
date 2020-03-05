addpath(pwd)
1;
hold on;

l = 0;
r = 10;
L = r-l;

epsilon=10.^(-4);
tau = double((sqrt(5)-1)/2);
n = 0;

x = l:0.1:r;

title ("Auksinio pjuvio metodas", "fontsize", 24);
plot(x,f(x))
axis([-1 10 -1 10])

res = 0;

L = r-l;
x1 = l + tau*L;
x2 = r - tau*L;
fx1 = f(x1);
fx2= f(x2);
		plot(x1, fx1, "r", "markersize", 15);
		plot(x2, fx2, "g", "markersize", 15)

while(L>epsilon)


	if(fx2 > fx1)
    l = x2;
    L = r - l;
    x2 = x1;
    fx2 = fx1;
    x1 = l + tau*L
    fx1 = f(x1)
		plot(x1, fx1, "r", "markersize", 15);
    res = x1;
	else
    r = x1;
    L = r - l;
    x1 = x2;
    fx1 = fx2;
    x2 = r - tau*L;
    fx2 = f(x2);
		plot(x2, fx2, "g", "markersize", 15)
    res = x2;
	endif
  disp(res);
	n = n+1;
endwhile

disp("The number of iterations: "),disp(n);
disp("The optimum point: "),disp(0.5*(x1+x2));
disp("The function value at optimum point: "), disp(0.5*(f(x1)+f(x2)));