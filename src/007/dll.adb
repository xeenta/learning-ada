with 
  Ada.Text_IO,
  Ada.Containers.Doubly_Linked_Lists;

use Ada.Text_IO;

procedure dll is
   
   Equal_Limit : constant := 10;
   
   generic
      Threshold : in Integer := 0;
   function Special_Equal (Left, Right : Integer) return Boolean;
   
   function Special_Equal (Left, Right : Integer) return Boolean is
   begin
      return abs (Left - Right) <= Threshold;
   end Special_Equal;
   
   function Int_Cmp_Fuzzy is new Special_Equal (Threshold => Equal_Limit);
   
   package Integer_List is new Ada.Containers.Doubly_Linked_Lists 
     (Element_Type => Integer,
      "="          => Int_Cmp_Fuzzy);
   
   package Int_IO is new Ada.Text_IO.Integer_IO (Integer);
   use Int_IO;
   
   A_List : Integer_List.List;
begin
   -- we can write it like this: Pkg.Subprogram (O, ...)
   Integer_List.Append (A_List, 10);
   Integer_List.Append (A_List, 200);
   Integer_List.Append (A_List, 220);
   
   for E of A_List loop
      Put (E); New_Line;
   end loop;
   
   -- or like this: O.Subprogram (...)
   if A_List.Contains (200) then
      Put_Line ("Contains 200");
   end if;
   
   -- we haven't put a 210 into the list, but our fuzzy cmp
   -- says we did.
   if A_List.Contains (210) then
      Put_Line ("it seems there's a 210 too");
   end if;
end dll;
