//load "c:/users/mathatin/desktop/F2+uF2.txt";

Z2 := IntegerRing(2);
P<u> := PolynomialRing(Z2);
R<u> := quo< P | u^2 - 0 >;
T<x> := PolynomialRing(R);
H<x> := quo< T | x^7 - 1 >;

n := 7;

f1:=x+1;
f2:=x^3+x+1;
f3:=x^3+x^2+1;

g := f1*f3 + u*f2*f3;

Elts := { };
for p in H do
  Include(~Elts,p*g);
end for;

#Elts;


function Coeff(f,n)
  H := [ ];
  for i in [0..n-1] do 
    H[i+1] := Coefficient(f,i);
  end for;
  return H;
end function;

// Bu halkada Gray donusum fonksiyonu:
function Gry(x)
if x eq u   then return [1,1]; end if;
if x eq u+1 then return [1,0]; end if;
if x eq 1   then return [0,1]; end if;
if x eq 0   then return [0,0]; end if;
return 0;
end function;

G := [ ];
for p in Elts do
   A := [ ];
   H := Coeff(p,n);
   for i in [1..n] do
      A := Gry(H[i]) cat A;
   end for;
   Append(~G,A);
end for;


C := LinearCode<GF(2),14 | G>;
C;






