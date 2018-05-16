with My_Pack;
with Suppack;
with Ada.Text_IO; use Ada.Text_IO;

procedure Test_Init is
begin
   Put_Line (Integer'Image (My_Pack.Get));
   My_Pack.Set (100);
   Put_Line (Integer'Image (My_Pack.Get));
   Put_Line (Integer'Image (My_Pack.Get_Count));
   Suppack.Print;
   Put_Line (Integer'Image (My_Pack.Get_Count));   
end Test_Init;
