//load "c:/users/mathatin/desktop/LBlock_integrall.txt";

s1 := [14, 9, 15, 0, 13, 4, 10, 11, 1, 2, 8, 3, 7, 6, 12, 5]; 
s2 := [4, 11, 14, 9, 15, 13, 0, 10, 7, 12, 5, 6, 2, 8, 1, 3];
s3 := [1, 14, 7, 12, 15, 13, 0, 6, 11, 5, 9, 3, 2, 4, 8, 10];
s4 := [7, 6, 8, 11, 0, 15, 3, 14, 9, 10, 12, 13, 5, 2, 4, 1];
s5 := [14, 5, 15, 0, 7, 2, 12, 13, 1, 8, 4, 9, 11, 10, 6, 3];
s6 := [2, 13, 11, 12, 15, 14, 0, 9, 7, 10, 6, 3, 1, 8, 4, 5];
s7 := [11, 9, 4, 14, 0, 15, 10, 13, 6, 12, 5, 7, 3, 8, 1, 2];
s8 := [13, 10, 15, 0, 14, 4, 9, 11, 2, 1, 8, 3, 7, 5, 12, 6];
s9 := [8, 7, 14, 5, 15, 13, 0, 6, 11, 12, 9, 10, 2, 4, 1, 3];
s10 := [11, 5, 15, 0, 7, 2, 9, 13, 4, 8, 1, 12, 14, 10, 3, 6];

Sbox := [s1,s2,s3,s4,s5,s6,s7,s8,s9,s10];

function Confussion(R)
         Res := [];
         for i:= 1 to 8 do
             Res[i] := Sbox[i][R[i]+1];
         end for;
         return Res;
end function;
  
function Diffussion(R)
         return [R[2],R[4],R[1],R[3],R[6],R[8],R[5],R[7]];
end function;
                        
function Shift8(R)
         return [R[3],R[4],R[5],R[6],R[7],R[8],R[1],R[2]];
end function;

function EncryptionRound(L,R)
         R := Shift8(R);
         L := Confussion(L);
         L := Diffussion(L);
         for i := 1 to 8 do
             R[i] := BitwiseXor(R[i],L[i]);
         end for;
         return R;
end function;

X := [];


/*

Makalede verilen integral ayrac�nda 6. �evrimden 
yani (CCCC CCCC, ACCC CCCC) den itibaren ba�layarak t�m 16 de�erleri
verince, sonda balanced olan nible lar�  ve aradaki constantlar�
g�rebiliyorum. Burada bir s�k�nt� yok hocam.

*/


counter := [0,0,0,0,0,0,0,0];
for a := 0 to 15 do
    X[2] := [6,0,4,0,11,3,4,0];
    X[1] := [a,13,0,0,12,0,0,1];
    for i := 3 to 34 do
        X[i] := EncryptionRound(X[i-1],X[i-2]);
    end for;
    X[8]; // �lk de�er constant ��kmal� ki ��k�yor.

    for j := 1 to 8 do 
        counter[j] := BitwiseXor(counter[j],X[10][j]);
    end for;
end for;

counter; // [ 11, 0, 11, 0, 7, 0, 1, 0 ] balanced de�erler g�z�k�yor.



/*
X[8] 16 de�eri:

[ 2, 15, 8, 7, 6, 11, 1, 1 ]
[ 2, 6, 1, 15, 7, 14, 3, 5 ]
[ 2, 5, 14, 7, 9, 8, 6, 12 ]
[ 2, 3, 4, 3, 12, 1, 9, 10 ]
[ 2, 7, 11, 0, 11, 7, 0, 2 ]
[ 2, 4, 6, 4, 4, 6, 12, 3 ]
[ 2, 9, 5, 8, 14, 3, 7, 8 ]
[ 2, 0, 7, 0, 5, 5, 5, 4 ]
[ 2, 11, 15, 11, 8, 4, 13, 11 ]
[ 2, 10, 10, 15, 13, 12, 4, 14 ]
[ 2, 13, 3, 2, 1, 13, 8, 15 ]
[ 2, 8, 2, 10, 0, 0, 14, 7 ]
[ 2, 12, 13, 12, 2, 2, 11, 6 ]
[ 2, 14, 12, 13, 15, 9, 10, 0 ]
[ 2, 2, 9, 8, 3, 15, 2, 13 ]
[ 2, 1, 0, 5, 10, 10, 15, 9 ]


*/





���

/*
Burada ise makalede verilen ilk �evrimdeki ayrac� kullan�yorum.
(AAAC AAAA, AAAA AAAA).

Son �evrimdeki balanced verilenlerin balanced olmad�klar� 2^60
deneme bitmedi�i i�in g�remedim fakat
2^60 ihtimalden al�nan ilk de�erler i�in 6. �evrim ��kt�lar�nda
constant olmas� gereken de�erlerin 
dedi�iniz gibi constant olmad��� g�r�l�yor hocam.
*/


for a1,a2,a3,a4,a5,a6,a7,b1,b2,b3,b4,b5,b6,b7,b8 in [0..15] do
    X[2] := [a1,a2,a3,6,a4,a5,a6,a7];
    X[1] := [b1,b2,b3,b4,b5,b6,b7,b8];
    for i := 3 to 8  do
        X[i] := EncryptionRound(X[i-1],X[i-2]);
    end for;
    if X[8][1] eq 0 then
    X[8]; // (CCCC CCCC) olmal� ama de�il
    end if;
