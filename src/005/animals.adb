package body Animals is
   
   function Legs
     (A : Animal) return Natural
   is (A.Number_Of_Legs);
   
   function Wings
     (A : Animal) return Natural
   is (A.Number_Of_Wings);
   
   procedure Add_Wings (A : in out Animal;
			N : Positive) is
   begin
      A.Number_Of_Wings := A.Wings + 2 * N;
   end Add_Wings;
   
   procedure Add_Legs (A : in out Animal;
		       N : Positive) is
   begin
      A.Number_Of_Legs := A.Number_Of_Legs + 2 * N;
   end Add_Legs;
   
end Animals;
