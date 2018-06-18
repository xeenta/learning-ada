with Ada.Text_IO; use Ada.Text_IO;

procedure Steps_2 is
   
   task Step_By_Step is
      entry Step_One;
      entry Step_Two;
      entry Step_Three;
   end Step_By_Step;
   
   task body Step_By_Step is
   begin
      select
         accept Step_One do
            Put_Line ("1");
         end Step_One;
      or
         accept Step_Two do
            Put_Line ("2");
         end Step_Two;
      or
         accept Step_Three do
            Put_Line ("3");
         end Step_Three;
      end select;
      Put_Line ("Bye from Step_By_Step");
   end Step_By_Step;
   
begin
   delay 1.0;
   Put_Line ("Bye?");
   Step_By_Step.Step_Three;
   delay 1.0;
   Put_Line ("Bye!");
end;
