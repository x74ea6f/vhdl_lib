
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;
use std.env.finish;

library work;
use work.str_lib.all;
use work.sim_lib.all;

entity test_str_lib3 is
end entity;

architecture SIM of test_str_lib3 is
begin

    process
    begin
        -- Test of print
        print("-- Start " & "My Library Test.");

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

        print("Finish:" + now);
        finish(0);
        wait;
    end process;

end architecture;

