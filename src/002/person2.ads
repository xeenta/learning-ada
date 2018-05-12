with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Person2 is
   subtype Age_Type is Natural range 0 .. 140;
   
   type Person is private;
   
   procedure Set_Name (A_Person :    out Person;
                       Name     : in     Unbounded_String);
   procedure Set_Age  (A_Person :    out Person;
                       Her_Age  : in     Age_Type);
   
   function Get_Name (A_Person : Person) return Unbounded_String;
   function Get_Age  (A_Person : Person) return Age_Type;
   
   function Is_Adult (A_Person : Person) return Boolean;
   
private
   Adult_Age : constant Age_Type := 18;

   type Person is 
      record
         Name : Unbounded_String;
         Age  : Age_Type;
      end record;
   
end Person2;
