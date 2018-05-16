package body My_Pack is
   
   Internal_Value : Integer;
   Count : Integer := 0;
   
   function Get return Integer is (Internal_Value);
   
   function Get_Count return Integer is (Count);

   
   procedure Set (V : in Integer) is
   begin
      Internal_Value := V;
   end Set;
   
begin
   Internal_Value := 25;
   Count := Count + 1;
end My_Pack;
