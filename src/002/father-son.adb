with Ada.Text_IO; use Ada.Text_IO;

package body Father.Son is
   function "+" (Left : Son_Type; Right : Father_Type) return Father_Type is
      T : Father_Type := Right;
   begin
      Put_Line ("using this");
      Father_What (T);
      return Father_Type (3 * Integer (Left) + Integer (T));
   end "+";
   
   function "+" (Left : Sonic_Type; Right : Father_Type) return Integer is
   begin
      Put_Line ("sonic this");
      return 2 * Integer (Left) + Integer (Right) - 1;
   end "+";
end Father.Son;
