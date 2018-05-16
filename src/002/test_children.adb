with Father.Son;
with Ada.Text_IO; use Ada.Text_IO;

procedure Test_Children is
   A : Father.Son.Son_Type := 5;  -- you can make it constant
   B : Father.Father_Type := 100; -- idem
   C : constant Father.Son.Sonic_Type := 20;
   R : Integer;
   --use type Father.Son.Son_Type;
   use type Father.Son.Sonic_Type;-- comment this
   use type Father.Father_Type;   -- comment this
begin
   R := Integer (Father.Son."+" (A, B));
   Put_Line (Integer'Image (R));
   R := Integer (B + A);
   Put_Line (Integer'Image (R));
   R := C + B;                   -- comment this
   -- R := B + C; --ERR
   Put_Line (Integer'Image (R)); -- comment this
end Test_Children;

