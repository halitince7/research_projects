//load "c:/users/mathatin/desktop/halit/poly_2u.txt";
F := "c:/users/mathatin/desktop/pol_13u.txt";

Z2   := IntegerRing(2);
P<u> := PolynomialRing(Z2);
R<u> := quo< P | u^2 - 0 >;
T<x> := PolynomialRing(R);

function Coeff(f,n)
  H := [ ];
  for i in [0..n-1] do 
    H[i+1] := Coefficient(f,i);
  end for;
  return H;
end function;

// Bu halkada Gray donusum fonksiyonu:
function Gry(x)
if x eq u   then return [1,1]; end if;
if x eq u+1 then return [1,0]; end if;
if x eq 1   then return [0,1]; end if;
if x eq 0   then return [0,0]; end if;
return 0;
end function;



Irr1 := { x,x+1,x+u,x+u+1};

NIrr2 := { };
for p1 in Irr1 do
  for p2 in Irr1 do
    Include(~NIrr2,p1*p2);
  end for;
end for;

Irr2 := { };
for a0 in R do
  for a1 in R do
     p := a0 + a1*x + x^2;
     if p notin NIrr2 then
        Include(~Irr2,p);
     end if;
  end for;
end for;  
 Irr2;
ççç
NIrr3 := { };
for p1 in Irr1 do
  for p2 in Irr1 do
    for p3 in Irr1 do
        Include(~NIrr3,p1*p2*p3);
    end for;
  end for;
end for;
for p1 in Irr1 do
  for p2 in Irr2 do
    Include(~NIrr3,p1*p2);
  end for;
end for;

Irr3 := { };
for a0 in R do
  for a1 in R do
    for a2 in R do
       p := a0 + a1*x + a2*x^2 + x^3;
       if p notin NIrr3 then
          Include(~Irr3,p);
       end if;
     end for;
  end for;
end for;  
//#Irr3;



Der7 := [ ];
Div := [ ];
for p1 in Irr3 do
  for p2 in Irr3 do
    for p3 in Irr3 do
      for p4 in Irr2 do
        for p5 in Irr2 do
        p := p1*p2*p3*p4*p5;
        AA := [ ];
        if p notin Der7 then
          AA := [p1,p2,p3,p4,p5];
          Append(~Der7,p);
          Append(~Div,AA);
        end if;
     end for; 
   end for;
end for;
end for; 
end for;
#Der7;

n := 13;

OP := [ ];
for i in [1..#Der7] do

f1 := [ ];
f2 := [ ];
f3 := [ ];
f4 := [ ];
f5 := [ ];
Append(~f1,x^0);
Append(~f2,x^0);
Append(~f3,x^0);
Append(~f4,x^0);
Append(~f5,x^0);

   f := Der7[i];
   Append(~f1,Div[i][1]);
   Append(~f2,Div[i][2]);
   Append(~f3,Div[i][3]);
   Append(~f4,Div[i][4]);
   Append(~f5,Div[i][5]);
   Tv := Transpose(CompanionMatrix(f));
   
for p1 in f1 do 
  for p2 in f2 do 
    for p3 in f3 do 
      for p4 in f4 do
        for p5 in f5 do
PP := [ ];
PP := [p1,p2,p3,p4,p5];

G :=Transpose( Evaluate(p1*p2*p3*p4*p5, Tv ) );
//G;       
CWs := [ ];
for i in [1..n] do
   Append(~CWs,G[i]);
   Append(~CWs,u*G[i]);
end for;

//CWs;



TT := [ ];
  for j in [1..#CWs] do
     A := [ ];
     for i in [1..n] do;
        //CWs[j][i];
        A := Gry(CWs[j][i]) cat A;
     end for;
     Append(~TT,A);
  end for;
//TT;
C := LinearCode< GF(2), 2*n | TT >;
d := MinimumDistance(C);
k := Dimension(C);
C2 :=  BKLC(GF(2), 2*n, k);
db := MinimumDistance(C2);



if d ge db and d ge 2 then 
J := [ ];
Append(~J,2*n);
Append(~J,k);
Append(~J,d);
  if J notin OP then
   C;
   Append(~OP,J);
  end if;
Write(F,"------------------------");
Write(F,f);
Write(F,Div[i]);
Write(F,PP);
Write(F,C);


   if IsMDS(C) then
      C;
      print " MMMMMMMMMMMMMMMMMMMMMMMMM";
      Write(F,"MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS MDS");
   end if;

Write(F,"------------------------");
end if;
     

end for; 
end for; 
end for; 
end for;
 end for;

end for;
OP;