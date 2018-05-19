with Ada.Text_IO; use Ada.Text_IO;

procedure Test_Age_Madness is
   subtype Age_Type is Natural range 0 .. 140;
   subtype Age_Distance is Integer;
   
   -- the following subtype is better
   --subtype Age_Distance is Integer range -Age_Type'Last .. Age_Type'Last;
   
   Adult_Age : constant Age_Type := 18;
   
   -- Q: "How many years ago have you kissed?"
   -- A: "Well, let me think, it must be fiftysix years ago or so"
   function Get_Dist_From_First_Kiss return Age_Distance is (56);
   
   -- Age guessed by the AI analyzing the subject
   function Guess_Age return Age_Type is (19);
   
   -- Q: "Have you ever kissed?"
   -- A: "Sure, I did!"
   function Have_You_Ever_Kissed return Boolean is (True);
   
   -- We have the number of years passed since subject's first kiss,
   -- and subject's age. Let's compute the age she had her first kiss.
   function Age_Of_Kiss (Current_Age : Age_Type) return Age_Type is
      Dist_Of_First_Kiss : constant Age_Distance := Get_Dist_From_First_Kiss;
   begin
      return Current_Age - Dist_Of_First_Kiss;
   end Age_Of_Kiss;
   
   
   First_Kiss_Age : Age_Type;
begin
   if Have_You_Ever_Kissed then
      First_Kiss_Age := Age_Of_Kiss (Guess_Age);
      
      if First_Kiss_Age < Adult_Age then 
         Put_Line ("you weren't adult!");
      else
         Put_Line ("so, you waiting for so long...");
      end if;
   end if;
end Test_Age_Madness;
