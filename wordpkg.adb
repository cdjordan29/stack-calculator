----------------------------------------------------------
-- Purpose: Wordpkg.adb is the implementation of wordpkg.ads
-- Parameters:
-- Precondition:
-- Postcondition:
----------------------------------------------------------
-- This Ada package body gives the implementation for the word abstract
-- data type.  A word is considered to be any consecutive sequence of
-- non-white-space characters.

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;


package body WordPkg is

   ----------------------------------------------------------
   -- Purpose: Returns words in string form
   -- Parameters: w, which will be the Word to be turned into a String
   -- Precondition:
   -- Postcondition:
   ----------------------------------------------------------
   function to_string (w : Word) return String is
      s: String(1..w.Length);
   begin
      for i in 1 .. w.Length loop
         s(i) := w.Letters(i);
      end loop;

      return s;
   end to_string;

   ----------------------------------------------------------
   -- Purpose: Creates a new word corresponding to the given string.
   -- Parameters: Item, which will be the new Word
   -- Precondition:
   -- Postcondition:
   ----------------------------------------------------------
   function New_Word(Item : String) return Word is
      A_Word : word;
   begin
      A_Word.Letters(1..Item'Length) := Item;
      A_Word.Length := Item'Length;
      return A_Word;
   end New_Word;

   ----------------------------------------------------------
   -- Purpose: Indicates the number of characters in a word.
   -- Parameters: Item, which is the Word who's length to return
   -- Precondition:
   -- Postcondition:
   ----------------------------------------------------------
   function Length (Item : Word) return Natural is
   begin
      return Item.Length;
   end Length;

   ----------------------------------------------------------
   -- Purpose: Returns the maximum word size supported by this package.
   -- Parameters:
   -- Precondition:
   -- Postcondition:
   ----------------------------------------------------------
   function Max_Word_Size return Positive is
   begin
      return MaxWordSize;
   end Max_Word_Size;

   ----------------------------------------------------------
   -- Purpose: Word comparison functions. The dictionary lexiographic ordering
   --          is used to determine when one word is less than another.
   -- Parameters: X, Y, which will be words to be compared
   -- Precondition:
   -- Postcondition:
   ----------------------------------------------------------
   function "="  (X, Y : Word) return Boolean is
   begin
      return X.Length = Y.Length and then
        X.Letters(1..X.Length) = Y.Letters(1..Y.Length);
   end "=";

   function "<="  (X, Y : Word) return Boolean is
   begin
      For I in 1..Natural'Min (X.Length, Y.Length)  loop
         if X.Letters(I) < Y.Letters(I) then
            return True;
         elsif X.Letters(I) > Y.Letters(I) then
            return False;
         end if;
      end loop;
      return X.Length <= Y.Length;
   end "<=";

   function "<" (X, Y : Word) return Boolean is
   begin
      return X <= Y and not (X = Y);
   end "<";

   function ">=" (X, Y : Word) return Boolean is
   begin
      return not (X < Y);
   end ">=";

   function ">"  (X, Y : Word) return Boolean is
   begin
      return not (X <= Y);
   end ">";

   -- I/O routines


   ----------------------------------------------------------
   -- Purpose: Skip over any spaces, tabs, or end of line markers in the input to
   --          determine whether or not another word is present. If another word
   --          is present, then return True, otherwise return False.
   -- Parameters: File, which will be the file used
   -- Precondition:
   -- Postcondition:
   ----------------------------------------------------------
   function Another_Word (File : File_Type) return Boolean is
      C : Character;
      End_Line : Boolean;
   begin
      loop
         exit when End_Of_File (File);
         Look_Ahead (File, C, End_Line);
         if End_Line then
            Skip_Line (File);
         else
            if C /= ' ' and C /= ASCII.HT then
               return True;
            end if;
            Get (File, C);
         end if;
      end loop;
      return False;
   end Another_Word;

   ----------------------------------------------------------
   -- Purpose: Skip any white-space that may preceed the word in the input.
   --          If the word is too long to fit in the representation being
   --          used, then raise the WordTooLong exception after the characters
   --          of the word have been read (though not stored).
   -- Parameters: File, which will be the file used
   -- Precondition:
   -- Postcondition:
   ----------------------------------------------------------
   procedure Get (File : File_Type; Item : out Word) is
      C : Character;
      End_Line : Boolean;
      TooLong : Boolean := False;
   begin
      Item.Length := 0;
      if Another_Word (File) then
         loop
            exit when End_Of_File (File);
            Look_Ahead (File, C, End_Line);

            exit when End_Line;
            exit when C = ' ' or else C = ASCII.HT;

            Get (File, C);

            -- Raise an exception if the word won't fit.
            if Item.Length = MaxWordSize then
               TooLong := True;
            end if;

            if not TooLong then
               Item.Length := Item.Length + 1;
               Item.Letters(Item.Length) := C;
            end if;
         end loop;
         if TooLong then
            raise WordTooLong;
         end if;
      end if;
   end Get;

   ----------------------------------------------------------
   -- Purpose: Sends the Word to the following get
   -- Parameters: Item, which the the sent back Word
   -- Precondition:
   -- Postcondition:
   ----------------------------------------------------------
   procedure Get (Item : out Word) is
   begin
      Get (Standard_Input, Item);
   end Get;

   ----------------------------------------------------------
   -- Purpose: Write only those characters that make up the word.
   -- Parameters: File, Item
   -- Precondition:
   -- Postcondition:
   ----------------------------------------------------------
   procedure Put (File : File_Type; Item : Word) is
   begin
      For I in 1..Length(Item) loop
         Put (File, Item.Letters(I));
      end loop;
   end Put;

   ----------------------------------------------------------
   -- Purpose: Write only the Word to standard input
   -- Parameters: Item
   -- Precondition:
   -- Postcondition:
   ----------------------------------------------------------
   procedure Put (Item : Word) is
   begin
      Put (Standard_Output, Item);
   end Put;

end WordPkg;
