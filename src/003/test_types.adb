-- compile with -gnatW8
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Wide_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;

procedure Test_Types is
   type Cows_Counter_Type is new Natural;

   type Fixed_Point_Type is delta 0.01 range 0.0 .. 1_166_405_539.00;

   -- decimal fixed point
   type Money is delta 0.001 digits 15;
   
   type Byte is mod 2**8;
   for Byte'Size use 8;
   
   subtype Age_Type is Integer range 0 .. 150;
   package SU renames Ada.Strings.Unbounded;
   subtype U_String is SU.Unbounded_String;
   function Us (S : String) return U_String renames SU.To_Unbounded_String;
   
   -- A record
   type Person is 
      record
         Name    : U_String;
         Surname : U_String;
         Age     : Age_Type;
         Married : Boolean;
      end record;

   
   function To_String (P : Person) return String is
   begin
      return SU.To_String (P.Name) & " " &
             Su.To_String (P.Surname) & ", " &
             Integer'Image (P.Age) & " years old, " &
	     (if P.Married then "married" else "single");
   end To_String;
   

   
   -- overload the concat op, just for moo
   function "&" (L : String;
                 R : Cows_Counter_Type) return String is
   begin
      return L & Integer'Image (Integer (R));
   end "&";

   Cows_In_The_Park : constant Cows_Counter_Type := 0;
   Newborn_Cows     : constant Integer := 1;

   Huge_Number      : constant Long_Integer := Long_Integer'Last;
   Very_Huge_Number : constant Long_Long_Integer := Long_Long_Integer'First;
   
   Normal_Float     : constant Float := Float'Last;
   Big_Float        : constant Long_Float := Long_Float'Last;
   Huge_Float       : constant Long_Long_Float := Long_Long_Float'Last;

   -- ANSI ESC seq for Bold and normal
   Esc_Char        : constant Character := Character'Val (27);
   Bold_On         : constant String := Esc_Char & "[1m";
   Fancy_Off       : constant String := Esc_Char & "[0m";

   -- this is a way to encode a character by its code
   Strange_Sign    : constant Wide_Character := '["A345"]';

   -- or we can write it "for real", provided the source code encoding
   -- matches the one chosen by the compiler... I use UTF-8 and GNAT
   -- compiler, therefore I've added the -gnatW8 option
   Greek_Letter    : constant Wide_Character := 'α';

   -- Also with Wide_Character we can use the attribute-function Val
   -- to convert the code of a character into the character
   No_Hiragana     : constant Wide_Character := Wide_Character'Val (16#306e#);

   -- always with the -gnatW8 option, we can write "wide string"
   -- directly.
   Hello_String    : constant Wide_String := "→Hello← ";

   -- A second longs a second
   One_Second      : constant Duration := 1.0;
   T               : Duration;
   
   -- these are bytes; let's see the wrap-around arithmetic
   Byte_1          : constant Byte := 254;
   Byte_2          : constant Byte := Byte_1 + 1;
   Byte_3          : constant Byte := Byte_2 + 1;
   
   
   Homer_Simpson   : constant Person := (Name => Us ("Homer"),
                                         Surname => Us ("Simpson"),
                                         Age => 54,
				         Married => True);

   package LI  is new Integer_IO (Long_Integer);
   package LLI is new Integer_IO (Long_Long_Integer);
   package F   is new Float_IO (Float);
   package FF  is new Float_IO (Long_Float);
   package FFF is new Float_IO (Long_Long_Float);
   package D   is new Fixed_IO (Duration);
   package M   is new Modular_IO (Byte);

   -- we can also have our special Cow IO
   package Cow is new Integer_IO (Cows_Counter_Type);

   package W renames Ada.Wide_Text_IO;
begin
   -- the following won't compile
   --Cows_In_The_Park := Cows_In_The_Park + Newborn_Cows;

   Put_Line ("cows in the park: " & Cows_In_The_Park);
   Cow.Put (Cows_In_The_Park); Put ("; ");
   Put ("newborn cows: "); Put (Newborn_Cows); New_Line;
   Put (Integer (Cows_Counter_Type'Last)); New_Line;
   LI.Put (Huge_Number); New_Line;
   LLI.Put (Very_Huge_Number); New_Line;
   Put (Integer'First);
   Put (Integer'Last); New_Line;
   Put (Float'Digits); Put (" §§ ");
   F.Put (Float'First); New_Line;
   delay One_Second; -- let's waste a second of your time
   Put (Long_Float'Digits); New_Line;
   Put (Long_Long_Float'Digits); New_Line;
   F.Put (Normal_Float); Put (" << Float"); New_Line;
   FF.Put (Big_Float); Put (" << Long_Float"); New_Line;
   FFF.Put (Huge_Float); Put (" << Long_Long_Float"); New_Line;
   Put_Line (Bold_On & "BOLD" & Fancy_Off);
   W.Put_Line (Hello_String &
               Greek_Letter &
               Strange_Sign &
               No_Hiragana);
   T := 1.0;
   while T > 0.01 loop
      D.Put (T, Aft => 2);
      delay T;
      T := T / 2.0;
   end loop;
   New_Line;
   F.Put (Float (Duration'Delta)); New_Line;
   F.Put (Float (Duration'First));
   F.Put (Float (Duration'Last)); New_Line;
   F.Put (Float (Duration'Small)); New_Line;
   F.Put (Float (Fixed_Point_Type'Small)); New_Line;
   F.Put (Float (Money'Small)); New_Line;
   F.Put (Float (Money'First)); 
   F.Put (Float (Money'Last)); New_Line;
   M.Put (Byte_1); M.Put (Byte_2); M.Put (Byte_3); New_Line;
   -- Let's try with a different base; unfortunately, it uses the Ada
   -- notation, found no way to remove it to write e.g. FF instead of
   -- 16#FF#.
   M.Put (Byte_1, Width => 8, Base => 16);
   M.Put (Byte_2, Width => 8, Base => 16);
   M.Put (Byte_3, Width => 8, Base => 2); New_Line;
   Put_Line (To_String (Homer_Simpson));
end Test_Types;
