package N1 is
   C1 : constant := 1;
   
   package N2 is
      type N2_Type is new Integer;
      PC : constant := 2;
   private
      Cnt : Integer;
   end N2;
   
   C2 : N2.N2_Type;
   
private
   
   package N3 is
      PC : constant := 3;
   private
      Cnt : Integer;
   end N3;
   
end N1;
