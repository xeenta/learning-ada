package body Animals.Flying_Horses is
   
   function Make (Horse_Color : Color) return Flying_Horse is
      R : Flying_Horse;
   begin
      R.Number_Of_Wings := 2;
      R.Number_Of_Legs := 4;
      R.Fur_Color := Horse_Color;
      return R;
   end Make;
   
   -- these are perfect animals, you won't mess with their wings or legs!
   
   overriding
   procedure Add_Wings (A : in out Flying_Horse;
			N : Positive) is
   begin
      null;
   end Add_Wings;
   
   overriding
   procedure Add_Legs (A : in out Flying_Horse;
		       N : Positive) is
   begin
      null;
   end Add_Legs;
   
end Animals.Flying_Horses;
