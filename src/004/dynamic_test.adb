with Ada.Text_IO; use Ada.Text_IO;

procedure Dynamic_Test is
   subtype Odd_Number is Integer with 
     Dynamic_Predicate => Odd_Number mod 2 /= 0;
   
   A_Number : Odd_Number := 1;
   
   -- despite the procedure name, I've used this source to test
   -- Static_Precidate too.
   
   -- This is taken from the manual
   type Animal is (Bear, Cat, Dog, Horse, Wolf, Rabbit);
   subtype Pet is Animal with
     Static_Predicate => Pet in Cat | Dog | Horse;
   
   -- gcc 4.9.2 won't compile this, even in Ada 2012 mode: then I am
   -- using an older version.
   subtype Pet2 is Animal with
     Static_Predicate => (case Pet2 is
                             when Cat | Dog | Horse | Rabbit => True,
                             when Bear | Wolf => False);
   
   
   My_Pet   : constant Pet  := Dog;
   My_Petty : constant Pet2 := Rabbit;
begin
   A_Number := A_Number + 2;
   Put_Line (Integer'Image (A_Number));
   -- buying a new pet... breaks the static_predicate
   --My_Pet := Bear;
   Put_Line (Pet'Image (My_Pet));
   Put_Line (Pet2'Image (My_Petty));
end Dynamic_Test;
