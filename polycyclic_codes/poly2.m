//load "c:/users/mathatin/desktop/poly2.txt";


P<v> := PolynomialRing(GF(2));           
S<v> := quo< P | v^2 - v  >;          
R<x> := PolynomialRing(S);        
        


function Coeff(f,n)
  H := [ ];
  for i in [0..n-1] do 
    H[i+1] := Coefficient(f,i);
  end for;
  return H;
end function;

function PolyCy(f,v,n)
  G := [ ];
  for i in [1..n] do
    Append(~G,Coeff(f,n));
    f := x*f mod (x^n - v);
  end for;
  C := LinearCode< S, n | G >;
  return C;
end function;




f := (x^4 + 3*x + 3)*(x^3 + x^2 + 2*x + 1);
v := x^10 + x^8 + x^4 + x^2 + x + 1;
n := 11;
C := PolyCy(f,v,n);
MinimumDistance(C);
C;