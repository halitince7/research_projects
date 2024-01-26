//load "c:/users/mathatin/desktop/fzehra/graph_cramer.txt";
Res := "c:/users/mathatin/desktop/fzehra/ResCramerLift.txt";
F := "c:/users/mathatin/desktop/temp.txt";
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
        if i le j then
           N[i][j] := RandomLift(M[i][j]);
        end if;
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






function Sol(A,W)

       m := Nrows(A);
       Soln := [ ];
       DetA := H!Determinant(A); //print " "; print "DetA:";  DetA; 
       for i := 1 to m do 
           C := RemoveColumn(A,i); 
           B := HorizontalJoin(W,C); 
           SwapRows(~B, 1, i);
           DetB := H!Determinant(B); //print "DetB:"; DetB; 
           x := DetB / DetA;  //print "x:"; x;
           Append(~Soln,x);
        end for;
        //V := Matrix(H,m,1,Soln);
        //A*V eq W; V;
        return Soln;

end function;           





function CramerLift(M)
     
      A := LiftMx(M);
      m := Nrows(A);
      N := ZeroMatrix(H,m,m);
      N := A;
      for i := 2 to m do
          A := ExtractBlock(N,1,1,i-1,i-1);
          Sums := [ ];
          for j := 1 to i-1 do
              sum := 0;
              for k := i to m do
                  sum := sum + N[j][k]*N[i][k];
              end for;
              Append(~Sums,sum);
          end for;
          W := Matrix(H,i-1,1,Sums);
          V := Sol(A,W); 
          for j := 1 to i-1 do
              N[i][j] := V[j];
          end for;
       end for;
       return N;

end function;    


function W272(WE)
   

      if WE[2][1] eq 12 then
          for beta := -10000 to 10000 do
              if 4398+beta eq WE[2][2] then
                 return beta;
                 break;
              end if;
           end for;
       end if;
              
end function;



function W172(WE)
 


   
       if WE[2][1] eq 12 then
          beta := WE[2][2]/2; 
          for gama := -1000 to 1000 do
              if (8640-64*gama) eq WE[3][2]  and (124281-24*beta+384*gama) eq WE[4][2] then 
                 return [1,gama,beta]; 
                 break;
              end if;
          end for;

          for gama := -1000 to 1000 do
             if 7616-64*gama eq WE[3][2] and 134521-24*beta+384*gama eq WE[4][2] then
                 return [2,gama,beta];
                 break;
              end if;
          end for;
      
       end if;
    

end function;



function WhatType(WE)

   if WE[3][1] eq 14 then return 1; end if;
   if WE[3][1] eq 16 then return 2; end if;

end function;


procedure Values(WE)


   if WhatType(WE) eq 2 then
      b := W272(WE);
      Write(F,"Type 2 code; \nAlpha Value is: ");
      Write(F,b);
      Write(F," ");
      print "Type 2 code; \nAlpha Value is: "; b;
   elif WhatType(WE) eq 1 then 
      b := W172(WE); 
      gama := b[2];
      beta := b[3];
      s := [gama,beta];
      if b[1] eq 1 then
      Write(F,"Type 2 WE_1; \ngama, beta values are:");
      Write(F,s);    
      Write(F," ");     
         print "Type 2 WE_1; \ngama, beta values are:"; s;
      elif b[1] eq 2 then
      Write(F,"Type 2 WE_2; \ngama, beta values are:");
      Write(F,s);
      Write(F," ");
         print "Type 2 WE_2; \ngama, beta values are:"; s;
      end if;
   end if;

end procedure;







A := [ 1,1,1,1,0,0,1,0,0,
       0,1,0,0,1,0,1,1,1,
       0,0,1,0,1,0,1,0,0,
       0,1,1,1,0,1,1,0,0,
       0,1,1,0,1,0,0,1,1,
       1,0,0,1,0,1,0,0,0,
       1,1,1,0,0,1,1,0,0,
       0,0,1,0,0,0,1,1,0,
       0,0,1,0,0,0,1,0,1 ];

