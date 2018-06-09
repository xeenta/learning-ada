with Ada.Text_IO; use Ada.Text_IO;
with Oriented; use Oriented;
--with Ada.Unchecked_Deallocation;

procedure Oriented_Test is
   Void_Obj : Object;
   Obj2     : Object;
   Obj_A    : Object_Access;
   Obj_A2   : Object_Access;
   
   X        : aliased Integer;
   X_Ref    : access Integer;
   X1_Ref   : access Integer;
   Y_Ref    : not null access Integer := X'Access;
   
   procedure Change_Int (I : not null access Integer) is
   begin
      I.all := 1999;
   end Change_Int;
   
   --procedure Free_Object is new Ada.Unchecked_Deallocation
   --  (Object => Object, Name => Object_Access);
   
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
   
   X_Ref := X'Access;
   X1_Ref := X_Ref;
   X := 2018;
   Put_Line (Integer'Image (X_Ref.all));
   Put_Line (Integer'Image (X1_Ref.all));
   Y_Ref.all := 2016;
   Put_Line (Integer'Image (X));
   Put_Line (Integer'Image (Y_Ref.all));
   Change_Int (X1_Ref);
   X1_Ref := null;
   -- The compiler warns us and a Constraint_Error
   -- exception will be raised at runtime
   --Change_Int (X1_Ref);
   if X1_Ref = null then -- condition is always true!
      Put_Line ("X1_Ref is really null, duh!");
   end if;
   X1_Ref := new Integer'(2011);
   Put_Line (Integer'Image (X1_Ref.all));   
   Change_Int (X1_Ref);
   Put_Line (Integer'Image (X1_Ref.all));
   -- Y_Ref := null; -- can't do this
end Oriented_Test;
