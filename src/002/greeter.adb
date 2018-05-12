--with Ada.Text_IO; use Ada.Text_IO;
with Greetings;
with Ada.Text_IO; use Ada.Text_IO;

procedure Greeter is
begin
   Put_Line (Greetings.Hello);
   Greetings.Swear (Greetings.Hello, 12);
   Greetings.Swear ("good evening", 20);
end Greeter;