M1 := Matrix(GF(2),9,9,A); 
n := 18;
m:=11;



while 1 eq 1 do


M2 := CramerLift(M1);   
I := ScalarMatrix(H,m-2,1); 
N := HorizontalJoin(I,M2); 
GM := GetGM(N);
G1 := GetGrayGM(GM);
C := LinearCode<GF(2), 4*n | G1>;
d := MinimumDistance(C); 


if d ge 12 then

C;
d;
IsSelfDual(C);
WE :=  WeightDistribution(C);
Values(WE);
Write(F,d);
Write(F,M2);
Write(F,WE);
Write(F,"------------");

end if;


end while;



























     
 

/*
function GraphToCode(G)
   
   n := #Vertices(G); 
   F := Faces(G); 
   m := #F;
   M := FVIM(G);
   RemoveRow(~M,3);
   RemoveRow(~M,4); 
   C := LinearCode(M); IsSelfDual(C);
   C := StandardForm(C); 
   G1 := GeneratorMatrix(C); 
   M1 := ColumnSubmatrix(G1, m-1, n-m+2);
   M2 := CramerLift(M1);   
   I := ScalarMatrix(H,m-2,1); 
   N := HorizontalJoin(I,M2); 
   GM := GetGM(N);
   G1 := GetGrayGM(GM);
   C1 := LinearCode<GF(2), 4*n | G1>;
   d := MinimumDistance(C1); 
   return C1;


end function;


G := Graph< 18 |  
[{2,4,7}, //1
 {3,1,5}, //2
 {2,6,12},  //3
 {8,9,1},  //4
 {2,6,10},//5
 {3,5,11},  //6
 {1,8,16}, //7
 {7,13,4},  //8
 {4,10,13}, //9
 {5,9,14}, //0
 {6,12,15}, //1
 {3,18,11},  //2
 {8,9,16}, //3
 {10,17,15}, //4
 {11,14,18}, //5
 {7,13,17},  //6
 {14,16,18}, //7
 {12,15,17} //8
]>;



n := #Vertices(G); 
   F := Faces(G); 
   m := #F;
   M := FVIM(G);

   RemoveRow(~M,3);
   RemoveRow(~M,4); 
   C := LinearCode(M); IsSelfDual(C); 
   C := StandardForm(C); 
   G1 := GeneratorMatrix(C); G1;
   M1 := ColumnSubmatrix(G1, m-1, n-m+2); M1;
   M2 := CramerLift(M1);   
   I := ScalarMatrix(H,m-2,1); 
   N := HorizontalJoin(I,M2); 
   GM := GetGM(N);
   G1 := GetGrayGM(GM);
   C1 := LinearCode<GF(2), 4*n | G1>;
   d := MinimumDistance(C1); 
   C1;

ççç



A := [ 1,0,1,1,
       0,1,1,1,
       1,1,1,0,
       1,1,0,1
       
      ];



A := [ 1,0,0,0,0,0,1,1,
       0,1,0,0,0,0,1,1,
       0,0,1,0,0,0,1,1,
       0,0,0,1,0,0,1,1,
       0,0,0,0,1,0,1,1,
       0,0,0,0,0,1,1,1,
       1,1,1,1,1,1,1,0,
       1,1,1,1,1,1,0,1 ];




A := [ 1,0,0,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,
       1,1,0,1,1,0,0,0,1,1,0,0,0,0,0,0,0,0,
       0,1,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,
       0,0,1,0,0,1,0,0,0,0,1,1,0,0,0,0,0,0,
       0,0,0,1,0,0,0,1,1,0,0,0,1,0,0,0,0,0,
       0,0,0,0,1,1,0,0,0,1,1,0,0,1,1,0,0,0,
       0,0,0,0,0,0,1,1,0,0,0,0,1,0,0,1,0,0,
       0,0,0,0,0,0,0,0,1,1,0,0,1,1,0,1,1,0,
       1,1,1,0,0,0,1,0,0,0,0,1,0,0,0,1,1,1];


M := Matrix(GF(2),9,18,A); 
N1 := EchelonForm(M); 
SwapColumns(~N1,6,7); 
SwapColumns(~N1,8,10);
SwapColumns(~N1,7,9);
SwapColumns(~N1,8,11);
SwapColumns(~N1,9,14);
M1 := ColumnSubmatrix(N1, 10, 9); 
M1t := Transpose(M1);
*/










