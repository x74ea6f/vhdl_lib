-- String library.
-- ```
-- Usage:
-- print("Hello" & "World"); -- HelloWorld"
-- print("Value=" & to_str(123)); -- Value=123
-- print("Value=" + 234); -- Value=234
-- print("Value=" + to_str(X"F", DEC_U); -- Value=15
-- Support type for:
-- (bit, boolean, integer, real, time, std_logic)
-- (bit_vector, boolean_vector, integer_vector, real_vector, time_vector, std_logic_vector)
-- (signed, unsigned)
-- ```
--
--
-- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;

package str_lib is

    type print_t is protected
        procedure print_core(str: string; end_line: boolean:=True);
        -- for library debug only
        procedure check_line(l_str: in string);
    end protected;

    shared variable SP: print_t;

    -- ```
    -- print value
    -- ```
    procedure print(v: string; end_line: boolean:=True);
    procedure print(v: bit; end_line: boolean:=True);
    procedure print(v: boolean; end_line: boolean:=True);
    procedure print(v: integer; end_line: boolean:=True);
    procedure print(v: real; end_line: boolean:=True);
    procedure print(v: time; end_line: boolean:=True);
    procedure print(v: std_logic; end_line: boolean:=True);

    --[TODO] Conflict in Vivado.
    -- procedure print(v: bit_vector; end_line: boolean:=True);
    -- procedure print(v: boolean_vector; end_line: boolean:=True);
    -- procedure print(v: integer_vector; end_line: boolean:=True);
    -- procedure print(v: real_vector; end_line: boolean:=True);
    -- procedure print(v: time_vector; end_line: boolean:=True);
    -- procedure print(v: std_logic_vector; end_line: boolean:=True);
    -- procedure print(v: signed; end_line: boolean:=True);
    -- procedure print(v: unsigned; end_line: boolean:=True);

    type PRINT_TYPE is (
        HEX,
        DEC_S, -- signed
        DEC_U, -- unsigned
        BIN);
    constant LOGIC_DEFAULT_TYPE: PRINT_TYPE := HEX; -- for bit_vector, std_logic_vector
    constant SIGNED_DEFAULT_TYPE: PRINT_TYPE := DEC_S; -- for intger, real
    constant UNSIGNED_DEFAULT_TYPE: PRINT_TYPE := DEC_U; -- for intger, real

    function verilog_prefix(slv: std_logic_vector) return string;

    -- ```
    -- to string
    -- ```
    function to_str(v: bit) return string;
    function to_str(v: boolean) return string;
    function to_str(v: integer; ptype: PRINT_TYPE:=SIGNED_DEFAULT_TYPE; prefix: string:="0x") return string;
    function to_str(v: real) return string;
    function to_str(v: time) return string;
    function to_str(v: std_logic) return string;

    function to_str(btv: bit_vector; ptype: PRINT_TYPE:=LOGIC_DEFAULT_TYPE; prefix: string:="0x") return string;
    function to_str(blv: boolean_vector) return string;
    function to_str(intv: integer_vector; ptype: PRINT_TYPE:=SIGNED_DEFAULT_TYPE; prefix: string:="0x") return string;
    function to_str(rlv: real_vector) return string;
    function to_str(tmv: time_vector) return string;
    function to_str(slv: std_logic_vector; ptype: PRINT_TYPE:=LOGIC_DEFAULT_TYPE; prefix: string:="0x") return string;
    function to_str(s: signed; ptype: PRINT_TYPE:=SIGNED_DEFAULT_TYPE; prefix: string:="0x") return string;
    function to_str(u: unsigned; ptype: PRINT_TYPE:=UNSIGNED_DEFAULT_TYPE; prefix: string:="0x") return string;

    -- ```
    -- string + *
    -- ```
    function "+" (l: string; r: bit) return string;
    function "+" (l: string; r: boolean) return string;
    function "+" (l: string; r: integer) return string;
    function "+" (l: string; r: real) return string;
    function "+" (l: string; r: time) return string;
    function "+" (l: string; r: std_logic) return string;

    function "+" (l: string; r: bit_vector) return string;
    function "+" (l: string; r: boolean_vector) return string;
    function "+" (l: string; r: integer_vector) return string;
    function "+" (l: string; r: real_vector) return string;
    function "+" (l: string; r: time_vector) return string;
    function "+" (l: string; r: std_logic_vector) return string;
    function "+" (l: string; r: signed) return string;
    function "+" (l: string; r: unsigned) return string;

    -- ```
    -- String / , Add Comma for CSV File
    -- ```
    function "/" (l: string; r: bit) return string;
    function "/" (l: string; r: boolean) return string;
    function "/" (l: string; r: integer) return string;
    function "/" (l: string; r: real) return string;
    function "/" (l: string; r: time) return string;
    function "/" (l: string; r: std_logic) return string;

    function "/" (l: string; r: bit_vector) return string;
    function "/" (l: string; r: boolean_vector) return string;
    function "/" (l: string; r: integer_vector) return string;
    function "/" (l: string; r: real_vector) return string;
    function "/" (l: string; r: time_vector) return string;
    function "/" (l: string; r: std_logic_vector) return string;
    function "/" (l: string; r: signed) return string;
    function "/" (l: string; r: unsigned) return string;

