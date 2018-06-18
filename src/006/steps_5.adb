with Ada.Text_IO; use Ada.Text_IO;

procedure Steps_5 is
   
   task Step_By_Step is
      entry Step_One;
      entry Step_Two;
   end Step_By_Step;
   
   task body Step_By_Step is
   begin
      loop
         select
            accept Step_One do
               Put_Line ("1");
            end Step_One;
         or
            accept Step_Two do
               Put_Line ("2");
            end Step_Two;
         or
            terminate;
         end select;
         Put_Line ("Again?!");
      end loop;
      Put_Line ("Never been here");
   end Step_By_Step;
   
begin
   Put_Line ("the world is a vampire");
   delay 3.2;
   Put_Line ("We don't even know");
   Step_By_Step.Step_Two;
   delay 1.0;
   Put_Line ("Gone now");
   Step_By_Step.Step_One;
   delay 1.0;
   Put_Line ("The End");
end;
