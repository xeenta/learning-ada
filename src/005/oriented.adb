with Ada.Unchecked_Deallocation;

package body Oriented is
   
   function NewObj
     return Object_Access
   is
      Local : Object_Access;
   begin
      Local := new Object'(Counter => 3,
                           Id => (Serial => 1,
                                  Subpart => 2));
      return Local;
   end NewObj;
   
   procedure Free (Obj : in out Object_Access) is
      procedure Free_Object is new Ada.Unchecked_Deallocation
        (Object => Object, Name => Object_Access);
   begin
      --null;
      Free_Object (Obj);
   end Free;
   
   procedure Initialize
     (Ob : in out Object;
      P_Id : Positive) is
   begin
      Ob.Counter := 2;
      Ob.Id.Serial := P_Id + 1;
      Ob.Id.Subpart := Ob.Id.Serial + P_Id * 2;
   end Initialize;
   
   function Get_Item_Id 
     (Ob : in Object)
     return Positive is
   begin
      return Ob.Counter + Ob.Id.Serial + Ob.Id.Subpart;
   end Get_Item_Id;
   
end Oriented;
