-- file library.
-- ```
-- 
-- ```
-- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.math_real.uniform;
use ieee.math_real.floor;

library std;
use std.textio.all;

library work;
use work.str_lib.all;

package file_lib is
    procedure read_line(file f: text; l: inout line; is_csv: boolean:=False);
    procedure read(ln: inout line; intv: out integer_vector);
    procedure read(ln: inout line; rlv: out real_vector);
    procedure comma2space(ln: inout line);

end package;

package body file_lib is

    -- ```
    -- readline() Wrapper
    -- ```
    procedure read_line(file f: text; l: inout line; is_csv: boolean:=False) is
    begin
        readline(f, l);
        if is_csv=True then
            comma2space(l);
        end if;
    end procedure;

    procedure read(ln: inout line; intv: out integer_vector) is
    begin
        for i in intv'range loop
            read(ln, intv(i));
        end loop;
    end procedure;

    procedure read(ln: inout line; rlv: out real_vector) is
    begin
        for i in rlv'range loop
            read(ln, rlv(i));
        end loop;
    end procedure;

    procedure comma2space(ln: inout line) is
        variable s: string(1 to 1);
        variable new_ln: line;
    begin
        for i in ln'range loop
            read(ln, s);
            s := " " when s="," else s; -- "," to " "
            write(new_ln, s);
        end loop;
        ln := new_ln;
    end procedure;

end package body;
