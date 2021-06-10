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
        LEN_A: positive := 5;
        LEN_B: positive := 4
    );
end entity;

architecture SIM of test_numeric_lib1 is
    constant U_MIN_A : integer := 0;
    constant U_MAX_A : integer := 2**LEN_A-1;
    constant S_MIN_A : integer := -(2**(LEN_A-1));
    constant S_MAX_A : integer := (2**(LEN_A-1))-1;
    constant U_MIN_B : integer := 0;
    constant U_MAX_B : integer := 2**LEN_B-1;
    constant S_MIN_B : integer := -(2**(LEN_B-1));
    constant S_MAX_B : integer := (2**(LEN_B-1))-1;

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
        variable s_a: signed(LEN_A-1 downto 0);
        variable s_b: signed(LEN_B-1 downto 0);
        variable u_a: unsigned(LEN_A-1 downto 0);
        variable u_b: unsigned(LEN_B-1 downto 0);

        variable add_len: natural := 0;
        variable sub_len: natural := 0;
        variable mul_len: natural := 0;
        variable div_len: natural := 0;
    begin
        print("Test numeric_lib");

        print("unsigned, unsigned");
        add_len := maximum(LEN_A, LEN_B) + 1;
        sub_len := maximum(LEN_A, LEN_B) + 1;
        mul_len := LEN_A + LEN_B;
        div_len := LEN_A;
        for i in U_MIN_A to U_MAX_A loop
        for k in U_MIN_B to U_MAX_B loop
            u_a:= to_unsigned(i, LEN_A);
            u_b:= to_unsigned(k, LEN_B);
            check(f_add(u_a, u_b), to_unsigned(i+k, add_len), "f_add_u", show_result);
            check(f_sub(u_a, u_b), to_signed(i-k, sub_len), "f_sub_u", show_result);
            check(f_mul(u_a, u_b), to_unsigned(i*k, mul_len), "f_mul_u", show_result);
            check(f_div(u_a, u_b), to_unsigned(clip_int(div_int(i,k), div_len+1), div_len), "f_div_u", show_result);
        end loop;
        end loop;

        print("unsigned, signed");
        add_len := maximum(LEN_A, LEN_B) + 1;
        sub_len := maximum(LEN_A, LEN_B) + 1;
        mul_len := LEN_A + LEN_B;
        div_len := LEN_A+1;
        for i in U_MIN_A to U_MAX_A loop
        for k in S_MIN_B to S_MAX_B loop
            u_a:= to_unsigned(i, LEN_A);
            s_b:= to_signed(k, LEN_B);
            -- print("A=" + u_a & ", B=" + s_b);
            check(f_add(u_a, s_b), to_signed(i+k, add_len), "f_add_us", show_result);
            check(f_sub(u_a, s_b), to_signed(i-k, sub_len), "f_sub_us", show_result);
            check(f_mul(u_a, s_b), to_signed(i*k, mul_len), "f_mul_us", show_result);
            check(f_div(u_a, s_b), to_signed(clip_int(div_int(i,k), div_len), div_len), "f_div_us", show_result);
        end loop;
        end loop;

        print("signed, unsigned");
        add_len := maximum(LEN_A, LEN_B) + 1;
        sub_len := maximum(LEN_A, LEN_B) + 1;
        mul_len := LEN_A + LEN_B;
        div_len := LEN_A;
        for i in S_MIN_A to S_MAX_A loop
        for k in U_MIN_B to U_MAX_B loop
            s_a:= to_signed(i, LEN_A);
            u_b:= to_unsigned(k, LEN_B);
            -- print("A=" + s_a & ", B=" + u_b);
            check(f_add(s_a, u_b), to_signed(i+k, add_len), "f_add_su", show_result);
            check(f_sub(s_a, u_b), to_signed(i-k, sub_len), "f_sub_su", show_result);
            check(f_mul(s_a, u_b), to_signed(i*k, mul_len), "f_mul_su", show_result);
            check(f_div(s_a, u_b), to_signed(clip_int(div_int(i,k), div_len), div_len), "f_div_su", show_result);
        end loop;
        end loop;

        print("signed, signed");
        add_len := maximum(LEN_A, LEN_B) + 1;
        sub_len := maximum(LEN_A, LEN_B) + 1;
        mul_len := LEN_A + LEN_B;
        div_len := LEN_A + 1;
        for i in S_MIN_A to S_MAX_A loop
        for k in S_MIN_B to S_MAX_B loop
            s_a:= to_signed(i, LEN_A);
            s_b:= to_signed(k, LEN_B);
            -- print("A=" + s_a & ", B=" + s_b);
            check(f_add(s_a, s_b), to_signed(i+k, add_len), "f_add_s", show_result);
            check(f_sub(s_a, s_b), to_signed(i-k, sub_len), "f_sub_s", show_result);
            check(f_mul(s_a, s_b), to_signed(i*k, mul_len), "f_mul_s", show_result);
            check(f_div(s_a, s_b), to_signed(clip_int(div_int(i,k), div_len), div_len), "f_div_s", show_result);
        end loop;
        end loop;

        finish(0);
    end process;
end architecture;

