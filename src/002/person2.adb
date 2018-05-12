package body Person2 is
   
   procedure Set_Name (A_Person :    out Person;
		       Name     : in     Unbounded_String) is
   begin
      A_Person.Name := Name;
   end Set_Name;
   
   procedure Set_Age  (A_Person :    out Person;
		       Her_Age  : in     Age_Type) is
   begin
      A_Person.Age := Her_Age;
   end Set_Age;
   
   function Get_Name (A_Person : Person) return Unbounded_String
     is (A_Person.Name);
   
   function Get_Age  (A_Person : Person) return Age_Type
     is (A_Person.Age);
   
   function Is_Adult (A_Person : Person) return Boolean
     is (A_Person.Age >= Adult_Age);
   
end Person2;
