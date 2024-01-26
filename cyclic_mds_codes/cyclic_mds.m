//load "c:/users/acer/desktop/samet.txt";

K := GF(2);
MR1 := MatrixRing(K, 4);
MR4 := MatrixRing(MR1, 4);
MR3 := MatrixRing(MR1, 3);
MR2 := MatrixRing(MR1, 2);

function by_one(block)
         k := #block;
         block := block cat block;
         block2 := [];
         for i := 1 to k do
             block2[i] := block[(i+3)];
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


function Determ(M) 
         n := Nrows(M);
         m := Ncols(M);
     if n ne m then
          print "ERROR";
          return 0;
      else

         if n eq 1 then
            det := M; 
            return det;
         elif n eq 2 then
            det := M[1][1]*M[2][2]-M[1][2]*M[2][1]; 
            return det;
         else 
            N := RemoveRow(M,1);
            det := 0;
            for i := 1 to n do
                N_temp := RemoveColumn(N,i);
                det := det + ((-1)^(1+i))*Determ(N_temp);
            end for;
            return det;
         end if;


      end if;

end function;






Ad := [[1,0,0,0],[0,1,0,0],[1,0,1,0],[1,1,0,1]];
Bd := [[0,1,0,0],[1,1,0,0],[0,0,1,1],[0,0,1,0]];
Cd := [[0,0,0,1],[0,0,1,0],[0,1,0,0],[1,0,0,0]];
Id := [[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]];

Ad := [[0,1,0,0],[0,0,1,0],[0,0,0,1],[0,1,0,0]];
Bd := [[0,0,0,1],[1,0,0,0],[0,1,0,1],[0,0,1,0]];
Cd := [[0,1,0,0],[0,0,1,0],[0,0,0,1],[1,0,1,0]];
Id := [[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]];

A := MR1 ! Ad; 
B := MR1 ! Bd; 
C := MR1 ! Cd; 
I := MR1 ! Id; 

block := [I,A,B,B,C];
M := MR4 ! Circulant(block);

M;



n := Nrows(M);
for i := 1 to n do
    for j := 1 to n do
        N := RemoveRow(M,i);
        N := RemoveColumn(N,j);
        det := Determ(N);
        det; print " ";
    end for;
end for;





















//Mat := MR3 ! [I,B,C,B,I,A,A,C,I];
//Mat;
//Determ(M);
//D := I+B*C^2+B*A^2+C*A+A*C+B^2;

