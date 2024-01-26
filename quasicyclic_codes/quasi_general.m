//load "c:/users/acer/desktop/quasigenel.txt";

FF := "c:/users/acer/desktop/RESS.txt";


q       := 4;
F<w>    := GF(q);
P<v> := PolynomialRing(F); 

n := 6;
A := Factorization(v^n-1);

A;





S<v> := quo< P | v^2 - v  >;          
R<x> := PolynomialRing(S); 


p1:= (x+w^2);
p2:= (x+1)*(x+w);

g:=p1*(1-v)+p2*v;


function IsZeroDiv(f)

for i0 in S do
    for i1 in S do
        for i2 in S do
            for i3 in S do
                for i4 in S do
                    for i5 in S do
                      //  for i6 in S do
                         
                            p := R![i0,i1,i2,i3,i4,i5]; //,i6];
                            if p ne 0 and p*f mod (x^n - 1) eq 0 then
                               return 0;
                            elif p*f mod (x^n - 1) eq 1 then
                               return 1;
                            end if;
                           
                       //end for;
                    end for;
               end for;
            end for;
        end for;
    end for;
end for;



end function;


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










g := R!g;
h := (x^n-1) div g;

print "g: ";
g;

A := [ ];
r := Degree(g);
for i in [1..n] do
  A := A cat Coeff(g,n);
  g := (g)*(x) mod(x^n-1);
end for;
M := Matrix(R, n, n, A); 
N := GetGM(M);
G := GetGrayGM(N);
C := LinearCode<F, 2*n | G>;
d := MinimumDistance(C);

print "<g>:";
C;
print " ";


Elts := [ ];
for i in S do Append(~Elts,i); end for;

HF := [ ];
for i0 in Elts do
    for i1 in Elts do
        for i2 in Elts do
            for i3 in Elts do
                for i4 in Elts do
                    for i5 in Elts do
                        //for i6 in Elts do
                         
                            p := R![i0,i1,i2,i3,i4,i5]; //,i6];
                            if GCD(p,h) eq 1 then


f := p;

if IsZeroDiv(f) eq 1 then


g1 := g;
gf := g*f mod(x^n-1);

print "f,gf:";
f;
gf;




A := [ ];
for i  in [1..n] do
  A := A cat Coeff(g1,n);
  g1 := g1*x mod(x^n-1);
end for;
M1 := Matrix(R, n, n, A); 
//M1;





A := [ ];
for i  in [1..n] do
  A := A cat Coeff(gf,n);
  gf := gf*x mod(x^n-1);
end for;
M2 := Matrix(R, n, n, A); 
//M2;




M := HorizontalJoin(M1,M2); 
//M;


N := GetGM(M);
G := GetGrayGM(N);
C := LinearCode<F, 4*n | G>;
d := MinimumDistance(C);
Write(FF,C);
print " <g,gf>: ";
C;
print " ";

end if;







                            end if;
                           
                        end for;
                    end for;
                //end for;
            end for;
        end for;
    end for;
end for;
                                                     












