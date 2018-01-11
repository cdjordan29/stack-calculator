--Name: Daniel Jordan
--Date: April 17, 2017
--Course: ITEC 320 Procedure Analysis and Design

--Purpose: This program implements a stack calculator.
--Input: Text files that have a series of calculations

--Sample input:
--  11 + -2 =
--    2 +
--      3 * ( 4 + 5 )
--  =
--  -2 ** 3 =

--Corresponding output:
--  11 + -2 = 9
--  2 + 3 * ( 4 + 5 ) = 29
--  -2 ** 3 = -8

pragma Ada_2012;
with ada.text_io; use ada.text_io;
with Ada.Integer_Text_IO; use ada.Integer_Text_IO;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with calcpkg; use calcpkg;
----------------------------------------------------------
-- Purpose: Main procedure of Program 4
-- Parameters:
-- Precondition:
-- Postcondition:
----------------------------------------------------------
procedure calc is

   c: Calculation;

begin
   while not End_Of_File loop
      get(c);
   end loop;
end calc;
