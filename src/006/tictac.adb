with Ada.Text_IO; use Ada.Text_IO;

procedure TicTac is
   
   task Count is
      entry Start;
      entry Stop;
      entry Reset;
   end Count;
   
   task body Count is
      Counter : Natural := 0;
      Is_Counting : Boolean := FALSE;
   begin
      loop
         select 
            when Is_Counting =>
               accept Stop do
                  Is_Counting := FALSE;
               end Stop;
               -- accept Start do
               --   Put_Line ("What?");
               -- end Start;
         or
            when not Is_Counting =>
               accept Start do
                  Is_Counting := TRUE;
               end Start;
         or
            accept Reset do
               Put_Line ("RESET");
               Counter := 0;
            end Reset;
         else
            if Is_Counting then
               Put_Line (Integer'Image (Counter) & ", counting...");
               delay 1.0;
               Counter := Counter + 1;
            end if;
         end select;
      end loop;
   end Count;
   
begin
   Count.Start;
   delay 5.5;
   Put_Line ("5.5!");
   delay 1.5;
   Count.Stop;
   Put_Line ("Stop");
   delay 3.0;
   Count.Start;
   Put_Line ("Start");
   delay 2.5;
   Count.Reset;
   delay 1.5;
   Put_Line ("Start again while counting...?");
   Count.Start; -- hang here!
   -- never reached
   Put_Line ("Restarted?");
   delay 3.0;
   Put_Line ("End of Main");
end TicTac;
