with Ada.Text_IO; use Ada.Text_IO;

procedure Steps is
   
   task Step_By_Step is
      entry Step_One;
      entry Step_Two;
      entry Step_Three;
   end Step_By_Step;
   
   task body Step_By_Step is
   begin
      accept Step_One do
         Put_Line ("1");
      end Step_One;
      accept Step_Two do
         Put_Line ("2");
      end Step_Two;
      accept Step_Three do
         Put_Line ("3");
      end Step_Three;
   end Step_By_Step;
   
begin
   Put_Line ("Steps");
   Step_By_Step.Step_One;
   Step_By_Step.Step_Two;
   Put_Line ("Redo step 1?");
   Step_By_Step.Step_One;
   Put_Line ("Just before the end");
end;
