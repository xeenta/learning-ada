with Ada.Strings.Unbounded;

package Animals.Humans is
   
   type Human is new Animals.Animal with private;
   
   type Sex_Type is (Male, Female);
   
   function Make 
     (Name : String; 
      Sex  : Sex_Type)
     return Human;
   
   function Get_Name (H : Human) return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Sex  (H : Human) return Sex_Type;
   
   overriding
   procedure Add_Wings (A : in out Human;
			N : Positive);
   
private
   type Human is new Animals.Animal with
      record
	 Name   : Ada.Strings.Unbounded.Unbounded_String;
	 Sex    : Sex_Type;
      end record;
end Animals.Humans;
