with A, B, Person;
with Ada.Text_IO; use Ada.Text_IO;

procedure Test_Pkg is
begin
   Put_Line ("Test_Pkg: " & Integer'Image (Person.Unit_Age));
   A.Print_Modify;
   Put_Line ("Test_Pkg: " & Integer'Image (Person.Unit_Age));   
   B.Print_Modify;
   Put_Line ("Test_Pkg: " & Integer'Image (Person.Unit_Age));
end Test_Pkg;
