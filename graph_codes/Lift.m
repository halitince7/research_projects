//load "c:/users/mathatin/desktop/fzehra/Lift.txt";

Res := "c:/users/mathatin/desktop/fzehra/ResLift.txt";


P<u,v> := PolynomialRing(GF(2),2);
H := quo< P | u^2 + v^2 , u*v >;
R1<x> := PolynomialRing(H);

T := [ 0,1,u,v,v^2,1+u,1+v,1+v^2,u+v,u+v^2,v+v^2,
1+u+v,1+u+v^2, 1+v+v^2,u+v+v^2,1+u+v+v^2 ];

function Ln(s)
   i := 0;
   for p in s do
       i := 1 + i;
   end for;
   return i;
end function;


function Project(p) 
  p := H!p;
  S := {0,1};
  for a in S do
      for b in S do
          for c in S do
              for d in S do
                  x := a*1 + b*u + c*v + d*u^2;
                  x := H!x;
                  if x + p eq 0 then
                     return a;
                  end if;
               end for;
          end for;
       end for;
   end for;
end function;


function Lift(c)
 
   A := [ ];
   
   for p in T do 
       if  Project(p) eq c then
           Append(~A,p);
       end if;
   end for;

   return A;

end function;



function LiftSEq(Ra) 
   
   n := Ln(Ra);
   Lifts := [ ];
   A := [ ];
   
   for i := 1 to n do 
       Append(~A,Lift(Ra[i]));
   end for;

   
for p1 in A[1] do 
for p2 in A[2] do 
for p3 in A[3] do
    B := [ ];
    B := [p1,p2,p3];
    Append(~Lifts,B);
end for; 
end for; 
end for;   
         
return Lifts;

end function;


Ra := [0,1,0];
Rb := [1,1,1];

L1 := LiftSEq(Ra);
L2 := LiftSEq(Rb);


Write(Res,"L1 :=");
Write(Res,L1);
Write(Res,";");
Write(Res," ");
Write(Res,"L2 :=");
Write(Res,L2);
Write(Res,";");











