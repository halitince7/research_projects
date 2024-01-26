//load "c:/users/mathatin/desktop/tugba/skew/skewIrr.txt";

S<w> := GF(9);
P<v> := PolynomialRing(S);
R<v> := quo< P | v^2 - v >;
T<x> := PolynomialRing(R);

El := [ ];
for i in R do
  if i ne 0 then
     Append(~El,i);
  end if;
end for;


Units := { };
NonUnits := { };
for e1 in El do
  for e2 in El do
     r := e1*e2;

     if r eq 0 then
        Include(~NonUnits,e1);
        Include(~NonUnits,e2);
     end if;

  end for;
end for;
Include(~NonUnits,0);

for e in El do
  if e notin NonUnits then
    Include(~Units,e); 
  end if;
end for;


function f(x)
  return x^3;
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


Irr1 := { };
for r0 in R do

    p := T![r0,1];
    Include(~Irr1,p);

end for;


NIrr2 := { };
for p1 in Irr1 do
  for p2 in Irr1 do
    Include(~NIrr2,Skw(p1,p2));
    Include(~NIrr2,Skw(p2,p1));
  end for;
end for;

Irr2 := { };
for a0 in R do
  for a1 in R do
     p := T![a0,a1,1];
     if p notin NIrr2 then
        Include(~Irr2,p);
     end if;
  end for;
end for;  



f := x^4-1;
H := [ ];
while f ne T!1 do

i := 0;
for p in Irr1 do
    
    if SkewDivision(f,p)[2] eq 0 then 
       Append(~H,p); 
       f := SkewDivision(f,p)[1]; 
    end if;
i := i+1;

end for;

if i eq #Irr1+1 then  break; end if;
end while;
H;



p := Skw(H[3],Skw(H[4], Skw(H[1],H[2])));
p;
ççç
x + 2,
    x + w^6*v + 1,
    x + w^2*v + w,
    x + w^6*v + w^7