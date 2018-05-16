package Moving_Thing is
   type Position is private;
   type Speed is private;
   type Thing is private;
   
   type Direction is (North, South,
		      East, West,
		      Up, Down);
   
   procedure Faster (T : in out Thing;
		     D : in     Direction;
		     M : in     Float);
		     
   procedure Stop (T : in out Thing);

private
   type Position is
      record
	 X, Y, Z : Float;
      end record;
   
   type Speed is
      record
	 Vx, Vy, Vz : Float;
      end record;
   
   type Thing is
      record
	 Pos : Position;
	 Spd : Speed;
      end record;
end Moving_Thing;
