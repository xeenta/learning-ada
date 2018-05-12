package Greeter is
   
   X : Integer := 1000;

   pragma Assertion_Policy (Check);

   procedure Greet (S : String)
     with Pre => S'Length > 0;
   
private
   
   Hi_Text : constant String := "Hi ";
   
end Greeter;
