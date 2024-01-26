//load "c:/users/mathatin/desktop/ideal_skew.txt";

S<w> := GF(4);
P<v> := PolynomialRing(S);
R<v> := quo< P | v^2 - v >;
T<x> := PolynomialRing(R);
TT<x> := quo< T | x^4 - 1 >;

A := [];
for p in TT do
 Append(~A,p);
end for;

T<x> := PolynomialRing(R);


function f(e)
  return e^2;
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


function IsZeroDiv(f)

for i0 in R do
    for i1 in R do
        for i2 in R do
            for i3 in R do
                

                         
                            p := T!(i0 + i1*x + i2*x^2 + i3*x^3);
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


function Coeff(f,n)
  H := [ ];
  for i in [0..n-1] do 
    H[i+1] := Coefficient(f,i);
  end for;
  return H;
end function;



function SkewCyclic(g,n) 

r := Degree(g);
H := [ ];
for i  in [0..n-1] do

   for j in [0..n-1] do
       Append(~H,Coefficient(g, j));
   end for;

   g := Skw(x,g) mod (x^n-1);
end for;
N := Matrix(R, n, n, H);

return N;
end function;



function SkewQuasi(g,f,n)

   M1 := SkewCyclic(g,n);
   M2 := SkewCyclic(f,n);
   M  := HorizontalJoin(M1,M2);
   //M  := HorizontalJoin(M,M);
   N := GetGM(M);
   G := GetGrayGM(N);
   C := LinearCode< S, 4*n | G>;
   d := MinimumDistance(C);
   return C;  

end function;






n := 4;

p1 := x^2+x+w^2;
p2 := x^2+x+w;

g := (1+v)*p1+v*p2;
h := (1+v)*p2+v*p1;

gf := x^3 + x^2 + (v + w)*x; 
I1 := { };
I2 := { };


for p in A do 
    p1 := p;
    aa1 := Skw(p1,g) mod (x^n-1);
    aa2 := Skw(p1,gf) mod (x^n-1);
    Include(~I1,aa1);
    Include(~I2,aa2);
end for;
I1 eq I2;


çççç

R1 := [ ];
for r in R do if r ne 0 then Append(~R1,r); end if; end for;

for a0 in R do
  for a1 in R do
    for a2 in R do
      for a3 in R do



  
     a := ( T ! (a0 + a1*x + a2*x^2 + a3*x^3) );


for b0 in R do
  for b1 in R do
    for b2 in R do
      for b3 in R do
   
     b := ( T ! (b0 + b1*x + b2*x^2 + b3*x^3) );



for c0 in R do
  for c1 in R do
    for c2 in R do
      for c3 in R do

    
     f := ( T ! (c0 + c1*x + c2*x^2 + c3*x^3) );  




if  Skw(b,f) mod (x^n-1) ne 0 and Skw(a,h)+Skw(b,f) mod (x^n-1) eq 1   then 
    if IsZeroDiv(f) eq 1 then


f;
gf := Skw(f,g) mod (x^n-1);
gf;
I1 := {};
I2 := {};


for p in A do 
    p1 := p;
    aa1 := Skw(p1,g) mod (x^n-1);
    aa2 := Skw(p1,gf) mod (x^n-1);
    Include(~I1,aa1);
    Include(~I2,aa2);
end for;
I1 eq I2;

    end if;
end if;



end for;
end for;
end for;
end for;

end for;
end for;
end for;
end for;

end for;
end for;
end for;
end for;




































