//load "c:/users/mathatin/desktop/poly.txt";

S    := GF(5);
P<x> := PolynomialRing(S);


function Shift(g,v,n)

a := [ ];
c := [ ];
for j in [0..n-1] do
     a[j+1] := Coefficient(g,j);
end for;

for j in [0..n-1] do
     c[j+1] := Coefficient(v,j);
end for;

  d    := a;
  n    := #a;
  k    := a[n];

  for i in [2..n] do 
    a[i] := d[i-1];
  end for;
  a[1] := 0;
  for i in [1..n] do
    c[i] := k*c[i];
  end for;
  d   := [ ];
  for i in [1..n] do
    d[i] := c[i] + a[i];
  end for;

  return (P ! d) ;
end function;



function PolyCyclic(f,v,n)
H := [ ];
for i in [1..n] do
a := [ ];
for j in [0..n-1] do
     a[j+1] := Coefficient(f,j);
end for;
H[i] := a;
f := Shift(f,v,n);
end for;
//H;
C := LinearCode< GF(5), n | H >;
return C;
end function;



a := [3, 0, 2, 2, 1, 0, 0, 0];
c := [1, 0, 3, 0, 0, 0, 0, 0];

f := (P ! a);
v := (P ! c);
n := 8;

PolyCyclic(f,v,n);










