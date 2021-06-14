
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

    process
        variable str: string(1 to 3);
        variable int: integer;
        variable intv: integer_vector(1 to 4);
    begin
        -- Test of print
        print("-- Start " & "My Library Test.");

        FT.open_file("sample_in.txt");
        while not FT.is_endfile loop
            FT.read(int);
            print(to_str(int));
            FT.read_integer_vector(intv);
            print(to_str(intv));
        end loop;
        FT.close_file;

        print("csv_file");
        FT.open_file("sample_in.csv");
        while not FT.is_endfile loop
            FT.read(int);
            print(to_str(int));
            FT.read_integer_vector(intv);
            print(to_str(intv));
        end loop;
        FT.close_file;
        

        print("Finish:" + now);
        finish(0);
        wait;
    end process;

end architecture;

