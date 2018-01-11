----------------------------------------------------------
-- Purpose: Calcpkg.ads is the specifications of the procedures
--          and functions used to implement calcpkg.adb
-- Parameters:
-- Precondition:
-- Postcondition:
----------------------------------------------------------

with WordPkg;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package calcpkg is

   type Calculation is limited private;

   procedure clear(c: out Calculation);

   --Read a calculation from standard input and write one to standard output
   procedure get(c: out Calculation);
   procedure put(c: Calculation);

   --returns the total calculation as a string
   function to_string(c: Calculation) return String;

   --returns the number of operands and operators in a calculation
   function length(c: Calculation) return Natural;

   --returns the result of the calculation
   function Result(c: Calculation) return Integer;

private

   type Calculation is record
      expression: Unbounded_String;
      length: Natural := 1;
      answer: Integer := 0;
   end record;

end calcpkg;
