package Animals.Flying_Horses is
   
   type Flying_Horse is new Animals.Animal with private;
   
   type Color is (Snow_White, Pitch_Black, Light_Pink);
   
   function Make (Horse_Color : Color) return Flying_Horse;
   
   overriding
   procedure Add_Wings (A : in out Flying_Horse;
			N : Positive);
   
   overriding
   procedure Add_Legs (A : in out Flying_Horse;
		       N : Positive);
   
private
   type Flying_Horse is new Animals.Animal with
      record
	 Fur_Color : Color;
      end record;
end Animals.Flying_Horses;
