//load "c:/users/mathatin/desktop/poly_Rq.txt";


p := 3;
s := 2;
q := p^s;
F<w> := GF(q);
P<u> := PolynomialRing(F);
P1<u>:=quo< P | u^2>;
R1<v>:= PolynomialRing(P1);
R<v> :=quo< R1 | v^2>;
T<x> := PolynomialRing(R);


function Gray(p)
  p := R!p;
  S := {0,1};
  for a in F do
      for b in F do
          for c in F do
              for d in F do
                  x := a*1 + b*u + c*v + d*u*v;
                  x := R!x;
                  if x + p eq 0 then
                     return [F!(a+b+c+d),F!(c+d),F!(b+d),F!(d)];
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

function Get_Code(G,n)

//G;       
CWs := [ ];
for i in [1..n] do
   Append(~CWs,G[i]);
   Append(~CWs,u*G[i]);
   Append(~CWs,v*G[i]);
   Append(~CWs,u*v*G[i]);
end for;

//CWs;



TT := [ ];
  for j in [1..#CWs] do
     A := [ ];
     for i in [1..n] do;
        //CWs[j][i];
        A := Gray(CWs[j][i]) cat A;
     end for;
     Append(~TT,A);
  end for;
//TT;
C := LinearCode< F, 4*n | TT >; 

return C;

end function;






Irr1 := { x, x+1 ,x+u, x+v,  x+u+1,  x+v+1, x+u+v, x+u+v+1 };

NIrr2 := { };
for p1 in Irr1 do
  for p2 in Irr1 do
    Include(~NIrr2,p1*p2);
  end for;
end for;


i := 0;
Irr2 := { };
for a0 in R do     if i eq 10000 then break; end if;
  for a1 in R do      if i eq 10000 then break; end if;
     p := a0 + a1*x + x^2;
     if p notin NIrr2 then
        Include(~Irr2,p); i:=i+1; 
     end if;
  end for;
end for;  


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

i := 0;
for a0 in R do    if i eq 10000 then break; end if;
  for a1 in R do     if i eq 10000 then break; end if;
    for a2 in R do      if i eq 10000 then break; end if;
       p := a0 + a1*x + a2*x^2 + x^3;
       if p notin NIrr3 then
          Include(~Irr3,p); i:=i+1;  if i eq 10000 then break; end if;
       end if;
     end for;
  end for;
end for;  










dosya1 := "c:/users/mathatin/desktop/R9_n28.txt";
dosya2 := "c:/users/mathatin/desktop/R9_n28_param.txt";

Codes  := [];
n := 7;

for p1 in Irr3 do
  for p2 in Irr3 do
    for p3 in Irr1 do

   

      p := p1*p2*p3;
      Tv := Transpose(CompanionMatrix(p));
      P1 := [ ]; P2 := [ ]; P3 := [ ];
      Append(~P1,x^0); Append(~P2,x^0); Append(~P3,x^0);
      Append(~P1,p1);  Append(~P2,p2);  Append(~P3,p3);

      for f1 in P1 do 
          for f2 in P2 do 
              for f3 in P3 do 
                  

                  PP := [f1,f2,f3];
                  f := f1*f2*f3;
                  G := Transpose( Evaluate(f, Tv ) );
                  C := Get_Code(G,n);
                  d := MinimumDistance(C);
                  k := Dimension(C);
                  J := [ ];
                  Append(~J,4*n);
                  Append(~J,k);
                  Append(~J,d);
                  
                  if J notin Codes then 
                     Append(~Codes,J);
                     C;
                     if IsMDS(C) then printf "MDSMDSMDSMDSMDSMDSMDSMDSMDSM"; end if;
                     C2 :=  BKLC(F, 4*n, k); 
                     db := MinimumDistance(C2); 

                     if d ge db and d ge 2 and k ne 0 then 
                      
                        Write(dosya2,J);
                        Write(dosya1,p);
                        Write(dosya1,PP);
                        Write(dosya1,f);
                        Write(dosya1,C);
                        Write(dosya1,"====================================");
                     end if;
                  end if;


end for; 
end for; 
end for; 

end for; 
end for;
end for;



