//load "c:/users/mathatin/desktop/fzehra/GraphLift_exring.txt";
Res := "c:/users/acer/desktop/fzehra/ResLift.txt";

/*
P<u,v> := PolynomialRing(GF(2),2);
H := quo< P | u^2 + v^2 , u*v >;
R1<x> := PolynomialRing(H);

T := [ 0,1,u,v,v^2,1+u,1+v,1+v^2,u+v,u+v^2,v+v^2,
1+u+v,1+u+v^2, 1+v+v^2,u+v+v^2,1+u+v+v^2 ];
*/

 

P<u,v> := PolynomialRing(GF(2),2);
H := quo< P | u^2 , v^2  >;
R1<x> := PolynomialRing(H);

T := [ 0,     1,       u,        v,       u*v,
       1+u,   1+v,     u+v,      1+u*v,   u+u*v,  v+u*v, 
       1+u+v, 1+u+u*v, 1+v+u*v , u+v+u*v,
       1+u+v+u*v ];


function Ln(s)
   i := 0;
   for p in s do
       i := i + 1;
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
                  x := a*1 + b*u + c*v + d*(u*v);
                  x := H!x;
                  if x + p eq 0 then
                     return a;
                  end if;
               end for;
          end for;
       end for;
   end for;
end function;



function RandomLift(c)
   A := [ ];
   c := GF(2)!c;
   for p in T do 
       if  Project(p) eq c then
           Append(~A,p);
       end if;
   end for;
   return Random(A);
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
    B[j] := H!u*(H!M[i][j]);
  end for;
  A := A cat B;

  B := [ ];
  for j in [1..n] do 
    B[j] := H!v*(H!M[i][j]);
  end for;
  A := A cat B;

  B := [ ];
  for j in [1..n] do 
    B[j] := (H!(u*v))*(H!M[i][j]);
  end for;
  A := A cat B;

end for;

N := Matrix(R1, 4*m, n, A); 
return N;
end function;




function Gry(p)
  p := H!p;
  S := {GF(2)!0,GF(2)!1};
  for a in S do
      for b in S do
          for c in S do
              for d in S do
                  x := a*1 + b*u + c*v + d*u*v;
                  x := H!x;
                  if x + p eq 0 then
                     return [GF(2)!(d),GF(2)!(c+d),GF(2)!(b+d),GF(2)!(a+b+c+d)];
                  end if;
               end for;
          end for;
       end for;
   end for;
end function;



function GetGrayGM(M)
  G := [ ];
  m := Nrows(M);
  n := Ncols(M);
  for i in [1..m] do
     A := [ ];
     for j in [1..n] do
        A := Gry(M[i][j]) cat A;
     end for;
     Append(~G,A);
  end for;
return G;
end function;




function FVIM(G)
F := Faces(G);
V := Vertices(G);
FM :=ZeroMatrix(GF(2), #F, #V); 
for i:=1 to #F do
    for j:=1 to #V do
        
        for e in F[i] do
            if InitialVertex(e) eq V[j] then
               FM[i][j] := GF(2)!1;
            end if;
        end for;
   
    end for;
end for;
return FM;
end function;


function LiftMx(M)
  m := Nrows(M);
  n := Ncols(M);
  N := ZeroMatrix(H,m,n);
  for i in [1..m] do
     for j in [1..n] do
        N[i][j] := RandomLift(M[i][j]);
     end for;
  end for;
return N;
end function;

function ProMx(M)
  m := Nrows(M);
  n := Ncols(M);
  N := ZeroMatrix(H,m,n);
  for i in [1..m] do
     for j in [1..n] do
        N[i][j] := Project(M[i][j]);
     end for;
  end for;
return N;
end function;

function GraphToCode(M1)
  /* 
   n := #Vertices(G); 
   F := Faces(G); 
   m := #F;
   M := FVIM(G);
   M; print " ";
   RemoveRow(~M,3);
   RemoveRow(~M,4); M; print " ";
   C := LinearCode(M); //IsSelfDual(C);
   C := StandardForm(C); 
   G := GeneratorMatrix(C); G;
   M1 := ColumnSubmatrix(G, m-1, n-m+2); 
  

   m:=10; n:=16;
   M2 := LiftMx(M1); 
   M2t := Transpose(M2);
   //M2*M2t;  
   I := ScalarMatrix(H,m-2,1); 
   N := HorizontalJoin(I,M2); 
   GM := GetGM(N);
   G1 := GetGrayGM(GM);
   C1 := LinearCode<GF(2), 4*n | G1>;
   d := MinimumDistance(C1);  
   return C1;
*/

end function;

/*
G := Graph< 16 |  
[{2,8,9}, //1
 {1,3,10}, //2
 {2,4,11},  //3
 {3,5,12},  //4
 {4,6,13},//5
 {14,5,7},  //6
 {6,8,15}, //7
 {1,7,16},  //8
 {1,10,16},//9
 {2,9,10}, //0
 {3,10,12},//1
 {4,13,11},  //2
 {5,12,14}, //3
 {6,13,15}, //4
 {7,14,16}, //5
 {8,9,15} //6
]>;



//for i :=1 to 100000 do 
    C := GraphToCode(G);
    d := MinimumDistance(C); 
    Codes := [ ];
    if IsSelfDual(C) then
       Append(~Codes,C);
       d; 
       IsSelfDual(C);
       print " ";
    end if;
//end for;

//Write(FF,Codes);
*/



/*
A := [ 1,0,0,0,0,0,1,1,
       0,1,0,0,0,0,1,1,
       0,0,1,0,0,0,1,1,
       0,0,0,1,0,0,1,1,
       0,0,0,0,1,0,1,1,
       0,0,0,0,0,1,1,1,
       1,1,1,1,1,1,1,0,
       1,1,1,1,1,1,0,1 ];

M := Matrix(GF(2),8,8,A);

for i:=1 to 2^9 do
M2 := GraphToCode(M);
ProMx(M2) eq M;
end for;
*/






A := [   1+u*v   , v+u*v,    0     , u*v     , u+v+u*v ,  v     , 1+v+u*v    ,  1+u+v,  
          v      ,   1+v,    v     , u+v+u*v , u*v     , u*v    , 1+u+u*v    ,  1,
         u+v+u*v , u    ,   1      , u+v     , u       , v+u*v  , 1+u+v+u*v  ,  1+u+u*v,
       u+v+u*v   , u*v  ,  u+v     , 1+u*v   , u+v     , u+u*v  , 1+u+v+u*v  ,  1+u+u*v,
         v       , u+u*v,  v+u+u*v , u+u*v   , 1       , u+u*v  , 1+u+v+u*v  ,  1+u+v,
       u*v       , v+u*v,  u+v     ,  0      , v+u*v   , 1+u+u*v, 1+u        ,  1+v,
       1+u+v     , 1+v  , 1+u+v+u*v, 1+u+v   , 1+u     , 1+u+u*v, 1+v        ,  u*v,
       1+u+u*v   , 1+u*v,  1+v+u*v , 1+v     , 1+v+u*v , 1+u+u*v, u+v+u*v    ,  1+v     ];


M2 := Matrix(H, 8, 8, A);
n:=16;
I := ScalarMatrix(H,8,1); 
   N := HorizontalJoin(I,M2); 
   GM := GetGM(N);
   G1 := GetGrayGM(GM);
   C1 := LinearCode<GF(2), 4*n | G1>;
C1;
MinimumDistance(C1);
IsSelfDual(C1);