end for;



/*

X[8] i�in ilk de�erler:

[ 0, 0, 7, 0, 2, 0, 0, 0 ]
[ 11, 5, 14, 2, 15, 0, 6, 13 ]
[ 13, 2, 1, 2, 4, 6, 5, 14 ]
[ 4, 13, 4, 2, 12, 5, 8, 10 ]
[ 2, 9, 7, 2, 14, 1, 4, 11 ]
[ 15, 1, 6, 2, 13, 4, 10, 5 ]
[ 0, 15, 3, 2, 6, 3, 14, 2 ]
[ 1, 10, 5, 2, 7, 15, 7, 6 ]
[ 14, 8, 13, 2, 1, 9, 3, 3 ]
[ 10, 4, 11, 2, 3, 11, 15, 1 ]
[ 0, 12, 2, 2, 9, 2, 13, 0 ]
[ 7, 3, 0, 2, 11, 12, 9, 12 ]
[ 13, 14, 15, 2, 8, 10, 2, 15 ]
[ 13, 7, 10, 2, 5, 14, 0, 8 ]
[ 8, 11, 9, 2, 0, 8, 11, 7 ]
[ 7, 6, 12, 2, 2, 13, 1, 9 ]
[ 2, 0, 8, 2, 10, 7, 12, 4 ]
[ 6, 10, 8, 10, 2, 0, 2, 9 ]
[ 12, 13, 5, 10, 12, 6, 0, 10 ]
[ 1, 2, 10, 10, 4, 5, 14, 14 ]
[ 11, 6, 1, 10, 9, 1, 9, 15 ]
[ 1, 14, 0, 10, 5, 4, 1, 1 ]
[ 14, 0, 15, 10, 3, 3, 8, 6 ]
[ 3, 5, 11, 10, 8, 15, 11, 2 ]
[ 12, 7, 13, 10, 11, 9, 13, 7 ]
[ 15, 11, 3, 10, 6, 11, 12, 5 ]
[ 9, 3, 2, 10, 14, 2, 3, 4 ]
[ 10, 12, 12, 10, 1, 12, 4, 8 ]
[ 12, 1, 9, 10, 7, 10, 6, 11 ]
[ 15, 8, 14, 10, 13, 14, 5, 12 ]
[ 10, 4, 7, 10, 10, 8, 7, 3 ]
[ 9, 9, 4, 10, 15, 13, 10, 13 ]
[ 12, 15, 6, 10, 0, 7, 15, 0 ]
[ 12, 3, 4, 7, 9, 0, 15, 7 ]
[ 14, 4, 1, 7, 10, 6, 8, 4 ]
[ 11, 11, 6, 7, 0, 5, 5, 0 ]
[ 9, 15, 5, 7, 2, 1, 7, 1 ]
[ 10, 7, 8, 7, 11, 4, 13, 15 ]
[ 13, 9, 11, 7, 8, 3, 0, 8 ]
[ 8, 12, 15, 7, 3, 15, 4, 12 ]
[ 15, 14, 13, 7, 5, 9, 1, 9 ]
[ 13, 2, 3, 7, 7, 11, 6, 11 ]
[ 3, 10, 10, 7, 15, 2, 10, 10 ]
[ 8, 5, 0, 7, 13, 12, 11, 6 ]
[ 6, 8, 9, 7, 6, 10, 12, 5 ]
[ 8, 1, 2, 7, 1, 14, 14, 2 ]
[ 5, 13, 7, 7, 12, 8, 9, 13 ]
[ 14, 0, 12, 7, 14, 13, 3, 3 ]
[ 3, 6, 14, 7, 4, 7, 2, 14 ]
[ 7, 8, 14, 15, 0, 0, 8, 5 ]
[ 5, 15, 9, 15, 14, 6, 15, 6 ]
[ 8, 0, 4, 15, 9, 5, 6, 2 ]
[ 10, 4, 15, 15, 4, 1, 10, 3 ]
[ 0, 12, 2, 15, 3, 4, 4, 13 ]
[ 7, 2, 11, 15, 5, 3, 2, 10 ]
[ 10, 7, 13, 15, 11, 15, 13, 14 ]
[ 13, 5, 1, 15, 8, 9, 11, 11 ]
[ 2, 9, 7, 15, 13, 11, 5, 9 ]
[ 12, 1, 6, 15, 12, 2, 7, 8 ]
[ 15, 14, 0, 15, 7, 12, 1, 4 ]
[ 1, 3, 3, 15, 1, 10, 14, 7 ]
[ 10, 10, 10, 15, 6, 14, 12, 0 ]
[ 7, 6, 5, 15, 15, 8, 3, 15 ]
[ 4, 11, 8, 15, 10, 13, 9, 1 ]
[ 9, 13, 12, 15, 2, 7, 0, 12 ]
[ 2, 11, 9, 5, 6, 0, 13, 0 ]
[ 1, 12, 4, 5, 11, 6, 4, 3 ]
[ 12, 3, 3, 5, 1, 5, 7, 7 ]

*/




