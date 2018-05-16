package Father.Son is
   subtype Son_Type is Father_Type range -20 .. 20;
   type Sonic_Type is range -20 .. 20;
   
   function "+" (Left : Son_Type; Right : Father_Type) return Father_Type;
   function "+" (Left : Sonic_Type; Right : Father_Type) return Integer;
   
end Father.Son;
