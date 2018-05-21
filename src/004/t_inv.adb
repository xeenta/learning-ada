with Ada.Text_IO; use Ada.Text_IO;

procedure T_Inv is
   
   package Internal is
      type Unknown is private with
        Type_Invariant => Isnt_Bad_Luck (Unknown);
      
      function Isnt_Bad_Luck
        (S : Unknown) return Boolean;

      procedure Assign (S : out Unknown;
                        D : in Integer);
      
      function To_String (S : Unknown) return String;
      
   private
      type Unknown is new Integer;
      
   end Internal;
   
   package body Internal is
      procedure Assign (S : out Unknown;
                        D : in Integer) is
         P : constant Unknown := 13;
      begin
	 -- This is ok: this intermediate value won't go outside here
         S := P;
         Put_Line ("It's ok " & Integer'Image (Integer (S)));
         S := Unknown (D + 2 * Integer (P));
         Put_Line ("And now?"); -- let's see what happens later
      end Assign;
      
      -- 13 is bad luck - indeed it's just like any other number, but
      -- you know, people can believe it.
      function Isnt_Bad_Luck (S : Unknown) return Boolean 
        is (S /= 13);
      
      -- This helps
      function To_String (S : Unknown) return String is
        (Integer'Image (Integer (S)));
      
   end Internal;
   
   V : Internal.Unknown;
begin
   Internal.Assign (V, 11);
   Put_Line ("Here it is " & Internal.To_String (V));
   Internal.Assign (V, -13);
   Put_Line ("And another one " & Internal.To_String (V));
end T_Inv;
