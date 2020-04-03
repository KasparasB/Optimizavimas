grid on;
hold on;

f = @(X) (1 / 8) * ((X(1) .^ 2) .* X(2) + X(1) .* (X(2) .^ 2) - X(1) .* X(2)); #funkcija naudojimui
f1 = @(x1, x2) (1 / 8) * ((x1 .^ 2) .* x2 + x1 .* (x2 .^ 2) - x1 .* x2); #funkcija braizymui



X_0 = [0, 0];
X_1 = [1, 1];
X_m = [0 / 10, 5/ 10]; #a = 0; b = 5;

X0 = X_0;

alpha = 0.5; 
teta = 1; 
gamma = 2; 
beta = 0.5;
eta = -0.5;

eps = 10 ^ (-5); 

[x1, x2] = meshgrid( -0.5:0.1:1.5,-0.5:0.1:1.5);
y = f1(x1, x2);
surf(x1, x2, y);
title(['Funkcijos grafikas']);

m = 2; 
delta1 = alpha * (sqrt(m + 1) + m - 1) / (m * sqrt(2));
delta2 = alpha * (sqrt(m + 1) - 1) / (m * sqrt(2));

X1 = [X0(1, 1) + delta2, X0(1, 2) + delta1];
X2 = [X0(1, 1) + delta1, X0(1, 2) + delta2];

Y0 = f(X0);
Y1 = f(X1);
Y2 = f(X2);

X = [X0; X1; X2];

Y = [Y0, Y1, Y2];

deltax = [X0(1), X0(1), X1(1); 
          X1(1), X2(1), X2(1)];
          
deltay = [X0(2), X0(2), X1(2); 
          X1(2), X2(2), X2(2)];

deltaz = [Y0+0.002, Y0+0.002, Y1+0.002;
          Y1+0.002, Y2+0.002, Y2+0.002];
          
plot3(deltax, deltay, deltaz+0.002,'b');

grid on;
hold on;

plot3(X(:, 1), X(:, 2),Y+0.002,'ro');
hold on;

n = 1; 
i = 3; 

format short;

while 1
    [out,idx] = sort(Y);
   
    #disp(idx);
    #disp(out);
    
    %Didziausia reiksme
    Yh = Y(idx(3));
    Xh = X(idx(3), :);
    
    %Antra pagal dydi reiksme
    Yg = Y(idx(2));
    Xg = X(idx(2), :);
 
    %Maziausia reiksme
    Ylow = Y(idx(1));
    Xlow = X(idx(1), :);
        
    #fprintf('%f %f %f \n',Yh, Yg, Ylow);
    
    Xc = (Xg + Xlow) / 2;
 
    Xnew = Xh + (1 + teta) * (Xc - Xh);
    Ynew= f(Xnew);
    
    disp(Xnew);
    
    i = i + 1;
    
    
    if Xnew(1) <= 0 || Xnew(2) <= 0 #Tikrinama, ar taskas nera mazesnis uz 0, nes kitaip gali buti nusuoliuota i lankas
        teta = - 1 / 2;
        Xnew = Xh + (1 + teta) * (Xc - Xh);
        Ynew= f(Xnew);
        i = i + 1;
    end
    
    #fprintf('%f %f %f %f \n',Xh, Xg, Xlow, Xnew);
    #fprintf('%f %f %f %f \n',Yh, Yg, Ylow, Ynew);
    
    if (Ylow < Ynew) && (Ynew < Yg)
        teta = 1;
        #fprintf('1 if \n');
    elseif (Ynew < Ylow)
        #fprintf('2 if \n');
        teta = gamma;
        Z = Xh + (1 + teta) * (Xc - Xh);
        Yz = f(Z);
        #fprintf('%f %f \n',Yz, Z);
        i = i + 1;
        if Yz < Ynew # Tikrinama, ar naujas taskas nera blogesnis uz pries tai tureta.
            Ynew = Yz;
            Xnew = Z;
        endif
    elseif Ynew > Yh
        #fprintf('3 if \n');
        teta = eta;
        Z = Xh + (1 + teta) * (Xc - Xh);
        Xnew = Z;
        Ynew = f(Z);
        i = i + 1;
    elseif (Yg < Ynew) && (Ynew < Yh)
        #fprintf('4 if \n');
        teta = beta;
        Z = Xh + (1 + teta) * (Xc - Xh);
        Xnew = Z;
        Ynew = f(Z);
        i = i + 1;
    endif
    
    if Xnew(1) <= 0 || Xnew(2) <= 0 #Tikrinama, ar taskas nera mazesnis uz 0, nes kitaip gali buti nusuoliuota i lankas
        teta = - 1 / 2;
        Xnew = Xh + (1 + teta) * (Xc - Xh);
        Ynew= f(Xnew);
        i = i + 1;
    end

    #fprintf('%f    %f   %f %d   %d \n', Xnew, Ynew, n, i);
 
    if(norm(Xlow - Xg) < eps && norm(Xlow - Xh) < eps && norm(Xg - Xh) < eps)
        if (max([abs(Ylow - Yg), abs(Ylow - Yh), abs(Yg - Yh)]) < eps) || (i == 100)
          break;
        endif
    endif
 
    n = n + 1;
    X = [Xlow; Xg; Xnew];
    Y = [Ylow, Yg, Ynew];
    
    deltax = [Xlow(1), Xlow(1), Xg(1); # X1 Krastine
              Xg(1), Xnew(1), Xnew(1)];
              
    deltay = [Xlow(2), Xlow(2), Xg(2); # X2 Krastine
              Xg(2), Xnew(2), Xnew(2)];
              
    deltaz = [Ylow+0.001, Ylow+0.001, Yg+0.001; # Aukstis, kuriame turi buti taskas
              Yg+0.001, Ynew+0.001, Ynew+0.001];
    
    #fprintf('delta x %f \n', deltax);
    #fprintf('delta y %f \n', deltay);
    
    plot3(deltax, deltay, deltaz, 'b'); # Krastiniu paisymas
    hold on;
    plot3(X(:, 1), X(:, 2), Y+0.001,'ro'); # Burbuliukai
    hold on;
    teta = 1;
endwhile

fprintf('Ciklu kiekis: %f', n);
fprintf('Funkcijos kvietimu skaicius: %f', i);
fprintf('Gautos reiksmes: \n');
disp(X);