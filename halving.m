function res=halving(f, X0, grad0)

f1=@(x) f(X0-x*grad0);

l=0;  
r=0.5; 

epsilon=10^(-5);

k=1; 

L = r-l; % intervalo ilgis

format short;

x1 = l + L*0.25;
x2 = r - L*0.25;
y1 = f1(x1);
y2 = f1(x2);

xm = 0.5*(l+r);
fxm =f1(xm);
while L>= epsilon
  L = r-l;
  x1 = l + L*0.25;
  x2 = r - L*0.25;
  fx1 = f1(x1); fx2 = f1(x2);
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
end
res=[0.5*(x1+x2), k+2];
end