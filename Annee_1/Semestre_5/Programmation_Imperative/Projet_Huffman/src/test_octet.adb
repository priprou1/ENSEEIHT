with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with OCTET; use OCTET;

procedure Test_Octet is

    procedure Test_To_Unbounded_String is
        Octet : T_Octet;
        U_Str : Unbounded_String;
    begin
        Put_Line ("=== Tester_To_Unbounded_String...");

        Octet := 146;
        U_Str := To_Unbounded_String (Octet);
        pragma Assert (U_Str = To_Unbounded_String ("10010010"));

        Octet := 156;
        U_Str := To_Unbounded_String (Octet);
        pragma Assert (U_Str = To_Unbounded_String ("10011100"));
    end Test_To_Unbounded_String;


    procedure Test_To_Octet is
        Octet : T_Octet;
        U_Str : Unbounded_String;
    begin
        Put_Line ("=== Tester_To_Octet...");

        U_Str := To_Unbounded_String ("10011100");

        Octet := To_Octet(U_Str);
        pragma Assert (Octet = 156);
    end Test_To_Octet;

begin
    Test_To_Unbounded_String;
    Test_To_Octet;
    Put_Line ("Fin des tests : OK.");
end Test_Octet;
