//load "c:/users/mathatin/desktop/tugba/skew/skewdivfield.txt";

S<w> := GF(9);
P<x> := PolynomialRing(S);



/*
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
*/

function f(x)
  return x^3;
end function;



function Skew(p,h)
  p := P ! p;
  h := P ! h;

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
  g := P ! g;
  t := P ! t;

  s := 0; 
  for i in [0..Degree(g)] do
    for j in [0..Degree(t)] do
      s := s + Skew((P ! Coefficient(g,i)*x^i) ,(P ! Coefficient(t,j)*x^j));
   end for;
  end for;
return s;
end function;



function SkewDivision(f,g)

    f := P!f;
    g := P!g;

    hh := P!0;
    while Degree(f) ge Degree(g) do   
    
    Df := Degree(f);
    Dg := Degree(g);  
    Dh1 := Df-Dg;    
    Lcf := LeadingCoefficient(f);
    Lcg := LeadingCoefficient(g);
    f1 := P!(Lcf*x^Df);
    g1 := P!(Lcg*x^Dg);
    
    for r in S do 
        h1 := P!(r*x^Dh1);
        if Skw(h1,g1) eq f1 then
           h := h1;
           f := P!(f - Skw(h,g));  
           hh := P!(hh+h);
           break;
        end if;
     end for;
     

 
    end while;

    Res := [hh,f];
    return Res;

end function;


Irr1 := { };
for r0 in S do

    p := P![r0,1];
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
for a0 in S do
  for a1 in S do
     p := P![a0,a1,1];
     if p notin NIrr2 then
        Include(~Irr2,p);
     end if;
  end for;
end for;  



NIrr3 := { };
for p1 in Irr1 do
  for p2 in Irr1 do
      for p3 in Irr1 do
    Include(~NIrr3,Skw(p1,Skw(p2,p3)));
    //Include(~NIrr3,Skw(p1,Skw(p3,p2)));
    //Include(~NIrr3,Skw(p2,Skw(p1,p3)));
    //Include(~NIrr3,Skw(p2,Skw(p3,p1)));
    //Include(~NIrr3,Skw(p3,Skw(p1,p2)));
    //Include(~NIrr3,Skw(p3,Skw(p2,p1)));
      end for;
  end for;
end for;

for p1 in Irr1 do
  for p2 in Irr2 do
    Include(~NIrr3,Skw(p1,p2));
    Include(~NIrr3,Skw(p2,p1));
  end for;
end for;



Irr3 := { };
for a0 in S do
  for a1 in S do
    for a2 in S do
       p := P![a0,a1,a2,1];
       if p notin NIrr3 then
          Include(~Irr3,p);
       end if;
     end for; 
  end for;
end for;  





NIrr4 := { };
for p1 in Irr1 do
  for p2 in Irr1 do
      for p3 in Irr1 do
          for p4 in Irr1 do
    Include(~NIrr4,Skw(p1,Skw(p2,Skw(p3,p4))));
    //Include(~NIrr3,Skw(p1,Skw(p3,p2)));
    //Include(~NIrr3,Skw(p2,Skw(p1,p3)));
    //Include(~NIrr3,Skw(p2,Skw(p3,p1)));
    //Include(~NIrr3,Skw(p3,Skw(p1,p2)));
    //Include(~NIrr3,Skw(p3,Skw(p2,p1)));
           end for;
      end for;
  end for;
end for;

for p1 in Irr2 do
  for p2 in Irr2 do
    Include(~NIrr4,Skw(p1,p2));
    Include(~NIrr4,Skw(p2,p1));
  end for;
end for;


for p1 in Irr2 do
  for p2 in Irr1 do
      for p3 in Irr1 do
    Include(~NIrr4,Skw(p1,Skw(p2,p3)));
/*
    Include(~NIrr4,Skw(p1,Skw(p3,p2)));
    Include(~NIrr4,Skw(p2,Skw(p1,p3)));
    Include(~NIrr4,Skw(p2,Skw(p3,p1)));
    Include(~NIrr4,Skw(p3,Skw(p1,p2)));
    Include(~NIrr4,Skw(p3,Skw(p1,p2)));
*/
    end for;
  end for;
end for;



for p1 in Irr1 do
  for p2 in Irr3 do
    Include(~NIrr4,Skw(p1,p2));
    Include(~NIrr4,Skw(p2,p1));
  end for;
end for;

Irr4 := { };
for a0 in S do
  for a1 in S do
    for a2 in S do
        for a3 in S do
       p := P![a0,a1,a2,a3,1];
       if p notin NIrr4 then
          Include(~Irr4,p);
       end if;
       end for;
     end for; 
  end for;
end for;  








f := x^16-1;



f := SkewDivision(f, x + w^6)[1];
f := SkewDivision(f, x + w^5)[1];
f := SkewDivision(f, x + w^3)[1];
f := SkewDivision(f, x + w^6)[1];


//f := SkewDivision(f,x + w^5)[1];
//f := SkewDivision(f,x + w^3)[1];
//f := SkewDivision(f,x + w^5)[1];
//f := SkewDivision(f,x + w^3)[1];
//f := SkewDivision(f,x + w^7)[1];
//f := SkewDivision(f,x + w)[1];
//f := SkewDivision(f,  x + 2)[1];
//f := SkewDivision(f, x + 1)[1];


//f := SkewDivision(f,x + w^2)[1];
//f := SkewDivision(f, x + w^6)[1];

//f := SkewDivision(f, x + w^2)[1];
//f := SkewDivision(f, x + w)[1];
//f := SkewDivision(f, x^2 + x + 1)[1];
//f := SkewDivision(f, x^2 + x + 1)[1];

//f := SkewDivision(f,  x^3 + x^2 + x + w)[1];
f;

H := [ ];
for p in Irr2 do 
    if SkewDivision(f,p)[2] eq 0 then
       Append(~H,p); 
       f := SkewDivision(f,p)[1]; 
    end if;
end for;

H;








