----------------------------------------------------------
-- Purpose: Stackpkg.ads is the specifications of the procedures
--          and functions used to implement stackpkg.adb
-- Parameters: generic parameters
-- Precondition:
-- Postcondition:
----------------------------------------------------------

generic  -- Generic parameters are declared here

	Size : Positive;            -- Size of stack to create

	type ItemType is private;   -- Type of elements that stack will contain

package StackPkg is

	type Stack is limited private;

	Stack_Empty: exception; -- Raised if an empty stack
	Stack_Full : exception; -- Raised if there is a push onto full stack

        -- Determine if stack is empty or full
	function isEmpty (s : Stack) return Boolean;
	function isFull  (s : Stack) return Boolean;

        -- Put element Item onto Stack s
	procedure push (item : ItemType; s : in out Stack);

        -- Remove an element from Stack s
	procedure pop  (s : in out Stack);

        -- Return top element from Stack s
	function  top   (s : Stack) return ItemType;

private

	type StackElements is array(1 .. Size) of ItemType;

	type Stack is record
		Elements : StackElements;
		Top : Natural := 0;
	end record;

end StackPkg;
