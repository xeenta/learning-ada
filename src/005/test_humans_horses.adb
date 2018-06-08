with Animals.Humans;
with Animals.Flying_Horses;
use Animals;

with Ada.Text_IO; use Ada.Text_IO;

procedure Test_Humans_Horses is

   Rider : Humans.Human :=
     Humans.Make ("Knight Rider",
                  Humans.Male);

   Pegasus : Flying_Horses.Flying_Horse :=
     Flying_Horses.Make (Flying_Horses.Snow_White);

   procedure Transform_Accordingly (O : in out Animal) is
   begin
      O.Add_Wings (2);
      O.Add_Legs (1);
   end Transform_Accordingly;
   
   procedure Transform_Accordingly_OK (O : in out Animal'Class) is
   begin
      O.Add_Wings (2);
      O.Add_Legs (1);
   end Transform_Accordingly_OK;
   
   NL : constant Character := Character'Val (10);

begin
   Put_Line("Original Rider" & NL &
              Integer'Image (Rider.Wings) & " wings" & NL &
              Integer'Image (Rider.Legs) & " legs");
   Put_Line("Original Pegasus" & NL &
              Integer'Image (Pegasus.Wings) & " wings" & NL &
              Integer'Image (Pegasus.Legs) & " legs");
   
   -- This isn't what we want
   --Transform_Accordingly (Animal (Rider));
   --Transform_Accordingly (Animal (Pegasus));
   
   Transform_Accordingly_OK (Rider);
   Transform_Accordingly_OK (Pegasus);   
   
   Put_Line("Trans Rider" & NL &
              Integer'Image (Rider.Wings) & " wings" & NL &
              Integer'Image (Rider.Legs) & " legs");
   Put_Line("Trans Pegasus" & NL &
              Integer'Image (Pegasus.Wings) & " wings" & NL &
              Integer'Image (Pegasus.Legs) & " legs");
end Test_Humans_Horses;
