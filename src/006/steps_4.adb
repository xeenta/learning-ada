with Ada.Text_IO; use Ada.Text_IO;

procedure Steps_4 is
   
   task Step_By_Step is
      entry Step_One;
      entry Step_Two;
      entry Step_Three;
      entry Finish;
   end Step_By_Step;
   
   task body Step_By_Step is
      Keep_Looping : Boolean := TRUE;
   begin
      while Keep_Looping loop
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
         or
            accept Finish do
               Keep_Looping := FALSE;
            end Finish;
         end select;
         Put_Line ("Again!");
      end loop;
      Put_Line ("Here we go");
   end Step_By_Step;
   
begin
   delay 1.0;
   Put_Line ("Bye?");
   Step_By_Step.Step_Three;
   delay 1.0;
   Step_By_Step.Step_Two;
   delay 1.0;
   Put_Line ("Bye by me, not by the task!");
   delay 1.0;
   Step_By_Step.Finish;
end;
