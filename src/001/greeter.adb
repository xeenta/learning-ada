with Ada.Text_IO; use Ada.Text_IO;

package body Greeter is
   
   Hello_Text : constant String := "Hello ";

   procedure Greet (S : String) is
   begin
      Put_Line (Hello_Text & S & "!");
      Put_Line (Hi_Text);
   end Greet;

end Greeter;
