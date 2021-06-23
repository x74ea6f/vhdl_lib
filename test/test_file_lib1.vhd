
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
        constant file_name3: string := "sample_out.csv";

        file f_in: text;
        file f_out: text;
        variable l: line;
        variable int: integer;
        variable intv: integer_vector(1 to 4);
        variable rlv: real_vector(1 to 4);
        variable slv: std_logic_vector(15 downto 0);

    begin

        STR_LIB_CONFIG.set_append_parenthesis(False);

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

        -- csv
        file_open(f_out, file_name3, WRITE_MODE);
        for i in 0 to 3 loop
            write(l, to_str(int) / intv / rlv / slv);
            -- write(l, to_str(int) / to_str(intv, append_parenthesis=>False) / to_str(rlv, append_parenthesis=>False) / slv);
            int := int + 1;
            writeline(f_out, l);
        end loop;

        file_close(f_out);


        finish(0);
    end process;

end architecture;

