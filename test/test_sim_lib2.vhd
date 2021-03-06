
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;
use std.env.finish;

library work;
use work.str_lib.all;
use work.sim_lib.all;

entity test_sim_lib2 is
end entity;

architecture SIM of test_sim_lib2 is
    signal clk, rstn: std_logic;
begin

    process begin
        make_clock(clk, 5 ns);
    end process;

    process
    begin
        -- Test of print
        print("-- Start " & "My Library Test.");
        make_reset(rstn, clk, 5);

        print("Wait 0Clock:" + now);
        wait_clock(clk, 0);
        print("Wait 1Clock:" + now);
        wait_clock(clk, 1);
        print("Wait 10Clock:" + now);
        wait_clock(clk, 10);

        print("Finish:" + now);
        finish(0);
        wait;
    end process;

end architecture;

