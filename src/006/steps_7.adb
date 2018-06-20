with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

procedure Steps_7 is

   task Bank is
      entry Put_Amount (Amount : in Float);
      entry Get_Amount (Amount : in Float);
      entry Give_Bonus (Amount : in Float);
   end Bank;

   task body Bank is
      Fee : constant Float := 2.0;
      Debt_Limit : constant Float := 1000.0;
      Money : Float := 0.0;
   begin
      loop
         select
            when Money > 0.0 =>
               accept Get_Amount (Amount : in Float) do
                  if Money - Amount < -Debt_Limit + Fee then
                     Put ("BANK: No debts greater than ");
                     Put (Debt_Limit, Aft => 2, Exp => 0);
                     New_Line;
                  else
                     Money := Money - Amount - 2.0;
                     Put ("BANK: Withdrawing ");
                     Put (Amount, Aft => 2, Exp => 0);
                     New_Line;
                     Put ("BANK: Current deposit: ");
                     Put (Money, Aft => 2, Exp => 0);
                     New_Line;
                  end if;
               end Get_Amount;
	 or
	    when Money < 0.0 =>
	       accept Give_Bonus (Amount : in Float) do
		  requeue Put_Amount;
	       end Give_Bonus;	       
         or
            accept Put_Amount (Amount : in Float) do
               Put ("BANK: Deposit ");
               Put (Amount, Aft => 2, Exp => 0);
               New_Line;
               Money := Money + Amount;
               Put ("BANK: Current deposit: ");
               Put (Money, Aft => 2, Exp => 0);
               New_Line;
            end Put_Amount;
         end select;
      end loop;
   end Bank;


   task Bonus;

   task body Bonus is
      Bonus_Amount : constant Float := 200.0;
   begin
      loop
	 -- Put_Line ("Checking for need");
         delay 5.0;
         Bank.Give_Bonus (Bonus_Amount);
         Put ("STATE: We helped the bank^H^H^H^H you with a bonus of ");
         Put (Bonus_Amount, Aft => 2, Exp => 0);
	 New_Line;
      end loop;
   end Bonus;

begin
   Bank.Put_Amount (120.0);
   Bank.Get_Amount (125.0);
   Put_Line ("We need more money, but we must wait for the bonus");
   Bank.Get_Amount (50.0);
end;
