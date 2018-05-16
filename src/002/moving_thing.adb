package body Moving_Thing is

   procedure Faster (T : in out Thing;
                     D : in     Direction;
                     M : in     Float) is
   begin
      null; -- null statement
   end Faster;

   procedure Stop (T : in out Thing) is
   begin
      T.Spd.Vx := 0.0;
      T.Spd.Vy := 0.0;
      T.Spd.Vz := 0.0;
   end;

end Moving_Thing;

