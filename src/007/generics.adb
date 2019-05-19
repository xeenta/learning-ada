-- tests with generics

with Ada.Text_IO; use Ada.Text_IO;

procedure Generics is

   generic
      type T is (<>);
      N : in T;
      with function "*" (A, B : T) return T is <>;
   function Multiplier (X : T) return T;
   
   function Multiplier (X : T) return T is
   begin
      return N * X;
   end;
   
   
   function Double_It is new Multiplier (Integer, 2);
   
   --  this can't work.
   --function Double_It is new Multiplier (Float, 2.0);
   
   type Num is (Zero, One, Two, Three, Four, Five, Six);   
   
   function "*" (A, B : Num) return Num is
   begin
      if Num'Pos (A) * Num'Pos (B) <= Num'Pos (Six) then
         return Num'Val (Num'Pos (A) * Num'Pos (B));
      else
         return Six;
      end if;
   end;
   
   --  no problem with overloading in Ada!
   function Double_It is new Multiplier (Num, Two);
   
   function Star_Op (A, B : Integer) return Integer is
   begin
      return (if A > B then A * (B + 1) else (A + 1) * B);
   end Star_Op;
   
   --function Strangeness is new Multiplier (Integer, 6, Star_Op);
   function Strangeness is new Multiplier (T   => Integer, 
                                           N   => 6, 
                                           "*" => Star_Op);   
   
   -- Ada.Text_IO.Integer_IO is a generic pkg! Here we instantiate it,
   -- the use it to overload Put with this type too.
   package Int_IO is new Integer_IO (Integer);
   use Int_IO;
   
   -- a modular type
   type Byte is mod 256;
   Byte_Test : Byte := 255;
   
   -- Ada.Text_IO.Modular_IO is another generic pkg.
   package Mod_IO is new Modular_IO (Byte);
   use Mod_IO;
   
   -- and another generic package is...
   package Enum_IO is new Enumeration_IO (Num);
   use Enum_IO;
   
   Num_Test : Num := Zero;
begin
   -- Modular test
   Put (Byte_Test); New_Line;  -- 255
   Byte_Test := Byte_Test + 1; -- this is ok
   Put (Byte_Test); New_Line;  -- 0
   
   -- enumeration test
   Put (Num_Test); New_Line;            -- ZERO
   Put (Num'Succ (Num_Test)); New_Line; -- ONE
   
   -- generics tests
   Put (Double_It (10)); New_Line;
   -- instead of Enum_IO, we can do this:
   Put_Line (Num'Image (Double_It (Three))); -- SIX
   Put_Line (Num'Image (Double_It (Two)));   -- FOUR
   Put (Strangeness (10)); New_Line;
   Put (Strangeness (5));  New_Line;
   Put (Strangeness (7));  New_Line;
end Generics;
   
