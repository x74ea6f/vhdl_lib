
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
        file f_in: text;
        variable l: line;
        variable int: integer;
        variable intv: integer_vector(1 to 4);

    begin

        print(replace("ABcdefg", "AB", "012"));
        SP.check_line("012cdefg");
        print(replace("zzAABcdefg", "AB", "012"));
        SP.check_line("zzA012cdefg");
        print(replace("abcdefgAB", "AB", "012"));
        SP.check_line("abcdefg012");
        print(replace("abcdefgA", "AB", "012"));
        SP.check_line("abcdefgA");
        print(replace("ABcdefgAB", "AB", "012"));
        SP.check_line("012cdefg012");
        print(replace("AB", "AABB", "012"));
        SP.check_line("AB");


        file_open(f_in, "sample_in.csv", READ_MODE);

        while not endfile(f_in) loop
            readline(f_in, l);
            comma2space(l);
            read(l, int);
            print(int);
            read(l, intv);
            print(to_str(intv));
        end loop;

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

