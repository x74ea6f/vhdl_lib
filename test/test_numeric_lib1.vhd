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

    -- 0/0=0, +n/0=+Max, -n/0=-Max
    function div_int(a: integer; b: integer) return integer is
    begin
        if b=0 then
            if a=0 then return 0;
            elsif a>0 then return integer'high;
            else return integer'low;
            end if;
        else
            return a/b;
        end if;
    end function;

    function clip_int(a: integer; constant n: positive) return integer is
        variable m: natural;
    begin
        m := n -1;
        return maximum(minimum(a, (2**m)-1), -(2**m));
    end function;

begin
    process is
        variable show_result: boolean := False;
        variable s_a, s_b: signed(DTW-1 downto  0);
        variable u_a, u_b: unsigned(DTW-1 downto  0);
        variable slv_a, slv_b: std_logic_vector(DTW-1 downto  0);
    begin
        print("Test numeric_lib");

        for i in U_MIN to U_MAX loop
        for k in U_MIN to U_MAX loop
            u_a:= to_unsigned(i, DTW);
            u_b:= to_unsigned(k, DTW);
            check(f_add(u_a, u_b), to_unsigned(i+k, DTW+1), "f_add_u", show_result);
            check(f_sub(u_a, u_b), to_signed(i-k, DTW+1), "f_sub_u", show_result);
            check(f_mul(u_a, u_b), to_unsigned(i*k, DTW*2), "f_mul_u", show_result);
            check(f_div(u_a, u_b), to_unsigned(clip_int(div_int(i,k), DTW+1), DTW), "f_mul_u", show_result);
        end loop;
        end loop;

        for i in U_MIN to U_MAX loop
        for k in S_MIN to S_MAX loop
            u_a:= to_unsigned(i, DTW);
            s_b:= to_signed(k, DTW);
            -- print("A=" + u_a & ", B=" + s_b);
            check(f_add(u_a, s_b), to_signed(i+k, DTW+1), "f_add_us", show_result);
            check(f_sub(u_a, s_b), to_signed(i-k, DTW+1), "f_sub_us", show_result);
            check(f_mul(u_a, s_b), to_signed(i*k, DTW*2), "f_mul_us", show_result);
            check(f_div(u_a, s_b), to_signed(clip_int(div_int(i,k), DTW+1), DTW+1), "f_mul_us", show_result);
        end loop;
        end loop;

        for i in S_MIN to S_MAX loop
        for k in U_MIN to U_MAX loop
            s_a:= to_signed(i, DTW);
            u_b:= to_unsigned(k, DTW);
            -- print("A=" + s_a & ", B=" + u_b);
            check(f_add(s_a, u_b), to_signed(i+k, DTW+1), "f_add_su", show_result);
            check(f_sub(s_a, u_b), to_signed(i-k, DTW+1), "f_sub_su", show_result);
            check(f_mul(s_a, u_b), to_signed(i*k, DTW*2), "f_mul_su", show_result);
            check(f_div(s_a, u_b), to_signed(clip_int(div_int(i,k), DTW), DTW), "f_mul_su", show_result);
        end loop;
        end loop;

        for i in S_MIN to S_MAX loop
        for k in S_MIN to S_MAX loop
            s_a:= to_signed(i, DTW);
            s_b:= to_signed(k, DTW);
            -- print("A=" + s_a & ", B=" + s_b);
            check(f_add(s_a, s_b), to_signed(i+k, DTW+1), "f_add_s", show_result);
            check(f_sub(s_a, s_b), to_signed(i-k, DTW+1), "f_sub_s", show_result);
            check(f_mul(s_a, s_b), to_signed(i*k, DTW*2), "f_mul_s", show_result);
            check(f_div(s_a, s_b), to_signed(clip_int(div_int(i,k), DTW+1), DTW+1), "f_mul_s", show_result);
        end loop;
        end loop;

        finish(0);
    end process;
end architecture;

