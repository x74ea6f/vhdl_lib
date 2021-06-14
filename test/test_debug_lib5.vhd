
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;
use std.env.finish;

library work;
use work.debug_lib.all;

entity test_debug_lib5 is
end entity;

architecture SIM of test_debug_lib5 is
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

        print(to_str(bit'('1')) /
            boolean'(True) /
            integer'(123) /
            real'(12.3) /
            std_logic'('1')
        );
        SP.check_line("'1',true,123,1.230000e+01,'1'");

        print(to_str(bit_vector'("1010")) / -- First as String
            boolean_vector'((True, False, True, False)) /
            integer_vector'((123, -234, 345, -678)) /
            real_vector'((12.3, -23.4, 34.5, 45.6)) /
            std_logic_vector'(X"123")
        );
        SP.check_line("0xA,(true,false,true,false),(123,-234,345,-678),(1.230000e+01,-2.340000e+01,3.450000e+01,4.560000e+01),0x123");

        print(to_str(signed'(to_signed(-10, 8))) /
            unsigned'(to_unsigned(10, 8)));
        SP.check_line("-10,10");

        print("Finish:" + now);
        finish(0);
        wait;
    end process;

end architecture;

