with My_Pack;
with Ada.Text_IO; use Ada.Text_IO;

package body Suppack is
   procedure Print is
   begin
      Put_Line (Integer'Image (My_Pack.Get));
   end Print;
end Suppack;
