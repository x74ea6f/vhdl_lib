
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;
use std.env.finish;

library work;
use work.debug_lib.all;

entity test_debug_lib1 is
end entity;

architecture SIM of test_debug_lib1 is

    -- shared variable l: line;
    -- procedure print(str: string; end_line: boolean:=True) is
    -- begin
    --     write(l, str);
    --     if end_line = True then
    --         writeline(output, l);
    --     end if;
    -- end procedure;
begin

    process
        variable v_bt: bit;
        variable v_bl: boolean;
        variable v_int: integer;
        variable v_rl: real;
        variable v_tm: time;
        variable v_sl: std_logic;

        variable v_btv: bit_vector(8 downto 0);
        variable v_blv: boolean_vector(7 downto 0);
        variable v_intv: integer_vector(1 to 5);
        variable v_rlv: real_vector(1 to 5);

        variable v_tmv: time_vector(7 downto 0);
        variable v_slv: std_logic_vector(8 downto 0);
        variable v_s: signed(8 downto 0);
        variable v_u: unsigned(8 downto 0);

        variable v_slv32: std_logic_vector(31 downto 0);

    begin
        -- Test of print
        print("-- Start " & "My Library ", false);
        print("Test " & ".");

        -- bit
        v_bt := '1';
        print("-- bit=" + v_bt);
        print(v_bt);
        print("to_str(): " & to_str(v_bt));

        -- boolean
        v_bl := True;
        print("-- boolean=" + v_bl);
        print(v_bl);
        print("to_str(): " & to_str(v_bl));

        -- integer
        v_int := -4;
        print("-- integer=" + v_int);
        print(v_int);
        print("to_str(): BIN=" & to_str(v_int, BIN), false);
        print(", DEC_U=" & to_str(v_int, DEC_U), false);
        print(", DEC_S=" & to_str(v_int, DEC_S), false);
        print(", HEX=" & to_str(v_int, HEX), false);
        print(", DAFAULT=" & to_str(v_int)); -- default as HEX


        -- real
        v_rl := -3.14;
        print("-- real=" + v_rl);
        print(v_rl);
        print("to_str(): " & to_str(v_rl));

        -- time
        v_tm := 123 ns;
        print("-- time=" + v_tm);
        print(v_tm);
        print("to_str(): " & to_str(v_tm));

        -- std_logic
        v_sl := '1';
        print("-- std_logic=" + v_sl);
        print(v_sl);
        print("to_str(): " & to_str(v_sl));

        -- bit_vector
        v_btv := "1" & "1010" & "1010";
        -- print(v_btv); -- NG
        -- print(to_str(v_btv)); -- OK 
        print("-- bit_vector=" + v_btv);
        print("to_str(): BIN=" & to_str(v_btv, BIN), false);
        print(", DEC_U=" & to_str(v_btv, DEC_U), false);
        print(", DEC_S=" & to_str(v_btv, DEC_S), false);
        print(", HEX=" & to_str(v_btv, HEX), false);
        print(", DAFAULT=" & to_str(v_btv)); -- default as HEX
        
        -- boolean_vector
        v_blv := (True, False, True, False) & (True, False, True, False);
        print("-- boolean_vector=" + v_blv);
        print("to_str(): " & to_str(v_blv));

        -- integer_vector
        v_intv := (-10, -1, 0, 1, 10);
        print("-- integer_vector=" + v_intv);
        print("to_str(): BIN=" & to_str(v_intv, BIN), false);
        print(", DEC_U=" & to_str(v_intv, DEC_U), false);
        print(", DEC_S=" & to_str(v_intv, DEC_S), false);
        print(", HEX=" & to_str(v_intv, HEX), false);
        print(", DAFAULT=" & to_str(v_intv)); -- default as HEX
        
        -- real_vector
        v_rlv := (-12.3, -0.1, 0.0, 0.1, 12.3);
        print("-- real_vector=" + v_rlv);
        print("to_str(): " & to_str(v_rlv));
        
        -- time_vector
        v_tmv := (1 ps, 2 ns, 3 us, 4 us, 12 ns, 123 ns, 1234 ns, 12345 ns);
        print("-- time_vector=" + v_tmv);
        print("to_str(): " & to_str(v_tmv));

        -- std_logic_vector
        v_slv := "1" & "1010" & "10XX";
        print("-- std_logic_vector=" + v_slv);
        print("to_str(): BIN=" & to_str(v_slv, BIN), false);
        print(", DEC_U=" & to_str(v_slv, DEC_U), false);
        print(", DEC_S=" & to_str(v_slv, DEC_S), false);
        print(", HEX=" & to_str(v_slv, HEX), false);
        print(", DAFAULT=" & to_str(v_slv)); -- default as HEX
        
        -- signed
        v_s := "1" & "1010" & "1010";
        print("-- signed=" + v_s);
        print("to_str(): BIN=" & to_str(v_s, BIN), false);
        print(", DEC_U=" & to_str(v_s, DEC_U), false);
        print(", DEC_S=" & to_str(v_s, DEC_S), false);
        print(", HEX=" & to_str(v_s, HEX), false);
        print(", DAFAULT=" & to_str(v_s)); -- default as HEX

        -- unsigned
        v_u := "1" & "1010" & "1010";
        print("-- signed=" + v_u);
        print("to_str(): BIN=" & to_str(v_u, BIN), false);
        print(", DEC_U=" & to_str(v_u, DEC_U), false);
        print(", DEC_S=" & to_str(v_u, DEC_S), false);
        print(", HEX=" & to_str(v_u, HEX), false);
        print(", DAFAULT=" & to_str(v_u)); -- default as HEX

        finish(0);
    end process;

end architecture;

