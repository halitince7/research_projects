//load "c:/users/mathatin/desktop/tugba/quasiF2.txt";



P<v> := PolynomialRing(GF(2));           
S<v> := quo< P | v^2 - v  >;          
R<x> := PolynomialRing(S); 
T<x> := quo< R | x^8 - 1  >;     




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


function GetGM(M)

m := Nrows(M);
n := Ncols(M);
A := [ ];
for i in [1..m] do
B := [ ];
  for j in [1..n] do 
    B[j] := M[i][j];
  end for;
  A := A cat B;
B := [ ];
  for j in [1..n] do 
    B[j] := v*M[i][j];
  end for;
  A := A cat B;
end for;
N := Matrix(R, 2*m, n, A); 
return N;

end function;




function GetGrayGM(M)

  G := [ ];
  m := Nrows(M);
  n := Ncols(M);
 
  for i in [1..m] do

     A := [ ];
     for j in [1..n] do
        A :=  A cat Gry(M[i][j]);
     end for;
     Append(~G,A);
  
end for;
return G;
end function;




A := [ ];
g := x + 1;
g2 := v*x^4 + x^3 + v*x^2 + (1+v)*x + 1;
g1 := p*f;
r := Degree(g);
n := 8;

for i  in [1..n-r] do
  A := A cat Coeff(g,n);
  g := g*x;
end for;

M := Matrix(R, n-r, n, A); 
M;
print " ";
N := GetGM(M);
N;
print " ";
G := GetGrayGM(N);
G;
C := LinearCode<GF(2), 2*n | G>;
C;
