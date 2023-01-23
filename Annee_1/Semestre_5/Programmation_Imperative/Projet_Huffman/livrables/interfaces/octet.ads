-- Définition d'un octet
with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;

package OCTET is

    type T_Octet is mod 2 ** 8;

    -- Convertir un octet en Unbounded_String.
    function To_Unbounded_String(Octet : in T_Octet) return Unbounded_String with
            Post => Length(To_Unbounded_String'Result) = 8;

    -- Convertir un Unbounded_String en octet.
    function To_Octet(Source : in Unbounded_String) return T_Octet with
            Pre => Length(Source) = 8;

end OCTET;
