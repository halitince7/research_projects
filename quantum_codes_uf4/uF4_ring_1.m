 //load "c:/users/mathatin/desktop/faik.txt";



S<w> := GF(4);
P<x> := PolynomialRing(S);


function RecipG(p)
return  ( (x^Degree(p)) * Evaluate(p, 1/x ) );
end function;

function MOD(n,p)
a :=  (x^n - 1) / (p*RecipG(p));
return a;
end function;

function RecipH(n,p)
h := (x^n - 1) / p;
return RecipG(h);
end function;


function ShortG(n,g)
A := [ ];
B := Factorization(x^n -1);
b := #B;
C := Factorization(g);
c := #C;

for i in [1..c] do

  for j in [1..b] do
      
     G :=[ ];
     if C[i][1] eq B[j][1] then
     Append(~G,j); Append(~G,C[i][2]);
     Append(~A,G);
     end if;

end for; end for;
return A;
end function;

n:=40;
g:= x^2+w^2*x+1;
gy := P!RecipG(g);
ggy := g*gy ;
h := (x^n-1) / g;
hy := P!RecipH(n,g);
hy2 := P!RecipG(h);
hhy := P!h*hy ;


(x^n-1) mod ggy;
hhy mod (x^n-1);



