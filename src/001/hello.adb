with Greeter; use Greeter;
with Ada.Text_IO; use Ada.Text_IO;

procedure Hello is
   package Int_IO is new Ada.Text_IO.Integer_IO (Integer);

   X : Integer := 2;
   
   procedure Do_It
     with Global => (Input => X);
   
   procedure Do_It is
   begin
      if X > 20 then
         Greeter.Greet ("Hello");
      end if;
   end Do_It;
   
begin
   -- Put_Line (Greeter.Hello_Text);
   Greeter.X := 10;
   for I in Integer range 0 .. 25
   loop
      X := X + I;
      Do_It;
   end loop;
   Put_Line (Integer'Image (Greeter.X));
   Put_Line (Integer'Image (X));
   Int_IO.Put (X); New_Line;
end Hello;

