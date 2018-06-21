with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;
--with Ada.Task_Identification;
--use Ada;

procedure Task_Type is
   
   subtype Player_Id_Type is Natural range 0 .. 100;
   
   task type Player is
      entry Punch (P : in Positive);
      entry Stamina (S : in Integer);
      entry Pass;
      entry Get_Id (Id : out Player_Id_Type);
      entry Get_Stamina (S : out Integer);
      entry Quit;
   end Player;
   
   Players : array (Positive range 1 .. 10) of Player;
   subtype Player_Index is Positive range Players'First .. Players'Last;
   
   task body Player is
      Personal_Id : Integer;
      package R is new Ada.Numerics.Discrete_Random (Player_Id_Type);
      G : R.Generator;
      My_Stamina : Integer := 80;
      Delay_Count : Natural := 0;
   begin
      R.Reset (G);
      Personal_Id := R.Random (G);
      Put ("Player "); Put (Personal_Id);
      Put_Line (" is born!");
      loop
	 select
	    accept Get_Stamina (S : out Integer) do
	       S := My_Stamina;
	    end Get_Stamina;
	 or
	    accept Punch (P : in Positive) do
	       Put ("Player "); Put (Personal_Id);
	       Put (" punches ");
	       declare
		  Punched_Id : Player_Id_Type;
	       begin
		  select
		     Players (P).Get_Id (Punched_Id);
		     Put (Punched_Id); New_Line;
		  or
		     delay 1.0;
		     Put ("> unknown < (goes by the idx of ");
		     Put (P); Put_Line (")");
		  end select;
	       end;
	       select
		  Players (P).Stamina (-40);
		  My_Stamina := My_Stamina - 5;
	       or 
		  delay 1.0;
	       end select;
	       My_Stamina := My_Stamina - 20;	       
	    end Punch;
	 or
	    accept Stamina (S : in Integer) do
	       My_Stamina := My_Stamina + S;
	    end Stamina;
	 or
	    accept Pass do
	       if My_Stamina < 0 then
		  My_Stamina := My_Stamina + 3;
	       end if;
	    end Pass;
	 or
	    accept Get_Id (Id : out Player_Id_Type) do
	       Id := Personal_Id;
	    end Get_Id;
	 or
	    delay 2.5;
	    if Delay_Count > 5 then
	       Delay_Count := 0;
	       My_Stamina := My_Stamina / 2;
	    end if;
	    Delay_Count := Delay_Count + 1;
	    Put ("Player "); Put (Personal_Id);
	    Put (" STAMINA "); Put (My_Stamina);
	    New_Line;
	    if My_Stamina < 30 then
	       select
		  accept Quit;
		  Put ("Player "); Put (Personal_Id);
		  Put_Line (" QUITS");
		  exit;
	       or
		  delay 1.0;
		  Put_Line ("No quit request within 1 sec");
	       end select;
	    end if;
	 end select;
	 if My_Stamina < 11 then
	    Put_Line ("^^^^^ Spontaneous death ^^^^^^");
	    exit;
	 end if;
      end loop;
   end Player;
   
   type Action_Type is (Punch_Someone, Peace, Check_Turn);
   
   package RP is new Ada.Numerics.Discrete_Random (Player_Index);
   package RA is new Ada.Numerics.Discrete_Random (Action_Type);
   
   Player_Gen : RP.Generator;
   I, J : Player_Index;
   Num_Of_Alive_Players : Natural;
   
   Action_Gen : RA.Generator;
   Action : Action_Type;
   
begin
   RP.Reset (Player_Gen);
   RA.Reset (Action_Gen);
   loop
      Num_Of_Alive_Players := 0;
      for P of Players loop
	 if not P'Terminated then
	    Num_Of_Alive_Players := Num_Of_Alive_Players + 1;
	 end if;
      end loop;
      Put ("ALIVE PLAYERS "); Put (Num_Of_Alive_Players); New_Line;
      exit when Num_Of_Alive_Players < 3;
      I := RP.Random (Player_Gen);
      if not Players (I)'Terminated then
	 Action := RA.Random (Action_Gen);
	 Put_Line (Action_Type'Image (Action));
	 case Action is
	    when Punch_Someone =>
	       J := RP.Random (Player_Gen);
	       if I /= J then
		  select -- do not hang on punch
		     delay 1.0;
		     Put_Line ("Not punched!");		     
		  then abort
		     Players (I).Punch (J);
		  end select;
	       end if;
	    when Peace =>
	       select -- do not hang on pass
	    	  delay 1.0;
		  Put_Line ("No passed!");
	       then abort
		  Players (I).Pass;
	       end select;
	    when Check_Turn =>
	       declare 
		  Stamina : Integer;
	       begin
		  select
		     delay 1.0;
		     Put ("WHAT Stamina "); Put (I); New_Line;
		  then abort
		     Players (I).Get_Stamina (Stamina);
		     if Stamina < 30 then
			select
			   delay 0.4;
			then abort
			   Players (I).Quit;
			end select;
		     end if;		     
		  end select;
	       end;
	 end case;
	 delay 0.5;
	 Put_Line ("*** ANOTHER ROUND ***");	 
      end if;
   end loop;
   Put_Line ("===================");
   for P of Players loop
      if not P'Terminated then
	 declare
	    P_Id : Player_Id_Type;
	 begin
	    P.Get_Id (P_Id);
	    Put ("##### PLAYER "); Put (P_Id); Put_Line (" #####");
	    P.Quit;
	 end;
      end if;
   end loop;
end;
