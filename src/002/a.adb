with Person;
with Ada.Text_IO; use Ada.Text_IO;

package body A is
   procedure Print_Modify is
      package I is new Ada.Text_IO.Integer_IO (Integer);
   begin
      I.Put (Person.Unit_Age); New_Line;
      Person.Unit_Age := 10;
   end Print_Modify;
end A;