end package;

package body str_lib is
    -- ```
    -- print message
    -- ```
    type print_t is protected body 
        -- print
        variable l: line; -- shared Line
        variable l_pre: line; -- previous line for debug

        procedure print_core(str: string; end_line: boolean:=True) is
        begin
            write(l, str);
            if end_line = True then
                l_pre := l;
                writeline(output, l);
            end if;
        end procedure;

        -- for library debug only
        procedure check_line(l_str: in string)is
        begin
            -- report "Data=" & l_pre.all & ", Exp=" & l_str;
            assert l_pre.all = l_str
            report "Compare NG, Data=" & l_pre.all & ", Exp=" & l_str
            severity ERROR;
        end procedure;

    end protected body print_t;

    procedure print(v: string; end_line: boolean:=True) is begin SP.print_core(v, end_line); end procedure;
    procedure print(v: bit; end_line: boolean:=True) is begin SP.print_core(to_str(v), end_line); end procedure;
    procedure print(v: boolean; end_line: boolean:=True) is begin SP.print_core(to_str(v), end_line); end procedure;
    procedure print(v: integer; end_line: boolean:=True) is begin SP.print_core(to_str(v), end_line); end procedure;
    procedure print(v: real; end_line: boolean:=True) is begin SP.print_core(to_str(v), end_line); end procedure;
    procedure print(v: time; end_line: boolean:=True) is begin SP.print_core(to_str(v), end_line); end procedure;
    procedure print(v: std_logic; end_line: boolean:=True) is begin SP.print_core(to_str(v), end_line); end procedure;
    procedure print(v: bit_vector; end_line: boolean:=True) is begin SP.print_core(to_str(v), end_line); end procedure;
    procedure print(v: boolean_vector; end_line: boolean:=True) is begin SP.print_core(to_str(v), end_line); end procedure;
    procedure print(v: integer_vector; end_line: boolean:=True) is begin SP.print_core(to_str(v), end_line); end procedure;
    procedure print(v: real_vector; end_line: boolean:=True) is begin SP.print_core(to_str(v), end_line); end procedure;
    procedure print(v: time_vector; end_line: boolean:=True) is begin SP.print_core(to_str(v), end_line); end procedure;
    procedure print(v: std_logic_vector; end_line: boolean:=True) is begin SP.print_core(to_str(v), end_line); end procedure;
    procedure print(v: signed; end_line: boolean:=True) is begin SP.print_core(to_str(v), end_line); end procedure;
    procedure print(v: unsigned; end_line: boolean:=True) is begin SP.print_core(to_str(v), end_line); end procedure;

    function verilog_prefix(slv: std_logic_vector) return string is
    begin
        return integer'image(slv'length) & "'h"; -- verilog like
    end function;

    -- ```
    -- to String
    -- ```
    -- std_logic_vector to string, Binary -- Use Internal Only
    function to_bstr(slv: std_logic_vector) return string is
        alias v: std_logic_vector(slv'length-1 downto 0) is slv;
        variable ret: string(1 to v'length);
        variable idx: natural := 1;
    begin
        for i in v'range loop
            ret(idx) := std_logic'image(v(i))(2);
            idx := idx+1;
        end loop;
        return ret;
    end function;

    -- bit to string
    function to_str(v: bit) return string is
    begin
        return bit'image(v);
    end function;

    -- boolean to string
    function to_str(v: boolean) return string is
    begin
        return boolean'image(v);
    end function;

    -- integer to string
    function to_str(v: integer; ptype: PRINT_TYPE:=SIGNED_DEFAULT_TYPE; prefix: string:="0x") return string is
        variable v_u: unsigned(31 downto 0);
    begin
        -- v: Only for integer'low/2 to integer'high/2
        v_u := to_unsigned(v, 32) when v>=0 else to_unsigned(integer'high + v + 1, 32);
        case ptype is
            when BIN => return to_bstr(std_logic_vector(to_signed(v, 32)));
            when DEC_U => return integer'image(to_integer(v_u));
            when DEC_S => return integer'image(v);
            when HEX => return prefix & to_hstring(std_logic_vector(to_signed(v,32)));
        end case;
    end function;

    -- real to string
    function to_str(v: real) return string is
    begin
        return real'image(v);
    end function;

    -- time to string
    function to_str(v: time) return string is
        constant RESO: time := 1 ps; -- Tim Resolution
        variable tm: time;
        variable ret: string(1 to 14); -- s10+3
        variable idx: natural := 1;
        type unit_t is array(0 to 5) of string(1 to 3);
        constant unit : unit_t := ("fs_", "ps_", "ns_", "us_", "ms_", "sec");
        -- Not implement min, hour
        variable unit_idx: natural := 0;
        variable tm_int: integer:= 0;
        variable len: natural;
    begin
        tm := v;
        while tm/= 0*RESO and unit_idx<5 loop
            tm_int := integer(tm/RESO);
            tm := tm/1000;
            unit_idx := unit_idx + 1;
        end loop;
        
        -- Integer
        len := integer'image(tm_int)'length;
        ret(idx to idx+len-1) := integer'image(tm_int);
        idx := idx + len;

        -- append Unit
        if unit(unit_idx)(3)='_' then
            ret(idx to idx+1) := unit(unit_idx)(1 to 2);
            idx := idx+2;
        else
            ret(idx to idx+2) := unit(unit_idx);
            idx := idx+3;
        end if;
        return ret(1 to idx-1);
    end function;
    -- function to_str(v: time) return string is
    -- begin
    --     return time'image(v);
    -- end function;

    -- std_logic to string
    function to_str(v: std_logic) return string is
    begin
        return std_logic'image(v);
    end function;

    -- bit_vector to string
    function to_str(btv: bit_vector; ptype: PRINT_TYPE:=LOGIC_DEFAULT_TYPE; prefix: string:="0x") return string is
    begin
        return to_str(to_std_logic_vector(btv), ptype, prefix);
    end function;

    --[TODO] vector系全部、
    -- length取得のために呼び出して、string取得するため本呼び出しを、
    -- 呼び出し1回にしたい。

    -- boolean_vector to string
    function to_str(blv: boolean_vector) return string is
        alias v: boolean_vector(blv'length-1 downto 0) is blv;
        variable ret: string(1 to v'length*(5+1)); -- "false"+','
        variable idx: natural := 1;
        variable len: natural;
    begin
        for i in v'range loop
            len := to_str(v(i))'length;
            ret(idx to idx+len-1) := to_str(v(i));
            idx := idx + len;

            if i/=0 then -- Not Last
                ret(idx) := ',';
                idx := idx+1;
            end if;
        end loop;
        return '(' & ret(1 to idx-1) & ')';
    end function;

    -- integer_vector to string
    function to_str(intv: integer_vector; ptype: PRINT_TYPE:=SIGNED_DEFAULT_TYPE; prefix: string:="0x") return string is
        alias v: integer_vector(intv'length-1 downto 0) is intv;
        -- type integer is range -2147483647 to 2147483647;
        variable ret: string(1 to v'length*(32+1)); -- 32bit+1, type as BIN
        variable idx: natural := 1;
        variable len: natural;
    begin
        for i in v'range loop
            len := to_str(v(i), ptype)'length;
            ret(idx to idx+len-1) := to_str(v(i), ptype, prefix);
            idx := idx+len;

            if i/=0 then -- Not Last
                ret(idx) := ',';
                idx := idx+1;
            end if;
        end loop;
        return '(' & ret(1 to idx-1) & ')';
    end function;

    -- real_vector to string
    function to_str(rlv: real_vector) return string is
        alias v: real_vector(rlv'length-1 downto 0) is rlv;
        -- type real is range -1.7014111e+308 to 1.7014111e+308;
        variable ret: string(1 to v'length*(15+1)); -- s1.7es3 + ","
        variable idx: natural := 1;
        variable len: natural;
    begin
        for i in v'range loop
            len := to_str(v(i))'length;
            ret(idx to idx+len-1) := to_str(v(i));
            idx := idx + len;

            if i/=0 then -- Not Last
                ret(idx) := ',';
                idx := idx+1;
            end if;
        end loop;
        return '(' & ret(1 to idx-1) & ')';
    end function;

    -- time_vector to string
    function to_str(tmv: time_vector) return string is
        alias v: time_vector(tmv'length-1 downto 0) is tmv;
        variable ret: string(1 to tmv'length*(14+1)); -- s10+3 + ","
        variable idx: natural := 1;
        variable len: natural;
    begin
        for i in v'range loop
            len := to_str(v(i))'length;
            ret(idx to idx+len-1) := to_str(v(i));
            idx := idx + len;

            if i/=0 then -- Not Last
                ret(idx) := ',';
                idx := idx+1;
            end if;
        end loop;
        return '(' & ret(1 to idx-1) & ')';
    end function;

    -- std_logic_vector to string
    function to_str(slv: std_logic_vector; ptype: PRINT_TYPE:=LOGIC_DEFAULT_TYPE; prefix: string:="0x") return string is
        alias v: std_logic_vector(slv'length-1 downto 0) is slv;
    begin
        -- dont support to_hstring(bit_vector) in Vivado 2020.2.
        case ptype is
            when BIN => return to_bstr(v);
            when DEC_U => return integer'image(to_integer(unsigned(to_std_logic_vector(v))));
            when DEC_S => return integer'image(to_integer(signed(to_std_logic_vector(v))));
            when HEX => return prefix & to_hstring(to_std_logic_vector(v));
        end case;
    end function;

    -- signed to string
    function to_str(s: signed; ptype: PRINT_TYPE:=SIGNED_DEFAULT_TYPE; prefix: string:="0x") return string is
        alias v: signed(s'length-1 downto 0) is s;
    begin
        case ptype is
            when BIN => return to_bstr(std_logic_vector(v));
            when DEC_U => return integer'image(to_integer(unsigned(v)));
            when DEC_S => return integer'image(to_integer(v));
            when HEX => return prefix & to_hstring(std_logic_vector(v));
        end case;
    end function;

    -- unsigned to string
    function to_str(u: unsigned; ptype: PRINT_TYPE:=UNSIGNED_DEFAULT_TYPE; prefix: string:="0x") return string is
        alias v: unsigned(u'length-1 downto 0) is u;
    begin
        case ptype is
            when BIN => return to_bstr(std_logic_vector(v));
            when DEC_U => return integer'image(to_integer(v));
            when DEC_S => return integer'image(to_integer(signed(v)));
            when HEX => return prefix & to_hstring(std_logic_vector(v));
        end case;
    end function;

    -- ```
    -- String + 
    -- ```

    function "+" (l: string; r: bit) return string is begin return l & to_str(r); end function;
    function "+" (l: string; r: boolean) return string is begin return l & to_str(r); end function;
    function "+" (l: string; r: integer) return string is begin return l & to_str(r); end function;
    function "+" (l: string; r: real) return string is begin return l & to_str(r); end function;
    function "+" (l: string; r: time) return string is begin return l & to_str(r); end function;
    function "+" (l: string; r: std_logic) return string is begin return l & to_str(r); end function;
    function "+" (l: string; r: bit_vector) return string is begin return l & to_str(r); end function;
    function "+" (l: string; r: boolean_vector) return string is begin return l & to_str(r); end function;
    function "+" (l: string; r: integer_vector) return string is begin return l & to_str(r); end function;
    function "+" (l: string; r: real_vector) return string is begin return l & to_str(r); end function;
    function "+" (l: string; r: time_vector) return string is begin return l & to_str(r); end function;
    function "+" (l: string; r: std_logic_vector) return string is begin return l & to_str(r); end function;
    function "+" (l: string; r: unsigned) return string is begin return l & to_str(r); end function;
    function "+" (l: string; r: signed) return string is begin return l & to_str(r); end function;

    -- ```
    -- String / , Add Comma for CSV File
    -- ```
    function "/" (l: string; r: bit) return string is begin return l & "," & to_str(r); end function;
    function "/" (l: string; r: boolean) return string is begin return l & "," & to_str(r); end function;
    function "/" (l: string; r: integer) return string is begin return l & "," & to_str(r); end function;
    function "/" (l: string; r: real) return string is begin return l & "," & to_str(r); end function;
    function "/" (l: string; r: time) return string is begin return l & "," & to_str(r); end function;
    function "/" (l: string; r: std_logic) return string is begin return l & "," & to_str(r); end function;
    function "/" (l: string; r: bit_vector) return string is begin return l & "," & to_str(r); end function;
    function "/" (l: string; r: boolean_vector) return string is begin return l & "," & to_str(r); end function;
    function "/" (l: string; r: integer_vector) return string is begin return l & "," & to_str(r); end function;
    function "/" (l: string; r: real_vector) return string is begin return l & "," & to_str(r); end function;
    function "/" (l: string; r: time_vector) return string is begin return l & "," & to_str(r); end function;
    function "/" (l: string; r: std_logic_vector) return string is begin return l & "," & to_str(r); end function;
    function "/" (l: string; r: unsigned) return string is begin return l & "," & to_str(r); end function;
    function "/" (l: string; r: signed) return string is begin return l & "," & to_str(r); end function;

end package body;
