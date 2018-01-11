----------------------------------------------------------
-- Purpose: Stackpkg.adb is the implementation of stackpkg.ads
-- Parameters:
-- Precondition:
-- Postcondition:
----------------------------------------------------------

package body StackPkg is

   ----------------------------------------------------------
   -- Purpose: Checks to see if the stack is empty
   -- Parameters: Stack, will be either num_Stack or op_Stack
   -- Precondition:
   -- Postcondition:
   ----------------------------------------------------------
   function isEmpty(s : Stack) return Boolean is
   begin
         return s.Top = 0;
   end isEmpty;

   ----------------------------------------------------------
   -- Purpose: Checks to see if the stack is full
   -- Parameters: Stack, will be either num_Stack or op_Stack
   -- Precondition:
   -- Postcondition:
   ----------------------------------------------------------
   function isFull(s : Stack) return Boolean is
   begin
         return s.Top = Size;
   end isFull;

   ----------------------------------------------------------
   -- Purpose: Pushes values onto the stack
   -- Parameters: ItemType, will be either Ints or Operator enums
   -- Precondition:
   -- Postcondition:
   ----------------------------------------------------------
   procedure push(item : ItemType; s : in out Stack) is
   begin
      if isFull(s) then
           raise Stack_Full;
        else
           s.Top := s.Top + 1;
           s.Elements(s.Top) := item;
        end if;
     end push;


     ----------------------------------------------------------
     -- Purpose: Pop values off of the stack
     -- Parameters: Stack, will be either num_Stack or op_Stack
     -- Precondition:
     -- Postcondition:
     ----------------------------------------------------------
     procedure pop(s : in out Stack) is
     begin
           if isEmpty(s) then
              raise Stack_Empty;
           else
           s.Top := s.Top - 1;
        end if;
     end pop;

     ----------------------------------------------------------
     -- Purpose: Checks the top of the stack
     -- Parameters: Stack, will be either num_Stack or op_Stack
     -- Precondition:
     -- Postcondition:
     ----------------------------------------------------------
     function top(s : Stack) return ItemType is
     begin
        if isEmpty(s) then
           raise Stack_Empty;
        end if;
        return s.Elements(s.Top);
     end top;

end StackPkg;
