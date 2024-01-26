//load "c:/users/mathatin/desktop/quasiskewdriveyeni8.txt";
F := "c:/users/mathatin/desktop/RESQUASI/RES_quasi_gf4_n8.txt";

S<w> := GF(4);
P<v> := PolynomialRing(S);
R<v> := quo< P | v^2 - v >;
T<x> := PolynomialRing(R);

n:=8;

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


function IsZeroDiv(f,n)

for i0 in R do
    for i1 in R do
        for i2 in R do
            for i3 in R do
                
        for i4 in R do    for i5 in R do
        for i6 in R do    for i7 in R do
                         
                            p := T![i0,i1,i2,i3,i4,i5,i6,i7];
                            if p ne 0 and Skw(p,f) mod (x^n - 1) eq 0 then 
                               return 0;
                            elif Skw(p,f) mod (x^n - 1) eq 1 then 
                               return 1;
                            end if;
                           
            end for; end for;
            end for; end for;
               
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
N := Matrix(R, n-r, n, H);

return N;
end function;



function SkewQuasi(g,f,n,r)

   M1 := SkewCyclic(g,n,r);
   M2 := SkewCyclic(f,n,r);
   M  := HorizontalJoin(M1,M2);
   //M  := HorizontalJoin(M,M);
   N := GetGM(M);
   G := GetGrayGM(N);
   C := LinearCode< S, 4*n | G>;
   d := MinimumDistance(C);
   return C;  

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








f := x^n-1;
f;
Facto := [ ];
i:=0;
while i lt 8 do
i:=i+1;
for p in Irr1 do 
    if SkewDivision(f,p)[2] eq 0 then
       Append(~Facto ,T!p); 
       f := SkewDivision(f,p)[1]; 
    end if;
end for;
end while;



i:=0;
while i lt 5 do
i:=i+1;
for p in Irr2 do 
    if SkewDivision(f,p)[2] eq 0 then
       Append(~Facto ,T!p); 
       f := SkewDivision(f,p)[1]; 
    end if;
end for;
end while;

i:=0;
while i lt 5 do
i:=i+1;
for p in Irr3 do 
    if SkewDivision(f,p)[2] eq 0 then
       Append(~Facto ,T!p); 
       f := SkewDivision(f,p)[1]; 
    end if;
end for;
end while;

i:=0;
while i lt 5 do
i:=i+1;
for p in Irr4 do 
    if SkewDivision(f,p)[2] eq 0 then
       Append(~Facto ,T!p); 
       f := SkewDivision(f,p)[1]; 
    end if;
end for;
end while;

Facto;
Write(F,f);
Write(F,Facto);


if f ne 1 then
Append(~Facto ,f);
f := 1;
end if;



a := #Facto;
S := {1..a};
SS := Subsets(S);
Divs := [ ];



for s in SS do



ss := SetToSequence(s);


t := [ ];
for k := 1 to a do 
  if k in ss then
    Append(~t,P!Facto[k]);
  else
     Append(~t,P!1);
  end if;
end for;



if a eq 2 then
g := Skw(t[2],t[1]);

elif a eq 3 then
g := Skw(t[3],Skw(t[2],t[1]));

elif a eq 4 then
g :=
Skw(t[4],
Skw(t[3],
Skw(t[2],t[1])));

elif a eq 5 then
g :=
Skw(t[5],
Skw(t[4],
Skw(t[3],
Skw(t[2],t[1]))));

elif a eq 6 then
g :=
Skw(t[6],
Skw(t[5],
Skw(t[4],
Skw(t[3],
Skw(t[2],t[1])))));

elif a eq 7 then
g :=
Skw(t[7],
Skw(t[6],
Skw(t[5],
Skw(t[4],
Skw(t[3],
Skw(t[2],t[1]))))));

elif a eq 8 then
g :=
Skw(t[8],
Skw(t[7],
Skw(t[6],
Skw(t[5],
Skw(t[4],
Skw(t[3],
Skw(t[2],t[1])))))));

elif a eq 9 then
g :=
Skw(t[9],
Skw(t[8],
Skw(t[7],
Skw(t[6],
Skw(t[5],
Skw(t[4],
Skw(t[3],
Skw(t[2],t[1]))))))));

elif a eq 10 then
g :=
Skw(t[10],
Skw(t[9],
Skw(t[8],
Skw(t[7],
Skw(t[6],
Skw(t[5],
Skw(t[4],
Skw(t[3],
Skw(t[2],t[1])))))))));

elif a eq 11 then
g :=
Skw(t[11],
Skw(t[10],
Skw(t[9],
Skw(t[8],
Skw(t[7],
Skw(t[6],
Skw(t[5],
Skw(t[4],
Skw(t[3],
Skw(t[2],t[1]))))))))));

elif a eq 12 then
g :=
Skw(t[12],
Skw(t[11],
Skw(t[10],
Skw(t[9],
Skw(t[8],
Skw(t[7],
Skw(t[6],
Skw(t[5],
Skw(t[4],
Skw(t[3],
Skw(t[2],t[1])))))))))));

