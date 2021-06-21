
library ieee;
library std;
library work;
use ieee.std_logic_1164.all;
use std.env.finish;
use work.str_lib.all;
use work.sim_lib.all;

entity debug_lib_example is
end entity;

architecture SIM of debug_lib_example is
    signal clk, rstn: std_logic;
begin
    process begin
        make_clock(clk, 5 ns); -- 10ns clock
    end process;

    process
        variable v_int: integer:=123;
        variable v_slv: std_logic_vector(8 downto 0):='1' & X"AB";
    begin
        print("Hello world! " + v_int); -- String + Integer
        print("StdLogiVector=" + v_slv & ", ", false); -- false: not flush
        print("Integer=" & to_str(v_int, HEX)); -- flush

        make_reset(rstn, clk, 5); -- reset
        wait_clock(clk, 5); -- wait clock rising, 5times

        print("Finish @" + now); -- show Simulation time
        finish(0);
    end process;

end architecture;

-- 
-- Hello world! 123
-- StdLogiVector=0x1AB, Integer=0x0000007B
-- Finish @100ns
-- 
