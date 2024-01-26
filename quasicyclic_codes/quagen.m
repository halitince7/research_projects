//load "c:/users/mathatin/desktop/tugba/quagen.txt";



P<v> := PolynomialRing(GF(2));           
S<v> := quo< P | v^2 - v  >;          
R<x> := PolynomialRing(S); 
T<x> := quo< R | x^3 - 1 >; 



function Coeff(f,n)
  H := [ ];
  for i in [0..n-1] do 
    H[i+1] := Coefficient(f,i);
  end for;
  return H;
end function;

function Gry(p)
p := S!p;
H := [ ];
for i in [0..1] do 
  H[i+1] := Coefficient(p,i);
end for;
return [H[1],H[1]+H[2]];
end function;


f :=  x^2 + (1+v)*x + 1;
g :=  x^2+ (1+v)*x + v ;
h := g*f;


A := [ ];
for p in T do
    Append(~A,p*f);
end for;

B := [ ];
for p in T do
    Append(~B,p*h);
end for;

G := [ ];

for p1 in A do
    for p2 in B do
        Append(~G,p1+p2);
    end for;
end for;

#G;

G1 := [ ];
for p in G do
    H := [ ];
    H := Coeff(p,3);
    H1 := [ ];
    for i in [1..3] do 
         H1 := H1 cat Gry(H[i]);
    end for;
    Append(~G1,H1);
end for;

#G1;

C := LinearCode<GF(2), 6 | G1>;
C;
































