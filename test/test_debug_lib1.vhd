
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

        variable l_str: string(1 to 25);
    begin
        -- Test of print
        print("-- Start " & "My Library ", false);
        print("Test" & ".");
        SP.check_line("-- Start My Library Test."); -- for regression

        -- bit
        v_bt := '1';
        print("-- bit=" + v_bt);
        SP.check_line("-- bit='1'");
        print(v_bt);
        SP.check_line("'1'");
        print("to_str(): " & to_str(v_bt));
        SP.check_line("to_str(): '1'");

        -- boolean
        v_bl := True;
        print("-- boolean=" + v_bl);
        SP.check_line("-- boolean=true");
        print(v_bl);
        SP.check_line("true");
        print("to_str(): " & to_str(v_bl));
        SP.check_line("to_str(): true");

        -- integer
        v_int := -4;
        print("-- integer=" + v_int);
        SP.check_line("-- integer=-4");
        print(v_int);
        SP.check_line("-4");
        print("to_str(): BIN=" & to_str(v_int, BIN), false);
        print(", DEC_U=" & to_str(v_int, DEC_U), false);
        print(", DEC_S=" & to_str(v_int, DEC_S), false);
        print(", HEX=" & to_str(v_int, HEX), false);
        print(", DAFAULT=" & to_str(v_int)); -- default as HEX
        SP.check_line("to_str(): BIN=11111111111111111111111111111100, DEC_U=2147483644, DEC_S=-4, HEX=0xFFFFFFFC, DAFAULT=-4");

        -- real
        v_rl := -3.14;
        print("-- real=" + v_rl);
        SP.check_line("-- real=-3.140000e+00");
        print(v_rl);
        SP.check_line("-3.140000e+00");
        print("to_str(): " & to_str(v_rl));
        SP.check_line("to_str(): -3.140000e+00");

        -- time
        v_tm := 123 ns;
        print("-- time=" + v_tm);
        SP.check_line("-- time=123ns");
        print(v_tm);
        SP.check_line("123ns");
        print("to_str(): " & to_str(v_tm));
        SP.check_line("to_str(): 123ns");

        -- std_logic
        v_sl := '1';
        print("-- std_logic=" + v_sl);
        SP.check_line("-- std_logic='1'");
        print(v_sl);
        SP.check_line("'1'");
        print("to_str(): " & to_str(v_sl));
        SP.check_line("to_str(): '1'");

        -- bit_vector
        v_btv := "1" & "1010" & "1010";
        -- print(v_btv); -- NG
        -- print(to_str(v_btv)); -- OK 
        print("-- bit_vector=" + v_btv);
        SP.check_line("-- bit_vector=0x1AA");
        print("to_str(): BIN=" & to_str(v_btv, BIN), false);
        print(", DEC_U=" & to_str(v_btv, DEC_U), false);
        print(", DEC_S=" & to_str(v_btv, DEC_S), false);
        print(", HEX=" & to_str(v_btv, HEX), false);
        print(", DAFAULT=" & to_str(v_btv)); -- default as HEX
        SP.check_line("to_str(): BIN=110101010, DEC_U=426, DEC_S=-86, HEX=0x1AA, DAFAULT=0x1AA");
        
        -- boolean_vector
        v_blv := (True, False, True, False) & (True, False, True, False);
        print("-- boolean_vector=" + v_blv);
        SP.check_line("-- boolean_vector=(true,false,true,false,true,false,true,false)");
        print("to_str(): " & to_str(v_blv));
        SP.check_line("to_str(): (true,false,true,false,true,false,true,false)");

        -- integer_vector
        v_intv := (-10, -1, 0, 1, 10);
        print("-- integer_vector=" + v_intv);
        SP.check_line("-- integer_vector=(-10,-1,0,1,10)");
        print("to_str(): BIN=" & to_str(v_intv, BIN), false);
        print(", DEC_U=" & to_str(v_intv, DEC_U), false);
        print(", DEC_S=" & to_str(v_intv, DEC_S), false);
        print(", HEX=" & to_str(v_intv, HEX), false);
        print(", DAFAULT=" & to_str(v_intv)); -- default as HEX
        SP.check_line("to_str(): BIN=(11111111111111111111111111110110,11111111111111111111111111111111,00000000000000000000000000000000,00000000000000000000000000000001,00000000000000000000000000001010), DEC_U=(2147483638,2147483647,0,1,10), DEC_S=(-10,-1,0,1,10), HEX=(0xFFFFFFF6,0xFFFFFFFF,0x00000000,0x00000001,0x0000000A), DAFAULT=(-10,-1,0,1,10)");
        
        -- real_vector
        v_rlv := (-12.3, -0.1, 0.0, 0.1, 12.3);
        print("-- real_vector=" + v_rlv);
        SP.check_line("-- real_vector=(-1.230000e+01,-1.000000e-01,0.000000e+00,1.000000e-01,1.230000e+01)");
        print("to_str(): " & to_str(v_rlv));
        SP.check_line("to_str(): (-1.230000e+01,-1.000000e-01,0.000000e+00,1.000000e-01,1.230000e+01)");
        
        -- time_vector
        v_tmv := (1 ps, 2 ns, 3 us, 4 us, 12 ns, 123 ns, 1234 ns, 12345 ns);
        print("-- time_vector=" + v_tmv);
        SP.check_line("-- time_vector=(1ps,2ns,3us,4us,12ns,123ns,1us,12us)");
        print("to_str(): " & to_str(v_tmv));
        SP.check_line("to_str(): (1ps,2ns,3us,4us,12ns,123ns,1us,12us)");

        -- std_logic_vector
        v_slv := "1" & "1010" & "10XX";
        print("-- std_logic_vector=" + v_slv);
        SP.check_line("-- std_logic_vector=0x1AX");
        print("to_str(): BIN=" & to_str(v_slv, BIN), false);
        print(", DEC_U=" & to_str(v_slv, DEC_U), false);
        print(", DEC_S=" & to_str(v_slv, DEC_S), false);
        print(", HEX=" & to_str(v_slv, HEX), false);
        print(", DAFAULT=" & to_str(v_slv)); -- default as HEX
        SP.check_line("to_str(): BIN=1101010XX, DEC_U=0, DEC_S=0, HEX=0x1AX, DAFAULT=0x1AX");
        
        -- signed
        v_s := "1" & "1010" & "1010";
        print("-- signed=" + v_s);
        SP.check_line("-- signed=-86");
        print("to_str(): BIN=" & to_str(v_s, BIN), false);
        print(", DEC_U=" & to_str(v_s, DEC_U), false);
        print(", DEC_S=" & to_str(v_s, DEC_S), false);
        print(", HEX=" & to_str(v_s, HEX), false);
        print(", DAFAULT=" & to_str(v_s)); -- default as HEX
        SP.check_line("to_str(): BIN=110101010, DEC_U=426, DEC_S=-86, HEX=0x1AA, DAFAULT=-86");

        -- unsigned
        v_u := "1" & "1010" & "1010";
        print("-- signed=" + v_u);
        SP.check_line("-- signed=426");
        print("to_str(): BIN=" & to_str(v_u, BIN), false);
        print(", DEC_U=" & to_str(v_u, DEC_U), false);
        print(", DEC_S=" & to_str(v_u, DEC_S), false);
        print(", HEX=" & to_str(v_u, HEX), false);
        print(", DAFAULT=" & to_str(v_u)); -- default as HEX
        SP.check_line("to_str(): BIN=110101010, DEC_U=426, DEC_S=-86, HEX=0x1AA, DAFAULT=426");

        finish(0);
    end process;

end architecture;
