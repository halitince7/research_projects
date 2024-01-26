S<w> := GF(4);
P<x> := PolynomialRing(S);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

/////////////////////////////////////////////////////////////////////////////////////////////////////

function Recip(p)
return  ( (x^Degree(p)) * Evaluate(p, 1/x ) );
end function;

function MR(n,p)
a :=  (x^n - 1) / (p*Recip(p));
return a;
end function;

///////////////////////////////////////////////////////////////////////////////////////////////////

                                     









                                       for n in [42..50] do

n;
p := x^n - 1;
k := #Factorization(p); 
E := [ ];


                                               

if k eq 1 then

  for f in AllDiv1(p) do

    if IsCoercible(P, MR(n,f)) then
    Append(~E,f);
    end if; 
  
  end for;




elif k eq 2 then

  for f in AllDiv2(p) do

    if IsCoercible(P, MR(n,f)) then
    Append(~E,f);
    end if; 
  
  end for;



elif k eq 3 then

  for f in AllDiv3(p) do

    if IsCoercible(P, MR(n,f)) then
    Append(~E,f);
    end if; 
  
  end for;




elif k eq 4 then
  for f in AllDiv4(p) do

    if IsCoercible(P, MR(n,f)) then
    Append(~E,f);
    end if; 
  
  end for;




elif k eq 5 then

  for f in AllDiv5(p) do

    if IsCoercible(P, MR(n,f)) then
    Append(~E,f);
    end if; 
  
  end for;




elif k eq 6 then

  for f in AllDiv6(p) do

    if IsCoercible(P, MR(n,f)) then
    Append(~E,f);
    end if; 
  
  end for;





elif k eq 7 then

  for f in AllDiv7(p) do

    if IsCoercible(P, MR(n,f)) then
    Append(~E,f);
    end if; 
  
  end for;





elif k eq 8 then

  for f in AllDiv8(p) do
    
    if IsCoercible(P, MR(n,f)) then
    Append(~E,f);
    end if; 
  
  end for;





elif k eq 9 then

  for f in AllDiv9(p) do

    if IsCoercible(P, MR(n,f)) then
    Append(~E,f);
    end if; 
  
  end for;



else

n;
k;

                                                 end if;
                        

////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////





Codes := [ ];
GC    := [ ];

for g in E do

  Append(~Codes,CyclicCode(n, g));  
  Append(~GC,g); 
  //IsSelfOrthogonal(Dual(CyclicCode(n, g)));

end for;






m := 2*n;
QC := [ ];
GP := [ ];
RP := [ ];

for C1 in Codes do
  d1 := MinimumDistance(C1);
  for C2 in Codes do
      d2 := MinimumDistance(C2);
     
     
              
              MD := [ ];
              Append(~MD,d1); Append(~MD,d2);
              MD := Sort(MD);
              d := MD[1];
              k := Dimension(C1) + Dimension(C2);
              k := 2*k - m;
              V := [ ];
              B := [ ];
              R := [ ];
              Append(~V,m); Append(~V,k); Append(~V,d);
              Append(~B,GeneratorPolynomial(C1)); Append(~B,GeneratorPolynomial(C2));
              Append(~R,Recip(GeneratorPolynomial(C1))); Append(~R,Recip(GeneratorPolynomial(C2)));
              
              if d ne 1 then
              Append(~GP,B);
              Append(~QC,V);
              Append(~RP,R);
              end if;

end for; end for; 





procedure YAZ(QC,GP,RP)

F  := "c:/users/halit/desktop/faikhep.txt";
F1 := "c:/users/halit/desktop/faikpar.txt";  
   
   for i in [1..#QC] do
     //GP[i][1]; RP[i][1];
     //print " ";
     //GP[i][2]; RP[i][2];
     //print " ";
     QC[i];  
     //print " ";
     //print " "; 
     
     Write(F," Generator-1,Generator-2:");
     Write(F,GP[i][1]); Write(F,GP[i][2]); 
     Write(F," Reciprocal-1,Reciprocal-2: ");
     Write(F,RP[i][1]); Write(F,RP[i][2]);
     Write(F," Quantum Parameters: ");
     Write(F,QC[i]); 
     Write(F," "); 
     Write(F," ");
     Write(F," ");
     Write(F1,QC[i]); 
   end for; 

end procedure;


YAZ(QC,GP,RP);




                                                  end for;





















