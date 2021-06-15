-- Sim library.
-- ```
-- ```
--
--
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
    -- ```
    -- File
    -- ```
    type file_t is protected
        procedure open_file(file_name: string);
        procedure close_file;
        impure function is_endfile return boolean;
        procedure read_line;
        procedure read_integer_vector(intv: out integer_vector);

        procedure read(v: out integer);
    end protected;

    shared variable FT: file_t;

    procedure read(ln: inout line; intv: out integer_vector);
    procedure comma2space(ln: inout line);

    impure function replace(str, search, rep:string) return string;

end package;

package body file_lib is

    -- ```
    -- Random
    -- ```
    type file_t is protected body 
        file f_in: text;
        variable ln: line;
        variable is_csv: boolean;

        procedure open_file(file_name: string) is
        begin
            if file_name(file_name'length-3 to file_name'length)=".csv" then
                is_csv := True;
            else
                is_csv := False;
            end if;
            file_open(f_in, file_name, READ_MODE);
        end procedure;
        
        procedure close_file is
        begin
            deallocate(ln);
            file_close(f_in);
        end procedure;

        impure function is_endfile return boolean is
            variable status: boolean;
        begin
            status := endfile(f_in);
            if status=False then
                read_line;
            end if;
            return status;
        end function;

        procedure comma2space is
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

        procedure read_line is
        begin
            readline(f_in, ln);
            if is_csv=True then
                comma2space;
            end if;
        end procedure;

        procedure read_integer_vector(intv: out integer_vector) is
            variable int: integer;
        begin
            for i in intv'range loop
                read(ln, intv(i));
            end loop;
        end procedure;

        procedure read(v: out integer) is
        begin
            read(ln, v);
        end procedure;

    end protected body file_t;

    procedure read(ln: inout line; intv: out integer_vector) is
    begin
        for i in intv'range loop
            read(ln, intv(i));
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

    impure function replace(str, search, rep:string) return string is
        variable s: character;
        variable tmp_ln: line;
        variable new_ln: line;
        variable search_idx: integer:=1;
    begin
        for i in str'range loop
            s := str(i);
            --[TODO]
            if s=search(search_idx) then
                -- print(to_str(s) / search_idx / search'length);

                if search_idx=search'length then
                    write(new_ln, rep);
                    deallocate(tmp_ln);
                    search_idx := 1;
                else
                    search_idx := search_idx + 1;
                    write(tmp_ln, s);
                end if;
            elsif s=search(1) then
                --[TODO]
            else
                search_idx := 1;
                if tmp_ln/=null and tmp_ln'length/=0 then
                    write(new_ln, tmp_ln.all);
                    deallocate(tmp_ln);
                end if;
                write(new_ln, s);
            end if;
        end loop;
        return new_ln.all;
    end function;

end package body;
