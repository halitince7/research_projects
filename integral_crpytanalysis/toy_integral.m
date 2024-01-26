//load "c:/users/mathatin/desktop/toy_integral.txt";

S := [ 165, 24, 67, 89, 59, 21, 100, 209, 255, 32, 46, 0, 69, 144, 191, 76, 61, 246, 154, 243, 149, 163, 88, 93,
5, 162, 84, 57, 98, 17, 45, 179, 153, 211, 52, 66, 23, 82, 8, 122, 94, 146, 34, 2, 228, 235, 161, 236, 231,
62, 249, 111, 87, 170, 36, 102, 51, 95, 203, 189, 3, 251, 180, 167, 25, 205, 248, 131, 225, 101, 68, 181,
99, 119, 152, 10, 71, 22, 53, 137, 138, 90, 155, 172, 86, 185, 206, 194, 178, 79, 156, 134, 234, 19, 91,
210, 29, 118, 196, 77, 117, 43, 18, 39, 198, 104, 120, 190, 11, 112, 9, 173, 70, 175, 237, 168, 129, 240,
74, 239, 224, 204, 195, 252, 202, 223, 42, 16, 247, 133, 12, 208, 73, 49, 244, 80, 197, 245, 135, 151, 6,
142, 105, 33, 115, 169, 136, 40, 30, 226, 193, 75, 107, 159, 110, 63, 128, 108, 219, 83, 150, 174, 109,
192, 56, 171, 78, 183, 221, 188, 222, 220, 121, 103, 230, 13, 254, 55, 125, 147, 176, 20, 242, 250, 214,
31, 126, 229, 28, 26, 139, 166, 184, 47, 143, 60, 7, 164, 64, 213, 114, 212, 38, 132, 148, 15, 238, 116,
81, 41, 187, 1, 253, 216, 177, 4, 233, 207, 37, 96, 241, 182, 157, 65, 123, 127, 201, 106, 48, 217, 186,
199, 200, 215, 158, 145, 227, 35, 232, 97, 124, 160, 113, 218, 141, 130, 27, 44, 140, 58, 54, 72, 14, 50,
85, 92 ];




procedure ABC(D)
         Res := [0,0,0,0];
         for i := 1 to 4 do
             sum := 0;
             syc := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
             for d in D do
                 sum := BitwiseXor(sum,d[i]);
                 syc[d[i]+1] := syc[d[i]+1] + 1;
             end for;
             counter1 := 0;
             for j := 1 to 15 do
                 if syc[j] eq syc[j+1] then
                    counter1 := counter1+1;
                 end if;
             end for;
             counter2 := 0;
             for j := 1 to 16 do
                 if syc[j] eq 0 then
                    counter2 := counter2+1;
                 end if;
             end for;
             if counter1 eq 15 then
                Res[i] := 2;  printf "A";
             elif counter2 eq 15 then 
                Res[i] := 1;  printf "C";
             elif sum eq 0 then
                Res[i] := 0;  printf "B";
             else
                Res[i] := 7;  printf "?";
             end if;
          end for;
          //return Res;
end procedure;


S := [5,2,8,11,1,0,7,3,6,15,12,4,9,10,13,14];
function Round(P)
         C := [];
         for i:=1 to 4 do
             C[i] := S[P[i]+1];
         end for; 
         x := C[1]; y:=C[2]; z:=C[3]; t:=C[4];
         C := [BitwiseXor(x,y), BitwiseXor(y,z), BitwiseXor(z,t), x];
         //C := [y, z, t, BitwiseXor(x,y)];
         return C;
end function;

function Encrypt(P,r)
         for i:=1 to r do
             P := Round(P);
         end for;
         return P;
end function;

c1 := Random([0..15]);
c2 := Random([0..15]);
c3 := Random([0..15]);


D := [];
Sum := [0,0,0,0];
r := 4;
for a in [0..15] do
    P := [a,c1,c2,c3]; 
    C := Encrypt(P,r); 
    Append(~D,C);
end for;
ABC(D);























