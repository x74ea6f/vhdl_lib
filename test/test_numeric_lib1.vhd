--[KNOCK]
-- Design arithmetic calc selector, use signed/unsigned. and Design Library.

library ieee;
library std;
library work;
use ieee.numeric_std.all;
use ieee.math_real.all;
use std.env.finish;

use work.numeric_lib.all;
use work.debug_lib.all;


entity test_numeric_lib1 is
    generic(
        DTW: integer := 4
    );
end entity;

architecture SIM of test_numeric_lib1 is
begin
    process is
    begin
        print("Hello VHDL");

        finish(0);
    end process;
end architecture;

