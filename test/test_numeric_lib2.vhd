library ieee;
library std;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use std.env.finish;

use work.numeric_lib.all;
use work.debug_lib.all;


entity test_numeric_lib2 is
    generic(
        LEN_A: positive := 5;
        LEN_B: positive := 4
    );
end entity;

architecture SIM of test_numeric_lib2 is
    constant U_MIN_A : integer := 0;
    constant U_MAX_A : integer := 2**LEN_A-1;
    constant S_MIN_A : integer := -(2**(LEN_A-1));
    constant S_MAX_A : integer := (2**(LEN_A-1))-1;
    constant U_MIN_B : integer := 0;
    constant U_MAX_B : integer := 2**LEN_B-1;
    constant S_MIN_B : integer := -(2**(LEN_B-1));
    constant S_MAX_B : integer := (2**(LEN_B-1))-1;

    procedure check(data, exp: std_logic; msg:string:=""; show_result:boolean:=false) is
    begin
        check('0'&data, '0'&exp, msg, show_result);
    end procedure;

    procedure check(data, exp: signed; msg:string:=""; show_result:boolean:=false) is
    begin
        check(std_logic_vector(data), std_logic_vector(exp), msg, show_result);
    end procedure;
    procedure check(data, exp: unsigned; msg:string:=""; show_result:boolean:=false) is
    begin
        check(std_logic_vector(data), std_logic_vector(exp), msg, show_result);
    end procedure;

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
        variable u_a: unsigned(LEN_A-1 downto 0);

        variable exp_sl: std_logic;
    begin
        print("Test numeric_lib");

        for i in U_MIN_A to U_MAX_A loop
            u_a := to_unsigned(i, LEN_A);
            -- print("A=" + u_a);

            exp_sl := '0' when (i=0) else '1';
            check(f_or_reduce(u_a), exp_sl , "or_reduce_u", show_result);
            exp_sl := '1' when (i=U_MAX_A) else '0';
            check(f_and_reduce(u_a), exp_sl , "and_reduce_u", show_result);

            check(f_clip(u_a, LEN_B), to_unsigned(clip_int(i, LEN_B+1), LEN_B) , "clip_u", show_result);

        end loop;

        for i in S_MIN_A to S_MAX_A loop
            s_a:= to_signed(i, LEN_A);
            -- print("A=" + s_a);

            exp_sl := '0' when (i=0) else '1';
            check(f_or_reduce(s_a), exp_sl , "or_reduce_s", show_result);
            exp_sl := '1' when (i=-1) else '0';
            check(f_and_reduce(s_a), exp_sl , "and_reduce_s", show_result);

            check(f_clip(s_a, LEN_B), to_signed(clip_int(i, LEN_B), LEN_B) , "clip_s", show_result);
        end loop;

        finish(0);
    end process;
end architecture;
