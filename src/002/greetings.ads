with Person;

package Greetings is
   
   Unknown_Greeting : exception;
   
   Hello        : constant String := "hello";
   Hi           : constant String := "hi";
   Good_Morning : constant String := "good morning";
   What_s_Up    : constant String := "what's up";
   
   procedure Swear (Greeting    : String;
                    Speaker_Age : Person.Age := Person.Age'First);
   
private
   
   Swear_Hello    : constant String := "fucking hello";
   Swear_Hi       : constant String := "fuck you";
   Swear_Morning  : constant String := "good fucking morning";
   Swear_Whats_Up : constant String := "what's the fuck";
   
end Greetings;