çç
C := LinearCode(N1);
IsSelfDual(C);
C;

ççç


A := [ 0,0,0,0,1,1,0,1,1,
       1,1,1,0,1,1,0,0,0,
       0,1,1,0,1,1,1,0,1,
       0,0,0,1,0,0,1,0,0,
       1,1,1,0,1,0,0,0,1,
       0,0,1,0,0,1,0,0,1,
       1,0,0,0,0,1,1,0,1,
       1,0,0,1,1,0,0,1,0,
       1,0,0,1,1,0,1,1,0 ];


A := [ 1,1,1,1,0,0,0,0,
       0,1,1,0,0,1,1,0,
       0,0,1,1,0,0,1,1,
       1,0,0,1,1,0,0,1 ];

M := Matrix(GF(2),4,8,A);
EchelonForm(M);
ççç



I := ScalarMatrix(GF(2),9,1); 
N := HorizontalJoin(I,M); 
C := LinearCode(N); IsSelfDual(C); 
C; 
ççç


   C := StandardForm(C); 
   G1 := GeneratorMatrix(C); 
   M1 := ColumnSubmatrix(G1, m-1, n-m+2); M1;


ççç
M;
print " ";
EchelonForm(M);

ççç



Codes := [ ];
k := #Codes;

while k eq 0 do

k := #Codes;
B := CramerLift(M);
//B;
//print " ";
Bt := Transpose(B);
//B*Bt;
//ProMx(B) eq M;
I := ScalarMatrix(H,8,1); 
N := HorizontalJoin(I,B); 
GM := GetGM(N);
G1 := GetGrayGM(GM);
C := LinearCode<GF(2), 4*16 | G1>;
d := MinimumDistance(C);  
C;
if d eq 12 then
d;
IsSelfDual(C);
Append(~Codes,C);
end if;


end while;


Codes;


























/*
A := [   1+u*v   , v+u*v,    0     , u*v     , u+v+u*v ,  v     , 1+v+u*v    ,  1+u+v,  
          v      ,   1+v,    v     , u+v+u*v , u*v     , u*v    , 1+u+u*v    ,  1,
         u+v+u*v , u    ,   1      , u+v     , u       , v+u*v  , 1+u+v+u*v  ,  1+u+u*v,
       u+v+u*v   , u*v  ,  u+v     , 1+u*v   , u+v     , u+u*v  , 1+u+v+u*v  ,  1+u+u*v,
         v       , u+u*v,  v+u+u*v , u+u*v   , 1       , u+u*v  , 1+u+v+u*v  ,  1+u+v,
       u*v       , v+u*v,  u+v     ,  0      , v+u*v   , 1+u+u*v, 1+u        ,  1+v,
       1+u+v     , 1+v  , 1+u+v+u*v, 1+u+v   , 1+u     , 1+u+u*v, 1+v        ,  u*v,
       1+u+u*v   , 1+u*v,  1+v+u*v , 1+v     , 1+v+u*v , 1+u+u*v, u+v+u*v    ,  1+v     ];


M := Matrix(H, 8, 8, A);
//M;
print " ";
N := ZeroMatrix(H,8,8);
for i:=1 to 8 do
    for j :=1 to 8 do
        if i le j then
        N[i][j]:=M[i][j];
        end if;
    end for;
end for;
//N;
print " ";

  
B1 := Cramer(M);
B1;
print " ";
B2 := Cramer(N);
B2;

for i:=1 to 8 do
    for j :=1 to 8 do
       
       if  B1[i][j] ne B2[i][j] then
           ent := [i,j];  ent; print " ";
       end if;
        
    end for;
end for;
B1 eq B2;
çç
Bt := Transpose(B);
B*Bt;

*/








