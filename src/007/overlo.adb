-- experiment with overloading
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

procedure Overlo is
   function Do_Something (A : Integer) return Integer is
   begin
      Put_Line ("Integer " & Integer'Image (A) & " return Integer");
      return A;
   end;   
   
   function Do_Something (A : Float) return Integer is
   begin
      Put_Line ("Float " & Float'Image (A));
      return Integer (A);
   end;
   
   -- this actually works like a conversion Integer -> Float
   -- and you can't do it in, say, C++!
   function Do_Something (A : Integer) return Float is
   begin
      Put_Line ("Integer " & Integer'Image (A) & " return Float");
      return Float (A);
   end;
   
   type Alfa_Type is new Integer range -10 .. 100;
   type Beta_Type is new Integer range -101 .. -11;
   
   function Do_Something (A : Alfa_Type) return Beta_Type is
   begin
      Put_Line ("Alfa_Type returns Beta_Type");
      return Beta_Type (if A <= 0 then A - 11 else -A);
   end;
   
   I1, I2 : Integer;
   F      : Float;
   Beta   : constant Beta_Type := Do_Something (Alfa_Type (50));
   
   -- we need to instantiate Integer_IO for Beta_Type, the we
   -- use the instance so that Put gets properly overloaded
   -- and then we can write (*)
   package Beta_IO is new Ada.Text_IO.Integer_IO (Beta_Type);
   use Beta_IO;
   
   type Salute_Type is (Hello, Bye);
   type Work_Type   is (Light, Heavy, Routine);
   
   procedure Do_Action (A : Salute_Type) is
   begin
      Put ("Salute_Type: ");
      case A is
         when Hello =>
            Put_Line ("Hello");
         when Bye =>
            Put_Line ("Bye");
      end case;
   end;
   
   procedure Do_Action (A : Work_Type) is
   begin
      Put ("Work_Type: ");
      case A is
         when Light =>
            Put_Line ("Folding papers");
         when Heavy =>
            Put_Line ("Lifting lifts");
         when Routine =>
            Put_Line ("Spinning and spinning");
      end case;
   end;
   
begin
   I1 := Do_Something (10);
   I2 := Do_Something (5.3);
   F  := Do_Something (11);
   -- use them, so the compiler won't bother
   Put (I1); New_Line;
   Put (I2); New_Line;
   Put (F); New_Line;
   
   Put (Beta); -- (*)
   New_Line;
   
   Do_Action (Hello);
   Do_Action (Bye);
   Do_Action (Light);
   Do_Action (Heavy);
   Do_Action (Routine);
end Overlo;
