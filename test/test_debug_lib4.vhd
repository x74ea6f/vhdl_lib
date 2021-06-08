
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;
use std.env.finish;

library work;
use work.debug_lib.all;

entity test_debug_lib4 is
end entity;

architecture SIM of test_debug_lib4 is
    signal clk: std_logic:= '0';
begin

    process begin
        wait for 5ns;
        clk <= not clk;
    end process;

    process
        variable exp_line: line;
    begin
        -- Test of print
        print("-- Start " & "My Library Test.");

        check(X"1234", X"1234"); -- No Message, no show

        check(X"1234", X"1234", "Message_no"); --  no show
        check(X"1234", X"1234", "", True); -- show OK
        check(X"1234", X"1234", "MessageOK", True); -- show OK

        check(X"1234", X"2345"); -- show Error
        check(X"1234", X"2345", "MessageError1"); -- show Error

        print("Finish:" + now);
        finish(0);
        wait;
    end process;

end architecture;

