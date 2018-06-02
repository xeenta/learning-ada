with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Calendar; use Ada.Calendar;


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
   
   package SU renames Ada.Strings.Unbounded;
   subtype U_String is SU.Unbounded_String;
   function Us (S : String) return U_String renames SU.To_Unbounded_String;
      
   type Person is
      record
         Name      : U_String;
         Surname   : U_String;
         Birthday  : Time;
         Deathday  : Time;
         Alive     : Boolean;
         Married   : Boolean;
      end record 
      with Dynamic_Predicate =>
         Person.Alive
            or else Person.Birthday < Person.Deathday;

   Aldo : Person := (
                      Name => Us ("Al"),
                      Surname => Us ("Pachinko"),
                      Birthday => Time_Of (2018, 1, 20),
                      Deathday => Time_Of (2017, 1, 20),
                      Alive => True,
                      Married => False
                    );

   Copy_Of_Aldo : Person;

   procedure Massage_Person (A_Person : in Person) is
   begin
      Put_Line ("Entering massage box");
      Put_Line ("Massaging Mr/Ms " & SU.To_String (A_Person.Surname));
   end Massage_Person;

begin
   A_Number := A_Number + 2;
   Put_Line (Integer'Image (A_Number));
   -- buying a new pet... breaks the static_predicate
   --My_Pet := Bear;
   Put_Line (Pet'Image (My_Pet));
   Put_Line (Pet2'Image (My_Petty));
   Put_Line ("Playing with Al");
   Aldo.Alive := False;
   -- comment/uncomment lines according to what you want to try.
   -- Aldo.Deathday := Time_Of (2019, 1, 19);
   Massage_Person (Aldo); -- checking dynamic pred
   --Copy_Of_Aldo := Aldo;
   Put_Line ("END...?");
   Aldo.Alive := True;
   if Aldo.Alive then
      Put_Line ("Al is alive!");
   end if;
   --Aldo := (Name => Us ("Aldebaran"),
   --         Surname => Us ("Pax"),
   --         Birthday => Aldo.Birthday,
   --         Deathday => Aldo.Deathday,
   --         Alive => False,
   --         Married => True);
   --Aldo.Alive := True;
   Put_Line ("Real END");
end Dynamic_Test;
