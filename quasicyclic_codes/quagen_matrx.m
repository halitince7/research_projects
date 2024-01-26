//load "c:/users/mathatin/desktop/tugba/quagenmtrxw.txt";



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


//g := x + 1;
g := x^4 + v*x^3 + x^2 + (1+v)*x + 1;
h := R!(x^7 - 1) div R!g;
h;

/*
Elts := [ ];
for i in S do Append(~Elts,i); end for;

HF := [ ];
for i0 in Elts do
    for i1 in Elts do
        for i2 in Elts do
            for i3 in Elts do
                for i4 in Elts do
                    for i5 in Elts do
                        for i6 in Elts do
                         
                            p := R!(i0 + i1*x + i2*x^2 + i3*x^3 + i4*x^4 + i5*x^5 + i6*x^6);
                            if GCD(p,h) eq 1 then
                               Append(~HF,p);
                            end if;
                           
                        end for;
                    end for;
                end for;
            end for;
        end for;
    end for;
end for;
                                                     
#HF;
*/


T<x> := quo< R | x^7 - 1 >;

/*
for f in HF do
//f;
*/

f := x^6 + x^5 + (1+v)*x^4 + (1+v)*x^3 + x^2 + (1+v)*x + v;
gf := (T!g)*(T!f);
//gf;
n := 7;


/*
g:= x + 1;
f := v*x^4 + x^3 + v*x^2 + (1+v)*x + 1;
gf := g*f;
gf;
n := 8;
çç
*/

/*
g :=  x +1+v;
f := 1;
gf := x^2+(1+v)*x ;
n := 4;
*/


r := Degree(g);
A := [ ];
for i  in [1..n] do
  A := A cat Coeff(g,n);
  g := (T!g)*(T!x);
end for;
M1 := Matrix(R, n, n, A); 
//M1;




r := Degree(gf);
A := [ ];
for i  in [1..n] do
  A := A cat Coeff(gf,n);
  gf := (T!gf)*(T!x);
end for;
M2 := Matrix(R, n, n, A); 
//M2;




M := DiagonalJoin(M1,M2); 
M;
N := GetGM(M);
G := GetGrayGM(N);
C := LinearCode<GF(2), 4*n | G>;
d := MinimumDistance(C);
C;

/*
if d lt 8 then
d;
gf;
print " " ;
end if;
*/

//end for;






