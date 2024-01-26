//load "c:/users/acer/desktop/integral/integral_form_Lblock.txt";


function Transform(S,transformation,emaxA,emaxU)
         maxA := Setseq(S[1][2])[1];
         maxU := Setseq(S[2][2])[1];
         if transformation eq 0 then
            return [[{},{0}],[{},{0}]];

         elif transformation eq 1 then
            return S;

         elif transformation eq 2 then

            if #S[1][1] eq 1 and #S[2][1] eq 0 then
               return [[{emaxA},{emaxA+1}],[{},{0}]];

            elif S eq [[{},{0}],[{},{0}]] then
               return [[{},{0}],[{},{0}]];

            else
                  return [[{},{0}],[{emaxU},{emaxU+1}]];
            end if;
         end if;
end function;


function XOR(S1,S2) 
         A := S1[1][1] sdiff S2[1][1]; 
         U := S1[2][1] sdiff S2[2][1];
         Amax:= {0}; Umax:={0};

         if #A ne 0 then
            Amax := {Max(A)+1};
         end if;

         if #U ne 0 then
            Umax := {Max(U)+1};
         end if;
 
         return [[A,Amax],[U,Umax]];
end function;

function MatrixMult(M,S,emaxA,emaxU)
         A := []; 
         for i := 1 to 16 do;
             a := [[{},{0}],[{},{0}]];
             for j := 1 to 16 do 
                 b := Transform(S[j],M[i][j],emaxA,emaxU);
                 a := XOR(b,a);
                 if Setseq(a[1][2])[1] gt emaxA then
                    emaxA := Setseq(a[1][2])[1];
                 end if;
                 if Setseq(a[2][2])[1] gt emaxU then
                    emaxU := Setseq(a[2][2])[1];
                 end if;
             end for;
             Append(~A,a);
         end for;
         return A,emaxA,emaxU;
end function;


// LBlock

D := Matrix([
[0,0,0,0, 0,0,0,0,  1,0,0,0, 0,0,0,0],
[0,0,0,0, 0,0,0,0,  0,1,0,0, 0,0,0,0],
[0,0,0,0, 0,0,0,0,  0,0,1,0, 0,0,0,0],
[0,0,0,0, 0,0,0,0,  0,0,0,1, 0,0,0,0],
[0,0,0,0, 0,0,0,0,  0,0,0,0, 1,0,0,0],
[0,0,0,0, 0,0,0,0,  0,0,0,0, 0,1,0,0],
[0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,1,0],
[0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,1],

[0,0,0,0, 0,0,1,0,  0,0,0,0, 2,0,0,0],
[0,0,0,0, 0,0,0,1,  0,0,0,0, 0,0,2,0],
[1,0,0,0, 0,0,0,0,  0,2,0,0, 0,0,0,0],
[0,1,0,0, 0,0,0,0,  0,0,0,2, 0,0,0,0],
[0,0,1,0, 0,0,0,0,  2,0,0,0, 0,0,0,0],
[0,0,0,1, 0,0,0,0,  0,0,2,0, 0,0,0,0],
[0,0,0,0, 1,0,0,0,  0,0,0,0, 0,2,0,0],
[0,0,0,0, 0,1,0,0,  0,0,0,0, 0,0,0,2]
]);

s1 :=  [[{},{0}],
        [{},{0}]]; 

s2 :=  [[{},{0}],
        [{},{0}]]; 

s3 :=  [[{},{0}],
        [{},{0}]]; 

s4 :=  [[{},{0}],
        [{},{0}]];

s5 :=  [[{},{0}],
        [{},{0}]]; 

s6 :=  [[{},{0}],
        [{},{0}]]; 

s7 :=  [[{},{0}],
        [{},{0}]]; 

s8 :=  [[{},{0}],
        [{},{0}]];


s9 :=  [[{0},{1}],
        [{},{0}]]; 

s10 :=  [[{},{0}],
        [{},{0}]]; 

s11 :=  [[{},{0}],
        [{},{0}]]; 

s12 :=  [[{},{0}],
        [{},{0}]];

s13 :=  [[{},{0}],
        [{},{0}]]; 

s14 :=  [[{},{0}],
        [{},{0}]]; 

s15 :=  [[{},{0}],
        [{},{0}]]; 

s16 :=  [[{},{0}],
        [{},{0}]];

S :=[s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16];
emaxA := 0; emaxU := 0; 
for i:= 1 to 3 do
    S,emaxA,emaxU := MatrixMult(D,S,emaxA,emaxU);
end for;
S;


