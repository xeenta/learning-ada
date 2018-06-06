with Ada.Text_IO; use Ada.Text_IO;
with Oriented; use Oriented;
with Ada.Unchecked_Deallocation;

procedure Oriented_Test is
   Void_Obj : Object;
   Obj2     : Object;
   Obj_A    : Object_Access;
   Obj_A2   : Object_Access;
   
   procedure Free_Object is new Ada.Unchecked_Deallocation
     (Object => Object, Name => Object_Access);
   
begin
   Void_Obj.Initialize (10);
   -- Obj2 := Void_Obj; -- no, because limited
   Obj_A := NewObj;
   Obj_A2 := Obj_A; -- not a good idea
   Put_Line (Integer'Image (Void_Obj.Get_Item_Id));
   --Free_Object (Obj_A); -- ok
   Put_Line ("Before");
   if Obj_A /= null then
     Put_Line ("Not null");
   end if;
   Free (Obj_A);
   if Obj_A = null then
     Put_Line ("Null");
   end if;
   if Obj_A2 /= null then
      Put_Line ("Ops");
   end if;
end Oriented_Test;
