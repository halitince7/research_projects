//load "c:/users/mathatin/desktop/Fcirc.txt";

Z4 := IntegerRing(4);

P<u> := PolynomialRing(Z4);
R<u> := quo< P | u^2 - 2*u >;


function Fcirc(v)

   n := 6;
   w := [ ];
   A := [ ];
   for i in [1..n] do
     A := A cat v;
    
     for j in [2..n] do
       w[j] := v[j-1];
     end for;
     w[1] := v[n];
     v := w;  
   end for;
   M := Matrix(R, n, n, A); 
   return M;

end function;


Q := [1,0,0, 2+u, 1+u,  1+u];

Fcirc(Q);  


