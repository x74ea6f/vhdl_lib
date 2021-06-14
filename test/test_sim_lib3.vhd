
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;
use std.env.finish;

library work;
use work.str_lib.all;
use work.sim_lib.all;

entity test_sim_lib3 is
end entity;

architecture SIM of test_sim_lib3 is
begin

    process
        variable exp_line: line;
        variable val: std_logic_vector(15 downto 0) := X"1234";
        variable exp_ok: std_logic_vector(15 downto 0) := X"1234";
        variable exp_ng: std_logic_vector(15 downto 0) := X"2345";
    begin
        -- Test of print
        print("-- Start " & "My Library Test.");

        check(val, exp_ok); -- No Message, no show

        check(val, exp_ok, "Message_no"); --  no show
        check(val, exp_ok, "", True); -- show OK
        check(val, exp_ok, "MessageOK", True); -- show OK

        check(val, exp_ng); -- show Error
        check(val, exp_ng, "MessageError1"); -- show Error

        print("Finish:" + now);
        finish(0);
        wait;
    end process;

end architecture;

