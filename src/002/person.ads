package Person is
   subtype Age is Natural range 0 .. 140;
   
   Adult_Age : constant Age := 18;
   
   Unit_Age : Age;
end Person;
