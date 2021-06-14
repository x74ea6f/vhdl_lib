
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;
use std.env.finish;

library work;
use work.str_lib.all;
use work.sim_lib.all;

entity test_sim_lib1 is
end entity;

architecture SIM of test_sim_lib1 is
begin

    process
    begin
        -- Test of print
        print("-- Start " & "My Library ", false);
        print("Test " & ".");

        for i in 0 to 10 loop
            print("RAND_SLV=" + rand_slv(8));
        end loop;

        for i in 0 to 10 loop
            print("RAND_SLV=" + rand_slv(16));
        end loop;

        for i in 0 to 10 loop
            print("RAND_SLV=" + rand_slv(32));
        end loop;

        for i in 0 to 10 loop
            print("RAND_SLV=" + rand_slv(64));
        end loop;

        finish(0);
        wait;
    end process;

end architecture;

