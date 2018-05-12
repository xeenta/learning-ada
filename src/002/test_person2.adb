with Person2; use Person2;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Test_Person2 is
   I_Am_Hugo : Person;
begin
   Set_Name (I_Am_Hugo, To_Unbounded_String ("Hugo"));
   Set_Age  (I_Am_Hugo, 19);
   if Is_Adult (I_Am_Hugo) then
      Put_Line ("He's adult");
   end if;
end Test_Person2;
