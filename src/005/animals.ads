package Animals is
   type Animal is abstract tagged private;
   
   function Legs
     (A : Animal) return Natural;
   
   function Wings
     (A : Animal) return Natural;
   
   procedure Add_Wings (A : in out Animal;
			N : Positive);
   
   procedure Add_Legs (A : in out Animal;
		       N : Positive);
   
private
   
   type Animal is abstract tagged
      record
	 Number_Of_Legs   : Natural;
	 Number_Of_Wings  : Natural;
      end record;   
   
end Animals;
