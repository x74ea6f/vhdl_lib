
library ieee;
library std;
library work;
use ieee.std_logic_1164.all;
use std.env.finish;
use work.str_lib.all;
use work.sim_lib.all;

entity sim_lib_example is
end entity;

architecture SIM of sim_lib_example is
    signal clk, rstn: std_logic;
begin
    process begin
        make_clock(clk, 5 ns); -- 10ns clock
    end process;

    process
    begin
        print("Hello world!");

        make_reset(rstn, clk, 5); -- reset
        wait_clock(clk, 5); -- wait clock rising, 5times

        print("Finish @" + now); -- show Simulation time
        finish(0);
    end process;

end architecture;
