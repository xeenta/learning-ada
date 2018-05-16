package body Father is
   procedure Father_What (A : in out Father_Type) is
   begin
      A := A + 1;
   end Father_What;
end Father;
   
