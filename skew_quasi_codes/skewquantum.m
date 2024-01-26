//load "c:/users/mathatin/desktop/tugba/skew/skewquantum.txt";

S<w> := GF(4);
P<v> := PolynomialRing(S);
R<v> := quo< P | v^2 - v >;
T<x> := PolynomialRing(R);



function f(x)
  return x^2;
end function;



function Skew(p,h)
  p := T ! p;
  h := T ! h;

  if p eq 0 or h eq 0 then
  return 0;
  end if;

  if Degree(p) eq 0 then
  return p*h;
  
  elif Degree(p) eq 1 then
  a := f(Coefficient(h,Degree(h)));
  return  Coefficient(p,Degree(p))*a*x^(Degree(p)+Degree(h));

  else
    a := f(Coefficient(h,Degree(h)));
    for i in [2..Degree(p)] do
      a := f(a);
    end for;
  return Coefficient(p,Degree(p))*a*x^(Degree(p)+Degree(h));
  end if;
end function;


function Skw(g,t)
  g := T ! g;
  t := T ! t;

  s := 0; 
  for i in [0..Degree(g)] do
    for j in [0..Degree(t)] do
      s := s + Skew((T ! Coefficient(g,i)*x^i) ,(T ! Coefficient(t,j)*x^j));
   end for;
  end for;
return s;
end function;






function Coeff(f,n)
  H := [ ];
  for i in [0..n-1] do 
    H[i+1] := Coefficient(f,i);
  end for;
  return H;
end function;

function Gry(p)
p := R!p;
H := [ ];
for i in [0..1] do 
  H[i+1] := Coefficient(p,i);
end for;
return [H[1],H[1]+H[2]];
end function;


function IsZeroDiv(f)

for i0 in R do
    for i1 in R do
        for i2 in R do
            for i3 in R do
                

                         
                            p := T![i0,i1,i2,i3];
                            if p ne 0 and Skw(p,f) mod (x^4 - 1) eq 0 then 
                               return 0;
                            elif Skw(p,f) mod (x^4 - 1) eq 1 then 
                               return 1;
                            end if;
                           

                
            end for;
        end for;
    end for;
end for;

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

function SkewDivision(f,g)

    f := T!f;
    g := T!g;

    hh := T!0;
    while Degree(f) ge Degree(g) do   
    
    Df := Degree(f);
    Dg := Degree(g);  
    Dh1 := Df-Dg;    
    Lcf := LeadingCoefficient(f);
    Lcg := LeadingCoefficient(g);
    f1 := T!(Lcf*x^Df);
    g1 := T!(Lcg*x^Dg);
    
    for r in R do 
        h1 := T!(r*x^Dh1);
        if Skw(h1,g1) eq f1 then
           h := h1;
           f := T!(f - Skw(h,g));  
           hh := T!(hh+h);
           break;
        end if;
     end for;
     

 
    end while;

    Res := [hh,f];
    return Res;

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




function SkewCyclic(g,n,r) 


H := [ ];
for i  in [0..n-r-1] do

   for j in [0..n-1] do
       Append(~H,Coefficient(g, j));
       end for;

   g := Skw(x,g) mod (x^n-1);
end for;

M := Matrix(R, n-r, n, H);
N := GetGM(M);
G := GetGrayGM(N);
C := LinearCode< S, 2*n | G>;
d := MinimumDistance(C);
return C;  

end function;







function Rec(g,n)

g := T!g;
r := Degree(g);
h := SkewDivision(x^n-1,g)[1];
D := Coeff(h,n-r+1);
H := [ ];

for i := 0 to n-r do
   
    a := D[n-r+1-i];
    for j := 0 to i-1 do
        a := f(a);
    end for;   
    Append(~H,a);

end for;

p := T!H;

return p;

end function;

p1 := x^4-1;
p2 := x^2+x+w^2+v;
SkewDivision(p1,p2);
ççç


Fac := [];
    
n:= 4;
g := x^2 + w*x + w;

Rec(g,n);




































