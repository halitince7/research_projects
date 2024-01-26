//load "c:/users/mathatin/desktop/tugba/quak.txt";



P<v> := PolynomialRing(GF(2));           
S<v> := quo< P | v^2 - v  >;          
R<x> := PolynomialRing(S); 
T<x> := quo< R | x^8 - 1 >;


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
return [H[2],H[1]+H[2]];
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



g := x^4 + v*x^3 + x^2 + (1+v)*x + 1;
f := x^6 + x^5 + (1+v)*x^4 + (1+v)*x^3 + x^2 + (1+v)*x + v;
gf := g*f;
n := 7;
g;
f;
gf;


g :=x^2*(x+1)+v*x;
f := 1;
gf := x^2*(x+1)+v*(x +1);
n := 4;



r := Degree(g);
A := [ ];
for i  in [1..n] do
  A := A cat Coeff(g,n);
  g := g*x;
end for;
M1 := Matrix(R, n, n, A); 
M1;

A := [ ];
for i  in [1..n] do
  A := A cat Coeff(gf,n);
  gf := gf*x;
end for;
M2 := Matrix(R, n, n, A); 
M2;

M := HorizontalJoin(M1,M2);
M;


F := { };

for e1 in S do
   for e2 in S do
      for e3 in S do
        for e4 in S do
           Include(~F,e1*M[1]+e2*M[2]+e3*M[3]+e4*M[4]); 
        end for;
      end for;
   end for;
end for;



G := { };
for p in F do
    A := [ ];
    for i in [1..2*n] do
        A := A cat Gry(p[i]);
    end for;
    Include(~G,A);
end for;


C1 := LinearCode<GF(2), 4*n | G>;
C1;




