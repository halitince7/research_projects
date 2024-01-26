function W272(WE)
   
   
   d := MinimumDistance(C);
   
   if d ne 12 then
      return 0;
   end if;

   
       if WE[2][1] eq 12 then
          for beta := -10000 to 10000 do
              if 43989+beta eq WE[2][2] then
                 return [beta];
                 break;
              else
                 return 0;
              end if;
           end for;
        end if;
    

end function;



function W172(WE)
   
   
   d := MinimumDistance(C);
  
   if d ne 12 then
      return 0;
   end if;

   
       if WE[2][1] eq 12 then
          beta := WE[2][2]/2;
          for gama := -10000 to 10000 do
              if 8640-64*gama eq WE[3][2] and 124281-24*beta+384*gama eq WE[4][2] then
                 return [1,gama,beta];
                 break;
              elif 7616-64*gama eq WE[3][2] and 134521-24*beta+384*gama eq WE[4][2] then
                 return [2,gama,beta];
                 break;
              else
                 return 0;
              end if;
           end for;
        end if;
    

end function;



function WhatType(WE)

   if WE[3][1] eq 14 then return 1; end if;
   if WE[3][1] eq 16 then return 2; end if;

end if;



function Values(WE)

   if WhatType(WE) eq 2 then
      b := W272(WE);
      print "Type 2 code, Alpha Value is: "; b;
   elif WhatType(WE) eq 1 then 
      b := W172(WE);
      gama := b[2];
      beta := b[3];
      s := [gama,beta];
      if b[1] eq 1 then
         print "Type 2 WE_1, Gama, Beta:"; s;
      elif b[1] eq 2 then
         print "Type 2 WE_1, Gama, Beta:"; s;
      end if;
   else
      return 0;
   end if;

end function;








