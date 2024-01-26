Z3 := GF(3);
P<x> := PolynomialRing(Z3);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function AllDiv9(p)
   X := Factorization(p);
   c := #X;
   D := [ ];
   for i1 in [0..X[1][2]] do   for i2 in [0..X[2][2]] do for i3 in [0..X[3][2]] do for i4 in [0..X[2][2]] do for i5 in [0..X[3][2]] do  for i6 in [0..X[2][2]] do for i7 in [0..X[3][2]] do for i8 in [0..X[2][2]] do for i9 in [0..X[3][2]] do
   Append(~D, Power(X[1][1] ,i1)*Power(X[2][1] ,i2)*Power(X[3][1] ,i3)*Power(X[4][1] ,i4)*Power(X[5][1] ,i5)*Power(X[6][1] ,i6)*Power(X[7][1] ,i7)*Power(X[8][1] ,i8)*Power(X[9][1] ,i9));
   end for; end for ; end for; end for ; end for;  end for ; end for;  end for ; end for;
   return D;
end function;


function AllDiv8(p)
   X := Factorization(p);
   c := #X;
   D := [ ];
   for i1 in [0..X[1][2]] do   for i2 in [0..X[2][2]] do for i3 in [0..X[3][2]] do for i4 in [0..X[2][2]] do for i5 in [0..X[3][2]] do  for i6 in [0..X[2][2]] do for i7 in [0..X[3][2]] do for i8 in [0..X[2][2]] do 
   Append(~D, Power(X[1][1] ,i1)*Power(X[2][1] ,i2)*Power(X[3][1] ,i3)*Power(X[4][1] ,i4)*Power(X[5][1] ,i5)*Power(X[6][1] ,i6)*Power(X[7][1] ,i7)*Power(X[8][1] ,i8));
   end for; end for ; end for; end for ; end for;  end for ; end for;  end for ;
   return D;
end function;



function AllDiv7(p)
   X := Factorization(p);
   c := #X;
   D := [ ];
   for i1 in [0..X[1][2]] do   for i2 in [0..X[2][2]] do for i3 in [0..X[3][2]] do for i4 in [0..X[2][2]] do for i5 in [0..X[3][2]] do  for i6 in [0..X[2][2]] do for i7 in [0..X[3][2]] do 
   Append(~D, Power(X[1][1] ,i1)*Power(X[2][1] ,i2)*Power(X[3][1] ,i3)*Power(X[4][1] ,i4)*Power(X[5][1] ,i5)*Power(X[6][1] ,i6)*Power(X[7][1] ,i7));
   end for; end for ; end for; end for ; end for;  end for ; end for; 
   return D;
end function;


function AllDiv6(p)
   X := Factorization(p);
   c := #X;
   D := [ ];
   for i1 in [0..X[1][2]] do   for i2 in [0..X[2][2]] do for i3 in [0..X[3][2]] do for i4 in [0..X[2][2]] do for i5 in [0..X[3][2]] do  for i6 in [0..X[2][2]] do 
   Append(~D, Power(X[1][1] ,i1)*Power(X[2][1] ,i2)*Power(X[3][1] ,i3)*Power(X[4][1] ,i4)*Power(X[5][1] ,i5)*Power(X[6][1] ,i6));
   end for; end for ; end for; end for ; end for;  end for ; 
   return D;
end function;

function AllDiv5(p)
   X := Factorization(p);
   c := #X;
   D := [ ];
   for i1 in [0..X[1][2]] do   for i2 in [0..X[2][2]] do for i3 in [0..X[3][2]] do for i4 in [0..X[2][2]] do for i5 in [0..X[3][2]] do   
   Append(~D, Power(X[1][1] ,i1)*Power(X[2][1] ,i2)*Power(X[3][1] ,i3)*Power(X[4][1] ,i4)*Power(X[5][1] ,i5));
   end for; end for ; end for; end for ; end for;
   return D;
end function;


function AllDiv4(p)
   X := Factorization(p);
   c := #X;
   D := [ ];
   for i1 in [0..X[1][2]] do   for i2 in [0..X[2][2]] do for i3 in [0..X[3][2]] do for i4 in [0..X[2][2]] do 
   Append(~D, Power(X[1][1] ,i1)*Power(X[2][1] ,i2)*Power(X[3][1] ,i3)*Power(X[4][1] ,i4));
   end for; end for ; end for; end for ; 
   return D;
end function;


function AllDiv3(p)
   X := Factorization(p);
   c := #X;
   D := [ ];
   for i1 in [0..X[1][2]] do   for i2 in [0..X[2][2]] do for i3 in [0..X[3][2]] do 
   Append(~D, Power(X[1][1] ,i1)*Power(X[2][1] ,i2)*Power(X[3][1] ,i3));
   end for; end for ; end for; 
   return D;
end function;



function AllDiv2(p)
   X := Factorization(p);
   c := #X;
   D := [ ];
   for i1 in [0..X[1][2]] do   for i2 in [0..X[2][2]] do  
   Append(~D, Power(X[1][1] ,i1)*Power(X[2][1] ,i2));
   end for; end for ; 
   return D;
end function;

function AllDiv1(p)
   X := Factorization(p);
   c := #X;
   D := [ ];
   for i1 in [0..X[1][2]] do    
   Append(~D, Power(X[1][1] ,i1));
   end for; 
   return D;
