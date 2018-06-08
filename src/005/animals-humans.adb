with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Animals.Humans is
   
   function Make 
     (Name : String; 
      Sex  : Sex_Type) return Human 
   is
      H : Human;
   begin
      H.Number_Of_Legs := 2;
      H.Number_Of_Wings := 0;
      H.Name := To_Unbounded_String (Name);
      H.Sex := Sex;
      return H;
   end Make;
   
   function Get_Name (H : Human) return Unbounded_String is (H.Name);
   
   function Get_Sex  (H : Human) return Sex_Type is (H.Sex);
   
   overriding
   procedure Add_Wings (A : in out Human;
			N : Positive) is
   begin
      null;
   end Add_Wings;

   
end Animals.Humans;
