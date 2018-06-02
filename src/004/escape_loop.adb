with Ada.Text_IO; use Ada.Text_IO;

procedure Escape_Loop is
   package IO is new Integer_IO (Integer);
begin
Reverse_Loop:
   for I in reverse 1 .. 100 loop
      for J in 2*I .. 4*I loop
         IO.Put (I);
         exit reverse_loop when I*J mod 300 = 0;
         IO.Put (J); New_Line;
      end loop;
   end loop Reverse_Loop;
end Escape_Loop;
