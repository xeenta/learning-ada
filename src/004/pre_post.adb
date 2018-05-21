with Ada.Text_IO; use Ada.Text_IO;

procedure Pre_Post is

   package P is

      type Int_Array is array (Integer range <>) of Integer;


      -- Increment the input (obvious)
      procedure Increment (A : in out Integer)
      with
        Post => A = A'Old + 1;

      -- A "limited" negate (nonsense...)
      procedure Limited_Negate (A : in out Integer;
                                B : in Integer)
      with
        Post => (if A < B then A = -A'Old else A = -B);

      -- just to show the attribute Result
      function Sum_Minus_One (A, B : Integer) return Integer
      with
        Post => Sum_Minus_One'Result = A + B - 1;

      -- 5, 2 give 3; -2, -5 give 3, but -5, -2... fails pre
      function Positive_Diff (A, B : Integer) return Integer
      with
        Pre => A > B,
        Post => Positive_Diff'Result = A - B;


      -- a sort... the precondition is rather odd: the caller must
      -- call this subprogram only when she knows the array isn't
      -- sorted; for a more "realistic" case, remove the Pre.
      procedure Sort (A : in out Int_Array)
      with
        Pre => (for some I in A'First .. A'Last - 1 => A (I) > A (I+1)),
        Post => (for all I in A'First .. A'Last - 1 => A (I) <= A (I+1));

   end P;


   package body P is
      
      -- bubble sort
      procedure Sort (A : in out Int_Array) is
         App : Integer;
         Swapped : Boolean := True;
      begin
         while Swapped loop
            Swapped := False;
            for I in A'First .. A'Last - 1 loop
               if A (I) > A (I + 1) then
                  App := A (I);
                  A (I) := A (I + 1);
                  A (I + 1) := App;
                  Swapped := True;
               end if;
            end loop;
         end loop;
      end Sort;

      procedure Increment (A : in out Integer) is
      begin
         A := A + 1;
      end Increment;

      procedure Limited_Negate (A : in out Integer;
                                B : in Integer) is
      begin
         -- correct implementation...
         --  if A < B then
         --     A := -A;
         --  else
         --     A := -B;
         --  end if;
         A := -A + B; -- wrong implementation...
      end Limited_Negate;

      function Sum_Minus_One (A, B : Integer) return Integer is
      begin
         -- for such a short function I prefer the other syntax...
         return A + B - 1;
      end Sum_Minus_One;

      function Positive_Diff (A, B : Integer) return Integer is
      begin
         return A - B;
      end Positive_Diff;

   end P;

   A : constant Integer := 1;
   B : Integer := 2;

   package IO is new Ada.Text_IO.Integer_IO (Integer);

   procedure O (X : Integer)
   with
     Inline;

   procedure O (X : Integer) is
   begin
      IO.Put (X); New_Line;
   end O;

   use P;
   
   -- an unsorted array
   Un_Arr   : Int_Array := (10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
   
   -- a sorted array
   Ord_Arr  : Int_Array := (1, 4, 8, 10, 11, 100, 200);
begin
   O (A); O (B);
   Increment (B); O (B);
   O (Sum_Minus_One (A, B));

   -- compiler warn: "actuals for this call may be in wrong order",
   -- this is why I've used named parameters
   O (Positive_Diff (A => B, B => A));
   Put_Line ("everything's alright?");

   -- Pre requires A > B, but B = 3 and A = 1... => runtime exception
   -- telling us "failed precondition from pre_post.adb" (followed by
   -- the line in the source code, which I removed because I'm
   -- modifying this source adding lines)

   --O (Positive_Diff (A, B));

   -- and this at runtime gives "failed postcondition from
   -- pre_post.adb", because the guy who implemented the code hasn't
   -- understood the specifications...

   --Limited_Negate (A, B);


   O (A); O (B);


   for I in Un_Arr'Range loop
      IO.Put (Un_Arr (I));
   end loop;
   New_Line;
   Sort (Un_Arr);
   for I in Un_Arr'Range loop
      IO.Put (Un_Arr (I));
   end loop;
   New_Line;
   
   -- calling this violates the preconditions: our sort assumes that
   -- the array isn't already sorted...
   --Sort (Ord_Arr);
end Pre_Post;
