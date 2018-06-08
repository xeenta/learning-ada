with Animals.Humans; use Animals;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded;

procedure Test_Humans is
   package U renames Ada.Strings.Unbounded;
   
   Karl_Marx : Humans.Human := 
     Humans.Make ("Karl Marx", 
		  Humans.Male);
   
   --Not_Human : Animal;
   
begin   
   Put (U.To_String (Karl_Marx.Get_Name) & ", ");
   Put_Line (Humans.Sex_Type'Image (Karl_Marx.Get_Sex) & ":");
   Put_Line (Natural'Image (Karl_Marx.Legs) & " legs");
   Put_Line (Natural'Image (Karl_Marx.Wings) & " wings");
   
   -- mad scientist can add legs, not wings, to human...
   Karl_Marx.Add_Legs (1);
   Karl_Marx.Add_Wings (2);
   Put_Line (Natural'Image (Karl_Marx.Legs) & " legs");   
   Put_Line (Natural'Image (Karl_Marx.Wings) & " wings");
   
   -- but if we consider Karl_Marx just an animal, then...
   Animal (Karl_Marx).Add_Wings (2);
   Put_Line (Natural'Image (Karl_Marx.Wings) & " wings");   
end Test_Humans;
