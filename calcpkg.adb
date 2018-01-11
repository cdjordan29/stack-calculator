with Ada.Text_IO; use Ada.Text_IO;
with WordPkg; use WordPkg;
with StackPkg;
----------------------------------------------------------
-- Purpose: Where all the caculations on the stacks are performed
-- Parameters:
-- Precondition:
-- Postcondition:
----------------------------------------------------------
package body calcpkg is

   --enums used for the operators
   type Operator is (add, sub, mul, div, exp, lParen, rParen, equal);

   --stacks used for performing calculations
   package Operator_Package is new StackPkg(50, Operator);
   package Operand_Package is new StackPkg(50, Integer);
   use Operand_Package, Operator_Package;

   num_Stack: Operand_Package.Stack;
   op_Stack: Operator_Package.Stack;

   procedure clear(c: out Calculation) is
   begin
      c.answer := 0;
      c.expression := Null_Unbounded_String;
   end clear;

   ----------------------------------------------------------
   -- Purpose: Evaluate procedure performs a calculation with its parameters
   -- Parameters: num1, num2, incoming ints from num_Stack, op incoming Operator
   --             from the op_Stack
   -- Precondition:
   -- Postcondition:
   ----------------------------------------------------------
   procedure evaluate(num1: in Integer; num2: in Integer; op: in Operator) is
      result: Integer;
   begin
      if op =  add then
         result := num1 + num2;
      elsif op = sub then
         result := num2 - num1;
      elsif op = mul then
         result := num1 * num2;
      elsif op = div then
         result := num2 / num1;
      elsif op = exp then
         result := num2 ** num1;
      else
         put("An error occured");
      end if;

      push(result, num_Stack);

   end evaluate;

   ----------------------------------------------------------
   -- Purpose: Function findPrec takes in an operator and returns the value of
   --          its precedence.
   -- Parameters: o, which is the Operator to be evaluated
   -- Precondition:
   -- Postcondition:
   ----------------------------------------------------------
   function findPrec(o: in Operator) return Integer is
   begin
      if o = lParen then
         return -1;
      elsif o = add or o = sub then
         return 1;
      elsif o = mul or o = div then
         return 2;
      elsif o = exp then
         return 3;
      else
         return 0;
      end if;
   end findPrec;

   ----------------------------------------------------------
   -- Purpose: Reads a calculation from standard input
   -- Parameters: c, which is the returned Calculation
   -- Precondition:
   -- Postcondition:
   ----------------------------------------------------------
   procedure get(c: out Calculation) is
      tempWord: Word;
      tempNum: Integer;
      tempEvalnum1: Integer;
      tempEvalnum2: Integer;
      tempOP: Operator;
   begin
      get(tempWord);

      --Start processing the input and see if the words are operators

      --Check for the +
      if to_string(tempWord) = "+" then
         --Concatenating the expression
         c.expression := c.expression & to_string(tempWord) & " ";
         --If the + is greater prec than the top of op_Stack, then push(add)
         if isEmpty(op_Stack) then
            push(add, op_Stack);
         elsif findPrec(add) > findPrec(top(op_Stack)) then
            push(add, op_Stack);
            --Else start doing caculations until the top of op_Stack has lesser precedence
         else
            tempEvalnum1 := top(num_Stack);
            pop(num_Stack);
            tempEvalnum2 := top(num_Stack);
            pop(num_Stack);
            tempOp := top(op_Stack);
            pop(op_Stack);

            evaluate(tempEvalnum1, tempEvalnum2, tempOP);
         end if;

         --Check for the -
      elsif to_string(tempWord) = "-" then
         --Concatenating the expression
         c.expression := c.expression & to_string(tempWord) & " ";
         --If the - is greater prec than the top of op_Stack, then push(sub)
         if isEmpty(op_Stack) then
            push(sub, op_Stack);
         elsif findPrec(sub) > findPrec(top(op_Stack)) then
            push(sub, op_Stack);
         else
            tempEvalnum1 := top(num_Stack);
            pop(num_Stack);
            tempEvalnum2 := top(num_Stack);
            pop(num_Stack);
            tempOp := top(op_Stack);
            pop(op_Stack);

            evaluate(tempEvalnum1, tempEvalnum2, tempOP);
         end if;

         --Check for the *
      elsif to_string(tempWord) = "*" then
         --Concatenating the expression
         c.expression := c.expression & to_string(tempWord) & " ";
         --If the * is greater prec than the top of op_Stack, then push(mul)
         if isEmpty(op_Stack) then
            push(mul, op_Stack);
         elsif findPrec(mul) > findPrec(top(op_Stack)) then
            push(mul, op_Stack);
         else
            tempEvalnum1 := top(num_Stack);
            pop(num_Stack);
            tempEvalnum2 := top(num_Stack);
            pop(num_Stack);
            tempOp := top(op_Stack);
            pop(op_Stack);

            evaluate(tempEvalnum1, tempEvalnum2, tempOP);
         end if;

         --Check for the /
      elsif to_string(tempWord) = "/" then
         --Concatenating the expression
         c.expression := c.expression & to_string(tempWord) & " ";
         --If the / is greater prec than the top of op_Stack, then push(div)
         if isEmpty(op_Stack) then
            push(div, op_Stack);
         elsif findPrec(div) > findPrec(top(op_Stack)) then
            push(div, op_Stack);
         else
            tempEvalnum1 := top(num_Stack);
            pop(num_Stack);
            tempEvalnum2 := top(num_Stack);
            pop(num_Stack);
            tempOp := top(op_Stack);
            pop(op_Stack);

            evaluate(tempEvalnum1, tempEvalnum2, tempOP);
         end if;

         --Check for the **
      elsif to_string(tempWord) = "**" then
         --Concatenating the expression
         c.expression := c.expression & to_string(tempWord) & " ";
         --If the ** is greater prec than the top of op_Stack, then push(exp)
         if isEmpty(op_Stack) then
            push(exp, op_Stack);
         elsif findPrec(exp) > findPrec(top(op_Stack)) then
            push(exp, op_Stack);
         else
            tempEvalnum1 := top(num_Stack);
            pop(num_Stack);
            tempEvalnum2 := top(num_Stack);
            pop(num_Stack);
            tempOp := top(op_Stack);
            pop(op_Stack);

            evaluate(tempEvalnum1, tempEvalnum2, tempOP);
         end if;

         --Check for the (
      elsif to_string(tempWord) = "(" then
         --Concatenating the expression
         c.expression := c.expression & to_string(tempWord) & " ";
         --Automatically push any lParens encountered
         push(lParen, op_Stack);

         --Check for the )
      elsif to_string(tempWord) = ")" then
         --Concatenating the expression
         c.expression := c.expression & to_string(tempWord) & " ";
         --If the ) is encountered then start doing calculations back to (
         while top(op_Stack) /= lParen loop
            tempEvalnum1 := top(num_Stack);
            pop(num_Stack);
            tempEvalnum2 := top(num_Stack);
            pop(num_Stack);
            tempOp := top(op_Stack);
            pop(op_Stack);

            evaluate(tempEvalnum1, tempEvalnum2, tempOP);
         end loop;
         --After reaching the ( on the op_Stack pop it
         pop(op_Stack);

         --Check for the =
      elsif to_string(tempWord) = "=" then
         --Concatenating the expression
         c.expression := c.expression & to_string(tempWord) & " ";
         --If the = is hit, we are done with this cal, move onto next cal
         while not isEmpty(op_Stack) loop
            tempEvalnum1 := top(num_Stack);
            pop(num_Stack);
            tempEvalnum2 := top(num_Stack);
            pop(num_Stack);
            tempOp := top(op_Stack);
            pop(op_Stack);

            evaluate(tempEvalnum1, tempEvalnum2, tempOP);
         end loop;

         c.answer := top(num_Stack);
         pop(num_Stack);
         Put_Line(to_string(c) & result(c)'img);
         clear(c);

      elsif to_string(tempWord) = "" then
         c.length := 0;

      --If the word is a number then push it onto the num_Stack
      else
         tempNum := Integer'Value(to_string(tempWord));
         push(tempNum, num_Stack);
         c.expression := c.expression & to_string(tempWord) & " ";--to_string from Wordpkg
      end if;

   end get;

   ----------------------------------------------------------
   -- Purpose: Writes a calculation to standard output
   -- Parameters: c, which will be the printed Calculation
   -- Precondition:
   -- Postcondition:
   ----------------------------------------------------------
   procedure put(c: Calculation) is
   begin
         put_line(to_string(c) & result(c)'img);--to_string from this pkg
   end put;

   ----------------------------------------------------------
   -- Purpose: Returns the calculation as a string
   -- Parameters: c, which will be the Calculation thats changed
   -- Precondition:
   -- Postcondition:
   ----------------------------------------------------------
   function to_string(c: Calculation) return String is
   begin
      return to_string(c.expression);--to_string from Ada.Strings.Unbounded
   end to_string;

   ----------------------------------------------------------
   -- Purpose: Returns the number of operands and operators in a calculation
   -- Parameters: c, which will be Calculation who's length to be returned
   -- Precondition:
   -- Postcondition:
   ----------------------------------------------------------
   function length(c: Calculation) return Natural is
   begin
      return c.length;
   end length;

   ----------------------------------------------------------
   -- Purpose: Returns the result of the calculation
   -- Parameters: c, which will be Calculation who's result will be returned
   -- Precondition:
   -- Postcondition:
   ----------------------------------------------------------
   function Result(c: Calculation) return Integer is
   begin
      return c.answer;
   end Result;

end calcpkg;
