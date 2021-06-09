--[KNOCK]
-- Design arithmetic calc selector, use signed/unsigned. and Design Library.

library ieee;
library std;
library work;
use ieee.std_logic_1164.all;
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
    constant U_MIN : integer := 0;
    constant U_MAX : integer := 2**DTW-1;
    constant S_MIN : integer := -(2**(DTW-1));
    constant S_MAX : integer := (2**(DTW-1))-1;

    procedure check(data: signed; exp: signed; msg:string:=""; show_result:boolean:=false) is
    begin
        check(std_logic_vector(data), std_logic_vector(exp), msg, show_result);
    end procedure;
    procedure check(data: unsigned; exp: unsigned; msg:string:=""; show_result:boolean:=false) is
    begin
        check(std_logic_vector(data), std_logic_vector(exp), msg, show_result);
    end procedure;

begin
    process is
        variable s_a, s_b: signed(DTW-1 downto  0);
        variable u_a, u_b: unsigned(DTW-1 downto  0);
        variable slv_a, slv_b: std_logic_vector(DTW-1 downto  0);

        variable tmp: signed(DTW-1 downto 0);
    begin
        print("Test numeric_lib");

        for i in S_MIN to S_MAX loop
        for k in S_MIN to S_MAX loop
            s_a:= to_signed(i, DTW);
            s_b:= to_signed(k, DTW);
            check(f_add(s_a, s_b), to_signed(i+k, DTW+1), "f_add_s", false);
            -- check(f_sub(s_a, s_b), to_signed(i+k, DTW+1), "f_add_ss", false);
        end loop;
        end loop;

        for i in U_MIN to U_MAX loop
        for k in U_MIN to U_MAX loop
            u_a:= to_unsigned(i, DTW);
            u_b:= to_unsigned(k, DTW);
            check(f_add(u_a, u_b), to_unsigned(i+k, DTW+1), "f_add_u", false);
        end loop;
        end loop;

        for i in U_MIN to U_MAX loop
        for k in S_MIN to S_MAX loop
            u_a:= to_unsigned(i, DTW);
            s_b:= to_signed(k, DTW);
            -- print("U=" + u_a & ", S=" + s_b);
            check(f_add(u_a, s_b), to_signed(i+k, DTW+1), "f_add_us", false);
            check(f_add(s_b, u_a), to_signed(i+k, DTW+1), "f_add_su", false);
        end loop;
        end loop;


        finish(0);
    end process;
end architecture;