end function;

//////////////////////////////////////////////////////////////////////////////////////////////////////////


function RecipG(p)
return  ((x^Degree(p))*Evaluate(p, 1/x ));
end function;

function MOD(n,p)
a :=  (x^n - 1) / (p*RecipG(p));
return a;
end function;


function RecipH(n,p)
h := (x^n - 1) / p;
return RecipG(h);
end function;


function ShortG(n,g)
A := [ ];
B := Factorization(x^n -1);
b := #B;
C := Factorization(g);
c := #C;

for i in [1..c] do

  for j in [1..b] do
      
     G :=[ ];
     if C[i][1] eq B[j][1] then
     Append(~G,j); Append(~G,C[i][2]);
     Append(~A,G);
     end if;

end for; end for;
return A;
end function;

///////////////////////////////////////////////////////////////////////////////////////////////////

                                     





                                 
F  := "c:/users/halit/desktop/tugbahepsi111.txt";
F1 := "c:/users/halit/desktop/tugbaparam111.txt"; 




                                         for n in [2..20] do


n;
p := x^n - 1;
Write(F,n); Write(F, Factorization(p));
Write(F, " ");
Write(F1,n);

k := #Factorization(p); 
E := [ ];                                             




if k eq 1 then

  for f in AllDiv1(p) do

    if IsCoercible(P, MOD(n,f)) then
    Append(~E,f);
    end if; 
  
  end for;




elif k eq 2 then

  for f in AllDiv2(p) do

    if IsCoercible(P, MOD(n,f)) then
    Append(~E,f);
    end if; 
  
  end for;



elif k eq 3 then

  for f in AllDiv3(p) do

    if IsCoercible(P, MOD(n,f)) then
    Append(~E,f);
    end if; 
  
  end for;




elif k eq 4 then
  for f in AllDiv4(p) do

    if IsCoercible(P, MOD(n,f)) then
    Append(~E,f);
    end if; 
  
  end for;




elif k eq 5 then

  for f in AllDiv5(p) do

    if IsCoercible(P, MOD(n,f)) then
    Append(~E,f);
    end if; 
  
  end for;




elif k eq 6 then

  for f in AllDiv6(p) do

    if IsCoercible(P, MOD(n,f)) then
    Append(~E,f);
    end if; 
  
  end for;





elif k eq 7 then

  for f in AllDiv7(p) do

    if IsCoercible(P, MOD(n,f)) then
    Append(~E,f);
    end if; 
  
  end for;





elif k eq 8 then

  for f in AllDiv8(p) do
    
    if IsCoercible(P, MOD(n,f)) then
    Append(~E,f);
    end if; 
  
  end for;





elif k eq 9 then

  for f in AllDiv9(p) do

    if IsCoercible(P, MOD(n,f)) then
    Append(~E,f);
    end if; 
  
  end for;



else
 k;
 print "hata";
end if;

////////////////////////////////////////////////////////////////////////////////////////////////////////////7
////////////////////////////////////////////////////////////////////////////////////////////////////////////

Codes := [ ];
for g in E do
Append(~Codes,CyclicCode(n, g)); 
end for;



m := 4*n;
QC := [ ];
for C1 in Codes do
  d1 := MinimumDistance(C1);
  for C2 in Codes do
      d2 := MinimumDistance(C2);
     
 for C3 in Codes do
        
          d3 := MinimumDistance(C3);
        
            for C4 in Codes do
               
                 d4 := MinimumDistance(C4);

              MD := [ ];
              Append(~MD,d1); Append(~MD,d2); Append(~MD,d3); Append(~MD,d4);
              MD := Sort(MD);
              d := MD[1];
              k := Dimension(C1) + Dimension(C2) + Dimension(C3) + Dimension(C4);
              k := 2*k - m;
              
              V := [ ];
              

              g1 := GeneratorPolynomial(C1);
              g2 := GeneratorPolynomial(C2);
              g3 := GeneratorPolynomial(C3);
              g4 := GeneratorPolynomial(C4);

              s := 0;
              for t in [1..#QC] do
              if (QC[t][2] eq k) and (QC[t][3] eq d) then
              s := 1; break;
              end if;
              end for;

         if (s eq 0) and (d ne 1) and (k ne 0) then

              Append(~V,m); Append(~V,k); Append(~V,d);
              Append(~QC,V);
              Write(F, " Generator 1-2-3-4:");
              Write(F,g1); Write(F,g2); Write(F,g3); Write(F,g4);
              Write(F,ShortG(n,g1)); Write(F,ShortG(n,g2)); Write(F,ShortG(n,g3)); Write(F,ShortG(n,g4));

              Write(F," Reciprocal 1-2-3-4: ");
              Write(F,RecipG(g1)); Write(F,RecipG(g2)); Write(F,RecipG(g3)); Write(F,RecipG(g4));
              
              Write(F," RecipH 1-2-3-4: ");
              Write(F,RecipH(n,g1)); Write(F,RecipH(n,g2)); Write(F,RecipH(n,g3)); Write(F,RecipH(n,g4));
              
              Write(F,V);
              Write(F," ");
              Write(F1,V);
              V;

              
              
           end if;

end for; end for; end for; end for; 



end for;






