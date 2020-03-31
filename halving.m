function res=halving(f, X0, grad0)

f1=@(x) f(X0.-x.*grad0);

l=0;  
r=0.5; 

epsilon=10^(-5);

k=1; 

fi = (sqrt(5) - 1) / 2;

L = r-l; % intervalo ilgis

format short;

x1 = l + L*0.25;
x2 = r - L*0.25;
y1 = f1(x1);
y2 = f1(x2);
while L>= epsilon
  
      if y2 < y1
          l = x1;
          L = r - l;
          x1 = x2;
          y1=y2;
          x2 = l + fi*L;
          y2 = f1(x2);
      else
          r = x2;
          L = r - l;
          x2 = x1;
          y2=y1;
          x1 = r - fi*L;
          y1 = f1(x1);
      end 
      
      k=k+1;
      L=r-l;

end
res=[x1, k+2];
end