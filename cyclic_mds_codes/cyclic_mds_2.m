//load "c:/users/mathatin/desktop/samet2.txt";

dosya := "c:/users/mathatin/desktop/son_samet2.txt";

K := GF(2);

boy := 4;

MR1 := MatrixRing(K, 4);
MR16 := MatrixRing(K, 16);
MR4 := MatrixRing(MR1, boy);


function by_one(block)
         k := #block;
         block := block cat block;
         block2 := [];
         for i := 1 to k do
             block2[i] := block[(i+boy-1)];
         end for;
         return block2;
end function;

function Circulant(block)
         k := #block;
         blocks := [];
         Append(~blocks,block);
         for i := 1 to k-1 do
             block := by_one(block);
             Append(~blocks,block);
         end for;
         return blocks;
end function;


function isMDS(M,boy)


S := {1..boy};

for s1 in Subsets(S,2) do
    i1 := Setseq(s1)[1];
    i2 := Setseq(s1)[2];
    for s2 in Subsets(S,2) do
        j1 := Setseq(s2)[1];
        j2 := Setseq(s2)[2];

        A1 := HorizontalJoin(M[i1][j1],M[i1][j2]);
        A2 := HorizontalJoin(M[i2][j1],M[i2][j2]);
        A :=  VerticalJoin(A1,A2);
        if IsSingular(A) then return false; end if; 
    end for; 
end for; 



for s1 in Subsets(S,3) do
    i1 := Setseq(s1)[1];
    i2 := Setseq(s1)[2];
    i3 := Setseq(s1)[3];
    for s2 in Subsets(S,3) do
        j1 := Setseq(s2)[1];
        j2 := Setseq(s2)[2];
        j3 := Setseq(s2)[3];

        Q1 := [M[i1][j1],M[i1][j2],M[i1][j3]];
        Q2 := [M[i2][j1],M[i2][j2],M[i2][j3]];
        Q3 := [M[i3][j1],M[i3][j2],M[i3][j3]];
        A1 := HorizontalJoin(Q1);
        A2 := HorizontalJoin(Q2);
        A3 := HorizontalJoin(Q3);
        Q := [A1,A2,A3];
        A := VerticalJoin(Q);
        if IsSingular(A) then return false; end if;
    end for; 
end for; 


for s1 in Subsets(S,4) do
    i1 := Setseq(s1)[1];
    i2 := Setseq(s1)[2];
    i3 := Setseq(s1)[3];
    i4 := Setseq(s1)[4];
    for s2 in Subsets(S,4) do
        j1 := Setseq(s2)[1];
        j2 := Setseq(s2)[2];
        j3 := Setseq(s2)[3];
        j4 := Setseq(s2)[4];

        Q1 := [M[i1][j1],M[i1][j2],M[i1][j3],M[i1][j4]];
        Q2 := [M[i2][j1],M[i2][j2],M[i2][j3],M[i2][j4]];
        Q3 := [M[i3][j1],M[i3][j2],M[i3][j3],M[i3][j4]];
        Q4 := [M[i4][j1],M[i4][j2],M[i4][j3],M[i4][j4]];

        A1 := HorizontalJoin(Q1);
        A2 := HorizontalJoin(Q2);
        A3 := HorizontalJoin(Q3);
        A4 := HorizontalJoin(Q4);

        Q := [A1,A2,A3,A4];
        A := VerticalJoin(Q); 
        if IsSingular(A) then  return false; end if;
    end for; 
end for; 

return true;

end function;   




function BinFor(M,boy)
          
    S := {1..boy};     

for s1 in Subsets(S,4) do
    i1 := Setseq(s1)[1];
    i2 := Setseq(s1)[2];
    i3 := Setseq(s1)[3];
    i4 := Setseq(s1)[4];
    for s2 in Subsets(S,4) do
        j1 := Setseq(s2)[1];
        j2 := Setseq(s2)[2];
        j3 := Setseq(s2)[3];
        j4 := Setseq(s2)[4];

        Q1 := [M[i1][j1],M[i1][j2],M[i1][j3],M[i1][j4]];
        Q2 := [M[i2][j1],M[i2][j2],M[i2][j3],M[i2][j4]];
        Q3 := [M[i3][j1],M[i3][j2],M[i3][j3],M[i3][j4]];
        Q4 := [M[i4][j1],M[i4][j2],M[i4][j3],M[i4][j4]];

        A1 := HorizontalJoin(Q1);
        A2 := HorizontalJoin(Q2);
        A3 := HorizontalJoin(Q3);
        A4 := HorizontalJoin(Q4);

        Q := [A1,A2,A3,A4];
        A := MR16 ! VerticalJoin(Q); 
        if IsSingular(A) then  return false; end if;
    end for; 
end for; 

return A;

end function;




function xor_say(A)
         say := 0;
         satir := Nrows(A);
         sutun := Ncols(A);
         for i := 1 to satir do
             for j := 1 to sutun do
                 if A[i][j] eq 1 then
                    say := say+1;
                 end if;
             end for;
             say := say-1;
          end for;
          return say;
end function;






Ad := [[0,0,1,1],[0,1,0,1],[1,1,0,0],[1,0,0,0]];
Bd := [[1,1,0,0],[1,0,0,1],[0,1,0,0],[0,0,1,0]];
Cd := [[1,0,0,1],[0,1,1,1],[1,1,0,1],[0,1,1,0]];
Id := [[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]];


Ad := [[1,0,0,0],[0,1,0,0],[1,0,1,0],[1,1,0,1]];
Bd := [[0,1,0,0],[1,1,0,0],[0,0,1,1],[0,0,1,0]];
Cd := [[0,0,0,1],[0,0,1,0],[0,1,0,0],[1,0,0,0]];
Id := [[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]];

A := MR1 ! Ad; 
B := MR1 ! Bd; 
C := MR1 ! Cd; 
I := MR1 ! Id; 

block := [I,A,B,C];
M := MR4 ! Circulant(block);







Id := [[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]];
I := MR1 ! Id; 

NonSing := [];
for M in MatrixRing(K, 4) do
    if not IsSingular(M) then
       Append(~NonSing,M);
    end if;
end for;
#NonSing;

counter := 0;
for A in NonSing do
    for C in NonSing do
     if A^2 eq ScalarMatrix(K,4,1) and C^2 eq ScalarMatrix(K,4,1) and (A+C)^6 eq ScalarMatrix(K,4,1) then
        B := (A+C)^4;
        block := [I,A,B,C];
        block2 := [I,C,B,A];
        M := MR4 ! Circulant(block);
        M2 := MR4 ! Circulant(block2);
        //ScalarMatrix(K,16,1) eq BinFor(M,boy)^2;
        if xor_say(A) + xor_say(B) + xor_say(C) eq 5 then
          if isMDS(M,boy) and isMDS(M2,boy) then [A,B,C];
             fprintf dosya, "%o: \n %o \n \n \n ",counter+1,[A,B,C];
             counter := counter+1;
          end if; 
        end if;
      end if;
    end for;
end for;
counter;









