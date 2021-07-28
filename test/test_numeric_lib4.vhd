library ieee;
library std;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use std.env.finish;

use work.numeric_lib.all;
use work.str_lib.all;
use work.sim_lib.all;

entity test_numeric_lib4 is
end entity;

architecture SIM of test_numeric_lib4 is

begin
    process is
    begin
        print("Test numeric_lib");

        check(clog2(1), 0, "clog2(1)", True);
        check(clog2(2), 1, "clog2(2)", True);
        check(clog2(3), 2, "clog2(3)", True);
        check(clog2(4), 2, "clog2(4)", True);
        check(clog2(5), 3, "clog2(5)", True);
        check(clog2(6), 3, "clog2(6)", True);
        check(clog2(7), 3, "clog2(7)", True);
        check(clog2(8), 3, "clog2(8)", True);
        check(clog2(9), 4, "clog2(9)", True);

        check(f_increment("0000"), "0001", "f_increment(0000)", True);
        check(f_increment("1010"), "1011", "f_increment(1010)", True);
        check(f_increment("1111"), "0000", "f_increment(1111)", True);
        check(f_increment("0"), "1", "f_ncrement(0)", True);
        check(f_increment("1"), "0", "f_ncrement(1)", True);

        finish(0);
    end process;
end architecture;

