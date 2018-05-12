with Ada.Text_IO; use Ada.Text_IO;

package body Greetings is
   
   procedure Swear (Greeting    : String;
                    Speaker_Age : Person.Age := Person.Age'First) is
   begin
      if Speaker_Age >= Person.Adult_Age then
         Put_Line ((if Greeting = Hello then Swear_Hello
                    elsif Greeting = Hi then Swear_Hi
                    elsif Greeting = Good_Morning then Swear_Morning
                    elsif Greeting = What_s_Up then Swear_Whats_Up
                    else raise Unknown_Greeting));
      else
         Put_Line (Hello);
      end if;
   end Swear;

end Greetings;
