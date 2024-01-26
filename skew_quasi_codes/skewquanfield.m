//load "c:/users/mathatin/desktop/quasi_skew/skew/skewquanfield.txt";
F := "c:/users/mathatin/desktop/tugba/skew/99RESSskewquanfield16.txt";

S<w> := GF(9);
P<x> := PolynomialRing(S);
1;

function f(x)
  return x^3;
end function;

function Coeff(f,n)
  H := [ ];
  for i in [0..n-1] do 
    H[i+1] := Coefficient(f,i);
  end for;
  return H;
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




function SkewCyclic(g,n,r) 


H := [ ];
for i  in [0..n-r-1] do

   for j in [0..n-1] do
       Append(~H,Coefficient(g, j));
       end for;

   g := Skw(x,g) mod (x^n-1);
end for;
M := Matrix(S, n-r, n, H);

   C := LinearCode(M);
   d := MinimumDistance(C);
   return C;  

end function;



function Rec(g,n)

g := P!g;
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

p := P!H;

return p;

end function;







n := 6;
g1 := x + 1;
r1 := Degree(g1);
C1 := SkewCyclic(g1,n,r1);

g2 := x+w^6;
r2 := Degree(g2);
C2 := SkewCyclic(g2,n,r2);

C1;
C2;


çççç























Facto := [
x + w^6,
x + w^6,
x + w^3,
x + w^5,

x^2 + x + w^5,
    x^2 + w^2,
    x^2 + w*x + w^3,
    x^2 + 2*x + 2,
    x^2 + w,
    x^2 + w^5*x + w

];


a := 10;
S := {1..a};
SS := Subsets(S);

Write(F,Facto);


Codes := [ ];
GenPolys := [ ];

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




//g := Skw(t[1],t[2]);

//g := Skw(t[1],Skw(t[2],t[3]));

//g := Skw(t[1],Skw(t[2],Skw(t[3],t[4])));

//g := Skw(t[1],Skw(t[2],Skw(t[3],Skw(t[4],t[5]))));

//g := Skw(t[1],Skw(t[2],Skw(t[3],Skw(t[4],Skw(t[5],t[6])))));

//g := Skw(t[1],Skw(t[2],Skw(t[3],Skw(t[4],Skw(t[5],Skw(t[6],Skw(t[7],t[8])))))));




g := 
Skw(t[1],
Skw(t[2],
Skw(t[3],
Skw(t[4],
Skw(t[5],
Skw(t[6],
Skw(t[7],
Skw(t[8],
Skw(t[9],t[10])))))))));



/*
g := 
Skw(t[1],
Skw(t[2],
Skw(t[3],
Skw(t[4],
Skw(t[5],
Skw(t[6],
Skw(t[7],
Skw(t[8],
Skw(t[9],
Skw(t[10],
Skw(t[11],t[12])))))))))));

*/



h   := SkewDivision(x^n-1,g)[1];
hy  := Rec(g,n);
hhy := Skw(hy,h); 

/*
if hhy mod(x^n-1) eq 0 then 

   r := Degree(g);
   C := SkewCyclic(g,n,r); 
   if C notin Codes then
   Append(~Codes,C); 
   Append(~GenPolys,g);
   end if;
   IsSelfOrthogonal(Dual(C));
end if; 
*/

if SkewDivision(hhy,x^n-1)[2] eq 0 then

   r := Degree(g);
   C := SkewCyclic(g,n,r);
   if C notin Codes then
   Append(~Codes,C);
   Append(~GenPolys,g);
   end if;
   IsSelfOrthogonal(Dual(C));
 
end if;


end for;

//Codes;





cn := #Codes;
for i:= 1 to cn do
  d1 := MinimumDistance(Codes[i]);
  for j := 1 to cn do
      d2 := MinimumDistance(Codes[j]);
     
     
              
              MD := [ ];
              Append(~MD,d1); Append(~MD,d2);
              MD := Sort(MD);
              d := MD[1];
              k := Dimension(Codes[i]) + Dimension(Codes[j]);
              k := 2*k - 2*n;
              V := [ ];


           if d ne 1 and k ne 0 then
              Append(~V,2*n); Append(~V,k); Append(~V,d);
              g1 := GenPolys[i];
              g2 := GenPolys[j];
              h1   := SkewDivision(x^n-1,g1)[1];
              hy1  := Rec(g1,n);
              h2   := SkewDivision(x^n-1,g2)[1];
              hy2  := Rec(g2,n);
              
              Write(F,"***************************************************");
              Write(F,"....Ozzaim & Ince Production, All Rights Reserved....");
              Write(F,"***************************************************");

              Write(F,"g1 and g2:");
              Write(F,[g1,g2]);
              Write(F,"h1 and h2:");
              Write(F,[h1,h2]);  
              Write(F,"hy1 and hy2:");
              Write(F,[hy1,hy2]);             
              Write(F,"Parameters:");
              Write(F,V);
            end if;
  
end for; end for; 



