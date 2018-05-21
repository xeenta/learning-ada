with Ada.Text_IO; use Ada.Text_IO;

procedure Loopinv is
   A : array (1 .. 20) of Integer;
   
   package IO is new Integer_IO (Integer);
begin
   -- let's fill the array with data
   for I in A'Range loop
      A (I) := (if I mod 2 = 0 then I-1 else I);
      IO.Put (A (I));
   end loop;
   New_Line (2);
   
   for I in A'First .. A'Last / 2 loop
      for J in I + 1 .. I + A'Last / 2 loop
         pragma Loop_Invariant (A (I) <= A (J));
         IO.Put (A (I)); IO.Put (A (J)); New_Line;
      end loop;
   end loop;
end Loopinv;
