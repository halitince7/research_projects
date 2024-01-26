//load "c:/users/acer/desktop/GNF.txt";


Set := [0..255];
Perm := [];
for i := 0 to 255 do
    x := Random(Set);
    Exclude(~Set,x);
    Append(~Perm,x);
end for;
Append(~Perm,Perm[1]);

function Encrypt(P)
         return [ Perm[P[8]+1], Perm[BitwiseXor(P[1],P[8])+1], Perm[BitwiseXor(P[2],P[7])+1], Perm[BitwiseXor(P[3],P[6])+1], Perm[BitwiseXor(P[4],P[5])+1],
 Perm[P[5]+1], Perm[P[6]+1], Perm[P[7]+1] ];
end function;

function Round(P)

         return [ Perm[P[8]+1], 
                  Perm[BitwiseXor(P[1],P[8])+1], 
                  Perm[BitwiseXor(P[2],P[7])+1], 
                  Perm[BitwiseXor(P[3],P[6])+1], 
                  Perm[BitwiseXor(P[4],P[5])+1],
                  Perm[P[5]+1], 
                  Perm[P[6]+1], 
                  Perm[P[7]+1] ];
end function;

function Encrypt2(P,k)

         Key  := [12,234,124,78,9,67,89,66];
         for i := 1 to k do
               

              
             for j := 1 to 8 do
                 P[j] := BitwiseXor(P[j],(j*Key[j]+45) mod 255);
             end for;
             P := Round(P);
         end for; 

         return P;

end function;


k := 11;
Set := [0..255]; 
sum := [0,0,0,0,0,0,0,0];
for a1 in [0..255] do 

  P := [a1,101,213,111, 16,178,190,11]; 
  P := Encrypt2(P,k); //P;
  Exclude(~Set,P[1]);
 
  for i := 1 to 8 do 
        sum[i] := BitwiseXor(sum[i],P[i]);
  end for;


end for;

//Set;
//sum;



