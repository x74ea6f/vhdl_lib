
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;
use std.env.finish;

library work;
use work.str_lib.all;
use work.sim_lib.all;
use work.file_lib.all;

entity test_file_lib1 is
end entity;

architecture SIM of test_file_lib1 is
begin

    process is
        constant file_name1: string := "sample_in.txt";
        constant is_csv1: boolean := False;
        constant file_name2: string := "sample_in.csv";
        constant is_csv2: boolean := True;

        file f_in: text;
        variable l: line;
        variable int: integer;
        variable intv: integer_vector(1 to 4);
        variable rlv: real_vector(1 to 4);
        variable slv: std_logic_vector(15 downto 0);

        type a is array (natural range <>) of std_logic_vector(3 downto 0);

        type c is array (natural range <>, natural range <>) of std_logic_vector(3 downto 0);
        type d is array (natural range <>, natural range <>) of std_logic;

        function get_array(n, m: natural) return d is
            variable ret: d(0 to 4, 5 downto 0);
        begin
            return ret;
        end function;

        variable dd: d(0 to 2, 3 downto 0) := (
            (X"4", X"5", X"6")
            ); 
        variable tmp: std_logic_vector(3 downto 0);
    begin

        for i in dd'range loop
            for j in 0 to 3 loop
                tmp(j) := dd(i,j);
            end loop;
            print(to_str(i) / tmp);
        end loop;



        -- txt
        file_open(f_in, file_name1, READ_MODE);

        while not endfile(f_in) loop
            read_line(f_in, l, is_csv1);
            read(l, int); -- in textio
            print(int);
            read(l, intv);
            print(to_str(intv));
            read(l, rlv);
            print(to_str(rlv));
            hread(l, slv); -- in std_logic_1164
            print(to_str(slv));
        end loop;

        file_close(f_in);

        -- csv
        file_open(f_in, file_name2, READ_MODE);

        while not endfile(f_in) loop
            read_line(f_in, l, is_csv2);
            read(l, int);
            print(int);
            read(l, intv);
            print(to_str(intv));
            read(l, rlv);
            print(to_str(rlv));
            hread(l, slv);
            print(to_str(slv));
        end loop;

        file_close(f_in);

        finish(0);
    end process;

    -- process
    --     variable str: string(1 to 3);
    --     variable int: integer;
    --     variable intv: integer_vector(1 to 4);
    -- begin
    --     -- Test of print
    --     print("-- Start " & "My Library Test.");

    --     FT.open_file("sample_in.txt");
    --     while not FT.is_endfile loop
    --         FT.read(int);
    --         print(to_str(int));
    --         FT.read_integer_vector(intv);
    --         print(to_str(intv));
    --     end loop;
    --     FT.close_file;

    --     print("csv_file");
    --     FT.open_file("sample_in.csv");
    --     while not FT.is_endfile loop
    --         FT.read(int);
    --         print(to_str(int));
    --         FT.read_integer_vector(intv);
    --         print(to_str(intv));
    --     end loop;
    --     FT.close_file;
        

    --     print("Finish:" + now);
    --     finish(0);
    --     wait;
    -- end process;

end architecture;

