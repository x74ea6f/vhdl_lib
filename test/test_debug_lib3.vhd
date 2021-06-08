
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;
use std.env.finish;

library work;
use work.debug_lib.all;

entity test_debug_lib3 is
end entity;

architecture SIM of test_debug_lib3 is
    signal clk, rstn: std_logic;
begin

    process begin
        make_clock(5 ns, clk);
    end process;

    process
    begin
        -- Test of print
        print("-- Start " & "My Library Test.");
        make_reset(clk, 5, rstn);

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

