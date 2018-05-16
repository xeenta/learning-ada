with Ada.Text_IO; use Ada.Text_IO;


procedure Thick_Hello is
   package Counter is
      type C_Type is mod 17;
      procedure Increment;
      procedure Increment (I : Integer);
      procedure Decrement;
      function Value return C_Type;
   private
      Cnt : C_Type := 0;
   end Counter;
   
   package body Counter is
      procedure Increment is
      begin
         Cnt := Cnt + 1;
      end Increment;
      
      procedure Increment (I : Integer) is
      begin
         Cnt := Cnt + C_Type (I mod C_Type'Modulus);
      end Increment;

      procedure Decrement is
      begin
         Cnt := Cnt - 1;
      end Decrement;
      
      function Value return C_Type is (Cnt);
   end Counter;
   
   package M is new Ada.Text_IO.Modular_IO (Counter.C_Type);
   use type Counter.C_Type;
   T : Counter.C_Type := 0;
begin
   for I in Integer range 1 .. 120
   loop
      if I rem 7 = 0 then
         Counter.Decrement;
      elsif I rem 12 = 0 then
         Counter.Decrement;
      elsif I rem 17 = 0 then
         Counter.Increment;
      elsif I rem 25 = 0 then
         Counter.Increment (I);
      end if;
      if T = Counter.Value then
         Counter.Increment;
      end if;
      M.Put (Counter.Value); New_Line;
      T := Counter.Value;
   end loop;
end Thick_Hello;
