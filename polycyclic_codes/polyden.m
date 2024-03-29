//load "c:/users/mathatin/desktop/polyden.txt";


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
//Irr2;

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
    for p3 in Irr1 do
      p := p1*p2*p3;
        if p notin Der7 then
          A := [p1,p2,p3];
          Append(~Der7,p);
          Append(~Div,A);
        end if;
     end for; 
   end for;
end for;
#Der7;











f  := x^7 + u*x^6 + u*x^5 + (u+1)*x^4 + x^2 + x;
f1 := x^3 + x^2 + (u + 1)*x + 1; 
f2 := x^3 + (u + 1)*x^2 + u*x + 1;
f3 := x ;
n := 7;


Tv := Transpose(CompanionMatrix(f));
G := Transpose(Evaluate(f2, Tv ));
MinimalPolynomial(G);
//G;

����
CWs := [ ];
for i in [1..7] do
   Append(~CWs,G[i]);
   Append(~CWs,u*G[i]);
end for;







T := [ ];
  for j in [1..#CWs] do
     A := [ ];
     for i in [1..7] do;
        //CWs[j][i];
        A := Gry(CWs[j][i]) cat A;
     end for;
     Append(~T,A);
  end for;
//T;
C1 := LinearCode< GF(2), 14 | T >;

time C1;







G := Evaluate(f1*f3, Tv );
//G;



CWs := [ ];
for a0 in R do
  for a1 in R do
    for a2 in R do
      for a3 in R do
        for a4 in R do
          for a5 in R do
            for a6 in R do 
              Q := [a0,a1,a2,a3,a4,a5,a6];
              cw := Matrix(R, 7, 1, Q);
              if G*cw eq 0 then
                 Append(~CWs,cw);
              end if;
              Q := [ ];

end for;end for;end for;end for;end for;end for;end for;

//CWs;

T := [ ];
  for j in [1..#CWs] do
     A := [ ];
     for i in [1..7] do;
        //CWs[j][i]
        A := Gry(CWs[j][i][1]) cat A;
     end for;
     Append(~T,A);
  end for;
//T;
C2 := LinearCode< GF(2), 14 | T >;

time C2;
C1 eq C2;