elif a eq 13 then
g :=
Skw(t[13],
Skw(t[12],
Skw(t[11],
Skw(t[10],
Skw(t[9],
Skw(t[8],
Skw(t[7],
Skw(t[6],
Skw(t[5],
Skw(t[4],
Skw(t[3],
Skw(t[2],t[1]))))))))))));

elif a eq 14 then
g :=
Skw(t[14],
Skw(t[13],
Skw(t[12],
Skw(t[11],
Skw(t[10],
Skw(t[9],
Skw(t[8],
Skw(t[7],
Skw(t[6],
Skw(t[5],
Skw(t[4],
Skw(t[3],
Skw(t[2],t[1])))))))))))));

elif a eq 15 then
g :=
Skw(t[15],
Skw(t[14],
Skw(t[13],
Skw(t[12],
Skw(t[11],
Skw(t[10],
Skw(t[9],
Skw(t[8],
Skw(t[7],
Skw(t[6],
Skw(t[5],
Skw(t[4],
Skw(t[3],
Skw(t[2],t[1]))))))))))))));

elif a eq 16 then
g :=
Skw(t[16],
Skw(t[15],
Skw(t[14],
Skw(t[13],
Skw(t[12],
Skw(t[11],
Skw(t[10],
Skw(t[9],
Skw(t[8],
Skw(t[7],
Skw(t[6],
Skw(t[5],
Skw(t[4],
Skw(t[3],
Skw(t[2],t[1])))))))))))))));

elif a eq 17 then
g :=
Skw(t[17],
Skw(t[16],
Skw(t[15],
Skw(t[14],
Skw(t[13],
Skw(t[12],
Skw(t[11],
Skw(t[10],
Skw(t[9],
Skw(t[8],
Skw(t[7],
Skw(t[6],
Skw(t[5],
Skw(t[4],
Skw(t[3],
Skw(t[2],t[1]))))))))))))))));

elif a eq 18 then
g :=
Skw(t[18],
Skw(t[17],
Skw(t[16],
Skw(t[15],
Skw(t[14],
Skw(t[13],
Skw(t[12],
Skw(t[11],
Skw(t[10],
Skw(t[9],
Skw(t[8],
Skw(t[7],
Skw(t[6],
Skw(t[5],
Skw(t[4],
Skw(t[3],
Skw(t[2],t[1])))))))))))))))));

elif a eq 20 then
g :=
Skw(t[20],
Skw(t[19],
Skw(t[18],
Skw(t[17],
Skw(t[16],
Skw(t[15],
Skw(t[14],
Skw(t[13],
Skw(t[12],
Skw(t[11],
Skw(t[10],
Skw(t[9],
Skw(t[8],
Skw(t[7],
Skw(t[6],
Skw(t[5],
Skw(t[4],
Skw(t[3],
Skw(t[2],t[1])))))))))))))))))));

end if;


Append(~Divs,g);


p1 := g;



for p2 in Divs do

        g := (1-v)*p1+v*p2; 
        r := Degree(g);
        if Coefficient(g,r) eq 1 then
Write(F,"||||||||||||||||||||||||||||||||||||||||||||||||||||");
Write(F,"yeni p1,p2:");
Write(F,p1);
Write(F,p2);
Write(F,"yeni g:");
Write(F,g);
Write(F, " ");
Write(F, " ");
        //print " new g:";         
        //g; 
        
        h := SkewDivision(x^n-1,g)[1];
        
syc := 0;





for a0 in R do for a1 in R do for a2 in R do for a3 in R do

     for a4 in R do for a5 in R do
     for a6 in R do for a7 in R do

if syc eq 2 then break; end if;
  
     aa := T![a0,a1,a2,a3,a4,a5,a6,a7];


for b0 in R do for b1 in R do for b2 in R do for b3 in R do

     for b4 in R do for b5 in R do
     for b6 in R do for b7 in R do

if syc eq 2 then break; end if;
   
     b := T![b0,b1,b2,b3,b4,b5,b6,b7];



for c0 in R do for c1 in R do for c2 in R do  for c3 in R do

     for c4 in R do  for c5 in R do
     for c6 in R do  for c7 in R do

if syc eq 2 then break; end if;
    
     f := T![c0,c1,c2,c3,c4,c5,c6,c7];  




if  Skw(b,f) mod (x^n-1) ne 0 and Skw(aa,h)+Skw(b,f) mod (x^n-1) eq 1   then 


      // if IsZeroDiv(f,n) eq 1 then


              //f;
              gf := Skw(f,g) mod(x^n-1);
              //gf;
              C := SkewQuasi(g,gf,n,r);
              C;
              syc := syc +1;
              if syc eq 2 then break; end if;

Write(F,"f,gf: ");
Write(F,f);
Write(F,gf);
Write(F,C);
Write(F, " ");

      //  end if;
end if;






end for;
end for;
end for;
end for;
end for; end for;
end for; end for;

end for;
end for;
end for;
end for;
end for; end for;
end for; end for;

end for;
end for;
end for;
end for;
end for; end for;
end for; end for;



end if;

end for;
end for;
























