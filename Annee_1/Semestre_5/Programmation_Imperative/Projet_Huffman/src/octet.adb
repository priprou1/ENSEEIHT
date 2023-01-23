package body OCTET is

    function To_Unbounded_String(Octet : in T_Octet) return Unbounded_String is
        Octet_String : Unbounded_String;
        N : T_Octet;
        Octet_lu : T_Octet := Octet;
    begin
        for I in 1..8 loop
            N := Octet_Lu/128;
            Octet_String := Octet_String & T_Octet'Image(N)(2);
            Octet_Lu := Octet_Lu * 2;
        end loop;
        return Octet_String;
    end To_Unbounded_String;

    function To_Octet(Source : in Unbounded_String) return T_Octet is
        Octet : T_Octet := 0;
    begin
        for I in 1..8 loop
            Octet := (Octet * 2 ) or (Character'pos(Element(Source, I)) - Character'pos('0'));
        end loop;
        return Octet;
    end To_Octet;

end OCTET;
