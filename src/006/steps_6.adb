with Ada.Text_IO; use Ada.Text_IO;

procedure Steps_6 is
   
   task Step_By_Step is
      entry Step_One;
      entry Step_Two;
   end Step_By_Step;
   
   task body Step_By_Step is
      Waiting_Count : Natural := 1;
   begin
      loop
         select
            accept Step_One do
               Put_Line ("1");
               Waiting_Count := 1;
            end Step_One;
         or
            accept Step_Two do
               Put_Line ("2");
               Waiting_Count := 1;
            end Step_Two;
         or
            delay 3.0;
            if Waiting_Count mod 4 = 0 then
               Put_Line ("Hurry Up, call me!");
            else
               Put_Line ("No calls. Waiting for another 3 secs");
            end if;
            Waiting_Count := Waiting_Count + 1;
         end select;
      end loop;
   end Step_By_Step;
   
begin
   Put_Line ("I do my business for 5.5 secs");
   delay 5.5;
   Put_Line ("Stepping into 1");
   Step_By_Step.Step_One;
   Put_Line ("Again... I do my business in 3.5 secs");
   delay 3.5;
   Step_By_Step.Step_Two;
   Put_Line ("Rest for 2 secs...");
   delay 2.0;
   Put_Line ("Wait...");
   delay 1.5;
   Put_Line ("Work hard 5 times!");
   for I in Integer range 1 .. 5 loop
      Put_Line ("** round " & Integer'Image (I));
      Step_By_Step.Step_One;
      delay 1.0;
      Step_By_Step.Step_Two;
      delay 1.0;
   end loop;
   Put_Line ("Tired... Bye!");
end;
