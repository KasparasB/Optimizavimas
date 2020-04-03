f = @(x1, x2) (1 / 8) * ((x1 .^ 2) .* x2 + x1 .* (x2 .^ 2) - x1 .* x2);
grad0 = @(X1, X2) [2 * X1 * X2 + X2 .^ 2 - X2, X1 ^ 2 + 2 * X1 * X2 - X1];

X_0 = [0, 0];
X_1 = [1, 1];
X_m= [1/10, 6/10];

X0 = X_1;

[x1, x2] = meshgrid(0:0.1:1, 0:0.1:1);
y = f(x1, x2);
surf(x1, x2, y);
title(['Funkcijos grafikas']);

learn_rate = 0.3; 
eps = 10 ^ (-5);
n = 1;

format long

dist = 10000;

while (dist >= eps)
    hold on;
    grad1 = grad0(X0(1),X0(2));
    X0 = X0 - learn_rate.* grad1;
    dist = norm(grad1);
 
    fprintf('X0= %f %f f(x0)= %f k= %d\n', X0, f(X0(1), X0(2)), n);

    plot(X0(1), X0(2), 'r', 'markersize',10);
        
    n = n + 1;
end
grid on;
hold off;