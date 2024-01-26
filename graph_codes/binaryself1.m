 //load "c:/users/acer/desktop/fzehra/binaryself1.txt";

Res := "c:/users/mathatin/desktop/fzehra/RESbinaryself.txt";


H := GF(2);
R1<x> := PolynomialRing(H);





T:= [ 0,1];


Units := {1 };
NonUnits := { 0};


function JJ(n)

M := ScalarMatrix(R1,n,1);

for i in [1..n] do
  for j in [1..n] do
     M[i][j] := 1;
  end for;
end for;

return M;

end function;





function Summ(s)
S := 0;
for e in s do
  S := S + H!e;
end for;
S := H!S;
return S;
end function;



function Ln(s)
i := 0;
for p in s do
  i := 1 + i;
end for;
return i;
end function;





function Fcirc(s,lam)
   
   n := Ln(s);
   w := [ ];
   A := [ ];
   for i in [1..n] do
     A := A cat s;
    
     for j in [2..n] do
       w[j] := s[j-1];
     end for;
     w[1] := lam*s[n];
     s := w;  
   end for;
   M := Matrix(H, n, n, A); 
   return M;

end function;




function Rcirc(s,lam)

   n := Ln(s);
   w := [ ];
   A := [ ];
   for i in [1..n] do
     A := A cat s;
    
     for j in [2..n] do
       w[j-1] := s[j];
     end for;
     w[n] := lam*s[1];
     s := w;  
   end for;
   M := Matrix(H, n, n, A); 
   return M;

end function;




function Thm31(Ra,Rb,z1)

A := Fcirc(Ra,z1);
B := Rcirc(Rb,z1);

n := Nrows(A);

I := ScalarMatrix(R1,2*n,1);
R0 := HorizontalJoin(A,B);
R2 := HorizontalJoin(-B,A); 

R := VerticalJoin(R0,R2);

M := HorizontalJoin(I,R);


C := LinearCode(M);
return C;

end function;






Ra := [ ];
Rb := [ ];

for a1 in T do 
for a2 in T do 
for a3 in T do 
for a4 in T do 
 
Ra := [a1,a2,a3,a4];

for b1 in T do 
for b2 in T do 
for b3 in T do 
for b4 in T do 

Rb := [b1,b2,b3,b4];


for z1 in Units do

A := Fcirc(Ra,z1);
B := Rcirc(Rb,z1);	
I := ScalarMatrix(R1,Ln(Ra),1);
J := JJ(Ln(Ra));
At := Transpose(A);
Bt := Transpose(B);
a := A*At + B*Bt;;

 
 if a eq I then 
    C := Thm31(Ra,Rb,z1);
               if not IsSelfDual(C) then 0;  end if;      
           d := MinimumDistance(C); 
           if d ge 12 then
              C;
              IsSelfDual(C);
              //Dimension(C); C;
           end if;
  end if;


end for;


end for; end for; end for; end for;
end for; end for; end for; end for;






