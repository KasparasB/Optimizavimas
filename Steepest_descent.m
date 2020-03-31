f=@(X) (1 / 8) * (X(1)^2.*X(2)+X(1)*X(2)^2-X(1)*X(2));
fi = @(x1,x2) (1 / 8) * ((x1 .^ 2) .* x2 + x1 .* (x2 .^ 2) - x1 .* x2);
grad0 = @(X) [2 * X(1) * X(2) + X(2) .^ 2 - X(2), X(1) ^ 2 + 2 * X(1) * X(2) - X(1)];

X_0 = [0, 0];
X_1 = [1, 1];
X_m= [0/10, 5/ 10];

[x1, x2] = meshgrid(0:0.1:1, 0:0.1:1);
y = fi(x1,x2);
surf(x1, x2, y);
title(['F-jos grafikas']);

epsilon = 10 ^ (-5);
n = 1;
i = 0;
nmax = 100; 

format long

dist = 10000;

X0 = X_1;
while dist >= epsilon
    hold on;
    
     grad=grad0(X0);
      res=halving(f,X0,grad);
      gamma=res(1);
      i=i+res(2)+1;
      X0 = X0 - gamma .* grad; % naujas taskas
      dist = norm(grad);
 
    fprintf('X0= %f %f f(x0)= %f k= %d i= %d \n', X0, f(X0), n,i);
 
    plot(X0(1), X0(2), 'r', 'markersize', 15);

    n = n + 1;
end
grid on;
hold off;