package Oriented is
   
   type Object is tagged limited private;
   type Object_Access is access Object;
   
   procedure Initialize (Ob : in out Object; P_Id : in Positive);
   function Get_Item_Id (Ob : in Object) return Positive;
   
   function NewObj return Object_Access;
   
   procedure Free (Obj : in out Object_Access);
   
private
   
   subtype Counter_Type is Integer range 2 .. 99;
   
   type Id_Type is
      record
         Serial : Positive := 1;
         Subpart : Positive := 1;
      end record;
   
   type Object is tagged limited
      record
         Counter : Counter_Type := 2;
         Id : Id_Type;
      end record;
   
end Oriented;
